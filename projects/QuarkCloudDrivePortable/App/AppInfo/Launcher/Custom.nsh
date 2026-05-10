Function CustomLaunch
  nsExec::ExecToLog 'cmd.exe /c "taskkill /f /im QuarkCloudDrive* >NUL 2>NUL & rd/s/q "%AppData%\quark-cloud-drive" 2>NUL & rd/s/q "%LocalAppData%\quark-cloud-drive" 2>NUL & rd/s/q "%LocalAppData%\quark-cloud-drive-updater" 2>NUL & echo. > "%LocalAppData%\quark-cloud-drive-updater" 2>NUL"'
FunctionEnd

Function CustomClose
FunctionEnd