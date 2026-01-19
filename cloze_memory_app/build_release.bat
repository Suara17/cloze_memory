@echo off
chcp 65001 >nul
echo ===========================================
echo Cloze Memory App - Build Release Version
echo ===========================================
echo.

cd /d %~dp0

echo [1/5] Checking Flutter environment...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter not found
    echo Please ensure Flutter is installed and in PATH
    pause
    exit /b 1
)
echo [OK] Flutter found
echo.

echo [2/5] Checking Visual Studio Build Tools...
where msbuild >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Visual Studio Build Tools not found
    echo Please install Visual Studio Build Tools with Desktop development with C++
    echo Download from: https://visualstudio.microsoft.com/downloads/
    pause
    exit /b 1
)
echo [OK] Visual Studio Build Tools found
echo.

echo [3/5] Installing dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies installed
echo.

echo [4/5] Building Windows release version...
flutter build windows --release
if %errorlevel% neq 0 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)
echo [OK] Release build completed
echo.

echo [5/5] Build summary:
echo ================================
echo Release executable location:
echo %~dp0build\windows\x64\runner\Release\cloze_memory_app.exe
echo.
echo To create an installer, run package_installer.bat
echo ================================
echo.
echo Build completed successfully!
echo You can find the executable in: build\windows\x64\runner\Release\
pause