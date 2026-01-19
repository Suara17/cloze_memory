@echo off
cd /d E:\flutter_app
if not exist installer mkdir installer
xcopy "build\windows\x64\runner\Release\*" "installer\" /e /i /h /y
copy "simple_installer.bat" "installer\"
echo Installation package created in installer\ directory