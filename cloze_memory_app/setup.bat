@echo off
chcp 65001 >nul
echo ============================================
echo Flutter Environment Setup - Quick Start
echo ============================================
echo.

echo Choose installation method:
echo [1] Automatic installation (PowerShell - Recommended)
echo [2] Manual installation (Step by step)
echo [3] Just configure environment variables
echo [4] Check current setup
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" (
    echo.
    echo Starting automatic installation...
    echo This will download Flutter and Android SDK automatically
    echo.
    pause
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0auto_install.ps1"
) else if "%choice%"=="2" (
    echo.
    echo Opening manual installation guide...
    start notepad "%~dp0MANUAL_SETUP.md"
    echo.
    echo Please follow the instructions in the opened file.
    pause
) else if "%choice%"=="3" (
    echo.
    echo Configuring environment variables...
    call "%~dp0configure_environment.bat"
) else if "%choice%"=="4" (
    echo.
    echo Checking current setup...
    call "%~dp0check_setup.bat"
) else (
    echo Invalid choice. Please run again.
    pause
    exit /b 1
)

echo.
echo Setup complete! Please restart your command prompt.
pause