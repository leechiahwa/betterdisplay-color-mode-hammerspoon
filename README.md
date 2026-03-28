# BetterDisplay Color Mode Auto Fix (Hammerspoon)

Automatically forces **Full RGB color mode** (instead of limited range YCbCr) on macOS whenever your external monitor is connected.

This is useful for HDMI setups where macOS defaults to washed-out colors.

---

## ✨ Features

* Automatically applies Full RGB on display connect
* Fixes washed-out / faded colors
* Lightweight and runs in the background
* No need for BetterDisplay Pro

---

## 🧰 Requirements

* BetterDisplay installed
* Hammerspoon installed
* Apple Silicon Mac (recommended for connectionMode support)

---

## ⚙️ Setup

### 1. Find your display name

Run:

```bash
/Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay get --displays
```

Look for your monitor name (e.g. `"X270 PRO"`).

---

### 2. Find available connection modes

```bash
/Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay get --name="YOUR DISPLAY" --connectionModeList
```

Identify a mode with:

* `RGB`
* `Full`
* Desired resolution / refresh rate

Example:

```
5804858444727454208 - 2560x1440 120.00Hz Fixed 8bit SDR RGB Full SRGB
```

---

### 3. Test the command

```bash
/Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set --name="YOUR DISPLAY" --connectionMode="bpc:8+range:full+encoding:rgb+hdrmode:sdr"
```

Or using mode ID:

```bash
/Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set --name="YOUR DISPLAY" --connectionMode=MODE_ID
```

Make sure this fixes your display before continuing.

---

### 4. Configure Hammerspoon

Edit:

```
~/.hammerspoon/init.lua
```

Add:

```lua
local function applyDisplayFix()
    hs.task.new("/bin/bash", nil, {
        "-c",
        '/Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set --name="YOUR DISPLAY" --connectionMode="bpc:8+range:full+encoding:rgb+hdrmode:sdr"'
    }):start()
end

hs.screen.watcher.new(function()
    -- Delay ensures macOS finishes detecting the display
    hs.timer.doAfter(2, applyDisplayFix)
end):start()
```

---

### 5. Reload Hammerspoon

* Click Hammerspoon menu bar icon
* Select **Reload Config**

---

## 🔁 How it works

* Detects screen changes (connect/disconnect, wake)
* Waits briefly for macOS to stabilize
* Re-applies Full RGB mode via BetterDisplay CLI

---

## ⚠️ Notes

* Works best on Apple Silicon Macs
* Some HDMI adapters may not support Full RGB
* A short delay (1–3 seconds) is normal before the fix applies
* If it fails, increase the delay in the script

---

## 💡 Alternative (Recommended)

If possible, use a **USB-C → DisplayPort cable** instead of HDMI.

This often enables Full RGB by default and removes the need for this workaround.

---
