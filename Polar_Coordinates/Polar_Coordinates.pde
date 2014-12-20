// Control size of circle (drawn in black)
float r = 50;
float theta = 0;
float x = 0;
float y = 0;

// Used to draw unwrapped sinusoidal (along red line)
float sx = 0;
float sy = 0;
float sPx = 0;
float sPy = 0;

// Used to draw wrapped sinusoidal (along black circle)
float nx = 0;
float ny = 0;

void setup() {

  size(640, 360);
  background(255);
  colorMode(HSB, 360, 100, 100);

  // Draw the "unwrapped" circle, shown in red
  stroke(0, 80, 90); // red
  strokeWeight(4);
  line(width/2 - PI*r, height/2 + r, width/2 + PI*r, height/2 + r);
  noStroke();
  
  // Set up the "unwrapped" sinusoidal, shown in green
  sx = width/2 - PI*r;
  sy = height/2 + r;
}

void draw() {

  // Draw the circle
  theta += 0.01;      // Move around the circle (360 degrees)
  x = r * cos(theta); // Convert from polar co-ordinates (r, theta) to Cartesian 
  y = r * sin(theta); // See: http://natureofcode.com/book/imgs/chapter03/ch03_08.png
  fill(0, 0, 0); // black
  ellipse(x+width/2, y+height/2, 4, 4);

  // Draw a sinusoidal (green) along the unwrapped circle (red)
  sPx = sx;
  sPy = sy;
  sx = sx + 1;
  sy = 10 * sin(radians(sx/(1*(2*PI*r)/360))) + height/2 + r; // Ensures one cycle per 360 degrees
  strokeWeight(4);
  stroke(120, 80, 90); // green
  if (frameCount > 1) line(sPx, sPy, sx, sy);
  noStroke();
  
  // Get co-ordinates of sinusoidal as it goes around circle
  // Thinking of r for the wrapped sinusoidal following the vertical
  // position (sy) of the unwrapped sinusoidal...
  nx = (sy - height/2) * cos(theta);
  ny = (sy - height/2) * sin(theta);
  noStroke();
  fill(240, 80, 90); // black
  ellipse(nx+width/2, ny+height/2, 4, 4);

}

