class Door {
  float x, y, w, h;
    Door(float x, float y) {
    this.x=x;
    this.y=y;
    this.w=40;
    this.h=50;
  }
  void display() { //draws the block
    fill(153, 76, 0);
    rect(x, y, w, h);
  }
  
  void goThruDoor(float fx, float fy, float fw, float fh){
    if (openDoor(fx,fy,fw,fh)){
    //enter new room
    }
  }
  
  boolean openDoor(float fx, float fy, float fw, float fh) { //returns true if the player is touching the door
    float dx=abs(fx-x);
    float dy=abs(fy-y);
    return dx<(fw+w)/2 && dy<(fh+h)/2;
  }
}