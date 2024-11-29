import com.hamoid.*;
VideoExport videoExport;
PImage img;
void setup() {
  size(640, 320);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("onecru-l.jpg");  // Load the image into the program  
  //img.resize(640,320);
  image(img, 0, 0);
    videoExport = new VideoExport(this);
  videoExport.startMovie();
}

void draw() {
  // Displays the image at its actual size at point (0,0)
  
  
  // Displays the image at point (0, height/2) at half of its size
  //image(img, 0, height/2, width/2, height/2);
  displace();
  videoExport.saveFrame();
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
  stroke(250);
  noFill();
  //rect(posX,posY,rw,rh);
  println ("x=" + posX + " y=" + posY + " steps=" + steps);
  
}

void keyPressed(){
  if (key == 'q') displace();
  if(key == 'e') image(img, 0, 0);
  if( key == 's') save(millis() + ".jpg");
  if(key == 'x'){
    videoExport.endMovie();
    exit();
  }
}
