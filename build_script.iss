[Setup]
AppName=GPTWindow
AppVersion=1.0.1+1
DefaultDirName={pf}\GPTWindow
DefaultGroupName=GPTWindow
OutputDir=.
OutputBaseFilename=GPTWindowInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "C:\Users\abhij\Desktop\Projects\gptwidget\build\windows\x64\runner\Release\gptwidget.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\abhij\Desktop\Projects\gptwidget\build\windows\x64\runner\Release\*.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\GPTWindow"; Filename: "{app}\gptwidget.exe"
Name: "{{group}}\Uninstall GPTWindow"; Filename: "{{un}}\GPTWindowInstaller.exe"

[UninstallDelete]
Type: filesandordirs; Name: "{app}\*"
