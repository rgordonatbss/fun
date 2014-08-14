/*
 * Based on code from: http://funprogramming.org/148-Drawing-shapes-with-glow-or-shadow.html
 */
// This function runs once only.
void setup() {
  
  // Create canvas
  size(800, 500);
  
  // Use Hue-Saturation-Brightness colour model
  // See: http://russellgordon.ca/hue-sat-bright.jpg
  // And: https://kuler.adobe.com
  colorMode(HSB, 360, 100, 100, 100);
  
  // Black background
  background(0, 0, 0);
  
  // Specify that rectangles should be located on canvas using (x, y)
  // co-ordinates that mark the CENTER of the shape (instead of top-right
  // corner which is the usual way).
  rectMode(CENTER);

  // Adjust speed of animation
  frameRate(10);  
}

void draw() {
  
  // Make the origin be in the centre of the screen
  translate(width/2, height/2);
  
  // Pick a random rotation amount
  float rotation = 0;
  rotation = random(0, 360);
  rotate(radians(rotation));
  
  // Pick a random amount to translate out from the origin
  float translation = 0;
  translation = random(-100, 100);
  translate(translation, 0);

  // Pick a random rectangle length
  float rectangleLength = 0;
  rectangleLength = random(150, 250);
  
  // Set border (stroke) color for shapes drawn below
  //      Hue  Sat  Bright  Transparency (as a %)
  stroke(38,   90,   100,       10);

  // First rectangle – exactly at centre of screen, 300 pixels wide, 50 pixels high
  strokeWeight(4); // Thin stroke to start
  rect(0, 0, rectangleLength, 20);
  
  // Second rectangle – exactly at centre of screen, 300 pixels wide, 50 pixels high
  strokeWeight(9); // A bit thicker...
  rect(0, 0, rectangleLength, 20);

  // Third rectangle – exactly at centre of screen, 300 pixels wide, 50 pixels high
  strokeWeight(25); // A bit thicker still...
  rect(0, 0, rectangleLength, 20);

  // Fourth rectangle – exactly at centre of screen, 300 pixels wide, 50 pixels high
  strokeWeight(36); // Even thicker...
  rect(0, 0, rectangleLength, 20);
  
  // Fifth rectangle
  noStroke(); // No border this time
  fill(210, 100, 100); // Set a blue fill
  rect(0, 0, rectangleLength, 20);
}
