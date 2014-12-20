// for reading file
BufferedReader reader;
String line;

// for tracking position of the agent
int x;
int y;
int stepSize = 5;
int diameter = 10;
float hue;

// runs once 
void setup() {
  
  // Create canvas
  size(1000, 1000);
  
  // Colour mode
  colorMode(HSB, 360, 100, 100, 100);
  
  // White background
  background(0, 0, 100);
  
  // No borders
  noStroke();
  
  // Pick a starting point
  x = (int) random(0, width);
  y = (int) random(0, height);
  
  // Open the file
  reader = createReader("example2.txt");    
}

// runs repeatedly - each iteration a line is read from file
void draw() {
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    // Stop reading because of an error or file is empty
    noLoop();  
  } else {
    line.toLowerCase(); // convert all characters to lower case
    //println(line);
    for(int i = 0; i < line.length(); i++) {
       //println(line.charAt(i));
       //println(int(line.charAt(i)));
       updateAgent(int(line.charAt(i)));
    }
  }
  
  // Save frames every now and again
  if (frameCount % 10 == 0) {
      saveFrame("output-####.png"); 
  }
}

void updateAgent(int value) {

  // Change direction of agent based on input text
  // Only letters a-z are used
  if (value >= 97 && value <= 99) {
    y -= stepSize; // North (a, b, c)
  }
  else if (value >= 100 && value <= 102) {
    y -= stepSize; // North-east (d, e, f)
    x += stepSize;
  }  
  else if (value >= 103 && value <= 105) {
    x += stepSize; // East (g, h, i)
  }  
  else if (value >= 105 && value <= 107) {
    x += stepSize; // South-east (j, k, l)
    y += stepSize; 
  }  
  else if (value >= 108 && value <= 110) {
    y += stepSize; // South (m, n, o)
  }  
  else if (value >= 111 && value <= 113) {
    x -= stepSize; // South-west (p, q, r)
    y += stepSize;
  }  
  else if (value >= 115 && value <= 117) {
    x -= stepSize; // West (s, t, u)
  }  
  else if (value >= 118 && value <= 122) {
    x -= stepSize; // North-west (v, w, x, y, z)
    y -= stepSize;
  }  
  
  // wrap at boundaries
  if (x > width) x = 0;
  if (x < 0) x = width;
  if (y > height) y = 0;
  if (y < 0) y = height;
  
  // draw the agent
  if (value == 99 || value == 101 || value == 105 || value == 110 || value == 117) {
    //hue = map(value - 96, 1, 26, 160, 240);
    fill(240, 80, 90, 50);
    hue = 240;
  } else {
    fill(0, 0, 0, 10);
  }
  ellipse(x, y, diameter, diameter);
}
