// Fonts
PFont serifItalic;
PFont serif;

// This function runs once only.
void setup() {

  // Create canvas
  size(1000, 800);

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
  triangle(width - width/8, height-height/8-height/96, width - width/8, height-height/8+height/96, width-width/8+width/96, height-height/8); // x 
  triangle(width/8 - width/96, height/8, width/8 + width/96, height/8, width/8, height/8-width/96); // y

  // Set noise detail for Perlin noise generator
  noiseDetail(8, 0.6);

  // How much of a jump through Perlin noise space to make
  float increment = 0.004;
  
  // How much to move left and up to display grid
  float gridNumberWidth = ((width - 2*(width/8)) / 12);
  float gridWhiteSpaceWidth = (2*gridNumberWidth / 10);
  float gridNumberHeight = ((height - 2*(height/8)) / 12);
  float gridWhiteSpaceHeight = (2*gridNumberHeight / 10); 

  // How far from start of x-axis to retrieve 1D Perlin noise values from
  float xOffset = 0.0;

  // Display a grid of the Perlin noise values
  for (int x = 0; x < 10; x++) {
    
    xOffset += increment; // Increment xoff with each additional column
    float yOffset = 0.0;  // For every xoff, start yoff at 0 (Keep in same patch of Y-axis as we move along X-axis in Perlin noise space) 

    // Get Perlin noise values along the y-axis for this x-axis value
    textFont(serifItalic);
    fill(0);

    for (int y = 0; y < 10; y++) {

      // Increment yOffset
      yOffset += increment;

      // Get noise value from Perlin noise space
      float noiseValue = noise(xOffset, yOffset);

      // Show value
      textFont(serif);
      fill(0);
      String s = String.format("%.3f", noiseValue);
      text(s, width/8 + gridWhiteSpaceWidth*(x+1) + gridNumberWidth*x, height - height/8 - gridWhiteSpaceHeight*1.5 - gridWhiteSpaceHeight*(y+1) - gridNumberHeight*y);
    }
  }
}

// This function runs repeatedly.
void draw() {
}
