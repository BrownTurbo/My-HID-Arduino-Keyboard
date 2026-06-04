#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10, 11); // RX, TX

#define KEY_NONE        0x00
#define KEY_LCTRL       0x01
#define KEY_LSHIFT      0x02
#define KEY_LALT        0x04
#define KEY_RCTRL       0x10
#define KEY_RSHIFT      0x20
#define KEY_RALT        0x40
#define KEY_TAB         0x2B

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

#define KEY_PLAY_PAUSE  0xCD
#define KEY_MUTE        0xE2
#define KEY_VOL_UP      0xE9
#define KEY_VOL_DOWN    0xEA
#define KEY_NEXT_TRACK  0xB5
#define KEY_PREV_TRACK  0xB6
#define KEY_STOP        0xB7

#define KEY_LGUI        0x08
#define KEY_RGUI        0x80

uint8_t activeGlobalModifiers = KEY_NONE;

void setup() 
{
  Serial.begin(9600);
  UCSR0B &= ~(1 << RXCIE0);
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
            unsigned int parseIndex = i + 2;
            uint8_t parsedMod = KEY_NONE;
            if (parseBracketedModifier(inputString, parseIndex, parsedMod)) {
              activeGlobalModifiers |= parsedMod;
              i = parseIndex;
            }
            else
            {
                char modChar = inputString.charAt(parseIndex);
                enableStickyModifier(modChar);
                i += 3;
            }
            executeReport(activeGlobalModifiers, KEY_NONE);
            delay(50);
            continue;
          }
          
          // Pattern: \- to CLEAR all held modifiers
          if (macroType == '-') {
            activeGlobalModifiers = KEY_NONE;
            executeReport(activeGlobalModifiers, KEY_NONE);
            i += 2;

            delay(50);
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

            if (activeGlobalModifiers & KEY_LALT) {
                delay(23);
            }

            // Parse characters until we find a target primary key or run out of string
            while (j < inputString.length()) {
              char target = inputString.charAt(j);
              if (target == '[') {
                uint8_t parsedMod = KEY_NONE;
                uint8_t parsedKey = KEY_NONE;
                
                unsigned int saveIndex = j; // Create context snapshot bookmark
                
                // 1. Cooperatively check if it's a bracketed modifier
                if (parseBracketedModifier(inputString, j, parsedMod)) {
                  comboMods |= parsedMod;
                  continue; 
                }
                
                // 2. Roll back index on fail, check if it's a structural navigational key
                j = saveIndex;
                if (parseBracketedKey(inputString, j, parsedKey)) {
                  executeReport(comboMods, parsedKey);
                  executionTriggered = true;
                  break;
                }
                
                // 3. Roll back index on fail, check if it's a multimedia transmission frame
                j = saveIndex;
                if (parseBracketedMediaKey(inputString, j, parsedKey)) {
                  sendMediaKey(parsedKey);
                  executionTriggered = true;
                  break;
                }
                
                // Fallback fail-safe: Bracket contents didn't match anything, skip past it safely
                j++; 
              } else {
                // Check if the current character is a modifier flag
                if (target == 'l')      { comboMods |= KEY_LSHIFT; j++; }
                else if (target == 'r') { comboMods |= KEY_RSHIFT; j++; }
                else if (target == 'c') { comboMods |= KEY_LCTRL;  j++; }
                else if (target == 'q') { comboMods |= KEY_RCTRL;  j++; }
                else if (target == 'a') { comboMods |= KEY_LALT;   j++; }
                else if (target == 'm') { comboMods |= KEY_RALT;   j++; }
                else if (target == 'f') { comboMods |= KEY_LGUI;   j++; }
                else if (target == 'g') { comboMods |= KEY_RGUI;   j++; }
                else {
                  // Not a modifier! Treat this character as the core keycap target
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
                    case 'T': comboKey = KEY_TAB;         break; 
                    case 'B': comboKey = KEY_BACKSPACE;   break;
                    case 'P': comboKey = KEY_SPACE;       break;
                    default:
                      if (target >= 'A' && target <= 'Z') { comboMods |= KEY_LSHIFT; comboKey = 0x04 + (target - 'A'); }
                      else if (target >= 'a' && target <= 'z') { comboKey = 0x04 + (target - 'a'); }
                      else if (target >= '1' && target <= '9') { comboKey = 0x1E + (target - '1'); }
                      else if (target == '0') { comboKey = 0x27; }
                      else if (target == ' ') { comboKey = KEY_SPACE; }
                      break;
                  }
                
                  executeReport(comboMods, comboKey);
                  executionTriggered = true;
                  j++;
                  break; // Combo fully compiled and spent! Exit loop.
                }
              }
            }
            if (executionTriggered) {
              i = j;
              continue;
            }
          }
          else if (handleSingleMacro(upperType)) {
            i += 2; // Jump index past backslash and the consumed type token flag
            continue;
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
          else if (macroType == '[') {
            unsigned int parseIndex = i + 1;
            uint8_t parsedKey = KEY_NONE;
            
            // Try matching navigation / layout structural tokens first
            if (parseBracketedKey(inputString, parseIndex, parsedKey)) {
              executeReport(activeGlobalModifiers, parsedKey);
              i = parseIndex;
              continue;
            }
            
            parseIndex = i + 1; // Reset cursor position evaluation back to opening bracket
            // Try matching multi-media consumer usage keys next
            if (parseBracketedMediaKey(inputString, parseIndex, parsedKey)) {
              sendMediaKey(parsedKey);
              i = parseIndex;
              continue;
            }
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

bool parseBracketedModifier(String input, unsigned int &index, uint8_t &out) {
  if (index < input.length() && input.charAt(index) == '[') {
    unsigned int closeBracket = input.indexOf(']', index);
    if (closeBracket != -1) {
      String token = input.substring(index + 1, closeBracket);
      token.toLowerCase();
      
      uint8_t tempOut = KEY_NONE;
      bool matched = false;

      if (token == "ctrl" || token == "lctrl")        { tempOut = KEY_LCTRL;  matched = true; }
      else if (token == "shift" || token == "lshift") { tempOut = KEY_LSHIFT; matched = true; }
      else if (token == "alt" || token == "lalt")     { tempOut = KEY_LALT;   matched = true; }
      else if (token == "win" || token == "lgui")     { tempOut = KEY_LGUI;   matched = true; }
      else if (token == "rctrl")                      { tempOut = KEY_RCTRL;  matched = true; }
      else if (token == "rshift")                     { tempOut = KEY_RSHIFT; matched = true; }
      else if (token == "ralt")                       { tempOut = KEY_RALT;   matched = true; }
      else if (token == "rgui" || token == "rwin")    { tempOut = KEY_RGUI;   matched = true; }

      if (matched) {
        out = tempOut;
        index = closeBracket + 1; // Explicit index update on confirmed match
        return true;
      }
    }
  }
  return false;
}

bool parseBracketedKey(String input, unsigned int &index, uint8_t &out) {
  if (index < input.length() && input.charAt(index) == '[') {
    unsigned int closeBracket = input.indexOf(']', index);
    if (closeBracket != -1) {
      String token = input.substring(index + 1, closeBracket);
      token.toLowerCase();
      
      uint8_t tempOut = KEY_NONE;
      bool matched = false;

      if (token == "up")                            { tempOut = KEY_UP;          matched = true; }
      else if (token == "down")                     { tempOut = KEY_DOWN;        matched = true; }
      else if (token == "left")                     { tempOut = KEY_LEFT;        matched = true; }
      else if (token == "right")                    { tempOut = KEY_RIGHT;       matched = true; }
      else if (token == "enter")                    { tempOut = KEY_ENTER;       matched = true; }
      else if (token == "esc")                      { tempOut = KEY_ESC;         matched = true; }
      else if (token == "caps")                     { tempOut = KEY_CAPS_LOCK;   matched = true; }
      else if (token == "numlock")                  { tempOut = KEY_NUM_LOCK;    matched = true; }
      else if (token == "scrolllock")               { tempOut = KEY_SCROLL_LOCK; matched = true; }
      else if (token == "delete" || token == "del") { tempOut = KEY_DELETE;      matched = true; }
      else if (token == "tab")                      { tempOut = KEY_TAB;         matched = true; }
      else if (token == "backspace")                { tempOut = KEY_BACKSPACE;   matched = true; }
      else if (token == "space")                    { tempOut = KEY_SPACE;       matched = true; }

      if (matched) {
        out = tempOut;
        index = closeBracket + 1; // Explicit index update on confirmed match
        return true;
      }
    }
  }
  return false;
}

bool parseBracketedMediaKey(String input, unsigned int &index, uint8_t &out) {
  if (index < input.length() && input.charAt(index) == '[') {
    unsigned int closeBracket = input.indexOf(']', index);
    if (closeBracket != -1) {
      String token = input.substring(index + 1, closeBracket);  
      token.toLowerCase();
      
      uint8_t tempOut = KEY_NONE;
      bool matched = false;

      if (token == "volup")            { tempOut = KEY_VOL_UP;     matched = true; }
      else if (token == "voldown")     { tempOut = KEY_VOL_DOWN;   matched = true; }
      else if (token == "mute")        { tempOut = KEY_MUTE;       matched = true; }
      else if (token == "play")        { tempOut = KEY_PLAY_PAUSE; matched = true; }
      else if (token == "stop")        { tempOut = KEY_STOP;       matched = true; }
      else if (token == "next")        { tempOut = KEY_NEXT_TRACK; matched = true; }
      else if (token == "prev")        { tempOut = KEY_PREV_TRACK; matched = true; }

      if (matched) {
        out = tempOut;
        index = closeBracket + 1; // Explicit index update on confirmed match
        return true;
      }
    }
  }
  return false;
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

    case 'V': sendMediaKey(KEY_VOL_UP);     targetKey = KEY_NONE; break; // \V drops Volume Up frame
    case 'I': sendMediaKey(KEY_VOL_DOWN);   targetKey = KEY_NONE; break; // \I drops Volume Down frame
    case 'M': sendMediaKey(KEY_MUTE);       targetKey = KEY_NONE; break; // \M toggles absolute Mute
    case 'Y': sendMediaKey(KEY_PLAY_PAUSE); targetKey = KEY_NONE; break; // \Y Pause&Play&Continue
    case 'Z': sendMediaKey(KEY_STOP);       targetKey = KEY_NONE; break; // \Z Stop
    case 'J': sendMediaKey(KEY_NEXT_TRACK); targetKey = KEY_NONE; break; // \J Next Track
    case 'W': sendMediaKey(KEY_PREV_TRACK); targetKey = KEY_NONE; break; // \W Previous Track

    default:
      switch (type) {
        case 'l': instantMod |= KEY_LSHIFT; break; 
        case 'r': instantMod |= KEY_RSHIFT; break; 
        case 'c': instantMod |= KEY_LCTRL;  break; 
        case 'q': instantMod |= KEY_RCTRL;  break; 
        case 'a': instantMod |= KEY_LALT;   break; 
        case 'm': instantMod |= KEY_RALT;   break; 
        case 'f': instantMod |= KEY_LGUI;   break; 
        case 'g': instantMod |= KEY_RGUI;   break;
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
    case 'f': activeGlobalModifiers |= KEY_LGUI;   break;
    case 'g': activeGlobalModifiers |= KEY_RGUI;   break;
  }
}

void sendMediaKey(uint16_t consumerUsageKey) {
  uint8_t mediaBuf[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
  
  // Convert custom codes to true USB HID Consumer usage codes
  uint16_t trueHIDCode = 0;
  switch(consumerUsageKey) {
    case KEY_PLAY_PAUSE: trueHIDCode = 0x00CD; break; // Play/Pause
    case KEY_MUTE: trueHIDCode = 0x00E2; break; // Mute
    case KEY_VOL_UP: trueHIDCode = 0x00E9; break; // Volume Up
    case KEY_VOL_DOWN: trueHIDCode = 0x00EA; break; // Volume Down
    case KEY_NEXT_TRACK: trueHIDCode = 0x00B5; break; // Next Track
    case KEY_PREV_TRACK: trueHIDCode = 0x00B6; break; // Previous Track
    case KEY_STOP: trueHIDCode = 0x00B7; break; // Stop
    default:   trueHIDCode = consumerUsageKey; break;
  }

  mediaBuf[0] = 0x02;
  mediaBuf[1] = trueHIDCode & 0xFF;        // Low byte
  mediaBuf[2] = (trueHIDCode >> 8) & 0xFF; // High byte

  // Press Key Event
  Serial.write(mediaBuf, 9);
  delay(30); // Hold delay time
  
  // Release Key Event to prevent stuck keys
  mediaBuf[0] = 0x00;
  mediaBuf[1] = 0x00;
  Serial.write(mediaBuf, 9);
}

void executeReport(uint8_t mod, uint8_t key) {
  uint8_t KeyboardBuf[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
  KeyboardBuf[0] = 0x01;
  KeyboardBuf[1] = mod;
  KeyboardBuf[2] = 0x00;
  KeyboardBuf[3] = key;
  Serial.write(KeyboardBuf, 9);
  
  delay(23); // Keydown duration hold

 if (key == KEY_NONE) {
    KeyboardBuf[1] = activeGlobalModifiers;
  } else {
    KeyboardBuf[1] = mod;
  }
  KeyboardBuf[3] = KEY_NONE;
  Serial.write(KeyboardBuf, 9); // Send clear key release report
  
  delay(45);   // Settling delay to let BIOS register execution state safely
}
