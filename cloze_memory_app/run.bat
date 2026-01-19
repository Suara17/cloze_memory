@echo off
chcp 65001 >nul
echo ===========================================
echo Cloze Memory App - Flutter Project Launcher
echo ===========================================
echo.

cd /d %~dp0

echo [1/4] Checking Flutter environment...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ^[ERROR^] Flutter not found
    echo Please run install_environment.bat first to install Flutter on E: drive
    echo Or manually add E:\flutter\flutter\bin to PATH environment variable
    pause
    exit /b 1
)
echo ^[OK^] Flutter environment ready
echo.

echo [2/4] Checking Android SDK...
if not exist "E:\Android\Sdk" (
    echo ^[ERROR^] Android SDK not found
    echo Please run install_environment.bat first to install Android SDK on E: drive
    pause
    exit /b 1
)
echo ^[OK^] Android SDK found
echo.

echo [3/4] Installing project dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo ^[ERROR^] Dependency installation failed
    pause
    exit /b 1
)
echo ^[OK^] Dependencies installed
echo.

echo [4/4] Starting application...
echo ================================
echo If this is your first run, it may take time to download additional dependencies
echo Please ensure you have internet connection
echo.
flutter run

pause