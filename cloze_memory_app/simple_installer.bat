@echo off
chcp 65001 >nul
echo ===========================================
echo Cloze Memory App - Simple Installer
echo ===========================================
echo.

cd /d %~dp0

echo [1/4] Checking if application files exist...
if not exist "cloze_memory_app.exe" (
    echo [ERROR] cloze_memory_app.exe not found in current directory
    echo Please make sure the exe file is in the same directory as this installer
    pause
    exit /b 1
)
echo [OK] Application files found
echo.

echo [2/4] Choosing installation directory...
set "INSTALL_DIR=%PROGRAMFILES%\Cloze Memory App"
if not "%1"=="" set "INSTALL_DIR=%1"

echo Installing to: %INSTALL_DIR%
echo Press any key to continue or Ctrl+C to cancel...
pause >nul
echo.

echo [3/4] Installing application...
if exist "%INSTALL_DIR%" (
    echo Removing old installation...
    rmdir /s /q "%INSTALL_DIR%"
)

mkdir "%INSTALL_DIR%" 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Failed to create installation directory
    echo Please run as administrator
    pause
    exit /b 1
)

echo Copying files...
copy "cloze_memory_app.exe" "%INSTALL_DIR%\" >nul
copy "*.dll" "%INSTALL_DIR%\" >nul 2>nul
if exist "data" xcopy "data" "%INSTALL_DIR%\data\" /e /i /h /y >nul 2>nul

echo [OK] Files installed
echo.

echo [4/4] Creating shortcuts...
echo Creating desktop shortcut...
powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Cloze Memory App.lnk'); $Shortcut.TargetPath = '%INSTALL_DIR%\cloze_memory_app.exe'; $Shortcut.Save()"

echo Creating start menu shortcut...
if not exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cloze Memory App" mkdir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cloze Memory App"
powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\Cloze Memory App\Cloze Memory App.lnk'); $Shortcut.TargetPath = '%INSTALL_DIR%\cloze_memory_app.exe'; $Shortcut.Save()"

echo Creating uninstaller...
(
echo @echo off
echo echo Uninstalling Cloze Memory App...
echo rmdir /s /q "%INSTALL_DIR%"
echo del "%USERPROFILE%%\Desktop\Cloze Memory App.lnk"
echo rmdir /s /q "%APPDATA%%\Microsoft\Windows\Start Menu\Programs\Cloze Memory App"
echo echo Uninstallation complete.
echo pause
) > "%INSTALL_DIR%\uninstall.bat"

echo [OK] Shortcuts created
echo.

echo ================================
echo Installation completed successfully!
echo ================================
echo.
echo Application installed to: %INSTALL_DIR%
echo Desktop shortcut created
echo Start menu shortcut created
echo.
echo To run the application:
echo - Double-click the desktop shortcut
echo - Or use Start menu: Cloze Memory App
echo.
echo To uninstall, run: %INSTALL_DIR%\uninstall.bat
echo.
pause