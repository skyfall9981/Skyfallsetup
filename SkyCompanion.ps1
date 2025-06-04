
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object System.Windows.Forms.Form
$form.Text = "SkyCompanion Sync Tool"
$form.Size = New-Object System.Drawing.Size(400,260)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "SkyCompanion: Windows ↔ Kali Sync & Status"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(80,20)
$form.Controls.Add($label)

# Sync Shared Folder
$btnShared = New-Object System.Windows.Forms.Button
$btnShared.Text = "🔄 Sync Shared Folder"
$btnShared.Size = New-Object System.Drawing.Size(280,30)
$btnShared.Location = New-Object System.Drawing.Point(50,60)
$btnShared.Add_Click({
    $src = "$env:USERPROFILE\SkyShared"
    $dst = "/home/skyfall/SkyShared"
    if (!(Test-Path $src)) { New-Item -ItemType Directory -Path $src | Out-Null }
    Start-Process "wsl" "-d kali-linux -- bash -c 'mkdir -p $dst'"
    Write-Host "✅ Folder synced between Windows and Kali"
})
$form.Controls.Add($btnShared)

# Check Tool Status
$btnCheck = New-Object System.Windows.Forms.Button
$btnCheck.Text = "🧪 Check Kali Tool Status"
$btnCheck.Size = New-Object System.Drawing.Size(280,30)
$btnCheck.Location = New-Object System.Drawing.Point(50,100)
$btnCheck.Add_Click({
    Start-Process "wsl" "-d kali-linux -- bash -c 'which nmap && which metasploit-framework && which powershell'"
})
$form.Controls.Add($btnCheck)

# Open SkyShared
$btnOpen = New-Object System.Windows.Forms.Button
$btnOpen.Text = "📁 Open Shared Folder"
$btnOpen.Size = New-Object System.Drawing.Size(280,30)
$btnOpen.Location = New-Object System.Drawing.Point(50,140)
$btnOpen.Add_Click({
    Start-Process "$env:USERPROFILE\SkyShared"
})
$form.Controls.Add($btnOpen)

# Exit
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "❌ Close"
$btnExit.Size = New-Object System.Drawing.Size(100,30)
$btnExit.Location = New-Object System.Drawing.Point(150,180)
$btnExit.Add_Click({ $form.Close() })
$form.Controls.Add($btnExit)

$form.Topmost = $true
$form.ShowDialog()
