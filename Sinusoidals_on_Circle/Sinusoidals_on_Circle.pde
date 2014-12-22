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
float nPx = 0;
float nPy = 0;

// What parts of the illustration to draw
boolean drawCircle = true;
boolean drawUnwrappedCircle = true;
boolean drawUnwrappedSinusoidal = false;
boolean drawUnwrappedCircleCentrePoint = true;
boolean drawSinusoidal = true;

void setup() {

  // HSB colour, white background, 1000x800 canvas
  size(1000, 800);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 100);

  // Follow regular Cartesian plane, origin lower-left
  translate(0, height);
  scale(1, -1);

  // Control size of circle (drawn in black)
  r = 75;
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
  nPx = 0;
  nPy = 0;

  // Set up the "unwrapped" sinusoidal, shown in green
  sx = width/2 - PI*r;
  sy = height/2 + r;

  for (int i = 0; i < 400; i++) { // Go a bit past 360 (one trip round the core circle, so any gaps are filled in)
    
    // Draw the circle
    theta += 1;      // Move around the circle (360 degrees)
    x = r * cos(radians(theta)); // Convert from polar co-ordinates (r, theta) to Cartesian 
    y = r * sin(radians(theta)); // See: http://natureofcode.com/book/imgs/chapter03/ch03_08.png
    fill(0, 0, 0); // black
    noStroke();
    if (drawCircle && lxEnd < (lxStart + 2*PI*r)) ellipse(x+width/2, y+height/2, 4, 4);

    // Characteristics of unwrapped circle
    lxEnd = (2*PI*r)*(theta/360) + lxStart;

    // Characteristics of sinusoidal along "unwrapped" circle (line)
    sPx = sx;
    sPy = sy;
    sx = sx + ((2*PI*r)/360);
    sy = 200 * sin(radians((sx - cycles)/((2*PI*r)/(360*cycles)))) + height/2 + r;
    strokeWeight(4);
    stroke(120, 80, 90); // green
    if (i > 0 && drawUnwrappedSinusoidal && lxEnd < 2*(lxStart + 2*PI*r)) line(sPx, sPy, sx, sy);
    noStroke();

    // Get co-ordinates of sinusoidal as it goes around circle
    // Thinking of "r" for the wrapped sinusoidal the vertical
    // position (sy) of the unwrapped sinusoidal...
    nPx = nx;
    nPy = ny;
    nx = (sy - height/2) * cos(radians(theta)) + width/2;
    ny = (sy - height/2) * sin(radians(theta)) + height/2;
    strokeWeight(2);
    stroke(240, 80, 90); // blue
    if (i > 0 && drawSinusoidal && lxEnd < 2*(lxStart + 2*PI*r)) line(nPx, nPy, nx, ny);
    
  }
  
}

void draw() {
}

void keyPressed() {
}

