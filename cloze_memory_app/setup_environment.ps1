# Cloze Memory App Setup (PowerShell Alternative)

Write-Host "==========================================="
Write-Host "Cloze Memory App - PowerShell Setup Script"
Write-Host "==========================================="
Write-Host ""

# Create directories
Write-Host "Step 1: Creating directories..."
$directories = @(
    "E:\flutter",
    "E:\Android",
    "E:\Android\Sdk"
)

foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
        Write-Host "Created: $dir"
    } else {
        Write-Host "Exists: $dir"
    }
}

Write-Host ""
Write-Host "Step 2: Flutter SDK Installation"
Write-Host "==============================="
Write-Host "Please complete these steps manually:"
Write-Host ""
Write-Host "1. Open browser: https://flutter.dev/docs/get-started/install/windows"
Write-Host "2. Download latest Flutter SDK zip file"
Write-Host "3. Extract to: E:\flutter\flutter"
Write-Host "4. Verify: E:\flutter\flutter\bin\flutter.bat exists"
Write-Host ""
Write-Host "OR use Git clone (recommended, requires Git):"
Write-Host "cd /d E:\flutter"
Write-Host "git clone https://github.com/flutter/flutter.git -b stable"
Write-Host ""

Write-Host "Step 3: Android SDK Installation"
Write-Host "==============================="
Write-Host "Please complete these steps manually:"
Write-Host ""
Write-Host "1. Open browser: https://developer.android.com/studio#command-tools"
Write-Host "2. Download 'Command line tools only' zip"
Write-Host "3. Extract to: E:\Android\Sdk\cmdline-tools\latest"
Write-Host ""

Write-Host "Step 4: Environment Variables Setup"
Write-Host "==============================="
Write-Host "Add these paths to system PATH variable:"
Write-Host "- E:\flutter\flutter\bin"
Write-Host "- E:\Android\Sdk\platform-tools"
Write-Host "- E:\Android\Sdk\tools\bin"
Write-Host ""
Write-Host "How to set PATH:"
Write-Host "1. Right-click 'This PC' -> 'Properties' -> 'Advanced system settings'"
Write-Host "2. Click 'Environment Variables'"
Write-Host "3. Find 'Path' in System variables, click Edit"
Write-Host "4. Click 'New', add each path above"
Write-Host "5. Click 'OK' to save"
Write-Host ""

Write-Host "Step 5: Verification"
Write-Host "==============================="
Write-Host "After installation, run these commands in new terminal:"
Write-Host "flutter doctor --android-licenses"
Write-Host "flutter doctor"
Write-Host ""
Write-Host "If everything works, you can run the app!"
Write-Host ""

Read-Host "Press Enter to exit"