# AdvancedLog
Powershell Module - Advanced Log

Simple and easy to use module for adding advanced logging features to powershell.

## Key Features

#### Standard-Messages
`Write-Log –Message "Standard-Messages" –Type Info`

#### Warning-Messages
`Write-Log –Message "Warning-Messages" –Type Warning`

#### Error-Messages
`Write-Log –Message "Error-Messages" –Type Error`

#### Color-Tags
`Write-Log -Message "ColorTags: <black>Black</black>, <blue>Blue</blue>, <cyan>Cyan</cyan>, <darkblue>DarkBlue</darkblue>, <darkcyan>DarkCyan</darkcyan>, <darkgray>DarkGray</darkgray>, <darkgreen>DarkGreen</darkgreen>, <darkmagenta>DarkMagenta</darkmagenta>, <darkred>DarkRed</darkred>, <darkyellow>DarkYellow</darkyellow>, <darkgreen>DarkGreen</darkgreen>, <gray>Gray</gray>, <green>Green</green>, <magenta>Magenta</magenta>, <red>Red</red>, <white>White</white>, <yellow>Yellow</yellow>" -Type Info`

#### Pipe-Parameter
`Ping 127.0.0.1 | Write-Log`

#### Fill-Line
`Ping 127.0.0.1 | Write-Log -FillLine`

#### Indent-Line
`Write-Log "Indent" -Indent 10`

#### Event-Log
`Write-Log "EventLog" -WriteEventLog -EventLogName "Test" -EventLogSource "Test"`

#### Log-File 
`Write-Log "Log File" -LogFile ".\test.log"`

##### or combine anything together

