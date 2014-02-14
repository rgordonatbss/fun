// How much of a jump through Perlin noise space to make
float increment;

// Fonts
PFont serifItalic;
PFont serif;

// This function runs once only.
void setup() {

  // Create canvas
  size(800, 800);
  
  // White background
  background(255);

  // Set fonts
  serif = loadFont("Times-Roman-24.vlw");
  serifItalic = loadFont("Times-Italic-24.vlw");

  // Draw axes
  stroke(0); // black
  strokeWeight(2);
  line(width/8, height-height/8, width-width/8, height-height/8); // horizontal
  line(width/8, height-height/8, width/8, height/8); // vertical
  
  // Label axes
  textFont(serifItalic);
  fill(0);
  text("x", width-width/8, height-height/8+height/24);
  text("y", width/8-width/24, height/8);
  
  // Arrows for end of axes
  fill(0);
  triangle(width - width/8, height-height/8-height/96,width - width/8, height-height/8+height/96, width-width/8+width/96, height-height/8); // x 
  triangle(width/8 - width/96, height/8, width/8 + width/96, height/8, width/8, height/8-height/96); // y   

}

// This function runs repeatedly.
void draw() {
}
