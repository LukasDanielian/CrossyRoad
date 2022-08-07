//CHECKS IF HIT BY ANY OBSTACLE THEN ENDS GAME
void hitByObstacle()
{
  if (rows.get(1).obstacles.size() > 0)
  {
    Obstacle obstacle = rows.get(1).obstacles.get(0);
    if (x >= obstacle.x - obstacle.w/2 && x <= obstacle.x + obstacle.w/2)
    {
      move.play(.25,.75);
      gameOver = true;
    }
  }
}

//CHECKS IF PLAYER IS ON LOG
void onLog()
{
  int log = -1;
  for (int i = 0; i < rows.get(1).obstacles.size(); i++)
  {
    Obstacle temp = rows.get(1).obstacles.get(i);
    if (x >= temp.x - temp.w/2 && x < temp.x + temp.w/2)
    {
      log = i;
      break;
    }
  }
  if (log != -1)
  {
    x += rows.get(1).obstacles.get(log).xMover;
  } else
  {
    move.play(.25,.75);
    gameOver = true;
  }
}

//CHECKS IF PLAYER IS IN BOUNDS
void checkBounds()
{
  if (x > width || x < 0)
  {
    move.play(.25,.75);
    gameOver = true;
  }
}
