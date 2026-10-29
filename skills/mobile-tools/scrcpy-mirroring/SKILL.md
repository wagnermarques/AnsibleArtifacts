---
name: scrcpy-mirroring
description: >-
  Use this skill when mirroring, controlling, or troubleshooting Android devices
  connected via USB or Wi-Fi (TCP/IP) using scrcpy and ADB.
---

# Android Screen Mirroring & Control with scrcpy

Procedures and troubleshooting guide for using `scrcpy` and `adb` across USB and Wi-Fi connections.

## 1. Quick Launch Commands

* **Launch Foreground (Recommended):**
  ```bash
  fzl-scrcpy
  ```
  *(Keeps screen awake and displays the live phone viewport).*

* **Launch in Background:**
  ```bash
  fzl-scrcpy-start
  ```
  *(Logs output to `~/.cache/scrcpy/scrcpy.log`).*

* **Switch to Wireless / Wi-Fi Mode:**
  ```bash
  fzl-scrcpy-tcpip
  ```

---

## 2. Wireless (TCP/IP) Step-by-Step Procedure

1. Connect the phone to the PC using a USB cable.
2. Ensure both PC and phone are on the **same Wi-Fi network**.
3. Run the TCP/IP initialization helper:
   ```bash
   fzl-scrcpy-tcpip
   ```
4. Once the prompt shows the device IP address (e.g. `192.168.1.105:5555`), unplug the USB cable.
5. Run:
   ```bash
   scrcpy --tcpip=192.168.1.105:5555
   ```

---

## 3. Useful Shortcuts while in scrcpy

| Shortcut | Action |
| :--- | :--- |
| **`MOD + f`** | Toggle Fullscreen |
| **`MOD + h`** | Press HOME button |
| **`MOD + b`** / Right-Click | Press BACK button |
| **`MOD + s`** | App Switcher (Overview) |
| **`MOD + p`** | Toggle device Power (turn screen off/on) |
| **`MOD + o`** | Turn device screen OFF (mirrors only on PC to save phone battery) |
| **`MOD + Up / Down`** | Volume Up / Down |

*(Note: `MOD` key defaults to `Alt` or `Super/Windows` key).*

---

## 4. Troubleshooting Checklist

* **Device Unauthorized:**
  Check the phone screen for the *"Allow USB Debugging?"* dialog and tap **Always allow from this computer**.
* **Device Not Detected:**
  Restart the ADB server:
  ```bash
  adb kill-server
  adb start-server
  adb devices
  ```
