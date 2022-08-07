//REPRESENTS ANY OBSTACLE IN ROW
class Obstacle
{
  //VARIABLES
  float x, y, xMover, w, h, d;
  int col, type;
  
  public Obstacle (float x, float y, float xMover, float w, float h, float d, int col, int type)
  {
    this.x = x;
    this.y = y;
    this.xMover = xMover;
    this.w = w;
    this.h = h;
    this.d = d;
    this.col = col;
    this.type = type;
  }

  //DRAWS ONE OBSTACLE
  void render ()
  {
    pushMatrix();
    //GRASS
    if (type == 0)
    {
      translate(x + 75, y + 125, 0);
      shape(rock);
    } 
    
    //RIVER
    else if (type == 2)
    {
      pushMatrix();
      translate(x, y + 40, 25);
      rotateY(PI/2);
      rotateZ(PI/2);
      shape(log);
      popMatrix();
    } 
    
    //TRAIN TRACKS OR ROAD
    else
    {
      fill(col);
      stroke(255);
      strokeWeight(5);
      translate(x, y, 0);
      box(w, h, d);
    }
    popMatrix();
    
    x += xMover;
  }

  //MOVES OBSTACLES UP
  void move ()
  {
    y += height/8;
  }

  //CHECKS IF OBSTACLE IS HIT BY ANY POINT
  boolean isHit(float px, float py)
  {
    if (px >= x - w/2 && px <= x + w/2 && py >= y - w/2 && py <= y + w/2)
    {
      return true;
    }
    return false;
  }
}
