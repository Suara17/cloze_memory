@echo off
echo ============================================
echo Checking Visual Studio Installation
echo ============================================
echo.

cd /d %~dp0

echo Checking Flutter doctor...
flutter doctor | findstr "Visual Studio"
echo.

echo Checking MSBuild...
where msbuild >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] MSBuild found
) else (
    echo [ERROR] MSBuild not found
    echo Please ensure Visual Studio Build Tools is properly installed
)

echo.
echo Checking cl.exe...
where cl >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Visual C++ compiler found
) else (
    echo [ERROR] Visual C++ compiler not found
    echo Please reinstall Visual Studio Build Tools with Desktop development with C++
)

echo.
echo If all checks show [OK], you can run the desktop app!
echo.

pause