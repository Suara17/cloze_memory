@echo off
chcp 65001 >nul
echo ===========================================
echo Cloze Memory App - Create Windows Installer
echo ===========================================
echo.

cd /d %~dp0

echo [1/6] Checking if release build exists...
if not exist "build\windows\x64\runner\Release\cloze_memory_app.exe" (
    echo [ERROR] Release build not found
    echo Please run build_release.bat first
    pause
    exit /b 1
)
echo [OK] Release build found
echo.

echo [2/6] Checking NSIS installation...
where makensis >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] NSIS not found
    echo Attempting to download and install NSIS...

    if not exist "nsis-setup.exe" (
        echo Downloading NSIS...
        powershell -Command "Invoke-WebRequest -Uri 'https://nsis.sourceforge.io/mediawiki/images/1/1c/NSIS_3.08_setup.exe' -OutFile 'nsis-setup.exe'"
        if %errorlevel% neq 0 (
            echo [ERROR] Failed to download NSIS
            echo Please download manually from: https://nsis.sourceforge.io/Download
            pause
            exit /b 1
        )
    )

    echo Installing NSIS (silent install)...
    nsis-setup.exe /S
    if %errorlevel% neq 0 (
        echo [ERROR] NSIS installation failed
        echo Please install manually
        pause
        exit /b 1
    )

    echo [OK] NSIS installed
) else (
    echo [OK] NSIS found
)
echo.

echo [3/6] Creating installer directory structure...
if exist "installer_temp" rmdir /s /q "installer_temp"
mkdir "installer_temp"
mkdir "installer_temp\app"

echo Copying application files...
xcopy "build\windows\x64\runner\Release\*" "installer_temp\app\" /e /i /h /y >nul
echo [OK] Files copied
echo.

echo [4/6] Creating NSIS script...
call :create_nsis_script
echo [OK] NSIS script created
echo.

echo [5/6] Building installer...
makensis installer_script.nsi
if %errorlevel% neq 0 (
    echo [ERROR] Installer creation failed
    pause
    exit /b 1
)
echo [OK] Installer created
echo.

echo [6/6] Cleaning up...
rmdir /s /q "installer_temp"
del "installer_script.nsi"
echo [OK] Cleanup completed
echo.

echo ================================
echo Installer created successfully!
echo Location: ClozeMemoryApp_Installer.exe
echo ================================
echo.
echo You can now distribute this installer to other Windows machines.
echo The installer will automatically install the app and create desktop shortcuts.
pause
goto :eof

:create_nsis_script
echo !include "MUI2.nsh" > installer_script.nsi
echo !include "FileFunc.nsh" >> installer_script.nsi
echo !include "LogicLib.nsh" >> installer_script.nsi
echo. >> installer_script.nsi
echo Name "Cloze Memory App" >> installer_script.nsi
echo OutFile "ClozeMemoryApp_Installer.exe" >> installer_script.nsi
echo Unicode True >> installer_script.nsi
echo InstallDir "$PROGRAMFILES\Cloze Memory App" >> installer_script.nsi
echo InstallDirRegKey HKCU "Software\ClozeMemoryApp" "" >> installer_script.nsi
echo RequestExecutionLevel admin >> installer_script.nsi
echo. >> installer_script.nsi
echo !define MUI_ABORTWARNING >> installer_script.nsi
echo !define MUI_ICON "installer_temp\app\cloze_memory_app.exe" >> installer_script.nsi
echo !define MUI_UNICON "installer_temp\app\cloze_memory_app.exe" >> installer_script.nsi
echo. >> installer_script.nsi
echo !insertmacro MUI_PAGE_WELCOME >> installer_script.nsi
echo !insertmacro MUI_PAGE_DIRECTORY >> installer_script.nsi
echo !insertmacro MUI_PAGE_INSTFILES >> installer_script.nsi
echo !insertmacro MUI_PAGE_FINISH >> installer_script.nsi
echo. >> installer_script.nsi
echo !insertmacro MUI_UNPAGE_WELCOME >> installer_script.nsi
echo !insertmacro MUI_UNPAGE_CONFIRM >> installer_script.nsi
echo !insertmacro MUI_UNPAGE_INSTFILES >> installer_script.nsi
echo !insertmacro MUI_UNPAGE_FINISH >> installer_script.nsi
echo. >> installer_script.nsi
echo !insertmacro MUI_LANGUAGE "SimpChinese" >> installer_script.nsi
echo !insertmacro MUI_LANGUAGE "English" >> installer_script.nsi
echo. >> installer_script.nsi
echo Section "MainSection" SEC01 >> installer_script.nsi
echo     SetOutPath "$INSTDIR" >> installer_script.nsi
echo     File /r "installer_temp\app\*" >> installer_script.nsi
echo. >> installer_script.nsi
echo     ; Create desktop shortcut >> installer_script.nsi
echo     CreateShortCut "$DESKTOP\Cloze Memory App.lnk" "$INSTDIR\cloze_memory_app.exe" "" "$INSTDIR\cloze_memory_app.exe" 0 >> installer_script.nsi
echo. >> installer_script.nsi
echo     ; Create start menu entries >> installer_script.nsi
echo     CreateDirectory "$SMPROGRAMS\Cloze Memory App" >> installer_script.nsi
echo     CreateShortCut "$SMPROGRAMS\Cloze Memory App\Cloze Memory App.lnk" "$INSTDIR\cloze_memory_app.exe" "" "$INSTDIR\cloze_memory_app.exe" 0 >> installer_script.nsi
echo     CreateShortCut "$SMPROGRAMS\Cloze Memory App\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0 >> installer_script.nsi
echo. >> installer_script.nsi
echo     ; Registry information for add/remove programs >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "DisplayName" "Cloze Memory App" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "UninstallString" "$\"$INSTDIR\uninstall.exe$\"" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "InstallLocation" "$\"$INSTDIR$\"" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "DisplayIcon" "$\"$INSTDIR\cloze_memory_app.exe$\"" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "Publisher" "Your Name" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "HelpLink" "https://github.com/yourusername/cloze-memory-app" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "URLUpdateInfo" "https://github.com/yourusername/cloze-memory-app" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "URLInfoAbout" "https://github.com/yourusername/cloze-memory-app" >> installer_script.nsi
echo     WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "DisplayVersion" "1.0.0" >> installer_script.nsi
echo     WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "VersionMajor" 1 >> installer_script.nsi
echo     WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "VersionMinor" 0 >> installer_script.nsi
echo     WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "NoModify" 1 >> installer_script.nsi
echo     WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "NoRepair" 1 >> installer_script.nsi
echo     WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" "EstimatedSize" 50000 >> installer_script.nsi
echo. >> installer_script.nsi
echo     WriteUninstaller "$INSTDIR\Uninstall.exe" >> installer_script.nsi
echo. >> installer_script.nsi
echo SectionEnd >> installer_script.nsi
echo. >> installer_script.nsi
echo Section "Uninstall" >> installer_script.nsi
echo     Delete "$DESKTOP\Cloze Memory App.lnk" >> installer_script.nsi
echo     Delete "$SMPROGRAMS\Cloze Memory App\Cloze Memory App.lnk" >> installer_script.nsi
echo     Delete "$SMPROGRAMS\Cloze Memory App\Uninstall.lnk" >> installer_script.nsi
echo     RMDir "$SMPROGRAMS\Cloze Memory App" >> installer_script.nsi
echo. >> installer_script.nsi
echo     Delete "$INSTDIR\cloze_memory_app.exe" >> installer_script.nsi
echo     Delete "$INSTDIR\Uninstall.exe" >> installer_script.nsi
echo     RMDir "$INSTDIR" >> installer_script.nsi
echo. >> installer_script.nsi
echo     DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ClozeMemoryApp" >> installer_script.nsi
echo     DeleteRegKey HKCU "Software\ClozeMemoryApp" >> installer_script.nsi
echo SectionEnd >> installer_script.nsi
goto :eof