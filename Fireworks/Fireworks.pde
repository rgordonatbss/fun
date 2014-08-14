// global variables; they can be accessed or set from any function
float xInt = 400;
float xVertex = 500;
float yVertex = 450;
float priorX = 0;
float priorY = 0;
float currentX = 0;
float currentY = 0;
float hue = 0;
float direction = 1;
float endRadius = 50;
float currentRadius = 1;
float xFinish = 0;
float yFinish = 0;
boolean explosionTime = false;

// this function runs once only
void setup() {

  // set canvas size
  size(1024, 768); 

  // use HSB (hue-saturation-brightness) color model
  // See https://plus.google.com/106892690517262395732/posts/ht8NSToLPkP for details
  // (post on HSB color model in ICS3U community)
  colorMode(HSB, 360, 100, 100);

  // black background
  background(240, 0, 0);

  // no border on shapes
  noStroke();

  // Set starting x value for firework (horizontal position)
  currentX = xInt;

  // Pick starting colour value
  hue = random(0, 360);

  // speed of animation
  frameRate(30);
}

// this function runs repeatedly, over and over again
void draw() {

  // Making launch of firework happen...

  // Set direction that firework will fire  
  if (direction < 1.5) {
    // Fireworks will fire left to right...
    //println("left to right"); // DEBUG

    // put origin (0,0) in lower left corner
    translate(0, height);

    // flip the scale on the y-axis
    // (so co-ordinate system is like a regular Cartesian
    // system where "y" increases going up the vertical axis)
    //    X   Y
    scale(1, -1);
  } else {

    // Fireworks will fire right to left...
    //println("right to left");  // DEBUG

    // put origin (0,0) in lower right corner
    translate(width, height);

    // flip the scale on the y-axis
    // (so co-ordinate system is like a regular Cartesian
    // system where "y" increases going up the vertical axis)
    //    X   Y
    scale(-1, -1);
  }


  // Draw the trail
  drawTrail();

  // Draw the explosion when the time is right...
  if (explosionTime) {
    drawExplosion();
  }
  
}

// drawTrail
//
// Purpose: Draw the trail of the firework.
void drawTrail() {
  
  // Draw the trail of the firework
  // draw black semi-transparent rectangle over canvas
  fill(0, 0, 0, 12);
  noStroke();
  rect(0, 0, width, height);

  // Decide whether to draw the exploion
  if (currentX > (xVertex + ((xVertex - xInt) / 2) )) {
    explosionTime = true;
  } 

  // Increment currentX (horizontal position of firework)
  // Also controls speed of animation
  if (!explosionTime) {
    currentX += 3;

    // Get vertical position of firework based current horizontal position
    currentY = quadraticPath(currentX, xInt, xVertex, yVertex);
  }  

  // set colour for firework
  fill(hue, 80, 90);
  stroke(hue, 80, 90);

  // draw firework trail
  strokeWeight(3);
  if (priorX != 0 && priorY !=0) {
    line(priorX, priorY, currentX, currentY);
  }
  priorX = currentX;
  priorY = currentY;
  
}

// drawExplosion
//
// Purpose: Draw the explosion for the firework.
//
void drawExplosion() {

  // Making explosion happen...

  // set colour for firework
  fill(hue, 80, 90, 30);

  // Draw an expanding circle to simulate explosion
  currentX = xVertex + ((xVertex - xInt) / 2) + 3;
  currentY = quadraticPath(currentX, xInt, xVertex, yVertex); 
  println("explosion x is" + currentX);
  println("explosion y is" + currentY);
  ellipse(currentX, currentY, currentRadius, currentRadius);

  // Increase size of circle
  currentRadius += 4;

  // Explosion finished, set up next firework launch
  if (currentRadius > endRadius) {
    // Pick new x-int (but not directly at right edge of canvas)
    xInt = random(0, width - 200);
    // Pick new vertex x value (somewhere between xInt and 50 pixels away from right edge of canvas)
    xVertex = random(xInt + 100, ((width - xInt) / 2));
    // Pick new vertex y value (at least 100 pixels above "ground" and not right at top of canvas)
    yVertex = random(height/2, height - 50);

    // Reset variables for location
    priorX = 0;
    priorY = 0;
    currentX = 0;
    currentY = 0;

    // Select next hue based on Golden Ratio
    hue = (hue + 0.618 * 360) % 360;

    // Decide which way firework will fire
    direction = random(1, 2);

    // Reset radius for explosion
    currentRadius = 1;

    // Reset current x to new x-int
    currentX = xInt;
    
    // No more explosions!
    explosionTime = false;
    
    // Clear everything
    noStroke();
    fill(0, 0, 0, 100);
    rect(0, 0, width, height);
  }
}

// quadraticPath
// 
// Purpose:   Given a vertex (d, c), an x-intercept (r),
//            and an x value, returns the corresponding y value
float quadraticPath(float x, float r, float d, float c) {

  // Work out the vertical scale factor (a)
  float a = 0;
  a = (0 - c) / ( (r - d) * (r - d) ); 

  // Now that we have the "a" value, return the y value that
  // matches the given "x" value
  return a * ( (x - d) * (x - d) ) + c;
}
