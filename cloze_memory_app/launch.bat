@echo off
chcp 65001 >nul
echo ===========================================
echo Cloze Memory App - Smart Launcher
echo ===========================================
echo.

cd /d %~dp0

echo Checking environment...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found. Please run setup.bat first.
    pause
    exit /b 1
)

echo.
echo Available platforms:
echo 1. Windows Desktop (requires Visual Studio)
echo 2. Chrome Web Browser
echo 3. Check system status
echo.

set /p choice="Choose platform (1-3): "

if "%choice%"=="1" (
    echo.
    echo Checking Visual Studio...
    where msbuild >nul 2>&1
    if %errorlevel% neq 0 (
        echo [ERROR] Visual Studio Build Tools not found!
        echo Please install Visual Studio Build Tools first.
        echo See VS_INSTALL_GUIDE.md for instructions.
        pause
        exit /b 1
    )

    echo [OK] Visual Studio ready
    echo.
    echo Starting Windows Desktop App...
    flutter run -d windows

) else if "%choice%"=="2" (
    echo.
    echo Starting Web App in Chrome...
    flutter run -d chrome

) else if "%choice%"=="3" (
    echo.
    echo System Status Check:
    echo ================================
    flutter doctor
    echo ================================
    pause

) else (
    echo Invalid choice. Please run again.
    pause
)

echo.
echo App finished.
pause