PImage img;

String BUILD = "0.01";

void setup() {
  size(640, 320);
  img = loadImage("onecru-l.jpg");  // Load the image into the program  
  //img.resize(640,320);
  image(img, 0, 0);

}

void draw() {

}

void displace(){
  //cut out a random rectangle from the image and "smear" it over
  int posX = (int) random(0,width);
  int posY = (int) random(0,height);
  int rw = (int) random(20,100);
  int rh = (int) random(10,50);
  int steps = (int) random(5,50);
  
  PImage rect = img.get(posX,posY,rw,rh);
  int dir = (int) random(0,4);
  
  for(int i = 0; i < steps; i++){
    if(dir == 0) image(rect,posX++,posY--);
    if(dir == 1) image(rect,posX--,posY++);
    if(dir == 2) image(rect,posX++,posY++);
    if(dir == 3) image(rect,posX--,posY--);
  }
  
}

void horizontal_slicer(){
  color background = color(255);
  
  noStroke();
  fill(background);
  int posY = 0; 
  while( posY < height){
    int step = (int)random(2,40);
    int shift = (int)random(-50,50);
    PImage rect = img.get(0,posY,width,step);
    image(rect,shift,posY);
    if(shift < 0) rect(width-shift,posY,shift,step);
    else rect(0,posY,shift,step);
    posY+=step;
  }
}

void keyPressed(){
  if (key == 'd') displace();
  if (key == 'h') horizontal_slicer();
  if( key == 'e') image(img, 0, 0);
  if( key == 's') save(BUILD + millis() + ".jpg");
}
