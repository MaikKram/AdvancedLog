function Test-EventLog {
[CmdletBinding()]
    Param (
        [string] $LogName
    )
    try {
        $_exists = Get-EventLog -list | Where-Object {$_.logdisplayname -eq $LogName} 
        if (! $_exists) {
            return $false
        } else  {
            return $true
        }
    } catch {
        Throw "Failed to test eventlog with $LogName. $($_.Exception.Message)"
    }
}

function Create-EventLog {
[CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)][string] $LogName,
        [Parameter(Mandatory=$true)][string] $LogSource
    )
 
    try
    {
        #create eventloger if not existing
        if (-not $(Test-EventLog -LogName $LogName)) {
            New-Eventlog -LogName $LogName -Source $LogSource
        }
    } catch {
        Throw "Failed to create eventlog with $LogName. $($_.Exception.Message)"
    }
}

function Fill-Line {
[CmdletBinding()]
    Param
    (
        [int] $Offset = 0,
        [int] $Contract = 0
    )
    $_bufferSize = $host.UI.RawUI.BufferSize.Width - 2
    $_s = [string]::Empty
    for ($i = 0; $i -le $Offset - 1; $i++) { $_s += " " }
    for ($i = $Offset; $i -le $($_bufferSize - $Contract); $i++) { $_s += "-" }
    return $_s
}

function Write-Log {
[CmdletBinding(DefaultParametersetName='None')]
    Param 
    (
        [Parameter(Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)][Alias('Name')][String] $Message,
        [ValidateSet(“Info”,”Warning”,”Error”)][String] $Type = "Info",
        [String]$LogFile = [String]::Empty,
        [Switch]$NoNewline = $false,
        [Switch]$FillLine,
        [int] $Indent = 0,
        [Parameter(ParameterSetName='EventLog',Mandatory=$false)][Switch]$WriteEventLog,
        [Parameter(ParameterSetName='EventLog',Mandatory=$true)][string]$EventLogName,
        [Parameter(ParameterSetName='EventLog',Mandatory=$true)][string]$EventLogSource,
        [Switch]$Live
    )

    begin {
        if (-not $Live) {
            [System.Text.StringBuilder] $_fullString = New-Object System.Text.StringBuilder
        }
        # Try open Logfile
        try {
            
            if (-not $([string]::IsNullOrEmpty($LogFile)) -and $(Test-Path -Path $([System.IO.Path]::GetDirectoryName($LogFile)))) { 
                $FS = New-Object System.IO.FileStream($LogFile, [System.IO.FileMode]::Append, [System.IO.FileAccess]::Write, [System.IO.FileShare]::ReadWrite)
                $LogStreamWriter = New-Object System.IO.StreamWriter($FS)
                $LogStreamWriter.AutoFlush = $true
            } 
        } catch {
            Throw "Could create Logfile. $($_.Exception.Message)"
        }
        # Try create EventLog
        try {
            if ($WriteEventLog) {
                Create-EventLog -LogName $EventLogName -LogSource $EventLogSource
            }
        }
        catch {
            Throw "Could create Eventlog. $($_.Exception.Message)"
        }
    }

    process {
        if ($Message -eq $null) { return }
	
	    # filter for colored text output
        filter ColorPatternTag([ConsoleColor]$Color = "White") 
        {
            $split = $_ -split "(<.*?\>.*?\</.*?\>)"

            for( $i = 0; $i -lt $split.Count; ++$i ) 
            {
                $_find = [System.Text.RegularExpressions.Regex]::Match($split[$i], "\<(?'farbe'.*?)\>(?'text'.*?)\</\k'farbe'\>")
                if ($_find.Success) {
                    Write-Host  $($_find.Groups['text'].value) -ForegroundColor $($_find.Groups['farbe'].value) -NoNewline
                }
                else {
                    Write-Host $split[$i] -ForegroundColor $Color -NoNewline
                }
            }
            
            Write-Host -NoNewline:$NoNewline
        }

    	# define an empty stringbuilder
        [System.Text.StringBuilder] $_string = New-Object System.Text.StringBuilder
        [System.Text.StringBuilder] $_type   = New-Object System.Text.StringBuilder
        [System.ConsoleColor] $_color   = [console]::ForegroundColor
        [System.Text.StringBuilder] $_indent = New-Object System.Text.StringBuilder

        # fill the indent with spaces
        for ($i = 0; $i -lt $Indent; $i++) { $_indent.Append(" ") | Out-Null }

        # add date and time 
        $null = $_string.Append([DateTime]::Now.ToString("yyyy-MM-dd HH:mm:ss.ffff"))
        
        switch($Type) {
            "Info" {	
		        $_type = "INFO"
                $_eventID = 0
                break
            }
            "Warning" {
                $_type = "WARN"
                $_eventID = 1
		        $_color = [System.ConsoleColor]::Yellow
                break
            }
            "Error" {
                $_type = "ERROR"
                $_eventID = 2
		        $_color = [System.ConsoleColor]::Red
                break
            }
        }

        $null = $_string.Append([String]::Format("{0,6} {1}{2}", $_type.toString(), $_indent.toString(), "$Message"))
        #fill line till end
        if ($FillLine) { $null = $_string.Append($(Fill-Line -Contract $($_string -replace "<.*?\>","").Length)) }
        
        #ONLY LIVE OUTPUT
        if ($Live) {
            # text out
            $($_string.ToString()) | ColorPatternTag -Color $_color
        
            # logfile out
            if ($LogStreamWriter -ne $null) {
                $LogStreamWriter.WriteLine($_string.ToString())
            }
        
            # eventlog out
            if ($WriteEventLog -and -not [string]::IsNullOrEmpty($Message)) {
                if ($_string.Length -gt 0) {  
                    Write-EventLog -LogName $EventLogName -Source $EventLogSource -EntryType $Type -EventId $_eventID -Message $([String]::Format("{0}{1}", $_indent.toString(), "$Message"))
                }
            }
        } else {
            # if we re not run in live modus, write the current line into buffer
            $null = $_fullString.AppendLine($_string)
        }

    }

    end {
        #if we re not run in live mode, write out the buffer, now
        if (-not $Live) {
            # text out
            $($_fullString.ToString()) | ColorPatternTag -Color $_color
            
            # logfile out
            if ($LogStreamWriter -ne $null) {
                $LogStreamWriter.WriteLine($_fullString.ToString())
            }
       
            # eventlog out
            if ($WriteEventLog) {
                if ($_fullString.Length -gt 0) {  
                    Write-EventLog -LogName $EventLogName -Source $EventLogSource -EntryType $Type -EventId $_eventID -Message $($_fullString.ToString())
                }
            }
       }

       #flush and dispose
       if ($LogStreamWriter -ne $null) {
            $LogStreamWriter.Close()
            $LogStreamWriter.Dispose()
            $FS.Close()
            $FS.Dispose()
       }
       $_string = $null
       $_fullString = $null
    }
}