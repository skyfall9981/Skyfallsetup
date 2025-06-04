
[Setup]
AppName=SkyFall AI Stack
AppVersion=1.0
DefaultDirName={userpf}\SkyStartAI
DefaultGroupName=SkyFall
OutputDir={userdocs}
OutputBaseFilename=SkyFallSetup
Compression=lzma
SolidCompression=yes

[Files]
Source: "SkyCenter_Launcher.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "SkyCompanion.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "SkyAgent_Monitor.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "SkyStart_OneClick_Deploy.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "SkyStart_GitHub_Connector.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "SkyStart_AI_Icon.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "SkyStart_Splash.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "SkyStart_Access_Links.txt"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{userdesktop}\SkyCenter"; Filename: "{app}\SkyCenter_Launcher.ps1"; WorkingDir: "{app}"; IconFilename: "{app}\SkyStart_AI_Icon.ico"
Name: "{userstartup}\SkyCenter"; Filename: "{app}\SkyCenter_Launcher.ps1"; WorkingDir: "{app}"; IconFilename: "{app}\SkyStart_AI_Icon.ico"

[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\SkyCenter_Launcher.ps1"""; Flags: shellexec
