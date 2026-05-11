Function CustomLaunch
  ; 启动前创建同名文件占位，阻止夸克自建更新目录
  nsExec::ExecToLog 'cmd.exe /c "echo. > "%LocalAppData%\quark-cloud-drive-updater" 2>NUL"'
FunctionEnd

Function CustomClose
FunctionEnd