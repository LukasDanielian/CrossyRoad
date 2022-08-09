//REPRESENDS ENTIRE ROW
class Row
{
  //VARIABLES
  float x, y;
  int mode;
  ArrayList <Obstacle> obstacles;
  int[] colors = {#F50525, #4AE0FC, #EDD518, #ED9818, #AC18ED};

  //RIVER FX VARIABLES
  int col, row;
  int scl = 10;
  int w;
  int h;
  float flying = 0;
  float[][] terrain;

  public Row(float x, float y)
  {
    obstacles=new ArrayList <Obstacle>();
    this.x = x;
    this.y = y;
    mode = (int)random(0, 4);

    //GRASS
    if (mode == 0)
    {
      for (int i= 0; i < 3; i++)
      {
        obstacles.add(new Obstacle(width/8 * (int)random(0, 8), y, 0, width/8, height/8, 200, #4B4B49, 0));
      }
    }

    //ROAD
    else if (mode ==1)
    {
      float speed = random (-15, 15);
      while (abs(speed) < 5)
      {
        speed = random(-15, 15);
      }
      obstacles.add(new Obstacle(random(0, width), y, speed, 2 * width/8, height/9, 200, colors[(int)random(0, colors.length)], 1));
    }

    //RIVER
    else if (mode == 2)
    {
      float speed = random (-7, 7);
      w = width;
      h = height/8;
      row = h/scl;
      col = w/scl;
      terrain = new float[col][row];
      while (abs(speed) < 3)
      {
        speed = random(-7, 7);
      }
      for (int i = 0; i < 3; i ++)
      {
        obstacles.add(new Obstacle(random(width/3*i, width/3 * i+1) + random(0, width/6), y, speed, 350, height/9, 30, #482C1B, 2));
      }
    }

    //TRAIN TRACKS
    else if (mode == 3)
    {
      obstacles.add(new Obstacle(-width/2 - 10, y, 0, width, height/9, 400, #FF050E, 3));
    }
  }

  //STARTING BLANK ROWS
  public Row(float y)
  {
    obstacles=new ArrayList <Obstacle>();
    x = width/2;
    mode = -1;
    this.y = y;
  }

  void render()
  {
    //grass
    if (mode==0)
    {
      for (int i = 0; i < obstacles.size(); i++)
      {
        obstacles.get(i).render();
      }
    }
    //ROAD
    else if (mode==1)
    {
      fill(100);
      noStroke();
      rect(x, y, width, height/8);

      float tempX = width/16;
      for (int i = 0; i < 8; i++)
      {
        fill(#FFF80F);
        pushMatrix();
        translate(0, 0, 1);
        rect(tempX, y, width/16, height/64);
        tempX += width/8;
        popMatrix();
      }

      for (int i = 0; i < obstacles.size(); i++)
      {
        obstacles.get(i).render();
        if (obstacles.get(i).x >= width + obstacles.get(i).w/2)
        {
          obstacles.get(i).x = -obstacles.get(i).w/2;
          obstacles.get (i).col = colors[(int)random(0, colors.length)];
        } else if (obstacles.get(i).x <= -obstacles.get(i).w/2)
        {
          obstacles.get(i).x = width + obstacles.get(i).w/2;
          obstacles.get (i).col = colors[(int)random(0, colors.length)];
        }
      }
    }
    //RIVER
    else if (mode==2)
    {
      fill(#3177FF);
      noStroke();

      //WATER DIRECTION
      if (obstacles.get(0).xMover > 0)
      {
        flying -= .05;
      } else
      {
        flying += .05;
      }

      //HEIGHT MAPPING
      float xOff = flying;
      for (int x = 0; x < col; x++)
      {
        float yOff = 0;
        for (int y = 0; y < row; y++)
        {
          if (y == row - 1 || y == 0)
          {
            terrain[x][y] = -5;
          } else
          {
            terrain[x][y] = map(noise(xOff, yOff), 0, 1, -5, 15);
          }
          xOff += .001;
        }
        yOff += .25;
      }

      //DRAWING WATER
      pushMatrix();
      translate(x- width/2, y - height/16);
      for (int y = 0; y < row-1; y++)
      {
        beginShape(TRIANGLE_STRIP);
        for (int x = 0; x < col; x++)
        {
          vertex(x*scl, y*scl, terrain[x][y]);
          vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
        }
        endShape();
      }
      popMatrix();

      //LOG RENDER
      for (int i = 0; i < obstacles.size(); i++)
      {
        obstacles.get(i).render();
        if (obstacles.get(i).x >= width + obstacles.get(i).w/2)
        {
          obstacles.get(i).x = -obstacles.get(i).w/2;
        } else if (obstacles.get(i).x <= - obstacles.get(i).w/2)
        {
          obstacles.get(i).x = width + obstacles.get(i).w/2;
        }
      }
    }
    //TRAIN TRACKS
    else if (mode == 3)
    {
      fill (#555A56);
      noStroke();

      //TRACK RENDER
      rect(x, y, width, height/8);
      int tempX = 0;
      fill(#482C1B);
      for (int i = 0; i < 32; i++)
      {
        pushMatrix();
        translate(0, 0, 1);
        rect(tempX, y, width/128, height/9, 1);
        tempX += width/32;
        popMatrix();
      }
      pushMatrix();
      fill(225);
      translate(0, 0, 2);
      rect(width/2, y + height/32, width, height/64);
      rect(width/2, y - height/32, width, height/64);
      popMatrix();

      //RENDER TRAINS
      obstacles.get(0).render();
      if ( obstacles.get(0).x >= width*1.5)
      {
        obstacles.get(0).x = -width/2 - 10;
        obstacles.get(0).xMover = 0;
      }

      //DETERMINE WHEN TRAIN MOVE
      int randNum = (int) random(0, 300);
      if (randNum == 0)
      {
        obstacles.get(0).xMover = 50;
      }
    }
  }

  //MOVES ROW AND EVERY OBSTACLE IN ROW FORWARD
  void move()
  {
    y += height/8;
    for (int i = 0; i < obstacles.size(); i++)
    {
      obstacles.get(i).move();
    }
    if (rows.size() == 12)
    {
      currentType = rows.get(2).mode;
    }
  }
}
