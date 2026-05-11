@echo off
chcp 65001 >nul
title 手动删除夸克右键菜单

echo 正在删除夸克右键菜单注册表...
reg delete "HKCR\*\shell\QuarkCloudDrive.upload" /f >nul 2>nul
reg delete "HKCR\Directory\shell\QuarkCloudDrive.upload" /f >nul 2>nul
reg delete "HKCR\Directory\shell\QuarkCloudDrive.backup" /f >nul 2>nul

echo.
echo 已清理完成！
echo 如还有残留，重启资源管理器即可。
pause >nul