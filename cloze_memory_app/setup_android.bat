@echo off
echo Accepting all Android SDK licenses...
cd /d E:\Android\Sdk\cmdline-tools\latest\bin

REM Accept all licenses automatically
echo y | sdkmanager.bat --licenses

echo Installing platform-tools...
sdkmanager.bat --install "platform-tools" --sdk_root="E:\Android\Sdk"

echo Android SDK setup complete!
pause