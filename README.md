---

# Bluetooth HID Macro Keyboard (Arduino Uno R3)

An advanced, high-performance firmware utility that transforms an Arduino Uno R3 paired with a Bluetooth Serial Module (such as an HC-05 or HC-06) into a fully programmable, scriptable hardware USB HID Keyboard.

By transmitting specifically formatted text sequences via Bluetooth, you can pass regular text typing alongside advanced navigation controls, persistent key combinations, absolute multi-modifier macros, and function keys up to F24. This setup executes directly at the hardware layer, making it completely functional inside complex environments like system BIOS menus, bootloaders, recovery shells, and command terminals.

---

## Technical Architecture Overview

The system architecture utilizes a split processing layout on the Arduino Uno R3's ATmega328P microcontroller:

```
[Phone / Bluetooth Master]
         │
         ▼ (Raw String Transmission e.g., "sudo -Kk\n")
[HC-05 / HC-06 Bluetooth Module]
         │
         ▼ (SoftwareSerial Line @ 9600 Baud)
[ATmega328P Core] ───► Parsing Loop Engine
         │
         ▼ (Raw 8-byte HID Reports @ 9600 Baud via Hardware Serial)
[ATmega16U2 USB Controller (Flashed with Keyboard HID Firmware)]
         │
         ▼ (Standard USB HID Keyboard Packets)
[Target Host Computer PC / Server]

```

When a data packet arrives over the Bluetooth interface, the main parser processes the string token by token. If a macro identifier backslash (`\`) is hit, it extracts the modifier sequence dynamically. Otherwise, it maps the character to its corresponding physical US-layout USB HID scan code and compiles an 8-byte keyboard report frame.

---

## Complete Command & Macro Specification

All command and macro strings begin with the escape character backslash (`\`). This engine features case-insensitive parsing for all standalone macro tokens.

### 1. Persistent "Sticky" Modifiers

These commands modify the persistent state variable `activeGlobalModifiers`. Once executed, these modifiers remain held down continuously across all subsequent text strings and keystrokes until explicitly cleared.

* 
**Syntax:** `\+[modifier_char]` 


* 
**Reset Syntax:** `\-` (Instantly releases all active modifiers) 



| Modifier Token 

 | Physical Key Mapping 

 | Bitmask Value 

 |
| --- | --- | --- |
| <br>`l` 

 | Left Shift 

 | `0x02` |
| <br>`r` 

 | Right Shift 

 | `0x20` |
| <br>`c` 

 | Left Control 

 | `0x01` |
| <br>`q` 

 | Right Control 

 | `0x10` |
| <br>`a` 

 | Left Alt 

 | `0x04` |
| <br>`m` 

 | Right Alt 

 | `0x40` |

### 2. Standalone Navigation & Special Macros

Sending these tokens triggers an instantaneous key-down and key-up sequence for the specified system key. They can be typed in **either uppercase or lowercase** (e.g., `\e` performs exactly like `\E`).

| Token (Case-Insensitive) | Physical Action Generated | USB HID Usage ID (Hex) 

 |
| --- | --- | --- |
| <br>`\U` 

 | Up Arrow 

 | `0x52` |
| <br>`\D` 

 | Down Arrow 

 | `0x51` |
| <br>`\L` 

 | Left Arrow 

 | `0x50` |
| <br>`\R` 

 | Right Arrow 

 | `0x4F` |
| <br>`\E` 

 | Enter / Return 

 | `0x28` |
| <br>`\S` 

 | Escape 

 | `0x29` |
| <br>`\T` 

 | Tab 

 | `0x2B` |
| <br>`\B` 

 | Backspace (Delete Backward) 

 | `0x2A` |
| <br>`\K` 

 | Forward Delete (Delete Character Ahead) 

 | `0x4C` |
| <br>`\C` 

 | Caps Lock Toggle 

 | `0x39` |
| <br>`\N` 

 | Num Lock Toggle 

 | `0x53` |
| <br>`\O` 

 | Scroll Lock Toggle 

 | `0x47` |

### 3. Transient Modifier Strikes

If you need a modifier held **only** for a single companion keystroke, use a lowercase modifier token inside a standalone statement.

* 
*Example:* Sending `\c` acts as a momentary hold on Left Control during the next evaluated frame.



### 4. Advanced Sequential Function Keys

The firmware parses extended multi-character function operations dynamically up to F24, exceeding standard commercial keyboard limits.

* 
**Syntax:** `\F1` through `\F24` 



### 5. Multi-Key Synchronous Combinations

For hotkeys that require absolute simultaneous structural delivery in a single data report packet, use the **eXecute Combo** sequence.

* 
**Syntax:** `\X[modifiers][primary_key]` 



The combination parser scans all incoming bytes immediately following `\X`. It treats all listed modifier tokens (`l`, `r`, `c`, `q`, `a`, `m`) as additive bitmasks, applying them simultaneously until it hits a non-modifier target keycap. Once the target keycap is found, it packages them all into a single unified buffer report, shoots it down the wire, and exits cleanly.

---

## Detailed Scripting & Automation Examples

### 1. Bypassing OS Security Prompts & Spawning Admin Terminals (Windows)

To execute administrative terminal tasks remotely via Bluetooth, you must reliably call system dialogue components:

```text
\Xacr\delay=100\cmd\XcaE

```

* **Dissection:** 1. `\Xac` fires a single-packet stroke of Left Alt + Left Control while the system accepts the subsequent parameter trailing character `r`, initializing the Windows *Run* dialogue.
2. The macro delay allows the graphic renderer on the target machine to construct the text focus framework.
3. `cmd` prints the literal string execution text character array.
4. `\XcaE` captures Left Control + Left Shift (`a` layout flag) combined with the standalone macro mapper code for `E` (Enter), invoking the Windows shortcut framework to execute the target string container directly as Administrator.

### 2. Multi-Line Linux Sysadmin Management Automation Scripts

If you paste a series of automation lines directly into your Bluetooth terminal application, the internal buffer tracks carriage alignments natively:

```text
sudo apt-get update -y\E
sudo apt-get upgrade -y\E
echo "HID Automation Completed Safely"\E

```

* 
**Dissection:** The embedded alphanumeric parser automatically matches internal newlines (`\n` or `\r`) to physical Enter executions, allowing a single copy-paste procedure to run sequential bash pipeline tasks sequentially down the line.



### 3. Deep-Dive IDE Navigation & Refactoring Combo Overrides

When auditing code paths inside tools like VS Code or Visual Studio, multi-tier navigation binds can be executed instantly:

```text
\XclF

```

* **Dissection:** Striking Left Control (`c`) combined with Shift (`l`) and passing the literal flag parameter character `F` triggers the global project code search tool instantly.

```text
\+c\U\D\D\-\K

```

* 
**Dissection:** Locks Left Control using the global tracking system, cycles up and down across visual paragraph fragments using sequential navigation arrow bursts, releases the persistent modifier tree, and drops the highlighting line payload using a clean forward delete command.



---

## Flashing & HID DFU Firmware Guide (Standard Path)

To make a standard Arduino Uno R3 register natively as a true hardware plug-and-play USB Keyboard, you must re-flash the firmware on the **ATmega16U2** coprocessor (the small square chip located near the USB port).

```
   ┌──────────┐
   │ USB Port │
   └────┬─────┘
        │
   ┌────┴─────┐
   │ATmega16U2│ <─── Flashed with "Arduino-keyboard-0.3.hex" (HID Mode)
   └────┬─────┘       or "Arduino-usbserial-atmega16u2-Uno-Rev3.hex" (Serial Programming Mode)
        │
   ┌────┴─────┐
   │ATmega328P│ <─── Runs your uploaded Main Sketch Program (.ino)
   └──────────┘

```

When you buy an Arduino, the ATmega16U2 chip is configured as a simple USB-to-Serial bridge. To transform it into a Keyboard controller, we use the **DFU (Device Firmware Update)** interface.

### Prerequisites

Download and install `dfu-programmer` via your operating system package manager:

* **macOS:** `brew install dfu-programmer`
* **Linux (Ubuntu/Debian):** `sudo apt-get install dfu-programmer`
* **Windows:** Download the official binary release and add its directory to your System PATH variables.

You will also need the compiled stock reference hex images. They are available inside the official Arduino core package directory or via public open-source Git repositories:

1. `Arduino-keyboard-0.3.hex` (The USB HID Keyboard firmware open-source profile)
2. `Arduino-usbserial-atmega16u2-Uno-Rev3.hex` (The original factory USB-Serial diagnostic firmware)

### Step 1: Placing the ATmega16U2 into DFU Mode

Before running command line tools, you must manually trip the ATmega16U2 into its hardware DFU configuration state:

1. Locate the 6-pin ICSP header situated adjacent to the USB connector interface.
2. Using a wire jumper or metal tweezers, briefly short the two pins closest to the USB port together.
3. Release the short. The Arduino will disconnect and reconnect inside your System Device Manager, revealing itself under a description name like `ATmega16U2` or `Arduino Uno DFU`.

### Step 2: Flashing the USB HID Keyboard Firmware

Open a command shell console and execute the following commands sequentially to clear the chip memory profile and flash the keyboard runtime profile:

```bash
# 1. Inspect the chip state connection parameters
dfu-programmer atmega16u2 get

# 2. Wipe the existing standard chip program flash profile
dfu-programmer atmega16u2 erase

# 3. Flash the target open-source USB HID Keyboard layout image
dfu-programmer atmega16u2 flash Arduino-keyboard-0.3.hex

# 4. Restructure and reset the controller to execute your new configuration safely
dfu-programmer atmega16u2 reset

```

Once completed, unplug your USB connection line and plug it back in. The host machine will instantly enumerate the Arduino Uno R3 as a standard hardware **USB HID Keyboard device**.

### Step 3: Reverting to Factory Serial Firmware (To Change or Update Code)

When the ATmega16U2 is running the Keyboard firmware, the Arduino IDE will no longer recognize its COM port, meaning you cannot upload updates to your `.ino` sketch. To update your program code layout on the ATmega328P, you must temporarily revert the coprocessor back to its stock serial configuration profile:

1. Short the ICSP pins again to push the ATmega16U2 back into DFU mode.
2. Execute these recovery commands inside your command console terminal:

```bash
# Wipe the keyboard hex image from the ATmega16U2 flash registers
dfu-programmer atmega16u2 erase

# Reflash the factory stock reference serial gateway image profile
dfu-programmer atmega16u2 flash Arduino-usbserial-atmega16u2-Uno-Rev3.hex

# Restart the device processor assembly lines
dfu-programmer atmega16u2 reset

```

3. Unplug and reconnect the USB line. The Arduino IDE will immediately detect the original COM port parameters.
4. Upload your updated sketch inside the Arduino IDE, then repeat **Step 1** and **Step 2** to switch back to Keyboard mode!

---

## Hardware Fallback Fix: ICSP Recovery (Using a Second Arduino)

If the ATmega16U2 coprocessor stops responding due to a failed DFU flash, corrupted bootloader fields, or an invalid hex image, the chip may become "bricked." In this state, it will refuse to enter DFU mode via the standard tweezers shorting trick.

To unbrick the chip, you can bypass the USB subsystem completely and re-flash the factory firmware directly through the **ICSP (In-Circuit Serial Programming)** hardware pins using a second functional Arduino (Uno, Mega, or Nano) acting as a dedicated hardware programmer.

### 1. Hardware Mapping & Wiring Requirements

Locate the specific 6-pin ICSP header situated **directly next to the ATmega16U2 chip** (do not confuse this with the secondary ICSP header near the main ATmega328P chip). Connect the Programmer Arduino to the Target Arduino's ATmega16U2 header using this precise layout:

| Programmer Arduino (Functional Board) | Target Arduino 16U2 ICSP Pin | Target Header Visual Mapping |
| --- | --- | --- |
| **Digital Pin 10** | Reset (Pin 5) | `MISO (1)  [●] [●] VCC (2)` |
| **Digital Pin 11** | MOSI (Pin 4) | `SCK  (3)  [●] [●] MOSI (4)` |
| **Digital Pin 12** | MISO (Pin 1) | `RST  (5)  [●] [●] GND (6)` |
| **Digital Pin 13** | SCK (Pin 3) | *(Pin 1 has a small dot indicator)* |
| **5V Power Rail** | VCC (Pin 2) |  |
| **GND Rail** | GND (Pin 6) |  |

> ⚠️ **CRITICAL HARDWARE REQUIREMENT:** You **MUST** connect a **10μF Electrolytic Capacitor** between the `RESET` and `GND` pins on the **Programmer Arduino**. Connect the longer lead (Positive) to `RESET` and the shorter lead (Negative) to `GND`. This overrides the automated reset cycle of the programmer board when your PC initializes a connection.

---

### 2. Preparing the Programmer Arduino

1. Disconnect the target board completely. Connect your functional Programmer Arduino to your PC via USB.
2. Launch the Arduino IDE. Open the stock example sketch: **File** → **Examples** → **ArduinoISP**.
3. Go to **Tools** → **Board** and choose your Programmer Arduino model (e.g., *Arduino Uno*). Select its matching active COM Port.
4. Press **Upload** to program the board into a dedicated hardware flashing tool.
5. Once the upload finishes, disconnect the USB cable and install the 10μF capacitor across `RESET` and `GND` on that programmer board.

---

### 3. Executing Advanced Terminal Recovery via AVRDUDE

Since the target board's COM port interface is completely broken, we will bypass the Arduino IDE and call **AVRDUDE**—the underlying flashing engine included with the Arduino core package toolchain.

Open your system command terminal (Command Prompt, PowerShell, or bash) and navigate to your local directory containing the reference `.hex` files.

#### Step 1: Verify Hardware Connectivity

Run this mapping command to ping the target ATmega16U2 chip. This command checks connectivity parameters without writing new data:

```bash
avrdude -c arduino -p m16u2 -P COM3 -b 19200 -v

```

*(Replace `COM3` with the actual active COM port identifier assigned to your **Programmer Arduino**).*

* **Expected Output Success:** If your wiring connections are sound, AVRDUDE will read the device signature array flag (`0x1e9489`) and report: `Device signature = 0x1e9489 (at90usb162 / atmega16u2)`.

#### Step 2: Clear Corrupted Memories & Flash New Firmware

If the signature check passes, execute the following command block to completely clear the corrupted chip flash sectors, write the chosen operational hex firmware file, and verify its structural data matches:

* **To Recover to Standard USB-Serial (Factory Mode):**
```bash
avrdude -c arduino -p m16u2 -P COM3 -b 19200 -e -U flash:w:Arduino-usbserial-atmega16u2-Uno-Rev3.hex:i

```


* **To Direct-Flash to Native USB HID Keyboard Mode:**
```bash
avrdude -c arduino -p m16u2 -P COM3 -b 19200 -e -U flash:w:Arduino-keyboard-0.3.hex:i

```



#### Detailed Parameter Breakdown:

* `-c arduino` Explicitly configures AVRDUDE to utilize the standard STK500 serial instruction set running inside your Programmer Arduino.
* `-p m16u2` Focuses processing commands strictly onto the targeted architecture footprint of the ATmega16U2 processor layout.
* `-b 19200` Locks down the communication speed to the exact baud parameter required by the default ArduinoISP firmware.
* `-e` Executes a full chip erase, clearing out corrupt lock bits or broken software loops before uploading new code.
* `-U flash:w:[filename]:i` Tells the programmer to **W**rite data down to the **Flash** memory space using Intel Hex verification parameters (`:i`).

Once the progress bar hits 100% and reports `verified`, disconnect your jumper lines. Your target Arduino Uno R3 is completely restored, unbricked, and ready for deployment.


When building and using a custom hardware-level USB injector or automated macro keyboard, you are working directly with low-level microcontrollers and host system input buses. Because this device bypasses operating system software security layers, there are several critical physical, electrical, and logical safety risks you must keep in mind to avoid bricking your hardware or damaging your host computer.

---




## ⚡ Electrical & Hardware Safeguards

### 1. The Capacitor Isolation Rule (Prevent Programmer Damage)

When using the **ICSP Fallback Recovery** method with a second Arduino, you must **never** connect the 10μF capacitor to the programmer board while uploading the `ArduinoISP` sketch from the Arduino IDE.

* **The Danger:** Connecting it early will short the reset circuit during compilation, which can overload the USB serial bridge of your host computer or corrupt the programmer board's bootloader.
* **Safe Protocol:** Upload the `ArduinoISP` code to your programmer board *first*. Unplug the USB cable, install the capacitor securely across `RESET` and `GND`, and only *then* connect it to your target board.

### 2. Guard Against Target Board Self-Reset

When the target board's ATmega16U2 chip is successfully flashed with the `Arduino-keyboard-0.3.hex` firmware, its hardware lines alter completely.

* **The Caution:** If you accidentally short the secondary ICSP header (the one next to the large ATmega328P chip) while the system is powered on, you can cause a rapid electrical brownout on the board. This can permanently corrupt the main runtime flash storage of your `.ino` program code.

---

## 🛑 Logic Loops & Infinite Typing Disasters

Because your Arduino mimics a real physical keyboard, the host operating system cannot distinguish between a human typing and your code executing at microsecond speeds. This introduces a major risk of an **infinite typing loop**.

### 1. The Boot-Loop Terminal Trap

If you program your Arduino to automatically execute a macro sequence inside the `setup()` function without a safety buffer delay, or if your `loop()` function gets stuck in an unhandled parsing error state, the device will start spamming commands the millisecond you plug it into a computer.

* **The Disaster Scenario:** If your code gets stuck typing a command like `rm -rf` or repeatedly hitting `Enter`, plugging the device into your PC will instantly command the computer to start destroying its own directories, opening hundreds of terminal windows, or closing active applications. You won't even be able to open the Arduino IDE to reflash it because the device will keep stealing your keyboard focus!

### 2. Emergency Kill-Switch Architecture

To completely eliminate this risk, you should always implement a **physical hardware safety cutoff** before deploying your script in production environments.

#### The Hardware Fix:

Wire a physical toggle switch or push-button between a digital pin (e.g., `Digital Pin 4`) and `GND` on your main board. Update your `loop()` function to strictly check the physical state of that pin before processing *any* Bluetooth data or sending HID packets:

```cpp
// Add this safety check to the very top of your loop()
void loop() {
  // Pullup resistor configuration means HIGH = Open/Safe, LOW = Pressed/Run
  if (digitalRead(4) == HIGH) {
    return; // Safety Stop Active! The keyboard engine is completely frozen.
  }

  if (BTSerial.available() > 0) {
    // ... rest of your macro engine code ...

```

---

## 🖥️ Target Host Environment Hazards

### 1. The Keystroke Dropping Bottleneck

The default execution speed inside `executeReport` uses explicit delay periods (`15ms` hold, `35ms` settling window).

* **The Danger of Tuning:** If you try to optimize your execution metrics by lowering these values to make the typing "faster," you will outrun the polling rate of the host machine's USB controller bus.
* **The Consequence:** The target machine will randomly drop modifier states or characters. For instance, a command like `rm -rf /path/to/target` could misfire as `rm -rf /path/ to/target` (notice the accidental space), causing the command to try to erase your root directory instead of the specific subfolder!

### 2. Keyboard Layout / Language Mismatches

Your Arduino sends raw mathematical HID usage ID matrix positions, **not characters**. The translation from scan code to letter happens entirely inside the host OS layout configurations.

* **The Caution:** If your Arduino is programmed to type a script expecting a standard **US Keyboard Layout**, but you plug it into a computer configured for a European layout (like **AZERTY** or **QWERTZ**), your commands will map to completely wrong characters.
* **Example:** A typed `w` might strike as a `z`, transforming benign command paths into completely unpredictable, destructive terminal instructions. Always double-check the host operating system's keyboard language settings before executing automated scripts!
