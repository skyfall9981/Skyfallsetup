
$desktop = [Environment]::GetFolderPath("Desktop")
$logPath = "$env:USERPROFILE\SkyStart.log"
$sharedFolder = "$env:USERPROFILE\SkyShared"

# Ensure log file and shared folder exist
if (!(Test-Path $logPath)) { New-Item -ItemType File -Path $logPath | Out-Null }
if (!(Test-Path $sharedFolder)) { New-Item -ItemType Directory -Path $sharedFolder | Out-Null }

# Create autorun Task Scheduler entry (SkyCompanion Service Mode)
$taskScript = @"
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command `
 'Start-Process powershell -ArgumentList \"-NoProfile -ExecutionPolicy Bypass -File `\"$env:USERPROFILE\\SkyCompanion.ps1`\"\"'
"@
$taskPath = "$env:USERPROFILE\SkyCompanion_AutoRun.bat"
$taskScript | Out-File -Encoding ASCII -FilePath $taskPath

# Register the task to run at logon
$taskName = "SkyCompanion_AutoRun"
SCHTASKS /Create /F /TN $taskName /TR "`"$taskPath`"" /SC ONLOGON /RL HIGHEST /RU $env:USERNAME | Out-Null

# Write log entry
Add-Content -Path $logPath -Value "$(Get-Date -Format 'u') - SkyCompanion autorun task registered."

# GUI: SkyCenter
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
$form = New-Object System.Windows.Forms.Form
$form.Text = "SkyCenter Command Panel"
$form.Size = New-Object System.Drawing.Size(420,280)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Welcome to SkyCenter"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(140,20)
$form.Controls.Add($label)

$btnKali = New-Object System.Windows.Forms.Button
$btnKali.Text = "🧨 Launch Kali Dashboard"
$btnKali.Size = New-Object System.Drawing.Size(320,30)
$btnKali.Location = New-Object System.Drawing.Point(50,60)
$btnKali.Add_Click({
  Start-Process "$env:USERPROFILE\Desktop\SkyStart_AI_Dashboard.exe"
})
$form.Controls.Add($btnKali)

$btnSync = New-Object System.Windows.Forms.Button
$btnSync.Text = "🔁 Launch SkyCompanion Now"
$btnSync.Size = New-Object System.Drawing.Size(320,30)
$btnSync.Location = New-Object System.Drawing.Point(50,100)
$btnSync.Add_Click({
  Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File $env:USERPROFILE\Downloads\SkyCompanion.ps1"
})
$form.Controls.Add($btnSync)

$btnLog = New-Object System.Windows.Forms.Button
$btnLog.Text = "📜 View SkyStart Log"
$btnLog.Size = New-Object System.Drawing.Size(320,30)
$btnLog.Location = New-Object System.Drawing.Point(50,140)
$btnLog.Add_Click({
  Start-Process notepad $logPath
})
$form.Controls.Add($btnLog)

$btnClose = New-Object System.Windows.Forms.Button
$btnClose.Text = "❌ Exit"
$btnClose.Size = New-Object System.Drawing.Size(120,30)
$btnClose.Location = New-Object System.Drawing.Point(150,190)
$btnClose.Add_Click({ $form.Close() })
$form.Controls.Add($btnClose)

$form.Topmost = $true
$form.ShowDialog()
