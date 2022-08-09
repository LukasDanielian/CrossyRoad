//
void renderLights()
{
  pushMatrix();
  rotateX(-PI/6);
  ambientLight(lights.get(lightingMode).x, lights.get(lightingMode).y, lights.get(lightingMode).z);
  directionalLight(lights.get(lightingMode).x, lights.get(lightingMode).y, lights.get(lightingMode).z, 0, 0, -1);
  popMatrix();
}

//TRANSLATES INTO CORRECT LOC AND ADDS BOX TO CONTAIN WORLD
void setup3D()
{
  pushMatrix();
  translate(-width/2, -height, width/4);
  noFill();
  noStroke();
  translate(width/2, height/2, width);
  rotateX(PI/4);
  fill(#4BFF00);
  rotateZ(map(x, 0, width, PI/4, -PI/4));
  box(width, height * 2, width/2 + 50);
  translate(-width/2, -height/2, -500);
}

//RENDERS ROTATING OBJ MODELS AND CIRCLES
void renderStartScreen()
{
  directionalLight(255, 255, 255, 0, 0, -1);
  pushMatrix();
  translate(-width/2, -height/2, width/2);
  hint(DISABLE_DEPTH_TEST);
  textSize(500);
  fill(255);
  text("Crossy Road", width/2, -height * 0.3);
  hint(ENABLE_DEPTH_TEST);

  for (int i = 0; i < characters.size(); i++)
  {
    pushMatrix();
    translate(width/6 + width/characters.size() * i, height/2, width * .5);
    strokeWeight(20);
    stroke(255);
    noFill();
    circle(0, 75, width/characters.size()/2);
    rotateX(PI);
    rotateY(frameCount * 0.05);
    shape(characters.get(i));
    popMatrix();
  }
  popMatrix();
}

//RENDERS EVERY ROW
void renderRows()
{
  for (int i = 0; i < rows.size(); i ++)
  {
    rows.get(i).render();
  }
}

//RENDERS PLAYER AND SLIDING MOVEMENT
void renderPlayer()
{
  //TRAIN TRACKS OR ROAD
  if (currentType == 1 || currentType == 3)
  {
    hitByObstacle();
  }
  //RIVER
  else if (currentType == 2)
  {
    onLog();
  }

  //PLAYER RENDER
  checkBounds();
  pushMatrix();
  translate(x+locations.get(player).x, 7*height/8 + locations.get(player).y, locations.get(player).z);
  rotateX(PI/2);
  shape(characters.get(player));
  popMatrix();
  popMatrix();

  //SLIDING MOVEMENT
  if (next != 0)
  {
    if (next < x)
    {
      x -= 25;
    }

    if (next > x)
    {
      x += 25;
    }

    if (x > next - 25 && x < next + 25)
    {
      x = next;
      next = 0;
    }
  }
}

//RENDERS ENDING TEXT
void renderGameOver()
{
  textSize(100);
  fill(255);
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  textSize(300);
  text("GAME OVER\nRestart: R", 0, 0);
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}

//RENDERS SCORE TEXT
void renderScore()
{

  noLights();
  pushMatrix();
  hint(DISABLE_DEPTH_TEST);
  fill(0);
  stroke(255);
  rect(-width * 1.35, -height * 1.4, width/2, height/2.5, 50);
  fill(255);
  textSize(200);
  text("Score: " + score, -width * 1.35, -height * 1.4);
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}
