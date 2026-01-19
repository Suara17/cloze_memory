@echo off
echo ============================================
echo Flutter Environment Diagnostic
echo ============================================
echo.

echo Checking environment variables...
echo.

echo JAVA_HOME = %JAVA_HOME%
echo FLUTTER_HOME = %FLUTTER_HOME%
echo ANDROID_HOME = %ANDROID_HOME%
echo ANDROID_SDK_ROOT = %ANDROID_SDK_ROOT%

echo.
echo Checking PATH...
echo %PATH%
echo.

echo.
echo Testing commands...
echo.

echo Testing flutter command...
flutter --version
if %errorlevel% neq 0 (
    echo [ERROR] Flutter command failed
) else (
    echo [OK] Flutter command works
)

echo.
echo Testing java command...
java -version 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Java command failed
) else (
    echo [OK] Java command works
)

echo.
echo Testing flutter devices...
flutter devices

echo.
echo Current directory: %CD%

pause