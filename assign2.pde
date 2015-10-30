//You should implement your assign2 here.
PImage background1, background2, enemy, fighter, hpImg, treasure, 
       start1, start2, end1, end2;
int backgroundX, background1X, background2X, hpW, 
    fighterX, fighterY, enemyX, treasureX, treasureY, gameState, speed;
final int GAME_START=0, GAME_RUN=1, GAME_OVER=2;
float enemyY;
boolean upPressed, downPressed, leftPressed, rightPressed;

void setup () {
  size(640, 480);
  //loadImage
  background1=  loadImage("img/bg1.png");
  background2=  loadImage("img/bg2.png");
  enemy      =  loadImage("img/enemy.png");
  fighter    =  loadImage("img/fighter.png");
  hpImg      =  loadImage("img/hp.png");
  treasure   =  loadImage("img/treasure.png");
  start1     =  loadImage("img/start1.png");
  start2     =  loadImage("img/start2.png");
  end1       =  loadImage("img/end1.png");
  end2       =  loadImage("img/end2.png");
  //init variables
  backgroundX = 0;
  hpW         = 40;
  fighterX    = 550;
  fighterY    = 240;
  enemyX      = -61;
  enemyY      = floor(random(60,401));
  treasureX   = floor(random(20,501));
  treasureY   = floor(random(60,401));
  gameState   = GAME_START;
  speed       = 5;
  upPressed = downPressed = leftPressed = downPressed = false;
}
void draw() {
  switch (gameState){
      case GAME_START:
         if(mouseY > 375 && mouseY < 420 && mouseX > 200 && mouseX < 450){
           //click
           if(mousePressed){
             gameState = GAME_RUN;
           }
           //hover
           else
             image(start1,0,0);
         }
         else
           image(start2,0,0);
         break;
      case GAME_RUN:
         //bg
         image(background2,background2X,0);
         image(background1,background1X,0);
         background2X = backgroundX + 640;
         background1X = backgroundX ;
         backgroundX += 2;
         background2X = (background2X %= 1280) - 640;
         background1X = (background1X %= 1280) - 640;
         
         //hp volume
         if(hpW <= 0){
           hpW = 0;
           gameState = GAME_OVER;
         }
         if(fighterX-enemyX <= 61 && fighterY-enemyY <= 61 && 
            enemyX-fighterX <= 51 && enemyY-fighterY <= 51){
           enemyX = -61;
           enemyY=floor(random(60,401));
           if(hpW < 40)
             hpW -= hpW;
           else  
             hpW -= 40;
         }
         if(fighterX-treasureX <= 41 && fighterY-treasureY <= 41 && 
            treasureX-fighterX <= 51 && treasureY-fighterY <= 51){
           treasureX = floor(random(20,501));
           treasureY = floor(random(60,401));
           if(hpW >= 200){
             hpW = 200;
           }
           else
             hpW+=20;
         }
         stroke(255,0,0);
         fill(255,0,0);
         rect(20,20,hpW,20);
         
         //hpImg
         image(hpImg,15,15);
         
         //treasure
         image(treasure,treasureX,treasureY);
         
         //fighter
         if(upPressed)
           fighterY -= speed;
         if(downPressed)
           fighterY += speed;
         if(leftPressed)
           fighterX -= speed;
         if(rightPressed)
           fighterX += speed;  
         //Boundary detection
         if(fighterX<0)
           fighterX = 0;
         if(fighterX > 590)
           fighterX = 590;
         if(fighterY < 0)
           fighterY = 0;
         if(fighterY > 430)
           fighterY = 430;
         image(fighter,fighterX,fighterY);
         
         //enemy
         enemyX += 4;
         if(enemyY>fighterY)
            enemyY+=((fighterY-enemyY))/40;
         if(enemyY<fighterY)
            enemyY+=((fighterY-enemyY))/40;
         if(enemyX > 640){
           enemyX = -61;
           enemyY = floor(random(60,401));
         }
         
         image(enemy,enemyX,enemyY);
         break;
      case GAME_OVER:
         if(mouseY >305 && mouseY < 350 && mouseX > 205 && mouseX < 440){
           //click
           if(mousePressed){
             fighterX = 550;
             fighterY = 240;
             treasureX = floor(random(20,501));
             treasureY = floor(random(60,401));
             hpW = 40;
             gameState = GAME_RUN;
           }
           //hover
           else
             image(end1,0,0);
         }
         else
           image(end2,0,0);
         break;
  }
}
void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
