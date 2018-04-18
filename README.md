# AdvancedLog
Powershell Module - Advanced Log

Simple and easy to use module for adding advanced logging features to powershell.

## Key Features

#### Standard-Messages
`Write-Log –Message "Standard-Messages" –Type Info`
![Example](https://github.com/MaikKram/AdvancedLog/blob/dev/gfx/sample1.png)

#### Warning-Messages
`Write-Log –Message "Warning-Messages" –Type Warning`
![Example](https://github.com/MaikKram/AdvancedLog/blob/dev/gfx/sample2.png)

#### Error-Messages
`Write-Log –Message "Error-Messages" –Type Error`
![Example](https://github.com/MaikKram/AdvancedLog/blob/dev/gfx/sample3.png)

#### Color-Tags
`Write-Log -Message "ColorTags: <black>Black</black>, <blue>Blue</blue>, <cyan>Cyan</cyan>, <darkblue>DarkBlue</darkblue>, <darkcyan>DarkCyan</darkcyan>, <darkgray>DarkGray</darkgray>, <darkgreen>DarkGreen</darkgreen>, <darkmagenta>DarkMagenta</darkmagenta>, <darkred>DarkRed</darkred>, <darkyellow>DarkYellow</darkyellow>, <darkgreen>DarkGreen</darkgreen>, <gray>Gray</gray>, <green>Green</green>, <magenta>Magenta</magenta>, <red>Red</red>, <white>White</white>, <yellow>Yellow</yellow>" -Type Info`
![Example](https://github.com/MaikKram/AdvancedLog/blob/dev/gfx/sample4.png)

#### Pipe-Parameter
`Ping 127.0.0.1 | Write-Log`
![Example](https://github.com/MaikKram/AdvancedLog/blob/dev/gfx/sample5.png)

#### Live-Output
`Ping 127.0.0.1 | Write-Log -Live`

#### Live-Output
`Ping 127.0.0.1 | Write-Log -Live`

#### Fill-Line
`Ping 127.0.0.1 | Write-Log -FillLine`
![Example](https://github.com/MaikKram/AdvancedLog/blob/dev/gfx/sample6.png)
![Example](https://github.com/MaikKram/AdvancedLog/blob/dev/gfx/sample6.1.png)

#### Indent-Line
`Write-Log "Indent" -Indent 10`

#### Event-Log
`Write-Log "EventLog" -WriteEventLog -EventLogName "Test" -EventLogSource "Test"`

#### Log-File 
`Write-Log "Log File" -LogFile ".\test.log"`

##### or combine anything together


## Further features planed

* Streamoutput (direct output from the message-streams)
* Customizable output and graphical styling with dingbat-font
