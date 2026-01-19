@echo off
echo ===========================================
echo Cloze Memory App - Windows Desktop
echo ===========================================
echo.

cd /d %~dp0

echo Checking environment...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found
    echo Please ensure Flutter is in your PATH
    pause
    exit /b 1
)

echo Checking Visual Studio...
where msbuild >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Visual Studio Build Tools not found
    echo Please install Visual Studio Build Tools with Desktop development with C++
    echo Download from: https://visualstudio.microsoft.com/downloads/
    pause
    exit /b 1
)

echo [OK] All prerequisites met
echo.

echo Installing dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Starting Cloze Memory App (Windows Desktop)...
echo Close this window to stop the app
echo.

flutter run -d windows

echo.
echo App closed.
pause