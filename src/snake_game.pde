int speed_x = 0;
int speed_y = 0; 
int snake_size = 20; //size of the beginning of the snake
int score = 0;
int move_x = 0;
int move_y = 0;
int fc1 = 255, fc2 = 255, fc3 = 255; 
ArrayList<snakeObj> snake = new ArrayList<snakeObj>();
snakeObj apple = new snakeObj();

PImage snakeimage;
PImage snakelogo;
// boolean isStart = false;
int modeP = 0;
boolean StartAndControls = true;

/////////////////////////////////////////////////////////////////////////////////

void setup()
{
  size(1200,800);
  frameRate(60);
 
  
  snake.add(new snakeObj());
  pickLocation();
  
}

void Media(){
  snakeimage = loadImage("snakeimage.png");
  snakelogo = loadImage("snakelogo.jpg");
  //BufferedImage mapmodifiable = ImageIO.read(new File("images/main.gif"));
  snakelogo.resize(60,60);
  snakeimage.resize(1200,800);
  image(snakeimage,0,0);
  // Game Name
  fill(255);
  textSize(60);
  text("Snake game", 90, 70);
  snakelogo.resize(60,60);
  image(snakelogo,430,20); 
  // Start button
  fill(29,206,240);
  rect(1080/2,550,150,50); // start button box
  
  fill(0);
  textSize(30);
  text("Start Game", 547, 583); // start txt
  
  // Controls button
  fill(29,206,240);
  rect(1080/2,620,150,50); // Controls button box
  
  fill(0);
  textSize(30);
  text("Controls ", 547, 651); // Controls txt
  
  if(StartAndControls){
    PressedStartAndControls();
  }
}

void PressedStartAndControls(){
  if((mouseX >= 1080/2 && mouseX <= 690) && (mouseY >= 550 && mouseY <= 600))
   {
      
     cursor(HAND);
     fill(242,2,2);  
      translate(615, 575);
      rotate(radians(frameCount*5));
   textSize(30);
   fill(255,255,255);
   text("start" ,-70 ,20 );
   text(" Game", 0, 20); // start txt
   }
   

   else if((mouseX >= 1080/2 && mouseX <= 690) && (mouseY >= 620 && mouseY <= 670))
   {
    cursor(HAND);
    fill(38,57,103);
    rect(1080/2,620,150,50); // Controls button box
    textSize(30);
    fill(0,255,0);
    text("Controls ", 547, 651); // Controls txt
   }
   else
   cursor(ARROW);
  

}

void draw()
{
  
  if(modeP == 0) {Media();}
  else if(modeP == 1) {guidePage();}
  else{
  if ((frameCount % 5)==0) // do something every 5 frames (frame rate is 60)
  {
   
  view();
  
  Food();
  Gameover();
  
  updateSnake();
  
  showScore();

  snakeMove();
  
  restart();
  
  }
}
}
/////////////////////////////////////////////////////////////////////////////////

void view()
{
  background(2);
  
  fill(29,206,240);
  rect(60, 60, 1080, 680, 20); //size of Cyan rectangle
}

void restart()
{
  if(keyPressed)
  {
      
    if (keyCode == SHIFT && snake.get(0).isalive==false)
    {
      snake.get(0).isalive = true;
      score = 0;
      snake.get(0).d = 60;
      snake.get(0).s = 100;
      move_x = 0;
      move_y = 0;
    }
  }
}
void Food()
{
  
  if(snake.get(0).isalive)
  {
    
    fill(fc1, fc2, fc3);
    rect(apple.getx(), apple.gety(),snake_size,snake_size);
  }
  
  
}


void Gameover()
{
  
  if(!snake.get(0).isalive)
{
    fill(255,0,0);
    textSize(100);
    text("Game Over", 335, 400); 
    fill(255,255,0);
    textSize(60);
    text("Your Score is: "+ score , 340, 480);
    textSize(40);
    text("To restart, press Shift.",340,520);
  }
}
void updateSnake()
{
  // to make sure that the snake will stop when gameover is showed
  if(snake.get(0).isalive)
  {
    //begin of the snake
    for(int i = 0; i <= score ; i++)
    {
      fill(255);
      rect(snake.get(i).d , snake.get(i).s, snake_size,snake_size);
    }
  }
  //update snake size
  for(int i = score; i > 0; i--)
  {
    //connect snake parts together
    snake.get(i).setsnake(snake.get(i-1).d, snake.get(i-1).s); 
  }
  
}

void eatApple()
{
  for(int i = score; i > 0; i--)
  {
    snake.add(new snakeObj());
    snake.get(i).setsnake(snake.get(i-1).d, snake.get(i-1).s);
  }
    

}

void pickLocation()
{
  int row = width /snake_size;
  int column = height/snake_size;
  int pickr = int(random(5,row-6));
  int pickc = int(random(5,column-6));
   fc1 = (int)random(255); fc2 = (int)random(255); fc3 = (int)random(255); //new food color
  apple.setsnake(pickr*snake_size,pickc*snake_size);
  
}

void showScore()
{
  if( (snake.get(0).d == apple.getx() ) && (snake.get(0).s == apple.gety() ) )
  {
    score++;
    eatApple();
    pickLocation(); //new position of food after the snake ate it
    
  }
  fill(255);
  textSize(30);
  text("Score: "+ score , 40, 40); 
}

void snakeMove()
{ 
  
  snake.get(0).d += speed_x ;
  snake.get(0).s += speed_y ;
  
  // if the snake hit the wall
  //1200-60-20(size) =1120    >>>>  800-60-20=720
  if (snake.get(0).d > 1120  || snake.get(0).d < 60 || snake.get(0).s > 720 || snake.get(0).s < 60) 
  {
    speed_x = 0;
    speed_y = 0;
    snake.get(0).isalive = false;
    
  }

 
  for(int i=1; i<score+1; i++)
{
  //if the head of the snake hit the same spot of any of the snake parts
  
  if (snake.get(0).d == snake.get(i).s  && snake.get(0).s == snake.get(i).s)
  {
    speed_x = 0;
    speed_y = 0;
    snake.get(0).isalive = false;
    
  }
  
  
}
  
  
  if(keyPressed)
  {
      
    if ( (keyCode == LEFT) && (move_x != 1) ) 
    {
      speed_x = -20;
      speed_y = 0;
      move_x = -1;
      move_y = 0;
    }
  
    if ( (keyCode == DOWN) && (move_y != -1) )
    {
      speed_y = 20;
      speed_x = 0;
      move_y = 1;
      move_x = 0;
    }
  
    if ( (keyCode == RIGHT) && (move_x != -1) )
    { 
      speed_x = 20; 
      speed_y = 0;
      move_x = 1;
      move_y = 0;
    }
  
    if ( (keyCode == UP) && (move_y != 1) )
    {
      speed_y = -20;
      speed_x = 0;
      move_y = -1;
      move_x = 0;
    }
  }
  
}

void mousePressed() {
  if(modeP == 0){
    //1080/2 + 150, 550 + 50
    //1080/2 + 150, 620 + 50
    if (mouseX >= 1080/2 && mouseX <= 1080/2 + 150){
      if (mouseY >= 550 && mouseY <= 550 + 50){
        modeP = 2;
      }else if (mouseY >= 620 && mouseY <= 620 + 50){
        modeP = 1;
      }
    }
  }
  if(modeP == 1){
    //1080/2 + 150, 550 + 50
    //1080/2 + 150, 620 + 50
    if (mouseX >= 1080/2 && mouseX <= 1080/2 + 150){
      if (mouseY >= 550 && mouseY <= 550 + 50){
        modeP = 2;
      }
       
    }
  }
}


void guidePage() {
  background(22, 206, 6);
  textSize(30);
  text("1. If you rotate on yourself , you lose.", 50, 150);
  text("2. If you hit the wall, you lose.", 50, 200);
  text("3. If you eat food , your score increase by 1.", 50, 250);
  text("4. Presse <- and -> to turn left and right.", 50, 300);
  text("5. Key shift to start a new game after die.", 50, 350);
  // Start button
  fill(29,206,240);
  rect(1080/2,550,150,50); // start button box
  
  fill(0);
  textSize(30);
 
  text("Start Game", 547, 583); // start txt
}
