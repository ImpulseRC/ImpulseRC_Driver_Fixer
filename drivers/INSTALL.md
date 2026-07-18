# STM32 DFU WinUSB Driver Installation Guide

## Overview

This guide explains how to install the WinUSB driver for STM32-based flight controllers in DFU (Device Firmware Update) mode. This is necessary for flashing firmware using tools like dfu-util.

## Problem This Solves

When you connect an STM32 controller to Windows in DFU mode, Windows may recognize it with an incompatible driver (e.g., STTub30). This prevents firmware flashing tools like dfu-util from accessing the device. The error message will be:

```
ERROR: Cannot open DFU device 0483:df11
LIBUSB_ERROR_NOT_SUPPORTED
```

This WinUSB driver installation makes the device accessible to libusb and dfu-util.

## Device Information

- **Vendor ID (VID):** 0x0483 (STMicroelectronics)
- **Product ID (PID):** 0xDF11 (STM32 Device in DFU Mode)
- **Supported:** STM32F3, STM32F4, STM32F7 series and compatible controllers

## Installation Methods

### Method 1: Automatic Installation (Recommended)

#### Using Windows Batch File

1. **Run as Administrator:**
   - Right-click `install_driver.bat`
   - Select "Run as administrator"

2. **Follow the prompts:**
   - Connect your flight controller in DFU mode
   - Press Enter to begin installation
   - Wait for completion
   - Restart your computer when prompted

#### Using PowerShell Script

1. **Open PowerShell as Administrator:**
   - Press `Win + X`, select "Windows PowerShell (Admin)"
   - Or search for "PowerShell" in Start menu, right-click → "Run as Administrator"

2. **Navigate to the drivers folder:**
   ```powershell
   cd "C:\Path\To\drivers"  # Replace with actual path
   ```

3. **Enable script execution (if needed):**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
   ```

4. **Run the installer:**
   ```powershell
   .\install_driver.ps1
   ```

5. **Follow the prompts**

### Method 2: Manual Installation via Device Manager

1. **Enter DFU Mode:**
   - Connect your flight controller to your computer
   - Set Boot0 pin to HIGH (consult your board manual)
   - Press Reset button
   - Device should now be in DFU mode

2. **Locate the device in Device Manager:**
   - Right-click "This PC" → "Manage"
   - Open "Device Manager"
   - Look under "Universal Serial Bus devices" for unknown devices
   - Or look under "Other devices" for devices with yellow exclamation marks

3. **Install the driver:**
   - Right-click the unknown STM32 device
   - Select "Update driver"
   - Choose "Browse my computer for driver software"
   - Click "Browse" and navigate to this folder
   - Select `STM32_DFU_WinUSB.inf`
   - Click "Next" and wait for installation

4. **Verify installation:**
   - The device should now appear as a standard USB device with WinUSB driver
   - You can now flash firmware

### Method 3: Command Line Installation

For scripting or automated deployment:

```batch
REM Run as Administrator
pnputil /add-driver "C:\Path\To\STM32_DFU_WinUSB.inf" /install
```

## Verification

After installation, verify that the driver is correctly installed:

1. **Via Device Manager:**
   - Connect a flight controller in DFU mode
   - Open Device Manager
   - Locate the device under "Universal Serial Bus devices"
   - Double-click it and go to "Driver" tab
   - The driver should be listed as "WinUSB"

2. **Via Command Line:**
   ```batch
   pnputil /enum-devices /connected /class "USB"
   ```

## Troubleshooting

### Problem: "Access Denied" error

**Solution:**
- Run the installer as Administrator
- Right-click the script/batch file → "Run as administrator"

### Problem: Driver installation fails with error code

**Solution:**
- Restart your computer
- Try installing again
- Ensure Windows is fully updated

### Problem: Device still appears as "STTub30"

**Solution:**
1. Uninstall the old driver:
   - Right-click the device in Device Manager
   - Select "Uninstall device"
   - Check "Delete the driver software for this device"
   - Restart your computer

2. Re-install WinUSB driver:
   - Follow the installation steps again

### Problem: Multiple flight controllers with different issues

**Solution:**
- Repeat the installation process for each controller
- Each should automatically get WinUSB driver when connected in DFU mode (after first installation)

### Problem: dfu-util still reports LIBUSB_ERROR_NOT_SUPPORTED

**Solution:**
1. Verify driver installation (use Device Manager check above)
2. Uninstall and reinstall the driver
3. Try a different USB port
4. If using USB hub, try connecting directly to motherboard

## Uninstall

To uninstall the WinUSB driver:

1. Open Device Manager
2. Locate the STM32 DFU device under "Universal Serial Bus devices"
3. Right-click → "Uninstall device"
4. Check "Delete the driver software for this device"
5. Click "Uninstall"

The old STM32 drivers will be restored on next connection.

## Technical Details

### What is WinUSB?

WinUSB is a generic USB driver framework that allows user-mode applications direct access to USB devices. It's part of the Windows Driver Kit and is the standard for tools like dfu-util.

### Why is this needed?

- **dfu-util** uses libusb library to communicate with USB devices
- libusb cannot access devices with proprietary vendor drivers (like STTub30)
- WinUSB provides the generic interface that libusb needs

### File Details

- **STM32_DFU_WinUSB.inf:** Driver installation file (hardware ID: USB\VID_0483&PID_DF11)
- **install_driver.bat:** Batch script for Windows command prompt
- **install_driver.ps1:** PowerShell script for modern Windows versions

## Support

If you encounter issues:

1. Check the troubleshooting section above
2. Verify your hardware connections
3. Ensure your flight controller supports DFU mode
4. Check Windows Update for latest drivers

## References

- [Microsoft WinUSB Documentation](https://docs.microsoft.com/en-us/windows-hardware/drivers/winusb/)
- [STM32 DFU Bootloader](https://www.st.com/resource/en/application_note/dm00110305-stm32f10xxx-usb-full-speed_device_library_stmicroelectronics.pdf)
- [dfu-util Documentation](http://dfu-util.sourceforge.net/)
