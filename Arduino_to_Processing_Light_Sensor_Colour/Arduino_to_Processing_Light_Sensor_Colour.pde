// Library required for reading serial port information
import processing.serial.*;
Serial port;

// Hue to use to control background
float hue;

void setup() {
  
  // Get and print a list of serial ports that are available
  println(Serial.list());

  // Connect our desired serial port
  port = new Serial(this, Serial.list()[2], 9600);
  
  // Make the canvas
  size(400, 400);
  
  // Switch to Hue-Saturation-Brightness colour model
  // See: https://twitter.com/rgordon/status/406373396939673602
  colorMode(HSB, 360, 100, 100);

  // White background
  background(0, 0, 100);
  
}

void draw() {
  
  // Change the background colour based on light intensity
  if (port.available() > 0) { // is the port available to read values from?
  
    int incomingByte = port.read(); // get the next byte from the serial port; see: http://arduino.cc/en/Reference/Serial
    println("I got: " + incomingByte); // DEBUG
    
    // Convert the light intensity value to a hue value
    hue = map(incomingByte, 0, 255, 0, 360); // see: https://www.processing.org/reference/map_.html
    background(hue, 80, 90); // change the background colour
  }
  
}
