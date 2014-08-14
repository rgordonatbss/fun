// To track location of particles
PVector[] location = new PVector[200];
PVector[] velocity = new PVector[200];

// To move through Perlin noise space
float xOffset = 0.0;
float yOffset = 0.0;
float xIncrement = 0.002;
float yIncrement = 0.05;

// This runs once
void setup() {

  // Create canvas
  size(640, 360);

  // Create objects

  // Set initial location and velocity
  float sOffset = 0;
  float sIncrement = 0.8;
  for (int i = 0; i < location.length; i ++) {
    sOffset += sIncrement;
    location[i] = new PVector(map(noise(sOffset), 0, 1, 0, width), map(noise(pow(sOffset, 2)), 0, 1, 0, height));
    velocity[i] = new PVector(0, 0);
  }

  // No borders
  noStroke();
  
  // Background is white
  background(255);
}

// This runs forever
void draw() {

  // Erase what was drawn last time
  //background(255);

  // Change velocity using Perlin noise
  yOffset = 0;
  for (int i = 0; i < location.length; i ++) {

    // Move through Perlin noise space
    xOffset += xIncrement;
    yOffset += yIncrement;

    // Generate new velocity
    velocity[i].x = cos(noise(xOffset, yOffset) * TWO_PI);
    velocity[i].y = sin(noise(xOffset, yOffset) * TWO_PI);

    // Update the location based on current velocity
    location[i].add(velocity[i]);

    // Draw particle in new location
    fill(0);
    point(location[i].x, location[i].y);
    ellipse(location[i].x, location[i].y, 1, 1);
  }
}
