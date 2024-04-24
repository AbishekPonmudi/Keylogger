               # /// This script is developed by havox
               # @copyrights under MIT licence //

# funtion decleared for the key detection
function Log-Keys {

    # store the key log output at this location 
    $logFolderPath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads\KeyLogs"
    if (-not (Test-Path -Path $logFolderPath)) {        New-Item -Path $logFolderPath -ItemType Directory | Out-Null
    }
    # file format to store the key logs
    $logFilePath = Join-Path -Path $logFolderPath -ChildPath "keylog.txt"
    Write-Host "Keylogs: "
    try {
        while ($true) {
            $key = $Host.UI.RawUI.ReadKey("IncludeKeyDown,NoEcho")
            $keyName = $key.VirtualKeyCode

            # key valuse defined to detect the key pressed 
           switch ($keyName) {
                {$_ -eq 8} { $keyName = "BACKSPACE" }
                {$_ -eq 9} { $keyName = "TAB" }
                {$_ -eq 13} { $keyName = "ENTER_KEY" }
                {$_ -eq 16} { $keyName = "SHIFT" }
                {$_ -eq 17} { $keyName = "CONTROL_KEY" }
                {$_ -eq 18} { $keyName = "ALT" }
                {$_ -eq 32} { $keyName = "SPACEBAR" }
                {$_ -eq 27} { $keyName = "ESC" }
                {$_ -eq 37} { $keyName = "LEFT_ARROW_KEY" }
                {$_ -eq 38} { $keyName = "UP_ARROW_KEY" }
                {$_ -eq 39} { $keyName = "RIGHT_ARROW_KEY" }
                {$_ -eq 40} { $keyName = "DOWN_ARROW_KEY" }
                {$_ -eq 91} { $keyName = "left WIndows Key"}
                {$_ -eq 20} { $KeyName = "CAPLOCK KEY"}
                {$_ -eq 42} { $KeyName = "Print Key"}
                {$_ -eq 112} { $KeyName = "F1"}
                {$_ -eq 113} { $KeyName = "F2"}
                {$_ -eq 114} { $KeyName = "F3"}
                {$_ -eq 115} { $KeyName = "F4"}
                {$_ -eq 116} { $KeyName = "F5"}
                {$_ -eq 117} { $KeyName = "F6"}
                {$_ -eq 118} { $KeyName = "F7"}
                {$_ -eq 119} { $KeyName = "F8"}
                {$_ -eq 120} { $KeyName = "F9"}
                {$_ -eq 121} { $KeyName = "F10"}
                {$_ -eq 122} { $KeyName = "F11"}
               default { $keyName = [char]$key.Character }
            }
             $timeStamp = Get-Date -Format "MM-dd-yyyy HH:mm:ss"
            $logEntry = "[$timeStamp] |$keyName|"

            # this line used to display the key logs
            Write-Host $logEntry 

            # to store the key logs
            Add-content -Path $logFilePath -Value $logEntry
        }
    } finally {
         # Close and save the log file
         $logFile = Get-Item $logFilePath
         $logFile.Close()
     }
}
Log-Keys