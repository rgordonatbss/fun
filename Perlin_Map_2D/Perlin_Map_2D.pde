/*
 * To the extent possible under law, Russell Gordon has waived all copyright and related
 * or neighboring rights to Perlin Map 2D illustration. This work is published from: Canada.
 * http://creativecommons.org/publicdomain/zero/1.0/
 */

// Fonts
PFont serifItalic;
PFont serif;

// Flag for what type of random noise to show
boolean usePerlin = true;

// How much of a jump through Perlin noise space to make
float increment = 0.004;

// How far from start of x-axis to retrieve 1D Perlin noise values from
float xOffset = 0.0;


// This function runs once only.
void setup() {

  // Create canvas
  size(1000, 800);

  // White background
  background(255);

  // Set fonts
  serif = loadFont("Times-Roman-24.vlw");
  serifItalic = loadFont("Times-Italic-24.vlw");

  // Set noise detail for Perlin noise generator
  noiseDetail(8, 0.6);

  // Draw the axes
  drawAxes();

  // Draw the values
  drawValues();

  // No need to loop
  noLoop();
}

// This function runs repeatedly.
void draw() {
}

// This function responds when keyboard keys are pressed.
void keyPressed() {

  // Toggle display of Perlin noise values versus random values
  if (key == 'r') {
    usePerlin = false;
    background(255);
    drawAxes();
    drawValues();
    redraw();
  } 
  else if (key == 'p') {
    usePerlin = true;
    background(255);
    drawAxes();
    drawValues();
    redraw();
  }
}

// drawAxes
//
// Purpose: Draw horizontal and vertical axes to display random numbers with
//
// Parameters: (none)
void drawAxes() {

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
}

// drawValues
//
// Purpose: Draw the noise values and labels for horizontal and vertical axes
//
// Parameters: (none)
void drawValues() {

  // How much to move left and up to display grid
  float gridNumberWidth = ((width - 2*(width/8)) / 12);
  float gridWhiteSpaceWidth = (2*gridNumberWidth / 10);
  float gridNumberHeight = ((height - 2*(height/8)) / 12);
  float gridWhiteSpaceHeight = (2*gridNumberHeight / 10); 

  // Display a grid of the Perlin noise values
  textFont(serif);
  xOffset = 0.0;
  for (int x = 0; x < 10; x++) {

    xOffset += increment; // Increment xOffset with each additional column
    float yOffset = 0.0;  // For every xOffset (column), start yOffset at 0 (Keep in same patch of Y-axis as we move along X-axis in Perlin noise space)

    // Draw x-axis labels as we go
    fill(125); // grey
    String xL;
    if (usePerlin) {
      xL = String.format("%.3f", xOffset);
      text(xL, width/8 + gridWhiteSpaceWidth*(x+1) + gridNumberWidth*x, height - height/8 + gridNumberHeight/3*2);
    } 
    else {
      xL = String.format("%3d", x + 1);
      text(xL, width/8 + gridWhiteSpaceWidth*(x+1) + gridNumberWidth*x + gridWhiteSpaceWidth/2, height - height/8 + gridNumberHeight/3*2);
    }

    // Get Perlin noise values along the y-axis for this x-axis value
    for (int y = 0; y < 10; y++) {

      // Increment yOffset
      yOffset += increment;

      // Draw y-axis labels if we're on the first column
      if (x == 0) {
        String yL;
        fill(125); // grey
        if (usePerlin) {
          yL = String.format("%.3f", yOffset);
          text(yL, width/8 - gridWhiteSpaceWidth*(x+1) - gridNumberWidth, height - height/8 - gridWhiteSpaceHeight*1.5 - gridWhiteSpaceHeight*(y+1) - gridNumberHeight*y);
        } 
        else {
          yL = String.format("%3d", y + 1);
          text(yL, width/8 - gridWhiteSpaceWidth*(x+1) - gridNumberWidth/7*5, height - height/8 - gridWhiteSpaceHeight*1.5 - gridWhiteSpaceHeight*(y+1) - gridNumberHeight*y);
        }
      }

      // Get noise values
      float noiseValue = 0.0;
      if (usePerlin) {
        noiseValue = noise(xOffset, yOffset); // Perlin noise values
      } 
      else {
        noiseValue = random(0, 1);  // Regular random numbers
      }

      // Show value
      fill(0); // black
      String s = String.format("%.3f", noiseValue);
      text(s, width/8 + gridWhiteSpaceWidth*(x+1) + gridNumberWidth*x, height - height/8 - gridWhiteSpaceHeight*1.5 - gridWhiteSpaceHeight*(y+1) - gridNumberHeight*y);
    }
  }
}
