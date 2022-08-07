//GENERAL MOVEMENT
void keyPressed()
{
  if (!gameOver)
  {
    //UP
    if (keyCode == UP && canMove)
    {
      for (int i = 0; i < rows.get(2).obstacles.size(); i++)
      {
        Obstacle temp = rows.get(2).obstacles.get(i);
        if (x >= temp.x - temp.w/2 && x <= temp.x + temp.w/2 && temp.type == 0)
        {
          return;
        }
      }

      for (int i = 0; i <rows.size(); i ++)
      {
        rows.get(i).move();
        if (rows.get(i).y > height)
        {
          rows.remove(i);
          i--;
        }
      }
      rows.add(new Row(width/2, -height * .45));
      score++;
      canMove = false;
      move.play(random(1,1.25));
    }

    //LEFT
    else if (keyCode == LEFT)
    {
      float nextPos = 0;
      while (nextPos < x)
      {
        nextPos += width/8;
      }
      nextPos -= width/8;

      int amount = 0;
      for (int i = 0; i < rows.get(1).obstacles.size(); i++)
      {
        Obstacle temp = rows.get(1).obstacles.get(i);
        if (temp.isHit(nextPos, 13 * height/16) && currentType == 0)
        {
          amount++;
        }
      }
      if (amount == 0)
      {
        next = nextPos;
        move.play(.5);
      }
    }

    //RIGHT
    else if (keyCode == RIGHT)
    {
      float nextPos = width;
      while (nextPos > x)
      {
        nextPos -= width/8;
      }
      nextPos += width/8;
      int amount = 0;
      for (int i = 0; i < rows.get(1).obstacles.size(); i++)
      {
        Obstacle temp = rows.get(1).obstacles.get(i);
        if (temp.isHit(nextPos, 13 * height/16) && currentType == 0)
        {
          amount++;
        }
      }
      if (amount == 0)
      {
        next = nextPos;
        move.play(.5);
      }
    }
  }
  
  //RESTART
  if (key == 'r')
  {
    setup();
  }
}

//DISABLES HOLDING DOWN KEYS
void keyReleased()
{
  if (keyCode == UP || keyCode == LEFT || keyCode == RIGHT)
  {
    canMove = true;
  }
}

//CHARACTER SELECTION
void mousePressed()
{
  if (startScreen)
  {
    for(int i = 0; i < characters.size(); i++)
    {
      if(dist(mouseX,mouseY, width/((characters.size()*2)) + ((width/characters.size()) * i), height/2) <= width/(characters.size()*4))
      {
        player = i;
        startScreen = false;
      }
    }
  }
}
