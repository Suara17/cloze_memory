@echo off
chcp 65001 >nul
echo ===========================================
echo Cloze Memory App - One-Click Packaging
echo ===========================================
echo.

cd /d %~dp0

echo Starting automated packaging process...
echo This will create a complete Windows installer
echo.

echo [Phase 1/2] Building Release Version
echo ====================================
call build_release.bat
if %errorlevel% neq 0 (
    echo [ERROR] Release build failed
    pause
    exit /b 1
)
echo.

echo [Phase 2/2] Creating Installer
echo ===============================
call package_installer.bat
if %errorlevel% neq 0 (
    echo [ERROR] Installer creation failed
    pause
    exit /b 1
)
echo.

echo ================================
echo PACKAGING COMPLETED SUCCESSFULLY!
echo ================================
echo.
echo Files created:
echo - Release EXE: build\windows\x64\runner\Release\cloze_memory_app.exe
echo - Installer: ClozeMemoryApp_Installer.exe
echo.
echo You can now distribute ClozeMemoryApp_Installer.exe
echo to other Windows computers for easy installation.
echo.
echo For detailed documentation, see WINDOWS_PACKAGING_GUIDE.md
echo.
pause