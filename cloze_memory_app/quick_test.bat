@echo off
echo ============================================
echo Quick Environment Test
echo ============================================
echo.

echo Testing environment variables...
echo JAVA_HOME: %JAVA_HOME%
echo FLUTTER_HOME: %FLUTTER_HOME%
echo ANDROID_HOME: %ANDROID_HOME%

echo.
echo Testing commands...
where flutter >nul 2>&1 && echo [OK] Flutter found || echo [ERROR] Flutter not found
where java >nul 2>&1 && echo [OK] Java found || echo [ERROR] Java not found

echo.
echo If all tests show [OK], you can run: flutter run -d windows
echo If not, please run env_updated.bat and follow the instructions.

pause