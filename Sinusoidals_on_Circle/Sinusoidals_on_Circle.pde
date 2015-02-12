// How many versions of pattern to draw
int patternCount = 100;

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
  size(2000, 2000);
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
  float multiplier = map(mouseY, 0, height, 5, 1);
  float shift = map(mouseX, 0, width, 25, 75);

  // Reset all control values
  for (int i = 0; i < patternCount; i ++) {

    // Control size of circle (drawn in black)
    r[i] = 500;
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
    a[i] = 1.5*multiplier*(i+1);
    d[i] = 2*shift * i;

    // Set up the "unwrapped" sinusoidal, shown in green
    sx[i] = width/2 - PI*r[i];
    sy[i] = height/2 + r[i];

    // Used to draw wrapped sinusoidal (along black circle)
    nx[i] = 0;
    ny[i] = 0;
    nPx[i] = 0;
    nPy[i] = 0;
//    hue[i] = ((360/patternCount)*i) % 360;
    hue[i] = 240 - patternCount/4;
//    hue[i] = 0 - patternCount/4;
    //hue[i] = 300 - patternCount/2;
//    brightness[i] = 100 - (i*75)/patternCount;
    brightness[i] = 100 - (i*100)/patternCount;
  }

  
  // Move around the circle
  for (int i = 0; i < patternCount; i++) { // Go a bit past 360 (one trip round the core circle, so any gaps are filled in)

    // Update each pattern
    for (int j = 0; j < 400; j++) {

      // Draw the "core" circle that drawing is based around
      theta[i] += 1;      // Move around the circle (360 degrees)
      x[i] = r[i] * cos(radians(theta[i])); // Convert from polar co-ordinates (r, theta) to Cartesian 
      y[i] = r[i] * sin(radians(theta[i])); // See: http://natureofcode.com/book/imgs/chapter03/ch03_08.png
      fill(0, 0, 0); // black
      noStroke();
      if (drawCircle && lineLength[i] < 2*PI*r[i]) ellipse(x[i]+width/2, y[i]+height/2, 4, 4);

      // Characteristics of unwrapped circle
      lineLength[i] = (2*PI*r[i])*(theta[i]/360);

      // Characteristics of sinusoidal along "unwrapped" circle (line)
      sx[i] = sx[i] + ((2*PI*r[i])/360);
      sy[i] = a[i] * sin(radians((sx[i] - d[i])/((2*PI*r[i])/(360*cycles[i])))) + height/2 + r[i];

      // Get co-ordinates of sinusoidal as it goes around circle
      // Thinking of "r" for the wrapped sinusoidal the vertical
      // position (sy) of the unwrapped sinusoidal...
      nPx[i] = nx[i];
      nPy[i] = ny[i];
      nx[i] = (sy[i] - height/2) * cos(radians(theta[i])) + width/2;
      ny[i] = (sy[i] - height/2) * sin(radians(theta[i])) + height/2;
      strokeWeight(2);
      stroke(hue[i], 80, brightness[i]); // blue
      if (j > 0 && drawSinusoidal && lineLength[i] < 2*(2*PI*r[i])) line(nPx[i], nPy[i], nx[i], ny[i]);
    }
  }
  
}

void keyPressed() {
  
  saveFrame("output-####.png");
}
