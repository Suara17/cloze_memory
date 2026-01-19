@echo off
echo ============================================
echo Visual Studio Installation Status
echo ============================================
echo.

echo Checking for Visual Studio Build Tools...
echo.

REM Check for MSBuild
where msbuild >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] MSBuild found
    for /f "tokens=*" %%i in ('where msbuild') do echo      Location: %%i
) else (
    echo [ERROR] MSBuild not found
)

echo.

REM Check for Visual C++ compiler
where cl >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Visual C++ compiler found
    for /f "tokens=*" %%i in ('where cl') do echo      Location: %%i
) else (
    echo [ERROR] Visual C++ compiler not found
)

echo.

REM Check for Windows SDK
if exist "C:\Program Files (x86)\Windows Kits\10" (
    echo [OK] Windows SDK found
) else if exist "C:\Program Files\Windows Kits\10" (
    echo [OK] Windows SDK found
) else (
    echo [WARNING] Windows SDK not found in standard locations
)

echo.

REM Flutter doctor check
echo Checking Flutter doctor...
flutter doctor | findstr "Visual Studio"
echo.

echo ================================
echo If you see [ERROR] messages above:
echo 1. Install Visual Studio Build Tools
echo 2. Select "Desktop development with C++" workload
echo 3. Restart computer
echo 4. Run this script again
echo.
echo Download: https://visualstudio.microsoft.com/downloads/
echo ================================

pause