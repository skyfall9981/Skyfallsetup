
# Ensure CredentialManager module exists
if (-not (Get-Module -ListAvailable -Name CredentialManager)) {
    Install-Module -Name CredentialManager -Scope CurrentUser -Force
    Import-Module CredentialManager
} else {
    Import-Module CredentialManager
}

# Step 1: Store GitHub credentials securely (only if not stored)
$credName = "SkyStartGitHub"
if (-not (Get-StoredCredential -Target $credName -ErrorAction SilentlyContinue)) {
    $username = "Briansecord0207@gmail.com"
    $password = ConvertTo-SecureString "Harleigh1010@" -AsPlainText -Force
    New-StoredCredential -Target $credName -Username $username -Password $password -Persist LocalMachine
    Write-Host "✅ GitHub credentials stored securely."
}

# Step 2: Clone GitHub Repo if not exists
$repoURL = "https://github.com/BrianSecord0207/SkyStartAI.git"
$localPath = "$env:USERPROFILE\SkyStartAI"
if (-not (Test-Path $localPath)) {
    git clone $repoURL $localPath
    Write-Host "✅ Repo cloned."
} else {
    Set-Location $localPath
    git pull origin main
    Write-Host "🔄 Repo updated."
}

# Step 3: Place SkyCenter Launcher on Desktop
$launcherScript = "$localPath\SkyCenter_Launcher.ps1"
$desktopShortcut = "$env:USERPROFILE\Desktop\SkyCenter.lnk"

$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut($desktopShortcut)
$shortcut.TargetPath = "powershell.exe"
$shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$launcherScript`""
$shortcut.IconLocation = "$localPath\SkyStart_AI_Icon.ico"
$shortcut.Save()
Write-Host "📎 Desktop shortcut created."

# Step 4: Create Startup Auto-Launch
$startupLink = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\SkyCenter.lnk"
$startupShortcut = $WshShell.CreateShortcut($startupLink)
$startupShortcut.TargetPath = "powershell.exe"
$startupShortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$launcherScript`""
$startupShortcut.IconLocation = "$localPath\SkyStart_AI_Icon.ico"
$startupShortcut.Save()
Write-Host "🚀 Auto-start setup complete."

# Step 5: Launch SkyCenter Immediately
Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$launcherScript`""
Write-Host "🧠 SkyCenter AI is now active."
