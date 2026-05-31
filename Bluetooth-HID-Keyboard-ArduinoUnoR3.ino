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
          
          if (macroType == 'F') {
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
          bool validMacro = handleSingleMacro(macroType);
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

  char upperType = type;
  if (upperType >= 'a' && upperType <= 'z') {
    upperType = upperType - 32; // Quick ASCII shift to uppercase
  }

  switch (upperType) {
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
