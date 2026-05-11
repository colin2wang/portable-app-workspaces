@echo off
chcp 65001 >nul
title Portable App Project Cleanup Tool

:: Get script directory
set "SCRIPT_DIR=%~dp0"

:: Execute PowerShell script
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%clean-gitignored-files.ps1"

pause
