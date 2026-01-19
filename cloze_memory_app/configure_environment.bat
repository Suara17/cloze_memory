@echo off
chcp 65001 >nul
echo Setting up environment variables for Flutter development on E: drive...
echo.

REM Flutter paths
setx FLUTTER_HOME "E:\flutter" /M
setx PATH "%PATH%;E:\flutter\bin" /M

REM Android SDK paths
setx ANDROID_HOME "E:\Android\Sdk" /M
setx ANDROID_SDK_ROOT "E:\Android\Sdk" /M
setx PATH "%PATH%;E:\Android\Sdk\platform-tools;E:\Android\Sdk\tools\bin" /M

echo Environment variables configured!
echo Please restart your command prompt and run: flutter doctor
echo.

pause