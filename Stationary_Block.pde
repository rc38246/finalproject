class StationaryBlock {
  float x, y, w, h;
  StationaryBlock(float x, float y, float w, float h) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  void display() { //draws the block
    fill(255, 0, 0);
    rect(x, y, w, h);
  }
}