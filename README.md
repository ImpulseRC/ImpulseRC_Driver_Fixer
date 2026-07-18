# ImpulseRC Driver Fixer

<p align="center">
  <img src="img/logo.png" />
</p>

<p align="center">
This application will attempt to install the correct serial port and DFU drivers for using STM32 F3, F4 and F7 based flight controllers on Windows. If you have trouble running the Driver Fixer you may need to install the <a href="https://www.microsoft.com/en-au/download/details.aspx?id=30653">Microsoft .NET Framework v4.5</a>
</p>

## Installation Methods

### Method 1: Using the Driver Fixer Executable (Recommended for most users)

1. Download and run `ImpulseRC_Driver_Fixer.exe`
2. Follow the on-screen instructions
3. Restart your computer if prompted

### Method 2: Manual WinUSB Driver Installation (For persistent DFU access)

This method is recommended if you have issues with multiple flight controllers or need consistent DFU device access for flashing firmware.

#### Step-by-step:

1. **Prepare the driver:**
   - Extract or navigate to the `drivers` folder in this repository
   - Locate `STM32_DFU_WinUSB.inf`

2. **Clean old drivers (optional but recommended):**
   - Right-click **This PC** or **My Computer** → **Manage**
   - Open **Device Manager**
   - Look for any STM32 or unknown USB devices
   - Right-click → **Uninstall device** → Check **Delete the driver software**
   - Restart your computer

3. **Install WinUSB driver:**
   - Connect your STM32-based flight controller in DFU mode (Boot0 pin HIGH, then reset)
   - Right-click `STM32_DFU_WinUSB.inf` → **Install** (requires Administrator)
   - Wait for installation to complete
   - Restart your computer

4. **Verify installation:**
   - Connect your flight controller (any mode)
   - Open Device Manager
   - Under **Universal Serial Bus devices**, you should see the device with WinUSB driver installed
   - You're ready to flash firmware!

### Troubleshooting

**Problem:** "Error 99" during installation
- **Solution:** Check Windows Update for pending updates and restart. Ensure you're running the installer as Administrator.

**Problem:** DFU device shows as "STTub30" instead of WinUSB
- **Solution:** 
  1. Uninstall the device in Device Manager (with driver removal)
  2. Restart your computer
  3. Re-run the driver installer

**Problem:** dfu-util reports `LIBUSB_ERROR_NOT_SUPPORTED`
- **Solution:** This means the WinUSB driver is not properly installed. Re-install using Method 2 above.

<p align="center">
If this tool has ever helped you out of a tight spot, please consider buying me a coffee!
</p>

<p align="center">
  <a href="https://www.paypal.com/donate/?hosted_button_id=CSRECZVEKTRHW"><img src="img/donate.png" /></a>
</p>

<p align="center">
  <a href="https://github.com/ImpulseRC/ImpulseRC_Driver_Fixer/releases/download/v1/ImpulseRC_Driver_Fixer.exe"><img src="img/download.png" /></a>
</p>
