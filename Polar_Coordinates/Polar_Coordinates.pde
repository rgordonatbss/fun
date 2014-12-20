float r = 50;
float theta = 0;

void setup() {
  size(640, 360);
  background(255);

  // Draw a line that is as long as the circle's circumference
  stroke(255, 0, 0); // red
  strokeWeight(4);
  line(width/2 - PI*r, height/2 + r, width/2 + PI*r, height/2 + r);
  noStroke();
}

void draw() {

  //[full] Polar coordinates (r,theta) are converted to Cartesian (x,y) for use in the ellipse() function.
  float x = r * cos(theta);
  float y = r * sin(theta);
  //[end]

  // Draw the circle
  fill(0); // black
  ellipse(x+width/2, y+height/2, 4, 4);

  // Move around the circle (360 degrees)
  theta += 0.01;
}

