@echo off
chcp 65001 >nul
echo ============================================
echo Complete Flutter Environment Setup
echo ============================================
echo.

echo [1/4] Checking Flutter SDK...
if exist "E:\flutter\bin\flutter.bat" (
    echo ^[OK^] Flutter SDK found at E:\flutter
) else (
    echo ^[ERROR^] Flutter SDK not found at E:\flutter\bin\flutter.bat
    echo Please run setup.bat and choose option 1 to install Flutter
    pause
    exit /b 1
)

echo.
echo [2/4] Downloading Android SDK...
echo This may take several minutes...
powershell.exe -Command "& {try { Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip' -OutFile 'E:\temp\android-tools.zip' -UseBasicParsing; Write-Host 'Download complete' } catch { Write-Host 'Download failed, trying alternative method...' }}"

if exist "E:\temp\android-tools.zip" (
    echo Extracting Android SDK...
    powershell.exe -Command "& { try { Expand-Archive -Path 'E:\temp\android-tools.zip' -DestinationPath 'E:\Android\Sdk' -Force; Write-Host 'Extraction complete' } catch { Write-Host 'Extraction failed' }}"
    del "E:\temp\android-tools.zip" 2>nul
) else (
    echo ^[WARNING^] Automatic download failed
    echo Please download Android SDK manually from:
    echo https://developer.android.com/studio#command-tools
    echo Extract to: E:\Android\Sdk\cmdline-tools\latest
    echo.
    echo Press any key after manual installation...
    pause
)

echo.
echo [3/4] Configuring environment variables...
setx FLUTTER_HOME "E:\flutter" /M >nul 2>&1
setx ANDROID_HOME "E:\Android\Sdk" /M >nul 2>&1
setx ANDROID_SDK_ROOT "E:\Android\Sdk" /M >nul 2>&1

REM Update PATH
for /f "tokens=2*" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul') do set "CURRENT_PATH=%%j"
set "NEW_PATH=%CURRENT_PATH%;E:\flutter\bin;E:\Android\Sdk\platform-tools;E:\Android\Sdk\tools\bin"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH /t REG_EXPAND_SZ /d "%NEW_PATH%" /f >nul 2>&1

echo ^[OK^] Environment variables configured

echo.
echo [4/4] Initializing Android SDK...
if exist "E:\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat" (
    echo Running Android SDK manager...
    call "E:\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat" --install "platform-tools" --sdk_root="E:\Android\Sdk" >nul 2>&1
    echo ^[OK^] Android SDK initialized
) else (
    echo ^[WARNING^] SDK manager not found, you may need to install Android SDK manually
)

echo.
echo ================================
echo Setup complete! Please:
echo 1. RESTART your command prompt
echo 2. Run: flutter doctor --android-licenses
echo 3. Run: flutter doctor
echo 4. Run: check_setup.bat to verify
echo 5. Run: run.bat to start the app
echo ================================

pause