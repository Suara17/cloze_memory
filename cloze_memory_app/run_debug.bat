@echo off
echo ===========================================
echo Cloze Memory App - Flutter Project Launcher (DEBUG)
echo ===========================================
echo.

cd /d %~dp0

echo [1/4] Checking Flutter environment...
echo Current PATH: %PATH%
echo.
flutter --version
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found - ErrorLevel: %errorlevel%
    echo Please run install_environment.bat first to install Flutter on E: drive
    echo Or manually add E:\flutter\bin to PATH environment variable
    echo.
    echo Press any key to continue...
    pause >nul
    exit /b 1
)
echo [OK] Flutter environment ready
echo.

echo [2/4] Checking Android SDK...
if not exist "E:\Android\Sdk" (
    echo [ERROR] Android SDK not found at E:\Android\Sdk
    echo Please run install_environment.bat first to install Android SDK on E: drive
    echo.
    echo Press any key to continue...
    pause >nul
    exit /b 1
)
echo [OK] Android SDK found
echo.

echo [3/4] Installing project dependencies...
echo Running: flutter pub get
echo.
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Dependency installation failed - ErrorLevel: %errorlevel%
    echo This might be due to network issues or corrupted dependencies
    echo Try running: flutter pub cache clean && flutter pub get
    echo.
    echo Press any key to continue...
    pause >nul
    exit /b 1
)
echo [OK] Dependencies installed
echo.

echo [4/4] Starting application...
echo ================================
echo Available devices:
flutter devices
echo.
echo If this is your first run, it may take time to download additional dependencies
echo Please ensure you have internet connection
echo.
echo Starting Flutter app...
echo Command: flutter run
echo.

flutter run

echo.
echo Flutter app finished.
echo Press any key to exit...
pause >nul