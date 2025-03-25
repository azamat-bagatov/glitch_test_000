import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

PImage img;

float scale = 1.0;

void setup() {
  size(640, 320);
  MidiBus.list(); 
  img = loadImage("onecru-l.jpg");  // Load the image into the program 
  //img = loadImage("crypt_onecru.jpg");  // Load the image into the program 
  img.resize(640,320);
  image(img, 0, 0);
   myBus = new MidiBus(this, "Akai MPD32", "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

}

void draw() {
  displace();
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  scale = map(value,0,127,0,10);
}

void displace(){
  //cut out a random rectangle from the image and "smear" it over
  int posX = (int) random(0,width);
  int posY = (int) random(0,height);
  int rw = int ( random(20,100)*scale);
  int rh = int ( random(10,50)*scale);
  int steps = int ( random(5,50)*scale);
  
  PImage rect = img.get(posX,posY,rw,rh);
  //PImage rect = get(posX,posY,rw,rh);
  int dir = (int) random(0,4);

  for(int i = 0; i < steps; i++){
    if(dir == 0) image(rect,posX++,posY--);
    if(dir == 1) image(rect,posX--,posY++);
    if(dir == 2) image(rect,posX++,posY++);
    if(dir == 3) image(rect,posX--,posY--);
  }
  
}

void keyPressed(){
  if (key == 'q') displace();
  if( key == 'e') image(img, 0, 0);
  if( key == 's') save(millis() + ".jpg");
}
