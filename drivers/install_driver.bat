@echo off
REM STM32 DFU WinUSB Driver Installer
REM This script installs the WinUSB driver for STM32 DFU devices on Windows

setlocal enabledelayedexpansion

REM Check if running as Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    echo ERROR: This script must be run as Administrator!
    echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo   STM32 DFU WinUSB Driver Installer
echo ============================================================
echo.
echo This script will install the WinUSB driver for STM32 DFU devices.
echo.
echo Before continuing:
echo 1. Connect your STM32 flight controller in DFU mode
echo    (Boot0 pin HIGH, then press Reset)
echo 2. Make sure the device appears in Device Manager
echo.
pause

REM Get the directory where this script is located
set SCRIPT_DIR=%~dp0
set INF_FILE=%SCRIPT_DIR%STM32_DFU_WinUSB.inf

REM Check if INF file exists
if not exist "%INF_FILE%" (
    echo.
    echo ERROR: STM32_DFU_WinUSB.inf not found in:
    echo "%SCRIPT_DIR%"
    echo.
    pause
    exit /b 1
)

echo Installing driver from: %INF_FILE%
echo.

REM Install the driver
pnputil /add-driver "%INF_FILE%" /install

if %errorlevel% equ 0 (
    echo.
    echo ============================================================
    echo   Driver installation successful!
    echo ============================================================
    echo.
    echo Next steps:
    echo 1. Restart your computer (recommended)
    echo 2. Connect your flight controller
    echo 3. You should now be able to flash firmware
    echo.
) else (
    echo.
    echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    echo   Driver installation failed!
    echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    echo.
    echo Troubleshooting:
    echo - Ensure your STM32 device is connected in DFU mode
    echo - Try restarting your computer and running this script again
    echo - Check Device Manager for unknown devices
    echo.
)

pause
