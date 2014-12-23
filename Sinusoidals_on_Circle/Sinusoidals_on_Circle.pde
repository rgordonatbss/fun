// How many versions of pattern to draw
int patternCount = 50;

// Control size of circle (drawn in black)
float[] r = new float[patternCount];
float[] theta = new float[patternCount];
float[] x = new float[patternCount];
float[] y = new float[patternCount];

// For drawing red line (unwrapped circle)
float[] lineLength = new float[patternCount]; // length of unwrapped circle

// Number of cycles in sinusoidal to be drawn
float[] cycles = new float[patternCount];

// Used to draw unwrapped sinusoidal (along red line)
float[] sx = new float[patternCount];
float[] sy = new float[patternCount];
float[] a = new float[patternCount];
float[] d = new float[patternCount];

// Used to draw wrapped sinusoidal (along black circle)
float[] nx = new float[patternCount];
float[] ny = new float[patternCount];
float[] nPx = new float[patternCount];
float[] nPy = new float[patternCount];
float[] hue = new float[patternCount];
float[] brightness = new float[patternCount];

// What parts of the illustration to draw
boolean drawCircle = false;
boolean drawSinusoidal = true;

void setup() {

  // HSB colour, black background, 1000x800 canvas
  size(1000, 800);
  colorMode(HSB, 360, 100, 100);
  background(0, 0, 0);
  
  // Very smooth line
  smooth(8);

  
}

void draw() {
  
  // Wipe background
  background(0, 0, 0);
  
  // Follow regular Cartesian plane, origin lower-left
  translate(0, height);
  scale(1, -1);
  
  // Used to control amplitude
  float multiplier = map(mouseX, 0, width, 1, 5);
  float shift = map(mouseY, 0, height, 25, 75);

  // Reset all control values
  for (int i = 0; i < patternCount; i ++) {

    // Control size of circle (drawn in black)
    r[i] = 50;
    theta[i] = 0;
    x[i] = 0;
    y[i] = 0;

    // Used to draw unwrapped line (red)
    lineLength[i] = 0;

    // Number of cycles in sinusoidal
    cycles[i] = 4;

    // Used to draw unwrapped sinusoidal (along red line)
    sx[i] = 0;
    sy[i] = 0;
    a[i] = multiplier*(i+1);
    d[i] = shift * i;

    // Set up the "unwrapped" sinusoidal, shown in green
    sx[i] = width/2 - PI*r[i];
    sy[i] = height/2 + r[i];

    // Used to draw wrapped sinusoidal (along black circle)
    nx[i] = 0;
    ny[i] = 0;
    nPx[i] = 0;
    nPy[i] = 0;
//    hue[i] = ((360/patternCount)*i) % 360;
    hue[i] = 240 - patternCount/2;
    brightness[i] = 100 - (i*75)/patternCount;
  }

  
  // Move around the circle
  for (int i = 0; i < 400; i++) { // Go a bit past 360 (one trip round the core circle, so any gaps are filled in)

    // Update each pattern
    for (int j = 0; j < patternCount; j++) {

      // Draw the "core" circle that drawing is based around
      theta[j] += 1;      // Move around the circle (360 degrees)
      x[j] = r[j] * cos(radians(theta[j])); // Convert from polar co-ordinates (r, theta) to Cartesian 
      y[j] = r[j] * sin(radians(theta[j])); // See: http://natureofcode.com/book/imgs/chapter03/ch03_08.png
      fill(0, 0, 0); // black
      noStroke();
      if (drawCircle && lineLength[j] < 2*PI*r[j]) ellipse(x[j]+width/2, y[j]+height/2, 4, 4);

      // Characteristics of unwrapped circle
      lineLength[j] = (2*PI*r[j])*(theta[j]/360);

      // Characteristics of sinusoidal along "unwrapped" circle (line)
      sx[j] = sx[j] + ((2*PI*r[j])/360);
      sy[j] = a[j] * sin(radians((sx[j] - d[j])/((2*PI*r[j])/(360*cycles[j])))) + height/2 + r[j];

      // Get co-ordinates of sinusoidal as it goes around circle
      // Thinking of "r" for the wrapped sinusoidal the vertical
      // position (sy) of the unwrapped sinusoidal...
      nPx[j] = nx[j];
      nPy[j] = ny[j];
      nx[j] = (sy[j] - height/2) * cos(radians(theta[j])) + width/2;
      ny[j] = (sy[j] - height/2) * sin(radians(theta[j])) + height/2;
      strokeWeight(2);
      stroke(hue[j], 80, brightness[j]); // blue
      if (i > 0 && drawSinusoidal && lineLength[j] < 2*(2*PI*r[j])) line(nPx[j], nPy[j], nx[j], ny[j]);
    }
  }
  
}

void mousePressed() {
  
  saveFrame("output-####.pdf");
}

