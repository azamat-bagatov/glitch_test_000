PImage img;

String BUILD = "c.07";

void setup() {
  size(640, 320);
  //img = loadImage("onecru-l.jpg");  
  img = loadImage("crypt_onecru.jpg");  
  img.resize(640,320);
  image(img, 0, 0);

}

void draw() {
  
  for(int i = 0; i < 10; i++) corrosion();

}

void corrosion(){
  
  float weight_matrix[][] = {
    {1.0,  0.1,  0.1},
    {0.1,  0.0,  0.1},
    {0.1,  0.1  ,1.0}
  };

  
  //start at pixel
  int posX = (int) random(0,width);
  int posY = (int) random(0,height);
  color col = img.get(posX,posY);
  int step[] = weighted_step(weight_matrix);
  //spread in a weighted random direction until random stop
  
  while(random(0,100) < 95){
    
    //move point at random
    posX += step[0];
    posY += step[1];
    step = weighted_step(weight_matrix);
    //change direction occasionally 
    //if(randomRoll (0.1) ) step = weighted_step(weight_matrix);
    
    //draw point
    stroke(col);
    point(posX,posY);
    
  }
  
}
int[] weighted_step(float wm[][]){
   int step[] = {0,0};
   int i,j;
   while(true){
     i =(int)random(-2,2); 
     j =(int)random(-2,2); 
     if ( randomRoll( wm[i+1][j+1]) ){
      step[0] = i; step[1] = j;
      break;
   }
   }
   return step;
}
boolean randomRoll(float p){
  if(random(0,1) < p) return true;
  else return false;
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
  color background = color(20);
  
  noStroke();
  fill(background);
  int posY = 0; 
  while( posY < height){
    int step = (int)random(2,80);
    int shift = int(random(-50,50));
    PImage rect = img.get(0,posY,width,step);
    image(rect,shift,posY);
    if(shift < 0) rect(width-shift,posY,shift,step);
    else rect(0,posY,shift,step);
    posY+=step;
  }
}

void keyPressed(){
  if (key == 'd') displace();
  if (key == 'h') {horizontal_slicer(); delay(30);}
  if( key == 'e') image(img, 0, 0);
  if( key == 's') save(BUILD + "__"+ millis() + ".jpg");
  if( key == 'c') corrosion();
}
