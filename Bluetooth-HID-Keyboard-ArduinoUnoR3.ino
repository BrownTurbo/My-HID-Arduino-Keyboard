#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10, 11); // RX, TX

#define KEY_NONE        0x00
#define KEY_LCTRL       0x01
#define KEY_LSHIFT      0x02
#define KEY_LALT        0x04
#define KEY_RCTRL       0x10
#define KEY_RSHIFT      0x20
#define KEY_RALT        0x40

#define KEY_ENTER  0x28
#define KEY_ESC    0x29
#define KEY_SPACE  0x2C
#define KEY_F9     0x42
#define KEY_F10    0x43
#define KEY_F12    0x45
#define KEY_RIGHT  0x4F
#define KEY_LEFT   0x50
#define KEY_DOWN   0x51
#define KEY_UP     0x52

#define KEY_CAPS_LOCK   0x39
#define KEY_SCROLL_LOCK 0x47
#define KEY_DELETE      0x4C
#define KEY_NUM_LOCK    0x53
#define KEY_BACKSPACE   0x2A

#define KEY_PLAY_PAUSE 0xCD
#define KEY_MUTE       0xE2
#define KEY_VOL_UP     0xE9
#define KEY_VOL_DOWN   0xEA

uint8_t buf[8] = { 0 };
uint8_t activeGlobalModifiers = KEY_NONE;

void setup() 
{
  Serial.begin(9600);
  BTSerial.begin(9600); 
}

void loop() 
{
  if (BTSerial.available() > 0) {
    // Read the complete text packet up to the newline delimiter
    String inputString = BTSerial.readStringUntil('\n');
    inputString.trim(); // Strip hidden \r and whitespace paddings

    unsigned int i = 0;
    while (i < inputString.length()) {
      char c = inputString.charAt(i);

      // Check if we hit the explicit command escape character
      if (c == '\\') {
        // Ensure there is at least one character after the backslash
        if (i + 1 < inputString.length()) {
          char macroType = inputString.charAt(i + 1);
          
          // Pattern: \+ to persistently HOLD down modifiers (e.g. \+c holds Left Ctrl)
          if (macroType == '+' && i + 2 < inputString.length()) {
            char modChar = inputString.charAt(i + 2);
            enableStickyModifier(modChar);
            i += 3;
            continue;
          }
          
          // Pattern: \- to CLEAR all held modifiers
          if (macroType == '-') {
            activeGlobalModifiers = KEY_NONE;
            i += 2;
            continue;
          }

          char upperType = macroType;
          if (upperType >= 'a' && upperType <= 'z') {
            upperType = upperType - 32; // Quick ASCII shift to uppercase
          }
          
          if (upperType == 'F') {
            // Parse a multi-character function key macro like \F10
            String fNumStr = "";
            unsigned int j = i + 2;
            
            while (j < inputString.length() && isDigit(inputString.charAt(j))) {
              fNumStr += inputString.charAt(j);
              j++;
            }
            
            if (fNumStr.length() > 0) {
              int fNumVal = fNumStr.toInt();
              // Validate bounding parameters to avoid out-of-bounds scan codes
              if (fNumVal >= 1 && fNumVal <= 24) {
              handleFunctionMacro(fNumVal);
                i = j; 
                continue;
              }
            }
          }
          else if (upperType == 'X') {
            unsigned int j = i + 2;
            uint8_t comboMods = activeGlobalModifiers; // Start with any currently held global modifiers
            uint8_t comboKey = KEY_NONE;
            bool executionTriggered = false;

            // Parse characters until we find a target primary key or run out of string
            while (j < inputString.length()) {
              char target = inputString.charAt(j);
            
              // Check if the current character is a modifier flag
              if (target == 'l')      { comboMods |= KEY_LSHIFT; j++; }
              else if (target == 'r') { comboMods |= KEY_RSHIFT; j++; }
              else if (target == 'c') { comboMods |= KEY_LCTRL;  j++; }
              else if (target == 'q') { comboMods |= KEY_RCTRL;  j++; }
              else if (target == 'a') { comboMods |= KEY_LALT;   j++; }
              else if (target == 'm') { comboMods |= KEY_RALT;   j++; }
              else {
                // Not a modifier! Treat this character as the core keycap target
                // First, check if it's an escaped navigation shortcut (like U, D, L, R, E, S, K, B, T)
                char upperTarget = target;
                if (upperTarget >= 'a' && upperTarget <= 'z') upperTarget -= 32;

                switch (upperTarget) {
                  case 'U': comboKey = KEY_UP;          break;
                  case 'D': comboKey = KEY_DOWN;        break;
                  case 'L': comboKey = KEY_LEFT;        break;
                  case 'R': comboKey = KEY_RIGHT;       break;
                  case 'E': comboKey = KEY_ENTER;       break;
                  case 'S': comboKey = KEY_ESC;         break;
                  case 'C': comboKey = KEY_CAPS_LOCK;   break;
                  case 'N': comboKey = KEY_NUM_LOCK;    break;
                  case 'O': comboKey = KEY_SCROLL_LOCK; break;
                  case 'K': comboKey = KEY_DELETE;      break;
                  case 'T': comboKey = 0x2B;            break; // Tab
                  case 'B': comboKey = KEY_BACKSPACE;   break;
                  case 'P': comboKey = KEY_SPACE;       break;
                  default:
                    // If it's a standard letter/number, let's look up its scan code dynamically
                    // Temporary registers to avoid disturbing global typing logic
                    uint8_t tempMod = KEY_NONE; 
                    uint8_t tempScan = KEY_NONE;
                  
                    // Run a quick trace through your alpha-numeric lookup function map
                    // We bypass executeReport by shifting its logic out if necessary, or running it directly:
                    if (target >= 'A' && target <= 'Z') { comboMods |= KEY_LSHIFT; comboKey = 0x04 + (target - 'A'); }
                    else if (target >= 'a' && target <= 'z') { comboKey = 0x04 + (target - 'a'); }
                    else if (target >= '1' && target <= '9') { comboKey = 0x1E + (target - '1'); }
                    else if (target == '0') { comboKey = 0x27; }
                    else if (target == ' ') { comboKey = KEY_SPACE; }
                    break;
                }
              
                // Fire the combination down the wire immediately
                executeReport(comboMods, comboKey);
                executionTriggered = true;
                j++;
                break; // Combo fully compiled and spent! Exit loop.
              }
            }
            if (executionTriggered) {
              i = j;
              continue;
            }
          }
          else if (upperType == 'D' && i + 6 < inputString.length()) {
            String checkDelay = inputString.substring(i + 1, i + 7); // Captures indices i+1 to i+6 ("delay=")
            checkDelay.toLowerCase(); 
            
            if (checkDelay == "delay=") {
              String msStr = "";
              unsigned int j = i + 7; // Advance processing cursor past the '=' character
              
              // Extract all digits defining milliseconds duration parameters
              while (j < inputString.length() && isDigit(inputString.charAt(j))) {
                msStr += inputString.charAt(j);
                j++;
              }
              
              if (msStr.length() > 0) {
                long duration = msStr.toInt();
                if (duration > 0) {
                  delay(duration); // Enforce the raw wait loop execution on ATmega328P
                }
                i = j; // Shift processing index forward over the parsed expression
                continue;
              }
            }
          }
          bool validMacro = handleSingleMacro(upperType);
          if (validMacro) {
            i += 2; 
            continue; 
          }
        }
      }

      // If it wasn't a valid macro sequence, treat it as normal text to type out
      sendAlphaNumericKey(c);
      i++;
      delay(20); // Steady pace delay between typing ordinary letters
    }
  }
}

void sendAlphaNumericKey(char c) {
  uint8_t modifier = activeGlobalModifiers;
  uint8_t scanCode = KEY_NONE;

  if (c >= 'A' && c <= 'Z') {
    modifier |= KEY_LSHIFT;
    scanCode = 0x04 + (c - 'A');
  } 
  else if (c >= 'a' && c <= 'z') {
    scanCode = 0x04 + (c - 'a');
  } 
  else if (c >= '1' && c <= '9') {
    scanCode = 0x1E + (c - '1');
  } 
  else {
    switch (c) {
      case '0': scanCode = 0x27; break;
      case ' ': scanCode = KEY_SPACE; break;
      case '\n': scanCode = KEY_ENTER; break;
      case '\r': scanCode = KEY_ENTER; break;
      case '\t': scanCode = 0x2B; break;
      case '\b': scanCode = KEY_BACKSPACE; break;
      
      // Top Row Symbols (Shifted Numbers)
      case '!': modifier |= KEY_LSHIFT; scanCode = 0x1E; break;
      case '@': modifier |= KEY_LSHIFT; scanCode = 0x1F; break;
      case '#': modifier |= KEY_LSHIFT; scanCode = 0x20; break;
      case '$': modifier |= KEY_LSHIFT; scanCode = 0x21; break;
      case '%': modifier |= KEY_LSHIFT; scanCode = 0x22; break;
      case '^': modifier |= KEY_LSHIFT; scanCode = 0x23; break;
      case '&': modifier |= KEY_LSHIFT; scanCode = 0x24; break;
      case '*': modifier |= KEY_LSHIFT; scanCode = 0x25; break;
      case '(': modifier |= KEY_LSHIFT; scanCode = 0x26; break;
      case ')': modifier |= KEY_LSHIFT; scanCode = 0x27; break;

      // Mathematical & Operational Keys
      case '-': scanCode = 0x2D; break;
      case '_': modifier |= KEY_LSHIFT; scanCode = 0x2D; break;
      case '=': scanCode = 0x2E; break;
      case '+': modifier |= KEY_LSHIFT; scanCode = 0x2E; break;

      // Brackets & Braces
      case '[': scanCode = 0x2F; break;
      case '{': modifier |= KEY_LSHIFT; scanCode = 0x2F; break;
      case ']': scanCode = 0x30; break;
      case '}': modifier |= KEY_LSHIFT; scanCode = 0x30; break;

      // Punctuation & Delimiters
      case ';': scanCode = 0x33; break;
      case ':': modifier |= KEY_LSHIFT; scanCode = 0x33; break;
      case '\'': scanCode = 0x34; break;
      case '"': modifier |= KEY_LSHIFT; scanCode = 0x34; break;
      case '`': scanCode = 0x35; break;
      case '~': modifier |= KEY_LSHIFT; scanCode = 0x35; break;
      case ',': scanCode = 0x36; break;
      case '<': modifier |= KEY_LSHIFT; scanCode = 0x36; break;
      case '.': scanCode = 0x37; break;
      case '>': modifier |= KEY_LSHIFT; scanCode = 0x37; break;
      case '/': scanCode = 0x38; break;
      case '?': modifier |= KEY_LSHIFT; scanCode = 0x38; break;

      // Structural Slashing Key
      case '\\': scanCode = 0x31; break;
      case '|':  modifier |= KEY_LSHIFT; scanCode = 0x31; break;
    }
  }

  if (scanCode != KEY_NONE) {
    executeReport(modifier, scanCode);
  }
}

// Returns true if a recognized macro was intercepted and executed
bool handleSingleMacro(char type) {
  uint8_t targetKey = KEY_NONE;
  uint8_t instantMod = activeGlobalModifiers;

  switch (type) {
    case 'U': targetKey = KEY_UP;    break; 
    case 'D': targetKey = KEY_DOWN;  break; 
    case 'L': targetKey = KEY_LEFT;  break; 
    case 'R': targetKey = KEY_RIGHT; break; 
    case 'E': targetKey = KEY_ENTER; break; 
    case 'S': targetKey = KEY_ESC;   break; 
    case 'C': targetKey = KEY_CAPS_LOCK;   break;
    case 'N': targetKey = KEY_NUM_LOCK;    break;
    case 'O': targetKey = KEY_SCROLL_LOCK; break;
    case 'K': targetKey = KEY_DELETE;      break;
    case 'T': targetKey = 0x2B;            break;
    case 'B': targetKey = KEY_BACKSPACE;   break;
    case 'P': targetKey = KEY_SPACE;       break;

    case 'V': sendMediaKey(KEY_VOL_UP);     return true; // \V drops Volume Up frame
    case 'I': sendMediaKey(KEY_VOL_DOWN);   return true; // \I drops Volume Down frame
    case 'M': sendMediaKey(KEY_MUTE);       return true; // \M toggles absolute Mute
    case 'Y': sendMediaKey(KEY_PLAY_PAUSE); return true; // \Y Pause&Play&Continue

    default:
      switch (type) {
        case 'l': instantMod |= KEY_LSHIFT; break; 
        case 'r': instantMod |= KEY_RSHIFT; break; 
        case 'c': instantMod |= KEY_LCTRL;  break; 
        case 'q': instantMod |= KEY_RCTRL;  break; 
        case 'a': instantMod |= KEY_LALT;   break; 
        case 'm': instantMod |= KEY_RALT;   break; 
        default:  return false; // Not a macro, pass back to normal typing engine
      }
      break;
  }

  executeReport(instantMod, targetKey);
  return true;
}

void handleFunctionMacro(int fNumber) {
uint8_t targetKey = KEY_NONE;

  // Handles F1 through F12 (1 to 12)
  if (fNumber >= 1 && fNumber <= 12) {
    targetKey = 0x3A + (fNumber - 1);
  }
  // Handles F13 through F24 (13 to 24)
  else if (fNumber >= 13 && fNumber <= 24) {
    targetKey = 0x68 + (fNumber - 13);
  }

  executeReport(activeGlobalModifiers, targetKey);
}

void enableStickyModifier(char m) {
  switch (m) {
    case 'l': activeGlobalModifiers |= KEY_LSHIFT; break;
    case 'r': activeGlobalModifiers |= KEY_RSHIFT; break;
    case 'c': activeGlobalModifiers |= KEY_LCTRL;  break;
    case 'q': activeGlobalModifiers |= KEY_RCTRL;  break;
    case 'a': activeGlobalModifiers |= KEY_LALT;   break;
    case 'm': activeGlobalModifiers |= KEY_RALT;   break;
  }
}

void sendMediaKey(uint8_t mediaKey) {
  uint8_t mediaBuf[2] = { 0 };
  
  // Package the specific Usage Page 0x0C media command
  mediaBuf[0] = mediaKey;
  mediaBuf[1] = 0x00;
  
  Serial.write(mediaBuf, 2); // Send the specialized compact media frame
  delay(15);                 // Hold state parameters momentarily
  
  mediaBuf[0] = 0x00;        // Clear report frame to signify release state
  Serial.write(mediaBuf, 2);
  delay(35);
}

void executeReport(uint8_t mod, uint8_t key) {
  buf[0] = mod;
  buf[2] = key;
  Serial.write(buf, 8);
  
  delay(15); // Keydown duration hold
  
  buf[0] = mod; 
  buf[2] = KEY_NONE;
  Serial.write(buf, 8); // Send clear key release report
  
  delay(35); // Settling delay to let BIOS register execution state safely
}
