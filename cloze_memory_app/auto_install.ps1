# Flutter and Android SDK Auto-Downloader
# Run this script as Administrator

Write-Host "==========================================="
Write-Host "Flutter & Android SDK Auto-Installer for E: drive"
Write-Host "==========================================="
Write-Host ""

# Check if running as administrator
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $principal.IsInRole($adminRole)) {
    Write-Host "Please run this script as Administrator!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

# Create directories
Write-Host "Creating directories..."
$dirs = @("E:\flutter", "E:\Android", "E:\Android\Sdk", "E:\temp")
foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "Created: $dir" -ForegroundColor Green
    }
}

# Download Flutter SDK
Write-Host ""
Write-Host "Downloading Flutter SDK..."
$flutterUrl = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.19.6-stable.zip"
$flutterZip = "E:\temp\flutter.zip"

try {
    Invoke-WebRequest -Uri $flutterUrl -OutFile $flutterZip -UseBasicParsing
    Write-Host "Flutter SDK downloaded successfully" -ForegroundColor Green

    # Extract Flutter
    Write-Host "Extracting Flutter SDK..."
    Expand-Archive -Path $flutterZip -DestinationPath "E:\flutter" -Force
    Write-Host "Flutter SDK extracted to E:\flutter\flutter" -ForegroundColor Green
} catch {
    Write-Host "Failed to download Flutter SDK. Please download manually from:" -ForegroundColor Red
    Write-Host "https://flutter.dev/docs/get-started/install/windows" -ForegroundColor Yellow
}

# Download Android Command Line Tools
Write-Host ""
Write-Host "Downloading Android Command Line Tools..."
$androidUrl = "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
$androidZip = "E:\temp\android-tools.zip"

try {
    Invoke-WebRequest -Uri $androidUrl -OutFile $androidZip -UseBasicParsing
    Write-Host "Android tools downloaded successfully" -ForegroundColor Green

    # Extract Android tools
    Write-Host "Extracting Android Command Line Tools..."
    Expand-Archive -Path $androidZip -DestinationPath "E:\Android\Sdk" -Force
    Write-Host "Android tools extracted to E:\Android\Sdk\cmdline-tools" -ForegroundColor Green
} catch {
    Write-Host "Failed to download Android tools. Please download manually from:" -ForegroundColor Red
    Write-Host "https://developer.android.com/studio#command-tools" -ForegroundColor Yellow
}

# Clean up
if (Test-Path "E:\temp") {
    Remove-Item "E:\temp" -Recurse -Force
}

# Set environment variables
Write-Host ""
Write-Host "Setting environment variables..."
[System.Environment]::SetEnvironmentVariable("FLUTTER_HOME", "E:\flutter", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", "E:\Android\Sdk", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", "E:\Android\Sdk", [System.EnvironmentVariableTarget]::Machine)

# Update PATH
$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
$newPaths = @("E:\flutter\flutter\bin", "E:\Android\Sdk\platform-tools", "E:\Android\Sdk\tools\bin")
foreach ($path in $newPaths) {
    if ($currentPath -notlike "*$path*") {
        $currentPath += ";$path"
    }
}
[System.Environment]::SetEnvironmentVariable("PATH", $currentPath, [System.EnvironmentVariableTarget]::Machine)

Write-Host "Environment variables configured!" -ForegroundColor Green

Write-Host ""
Write-Host "==========================================="
Write-Host "Installation Summary:"
Write-Host "- Flutter SDK: E:\flutter\flutter"
Write-Host "- Android SDK: E:\Android\Sdk"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Restart your command prompt"
Write-Host "2. Run: flutter doctor --android-licenses"
Write-Host "3. Run: flutter doctor"
Write-Host "4. Run: check_setup.bat to verify"
Write-Host "5. Run: run.bat to start the app"
Write-Host "==========================================="

Read-Host "Press Enter to exit"