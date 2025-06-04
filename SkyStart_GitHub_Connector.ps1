
# Check for credential existence
$credName = "SkyStartGitHub"

if (-not (Get-StoredCredential -Target $credName -ErrorAction SilentlyContinue)) {
    $username = "Briansecord0207@gmail.com"
    $password = ConvertTo-SecureString "Harleigh1010@" -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($username, $password)
    New-StoredCredential -Target $credName -Username $username -Password $password -Persist LocalMachine
    Write-Host "✅ GitHub credentials stored in Windows Credential Manager under 'SkyStartGitHub'"
} else {
    Write-Host "🔐 Credentials already exist in Credential Manager."
}

# Clone repo or sync
$repoURL = "https://github.com/BrianSecord0207/SkyStartAI.git"
$localPath = "$env:USERPROFILE\SkyStartAI"

if (-not (Test-Path $localPath)) {
    git clone $repoURL $localPath
    Write-Host "✅ Repo cloned to $localPath"
} else {
    Set-Location $localPath
    git pull origin main
    Write-Host "🔄 Repo updated from GitHub"
}

# Optional: Sync local SkyStart log or config to repo
$logFile = "$env:USERPROFILE\SkyStart.log"
if (Test-Path $logFile) {
    Copy-Item $logFile "$localPath\SkyStart.log" -Force
    Set-Location $localPath
    git add .
    git commit -m "Auto-sync SkyStart.log"
    git push origin main
    Write-Host "🚀 SkyStart.log synced to GitHub"
}
