@echo off
chcp 65001 >nul
echo ===========================================
echo Cloze Memory App - E Drive Setup Script
echo ===========================================
echo.
echo This script helps you install Flutter and Android SDK on E: drive
echo.

set "FLUTTER_DIR=E:\flutter\flutter"
set "ANDROID_SDK_DIR=E:\Android\Sdk"

echo Step 1: Creating directories...
echo ================================
if not exist "E:\flutter" mkdir "E:\flutter"
if not exist "E:\Android" mkdir "E:\Android"
if not exist "E:\Android\Sdk" mkdir "E:\Android\Sdk"
echo Directories created successfully!
echo.

echo Step 2: Flutter SDK Installation
echo ================================
echo Please complete these steps manually:
echo.
echo 1. Open browser: https://flutter.dev/docs/get-started/install/windows
echo 2. Download latest Flutter SDK zip file
echo 3. Extract to: E:\flutter\flutter
echo 4. Verify: E:\flutter\flutter\bin\flutter.bat exists
echo.
echo OR use Git clone (recommended, requires Git):
echo cd /d E:\flutter
echo git clone https://github.com/flutter/flutter.git -b stable
echo.

echo Step 3: Android SDK Installation
echo ================================
echo Please complete these steps manually:
echo.
echo 1. Open browser: https://developer.android.com/studio#command-tools
echo 2. Download "Command line tools only" zip
echo 3. Extract to: E:\Android\Sdk\cmdline-tools\latest
echo.

echo Step 4: Environment Variables Setup
echo ================================
echo Add these paths to system PATH variable:
echo - E:\flutter\flutter\bin
echo - E:\Android\Sdk\platform-tools
echo - E:\Android\Sdk\tools\bin
echo.
echo How to set PATH:
echo 1. Right-click "This PC" -^> "Properties" -^> "Advanced system settings"
echo 2. Click "Environment Variables"
echo 3. Find "Path" in System variables, click Edit
echo 4. Click "New", add each path above
echo 5. Click "OK" to save
echo.

echo Step 5: Verification
echo ================================
echo After installation, run these commands in new terminal:
echo flutter doctor --android-licenses
echo flutter doctor
echo.
echo If everything works, you can run the app!
echo.

pause