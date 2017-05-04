import java.util.Random;
Random randint = new Random();
Player player;

int s;
int startvalue;
int counter;
boolean N;
ArrayList<StationaryBlock> hubArea = new ArrayList<StationaryBlock>();
ArrayList<StationaryBlock> blocks1 = new ArrayList<StationaryBlock>();
ArrayList<StationaryBlock> blocks2 = new ArrayList<StationaryBlock>();
ArrayList<StationaryBlock> blocks3 = new ArrayList<StationaryBlock>();
ArrayList<StationaryBlock> blocks4 = new ArrayList<StationaryBlock>();
ArrayList<StationaryBlock> blocks5 = new ArrayList<StationaryBlock>();
ArrayList<Particles> particles = new ArrayList<Particles>();
//ArrayList<StationaryBlock> blocks=new ArrayList<StationaryBlock>();
ArrayList<Door> arraydoors= new ArrayList<Door>();

void setup(){
  size(1280, 720);
  buttoncolor = color(102);
  highlight = color(51); 
  button[0] = new RectButton(640, 300, 85, 30, buttoncolor, highlight, "Resume");
  button[1] = new RectButton(640, 350, 125, 30, buttoncolor, highlight, "New Game");
  button[2] = new RectButton(640, 400, 60, 30, buttoncolor, highlight, "Exit");

  startvalue = second();
  counter = 0;
  N = false;
  
  player=new Player();
  player.x = width/2;
  player.y = width/2-200;
  player.w = 10;
  player.h = 10;
  player.vy=0;
  rectMode(CENTER);
  player.moveSpeed=3;
  player.jumpSpeed=8;
  
  blocks1.add(new StationaryBlock(200, 300, 60, 20));
  blocks1.add(new StationaryBlock(300, 400, 60, 20));
  blocks1.add(new StationaryBlock(400, 500, 60, 20));
  blocks1.add(new StationaryBlock(500, 600, 60, 20));
  blocks1.add(new StationaryBlock(600, 700, 60, 20));
  blocks1.add(new StationaryBlock(700, 600, 60, 20));
  blocks1.add(new StationaryBlock(800, 500, 60, 20));
  blocks1.add(new StationaryBlock(900, 400, 60, 20));
  blocks1.add(new StationaryBlock(1000, 500, 60, 20));
  blocks1.add(new StationaryBlock(1100, 600, 60, 20));
  blocks1.add(new StationaryBlock(1200, 500, 60, 20));
  blocks1.add(new StationaryBlock(100, 200, 60, 20));
  


  
  arraydoors.add(new Door(100,150));
  arraydoors.add(new Door(300,350));
  arraydoors.add(new Door(600,650));
    
  
  rectMode(CENTER);
  player.moveSpeed=3;
  player.jumpSpeed= 8;

}

RectButton [] button = new RectButton[3];
boolean locked = false;
color currentcolor, buttoncolor, highlight;
boolean paused = false;

void update(int x, int y) {
  if (locked == false) {
    button[0].update();
    button[1].update();
    button[2].update();
  } else {
    locked = false;
  }
  if (mousePressed && paused) {
    if (button[0].pressed()) {
      paused = false;
    } else if (button[1].pressed()) {
      paused = false;
    } else if (button[2].pressed()) {
      exit();
    }
  }
}

void Paused() {
  update(mouseX, mouseY);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  stroke(255);
  fill(currentcolor);
  rect(640, 200, 150, 60);
  fill(255);
  text("Paused", 640, 200);
  button[0].display();
  button[1].display();
  button[2].display(); 
  rectMode(CORNER);
  textAlign(BASELINE);
}

float randFloaty = random(0, .01);
float randFloatx = random(0, .01);

void draw(){  

  background(0);
  player.playerMove();
  
  player.display();
  particles.add(new Particles(0, 0, 2));
  
  for (int i=0;i<blocks1.size();i++) { //displays all blocks and checks if they are colliding with the player
    StationaryBlock b=blocks1.get(i);
    player.collide(b.x, b.y, b.w, b.h);
    b.display();
  }
  
  for (int i=0;i<arraydoors.size();i++) { 
    Door d=arraydoors.get(i);
    player.collide(d.x, d.y, d.w, d.h);
    d.display();
  }
  
  for (int i = 0; i < particles.size(); i ++) {
    Particles particle = particles.get(i);
    particle.display();
    randFloaty = random(0, .01);
    randFloatx = random(-.01, .01);
    particle.applyForces(randFloatx, randFloaty);
    if (particle.dead()) {
        particles.remove(i);
      }
  }
  
  if (paused){
    Paused();
  }
  
 }

boolean holdLeft = false, holdRight = false, holdSprint = false, holdJump = false;
int jumpMax = 500;
boolean falling = false;
/*/
boolean doorbool(){
  for (int i=0;i<arraydoors.size();i++) {
    Door d=arraydoors.get(i);
    if player.x<d;
  }
}
/*/

void setSignal (boolean setTo) { 

  if (key == 'q'){
    holdSprint = setTo;  
  }
  
}
 
void keyPressed() {
  if (key==CODED && keyCode==LEFT && paused == false) player.vx=-1*player.moveSpeed; //move left
  if (key==CODED && keyCode==RIGHT && paused == false) player.vx=player.moveSpeed; //move right
  if (key==CODED && keyCode==UP && player.vy==0 && paused == false || key == ' ' && player.vy==0 && paused == false) { //jump
    player.y-=player.jumpSpeed;
    player.vy=-1*player.jumpSpeed;
  }
  if (key == 'p' || key =='P'){
    paused = !paused;
    setSignal(false);  
  }else if (paused == false){
  setSignal(true);
  }
}
 
void keyReleased() { 
  if (key==CODED && keyCode==LEFT && player.vx<0) player.vx=0;
  if (key==CODED && keyCode==RIGHT && player.vx>0) player.vx=0;
  setSignal(false);
}