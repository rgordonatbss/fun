// Control size of circle
float r = 50;
float theta = 0;
float x = 0;
float y = 0;

// Used to draw the sinusoidal
float sx = 0;
float sy = 0;
float sPx = 0;
float sPy = 0;

// Used to draw sinusoidal along the circle
float nx = 0;
float ny = 0;

void setup() {

  size(640, 360);
  background(255);
  colorMode(HSB, 360, 100, 100);

  // Draw a line that is as long as the circle's circumference
  stroke(0, 80, 90); // red
  strokeWeight(4);
  line(width/2 - PI*r, height/2 + r, width/2 + PI*r, height/2 + r);
  noStroke();
  
  // Set up the sinusoidal
  sx = width/2 - PI*r;
  sy = height/2 + r;
}

void draw() {

  // Polar coordinates (r,theta) are converted to Cartesian (x,y) for use in the ellipse() function.
  x = r * cos(theta);
  y = r * sin(theta);

  // Draw the circle
  fill(0, 0, 0); // black
  ellipse(x+width/2, y+height/2, 4, 4);

  // Draw a sinusoidal along the unwrapped circle (green)
  sPx = sx;
  sPy = sy;
  sx = sx + 1;
  sy = 10 * sin(radians(sx/0.25)) + height/2 + r;
  strokeWeight(4);
  stroke(120, 80, 90); // green
  if (frameCount > 1) line(sPx, sPy, sx, sy);
  noStroke();
  
  // Get co-ordinates of sinusoidal as it goes around circle
  // Vary r by the amplitude of the green?
  nx = (sy - height/2) * cos(theta);
  ny = (sy - height/2) * sin(theta);
  // Draw the circle
  noStroke();
  fill(240, 80, 90); // black
  ellipse(nx+width/2, ny+height/2, 4, 4);

  // Move around the circle (360 degrees)
  theta += 0.01;
}

