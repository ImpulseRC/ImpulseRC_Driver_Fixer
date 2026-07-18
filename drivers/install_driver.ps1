# STM32 DFU WinUSB Driver Installer
# This script installs the WinUSB driver for STM32 DFU devices on Windows

# Check if running as Administrator
$isAdmin = [System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544'
if (-not $isAdmin) {
    Write-Host ""
    Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Red
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   STM32 DFU WinUSB Driver Installer" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This script will install the WinUSB driver for STM32 DFU devices." -ForegroundColor White
Write-Host ""
Write-Host "Before continuing:" -ForegroundColor Yellow
Write-Host "1. Connect your STM32 flight controller in DFU mode" -ForegroundColor Yellow
Write-Host "   (Boot0 pin HIGH, then press Reset)" -ForegroundColor Yellow
Write-Host "2. Make sure the device appears in Device Manager" -ForegroundColor Yellow
Write-Host ""
Read-Host "Press Enter to continue"

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$infFile = Join-Path $scriptDir "STM32_DFU_WinUSB.inf"

# Check if INF file exists
if (-not (Test-Path $infFile)) {
    Write-Host ""
    Write-Host "ERROR: STM32_DFU_WinUSB.inf not found in:" -ForegroundColor Red
    Write-Host "$scriptDir" -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Installing driver from: $infFile" -ForegroundColor White
Write-Host ""

# Install the driver
$infPath = (Resolve-Path $infFile).Path
try {
    pnputil /add-driver "$infPath" /install
    $lastExitCode = $LASTEXITCODE
} catch {
    $lastExitCode = 1
    Write-Host "Error running pnputil: $_" -ForegroundColor Red
}

Write-Host ""

if ($lastExitCode -eq 0) {
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host "   Driver installation successful!" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor White
    Write-Host "1. Restart your computer (recommended)" -ForegroundColor White
    Write-Host "2. Connect your flight controller" -ForegroundColor White
    Write-Host "3. You should now be able to flash firmware" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Red
    Write-Host "   Driver installation failed!" -ForegroundColor Red
    Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host "- Ensure your STM32 device is connected in DFU mode" -ForegroundColor Yellow
    Write-Host "- Try restarting your computer and running this script again" -ForegroundColor Yellow
    Write-Host "- Check Device Manager for unknown devices" -ForegroundColor Yellow
    Write-Host ""
}

Read-Host "Press Enter to exit"
