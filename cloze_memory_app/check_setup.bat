@echo off
chcp 65001 >nul
echo ===========================================
echo Cloze Memory App - Setup Check Script
echo ===========================================
echo.

set "ERROR_COUNT=0"

echo [Check] Flutter SDK path...
if exist "E:\flutter\bin\flutter.bat" (
    echo ^[OK^] Flutter SDK found: E:\flutter
) else (
    echo ^[ERROR^] Flutter SDK not found: E:\flutter\bin\flutter.bat
    set /a "ERROR_COUNT+=1"
)

echo.
echo [Check] Android SDK path...
if exist "E:\Android\Sdk" (
    echo ^[OK^] Android SDK found: E:\Android\Sdk
) else (
    echo ^[ERROR^] Android SDK not found: E:\Android\Sdk
    set /a "ERROR_COUNT+=1"
)

echo.
echo [Check] PATH environment variable...
echo Looking for E:\flutter\bin ...
echo %PATH% | findstr /C:"E:\flutter\bin" >nul
if %errorlevel% equ 0 (
    echo ^[OK^] Flutter bin path in PATH
) else (
    echo ^[ERROR^] Flutter bin path not in PATH: E:\flutter\bin
    set /a "ERROR_COUNT+=1"
)

echo Looking for E:\Android\Sdk\platform-tools ...
echo %PATH% | findstr /C:"E:\Android\Sdk\platform-tools" >nul
if %errorlevel% equ 0 (
    echo ^[OK^] Android platform-tools path in PATH
) else (
    echo ^[ERROR^] Android platform-tools path not in PATH: E:\Android\Sdk\platform-tools
    set /a "ERROR_COUNT+=1"
)

echo.
echo [Check] Flutter command...
flutter --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ^[OK^] Flutter command available
) else (
    echo ^[ERROR^] Flutter command not available
    set /a "ERROR_COUNT+=1"
)

echo.
echo [Check] Project files integrity...
set "PROJECT_FILES_OK=1"
if not exist "pubspec.yaml" set "PROJECT_FILES_OK=0"
if not exist "lib\main.dart" set "PROJECT_FILES_OK=0"
if not exist "android\local.properties" set "PROJECT_FILES_OK=0"

if %PROJECT_FILES_OK% equ 1 (
    echo ^[OK^] Project files complete
) else (
    echo ^[ERROR^] Project files incomplete
    set /a "ERROR_COUNT+=1"
)

echo.
echo ================================
if %ERROR_COUNT% equ 0 (
    echo ^[SUCCESS^] All checks passed! Run run.bat to start the app
) else (
    echo ^[WARNING^] Found %ERROR_COUNT% issues
    echo Run install_environment.bat to fix these issues
)
echo ================================

pause