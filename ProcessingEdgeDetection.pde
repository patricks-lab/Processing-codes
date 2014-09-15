//Processing code
//You may use this code for non commercial purposes, such as 
//research 

PImage img;
float pix_up,pix_down,pix_left,pix_right;
int numOfAdjPixels,extra;

void setup() {
size(472,633);
img = loadImage("sample.png");
}

void draw() {
  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
             // Where are we, pixel-wise?
        
        int loc = y + x*width;
        
        float now_color = get_bw(img.pixels[loc]);
        if(x > 1) {//searches for left pixel
          pix_up = get_bw(img.pixels[loc - width]);
          numOfAdjPixels++;
        } else {
          extra+=pix_up;
        }
        if(x < width-1) {//searches for right pixel
          pix_down = get_bw(img.pixels[loc+width]);
          numOfAdjPixels++;
        } else {
           extra+=pix_down;
        }
        if(y > 1) {//searches for top pixel
          pix_left = get_bw(img.pixels[loc-1]);
          numOfAdjPixels++;
        } else {
          extra+=pix_left;
        }
        if(y < height-1) {//search for bottom pixel                 
          pix_right = get_bw(img.pixels[loc+1]);
          numOfAdjPixels++;
        } else {
          extra+=pix_right;
        }
        
        float average = (pix_up + pix_down + pix_left + pix_right - extra)/numOfAdjPixels;
        extra = 0;
        numOfAdjPixels = 0;
        //stroke(r,g,b);
       pixels[loc] = color(abs(now_color - average)*mouseY/10);
    }
  }
  updatePixels();
}

float get_bw(color c) {//get black + white val from datatype color
  return (red(c) + green(c) + blue(c))/3;
}