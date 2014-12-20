// Control size of circle (drawn in black)
float r = 0;
float theta = 0;
float x = 0;
float y = 0;

// For drawing red line (unwrapped circle)
float lxStart = 0; // starting position of unwrapped circle
float lxEnd = 0;   // ending position of unwrapped circle
float ly = 0;

// Number of cycles in sinusoidal
float cycles = 0;

// Used to draw unwrapped sinusoidal (along red line)
float sx = 0;
float sy = 0;
float sPx = 0;
float sPy = 0;

// Used to draw wrapped sinusoidal (along black circle)
float nx = 0;
float ny = 0;

// What parts of the illustration to draw
boolean drawCircle = true;
boolean drawUnwrappedCircle = true;
boolean drawUnwrappedSinusoidal = true;
boolean drawSinusoidal = true;

void setup() {

  size(640, 360);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);

  // Control size of circle (drawn in black)
  r = 50;
  theta = 0;
  x = 0;
  y = 0;

  // Used to draw unwrapped line (red)
  lxStart = width/2 - PI*r;
  lxEnd = 0;
  ly = height/2 + r;

  // Number of cycles in sinusoidal
  cycles = 4;

  // Used to draw unwrapped sinusoidal (along red line)
  sx = 0;
  sy = 0;
  sPx = 0;
  sPy = 0;

  // Used to draw wrapped sinusoidal (along black circle)
  nx = 0;
  ny = 0;

  // Set up the "unwrapped" sinusoidal, shown in green
  sx = width/2 - PI*r;
  sy = height/2 + r;
}

void draw() {

  // Follow regular Cartesian plane
  translate(0, height);
  scale(1, -1);

  // Draw the circle
  theta += 1;      // Move around the circle (360 degrees)
  x = r * cos(radians(theta)); // Convert from polar co-ordinates (r, theta) to Cartesian 
  y = r * sin(radians(theta)); // See: http://natureofcode.com/book/imgs/chapter03/ch03_08.png
  fill(0, 0, 0); // black
  if (drawCircle && lxEnd < (lxStart + 2*PI*r)) ellipse(x+width/2, y+height/2, 4, 4);

  // Draw the "unwrapped" circle, shown in red
  lxEnd = (2*PI*r)*(theta/360) + lxStart;
  println((2*PI*r));
  strokeWeight(4);
  stroke(0, 80, 90); // green
  if (drawUnwrappedCircle && lxEnd < (lxStart + 2*PI*r)) line(lxStart, ly, lxEnd, ly);
  noStroke();

  // Draw a sinusoidal (green) along the unwrapped circle (red)
  sPx = sx;
  sPy = sy;
  sx = sx + ((2*PI*r)/360);
  sy = 10 * sin(radians((sx - cycles)/((2*PI*r)/(360*cycles)))) + height/2 + r; // ((1/cycles)*(2*PI*r)/360)
  strokeWeight(4);
  stroke(120, 80, 90); // green
  if (frameCount > 1 && drawUnwrappedSinusoidal && lxEnd < (lxStart + 2*PI*r)) line(sPx, sPy, sx, sy);
  noStroke();

  // Get co-ordinates of sinusoidal as it goes around circle
  // Thinking of r for the wrapped sinusoidal following the vertical
  // position (sy) of the unwrapped sinusoidal...
  nx = (sy - height/2) * cos(radians(theta));
  ny = (sy - height/2) * sin(radians(theta));
  noStroke();
  fill(240, 80, 90); // black
  if (drawSinusoidal && lxEnd < (lxStart + 2*PI*r)) ellipse(nx+width/2, ny+height/2, 4, 4);
}

void keyPressed() {

  // Toggle drawing of the basic circle drawn with polar co-ordinates
  if (key == '1') {
    if (drawCircle) {
      drawCircle = false;
    } else {
      drawCircle = true;
    }
    setup(); // reset drawing
  }

  // Toggle drawing of the basic circle drawn with polar co-ordinates
  if (key == '2') {
    if (drawUnwrappedCircle) {
      drawUnwrappedCircle = false;
    } else {
      drawUnwrappedCircle = true;
    }
    setup(); // reset drawing
  }

  // Toggle drawing of the basic circle drawn with polar co-ordinates
  if (key == '3') {
    if (drawUnwrappedSinusoidal) {
      drawUnwrappedSinusoidal = false;
    } else {
      drawUnwrappedSinusoidal = true;
    }
    setup(); // reset drawing
  }

  // Toggle drawing of the basic circle drawn with polar co-ordinates
  if (key == '4') {
    if (drawSinusoidal) {
      drawSinusoidal = false;
    } else {
      drawSinusoidal = true;
    }
    setup(); // reset drawing
  }
}

