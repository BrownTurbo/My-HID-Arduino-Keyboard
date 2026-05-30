#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10, 11); // RX, TX

#define KEY_NONE        0x00
#define KEY_LEFT_SHIFT  0x02
#define KEY_LEFT_CTRL   0x01

#define BIOS_KEY_ENTER  0x28
#define BIOS_KEY_ESC    0x29
#define BIOS_KEY_SPACE  0x2C
#define BIOS_KEY_F9     0x42
#define BIOS_KEY_F10    0x43
#define BIOS_KEY_F12    0x45
#define BIOS_KEY_RIGHT  0x4F
#define BIOS_KEY_LEFT   0x50
#define BIOS_KEY_DOWN   0x51
#define BIOS_KEY_UP     0x52

uint8_t buf[8] = { 0 };

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
          
          if (macroType == 'F') {
            // Parse a multi-character function key macro like \F10
            String fNumStr = "";
            unsigned int j = i + 2;
            
            while (j < inputString.length() && isDigit(inputString.charAt(j))) {
              fNumStr += inputString.charAt(j);
              j++;
            }
            
            if (fNumStr.length() > 0) {
              handleFunctionMacro(fNumStr.toInt());
              i = j; // Advance past the entire sequence: '\', 'F', and the digits
              continue; // Skip the default increment step
            }
          } 
          else {
            // Handle single character navigation macros like \U, \D, \L, \R, \E, \S
            bool validMacro = handleSingleMacro(macroType);
            if (validMacro) {
              i += 2; // Advance index past the '\' and the command character
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

void sendAlphaNumericKey(char c) {
  uint8_t modifier = KEY_NONE;
  uint8_t scanCode = KEY_NONE;

  if (c >= 'A' && c <= 'Z') {
    modifier = KEY_LEFT_SHIFT;
    scanCode = 0x04 + (c - 'A');
  } 
  else if (c >= 'a' && c <= 'z') {
    scanCode = 0x04 + (c - 'a');
  } 
  else if (c >= '1' && c <= '9') {
    scanCode = 0x1E + (c - '1');
  } 
  else if (c == '0') {
    scanCode = 0x27;
  } 
  else if (c == ' ') {
    scanCode = BIOS_KEY_SPACE;
  }

  if (scanCode != KEY_NONE) {
    executeReport(modifier, scanCode);
  }
}

// Returns true if a recognized macro was intercepted and executed
bool handleSingleMacro(char type) {
  uint8_t targetKey = KEY_NONE;

  switch (type) {
    case 'U': targetKey = BIOS_KEY_UP;    break; 
    case 'D': targetKey = BIOS_KEY_DOWN;  break; 
    case 'L': targetKey = BIOS_KEY_LEFT;  break; 
    case 'R': targetKey = BIOS_KEY_RIGHT; break; 
    case 'E': targetKey = BIOS_KEY_ENTER; break; 
    case 'S': targetKey = BIOS_KEY_ESC;   break; 
    default:  return false; // Not a macro, process as normal text
  }

  if (targetKey != KEY_NONE) {
    executeReport(KEY_NONE, targetKey);
  }
  return true;
}

void handleFunctionMacro(int fNumber) {
  uint8_t targetKey = KEY_NONE;
  if (fNumber == 9)  targetKey = BIOS_KEY_F9;
  if (fNumber == 10) targetKey = BIOS_KEY_F10;
  if (fNumber == 12) targetKey = BIOS_KEY_F12;

  if (targetKey != KEY_NONE) {
    executeReport(KEY_NONE, targetKey);
  }
}

void executeReport(uint8_t mod, uint8_t key) {
  buf[0] = mod;
  buf[2] = key;
  Serial.write(buf, 8);
  
  delay(15); // Keydown duration hold
  
  buf[0] = 0;
  buf[2] = 0;
  Serial.write(buf, 8); // Send clear key release report
  
  delay(35); // Settling delay to let BIOS register execution state safely
}
