//IMPORTS
import peasy.*;
import processing.sound.*;

//VARIABLES
ArrayList <Row> rows;
float x;
int score;
boolean canMove;
int currentType;
boolean gameOver;
PeasyCam cam;
PShape chicken, rock, log, pig, horse;
ArrayList<PShape> characters;
ArrayList<PVector> locations;
ArrayList<PVector> lights;
float next;
boolean startScreen;
int player;
int lightingMode;
SoundFile move;

void setup()
{
  //SETTINGS
  fullScreen(P3D);
  textAlign (CENTER, CENTER);
  rectMode (CENTER);
  shapeMode (CENTER);
  imageMode (CENTER);
  
  //VARIABLE DECLARATION
  characters = new ArrayList<PShape>();
  locations = new ArrayList<PVector>();
  lights = new ArrayList<PVector>();
  cam = new PeasyCam(this, 3000);
  cam.setActive(false);
  rows = new ArrayList <Row>();
  x=width/2;
  canMove = true;
  currentType = 0;
  gameOver = false;
  startScreen = true;
  score =0;
  next = 0;
  player = 0;
  move = new SoundFile(this,"move.wav");
  move.amp(.25);
  
  //CHICKEN
  chicken = loadShape("Chicken.obj");
  chicken.scale(50);
  chicken.setFill(color(255));
  chicken.translate(30,0,-100);
  characters.add(chicken);
  locations.add(new PVector(0, -70, 125));
  
  //PIG
  pig = loadShape("pig.obj");
  pig.scale(40);
  pig.setFill(color(#FF03FB));
  pig.translate(30,0,0);
  characters.add(pig);
  locations.add(new PVector (5, -60, 150));
  
  //HORSE
  horse = loadShape("horse.obj");
  horse.scale(40);
  horse.setFill(color(#9D9974));
  horse.translate(30,0,0);
  characters.add(horse);
  locations.add(new PVector (0, -80, 185));
  
  //ROCK
  rock = loadShape("rock.obj");
  rock.scale(1.5);
  
  //LOG
  log = loadShape("log.obj");
  log.scale(150);
  log.setFill(color(#484226));
  
  //ADDS STARTING ROWS
  int loc = 15 * height/16;
  rows.add(new Row(loc));
  loc -= height/8;
  rows.add(new Row(loc));
  loc -= height/8;
  for (int i = 0; i < 10; i++)
  {
    rows.add(new Row(width/2, loc));
    loc -= height/8;
  }

  //ADD LIGHTING OPTIONS
  lights.add(new PVector(255, 255, 255));
  lights.add(new PVector(50, 50, 150));
  lights.add(new PVector(200, 100, 150));
  lightingMode = (int)random(0, lights.size());
}

void draw()
{
  background(0);
  
  //START SCREEN
  if (startScreen)
  {
    renderStartScreen();
  }
  
  //MAIN GAME
  else if (!gameOver)
  {
    //MAP RENDER
    renderLights();
    setup3D();
    renderRows();
    renderPlayer();
  } 
  
  //GAME OVER
  else
  {
    renderGameOver();
  }
  
  //SCORE DISPLAY
  if (!startScreen)
  {
    renderScore();
  }
}
