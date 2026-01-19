@echo off
echo ===========================================
echo Cloze Memory App - Simple Version
echo ===========================================
echo.

cd /d %~dp0

echo Checking Flutter environment...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found
    echo Please ensure Flutter is properly installed and in PATH
    pause
    exit /b 1
)
echo [OK] Flutter ready
echo.

echo Installing dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies installed
echo.

echo Starting simple version of the app...
echo This version has no file I/O or persistence to avoid issues
echo.

flutter run --target=lib/main_simple.dart -d windows

pause