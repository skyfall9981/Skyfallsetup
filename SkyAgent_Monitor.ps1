
$logFile = "$env:USERPROFILE\\SkyStartAI\\SkyStart.log"
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = [System.IO.Path]::GetDirectoryName($logFile)
$watcher.Filter = [System.IO.Path]::GetFileName($logFile)
$watcher.EnableRaisingEvents = $true
$watcher.IncludeSubdirectories = $false

Register-ObjectEvent $watcher Changed -Action {
    Start-Sleep -Milliseconds 500  # small delay to allow write to finish
    $lastLine = Get-Content $logFile | Select-Object -Last 1
    if ($lastLine -match "error|fail|disconnect|unauthorized|timeout") {
        $msg = "⚠️ SkyAgent Alert: $lastLine"
        [System.Windows.Forms.MessageBox]::Show($msg, "SkyAgent Trigger", 'OK', 'Warning')
        Add-Content "$env:USERPROFILE\\SkyAgent.log" "$(Get-Date -Format u) ALERT: $lastLine"
    }
}

Write-Host "🛡️ SkyAgent is now monitoring SkyStart.log in real-time."
while ($true) { Start-Sleep -Seconds 2 }  # Keep the script alive
