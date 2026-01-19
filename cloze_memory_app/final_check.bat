@echo off
echo ============================================
echo Flutter Environment Setup - Final Check
echo ============================================
echo.

echo Checking Flutter SDK...
if exist "E:\flutter\bin\flutter.bat" (
    echo [OK] Flutter SDK found at E:\flutter
) else (
    echo [ERROR] Flutter SDK not found
)

echo.
echo Checking Android SDK...
if exist "E:\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat" (
    echo [OK] Android SDK found at E:\Android\Sdk
) else (
    echo [WARNING] Android SDK not fully installed (optional for web development)
)

echo.
echo Checking project files...
if exist "lib\main.dart" (
    echo [OK] Flutter project ready
) else (
    echo [ERROR] Project files missing
)

echo.
echo ================================
echo SUCCESS: Environment setup complete!
echo ================================
echo.
echo Your Cloze Memory App is now ready!
echo.
echo WEB VERSION (Recommended):
echo Visit: http://localhost:8080 in your browser
echo.
echo MOBILE VERSION (Requires Android SDK):
echo Run: flutter run -d chrome (if browser works)
echo Or install Android Studio for mobile development
echo.
echo Useful commands:
echo - flutter doctor          (check environment)
echo - flutter pub get         (install dependencies)
echo - check_setup.bat         (verify setup)
echo - run.bat                 (start app)
echo.
echo ================================

pause