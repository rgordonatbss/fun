// Original Source created by Ben Stephenson, University of Calgary
// Code modified by Sandy Graham


////////////////////////////////////////////////////////////////////////////////
//  DO NOT CHANGE ANYTHING IN THIS FILE EXCEPT IN THE MARKED REGION NEAR THE 
//  BOTTOM OF THE FILE.
////////////////////////////////////////////////////////////////////////////////
import processing.video.*;

Capture cam;          // the object representing the camera
PImage camimg;        // image from the camera
PImage transformed;   // the transformed image
PImage bgimg;   // the transformed image

float cam_r, cam_g, cam_b;            // camera pixel red, green and blue
float trans_r, trans_g, trans_b;      // transformed pixel red, green and blue
float max_cam_r = 0;
float min_cam_r = 255;
float max_cam_g = 0;
float min_cam_g = 255;
float max_cam_b = 0;
float min_cam_b = 255;

void setup()
{
  String[] cameras = Capture.list();  // get a list of all the available cameras
  // and their resolutions / frame rates

  if (cameras.length == 0)            // check that we have an avaialble camera 
  { 
    println("There are no cameras available for capture.");
    exit();
  } else                                // display a list of the cameras 
  {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) 
    {
      println(cameras[i]);
    }

    // This attempts to find a camera with a resolution of 640x480 at 30 frames per
    // second.  However, there is no guarantee that any particular camera provides
    // this resolution / framerate.  As an alternative, you can initialize the
    // camera as:
    //
    // cam = new Capture(this, cameras[0])
    //
    // Use an index other than 0 if you don't like the resolution or framerate of 
    // camera 0.  While the following code won't do anything about a low framerate,
    // it will scale whatever image it gets back from the camera to 640x480 with a
    // frame rate of 30 frames per second.
    //
    cam = new Capture(this, 640, 480, 30);
    cam.start();
  }

  size(640, 480);                      // set the window size
  camimg = new PImage(640, 480);       // create images to hold the original
  transformed = new PImage(640, 480);  // and transformed data

  // read the first frame from the camera
  if (cam.available() == true) {
    cam.read();  // read a new frame of data from the camera
    camimg.copy(cam, 0, 0, 640, 480, 0, 0, 640, 480);
  }

  // load background image
  bgimg = loadImage("background.jpg");
}

void draw()
{

  if (cam.available() == true) {
    cam.read();  // read a new frame of data from the camera
    camimg.copy(cam, 0, 0, 640, 480, 0, 0, 640, 480);
  }


  ////////////////////////////////////////////
  // ONLY MAKE CHANGES BELOW THIS POINT
  ////////////////////////////////////////////

  for (int y = 0; y < cam.height; y ++) {
    for (int x = 0; x < cam.width; x ++) {
      cam_r = red(camimg.get(x, y));
      cam_g = green(camimg.get(x, y));
      cam_b = blue(camimg.get(x, y));

      if ((y > 0 && y < 50 && x > 0 && x < 50) ||
        (y > cam.height - 50 && y < cam.height && x > cam.width - 50 && x < cam.width)) { // sample top left and bottom right corner continuously

        if (frameCount % 30 == 0) {
          max_cam_r = 0;
          min_cam_r = 255;
          max_cam_g = 0;
          min_cam_g = 255;
          max_cam_b = 0;
          min_cam_b = 255;
        } 
        // Track maximum r, g, b values
        if (cam_r > max_cam_r) {
          max_cam_r = cam_r;
        }
        if (cam_g > max_cam_g) {
          max_cam_g = cam_g;
        }
        if (cam_b > max_cam_b) {
          max_cam_b = cam_b;
        }

        // Track minimum r, g, b values
        if (cam_r < min_cam_r) {
          min_cam_r = cam_r;
        }
        if (cam_g < min_cam_g) {
          min_cam_g = cam_g;
        }
        if (cam_b < min_cam_b) {
          min_cam_b = cam_b;
        }
      }

      // Decide what pixel to let through
      if ((cam_r > min_cam_r && cam_r < max_cam_r) &&
        (cam_g > min_cam_g && cam_g < max_cam_g) && 
        (cam_b > min_cam_b && cam_b < max_cam_b) 
        ) {  // if the pixel is the green screen colour...
        //      if ((cam_r > max_cam_r - 25 && cam_r < max_cam_r + 25) &&
        //        (cam_g > max_cam_g - 25 && cam_g < max_cam_g + 25) && 
        //        (cam_b > max_cam_b - 25 && cam_b < max_cam_b + 25) 
        //        ) {  // if the pixel is the green screen colour...
        trans_r = red(bgimg.get(x, y));
        trans_g = green(bgimg.get(x, y));    // use the background image
        trans_b = blue(bgimg.get(x, y));
      } else { // otherwise...
        trans_r = cam_r;
        trans_g = cam_g;    // use the camera image
        trans_b = cam_b;
      }

      //        trans_r = 255 - cam_r;
      //        trans_g = 255 - cam_g;
      //        trans_b = 255 - cam_b;
      //        
      if (!(frameCount % 30 == 0)) {
        transformed.set(x, y, color(trans_r, trans_g, trans_b));
      }
    }
  }

  //image(bgimg, 0, 0);
  println("max_cam_r is: " + max_cam_r);
  println("max_cam_g is: " + max_cam_g);
  println("max_cam_b is: " + max_cam_b);
  println("min_cam_r is: " + min_cam_r);
  println("min_cam_g is: " + min_cam_g);
  println("min_cam_b is: " + min_cam_b);



  ////////////////////////////////////////////
  // ONLY MAKE CHANGES ABOVE THIS POINT
  ////////////////////////////////////////////

  image(transformed, 0, 0);             // draw the transformed image on the screen
  //image(camimg, 0, 0);             // draw the transformed image on the screen
}
