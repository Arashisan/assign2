//You should implement your assign2 here.
PImage bg1, bg2, enemy, fighter, hp, treasure, start1, start2, end1, end2;
int BGx, BG1x, BG2x, HPw, FIx, FIy, ENx, TRx, TRy, gameState, speed;
final int GAME_START=0, GAME_RUN=1, GAME_OVER=2;
float ENy, ENySpeed;
boolean upPressed, downPressed, leftPressed, rightPressed;

void setup () {
  size(640, 480);
  //loadImage
  bg1      =  loadImage("img/bg1.png");
  bg2      =  loadImage("img/bg2.png");
  enemy    =  loadImage("img/enemy.png");
  fighter  =  loadImage("img/fighter.png");
  hp       =  loadImage("img/hp.png");
  treasure =  loadImage("img/treasure.png");
  start1   =  loadImage("img/start1.png");
  start2   =  loadImage("img/start2.png");
  end1     =  loadImage("img/end1.png");
  end2     =  loadImage("img/end2.png");
  //init variables
  BGx = 0;
  HPw = 40;
  FIx = 550;
  FIy = 240;
  ENx = -61;
  ENy = floor(random(60,401));
  TRx = floor(random(20,501));
  TRy = floor(random(60,401));
  ENx = -61;
  gameState = GAME_START;
  speed     = 5;
  ENySpeed  = 0;
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
         image(bg2,BG2x,0);
         image(bg1,BG1x,0);
         BG2x = BGx + 640;
         BG1x = BGx ;
         BGx += 2;
         BG2x = (BG2x %= 1280) - 640;
         BG1x = (BG1x %= 1280) - 640;
         //hp volume
         if(HPw <= 0){
           HPw = 0;
           gameState = GAME_OVER;
         }
         if(FIx-ENx <= 61 && FIy-ENy <= 61 && ENx-FIx <= 51 && ENy-FIy <= 51){
           ENx = -61;
           ENySpeed = 0;
           ENy=floor(random(60,401));
           if(HPw < 40)
             HPw -= HPw;
           else  
             HPw -= 40;
         }
         if(FIx-TRx <= 41 && FIy-TRy <= 41 && TRx-FIx <= 51 && TRy-FIy <= 51){
           TRx = floor(random(20,501));
           TRy = floor(random(60,401));
           if(HPw >= 200){
             HPw = 200;
           }
           else
             HPw+=20;
         }
         stroke(255,0,0);
         fill(255,0,0);
         rect(20,20,HPw,20);
         //hp
         image(hp,15,15);
         //treasure
         image(treasure,TRx,TRy);
         //fighter
         if(upPressed)
           FIy -= speed;
         if(downPressed)
           FIy += speed;
         if(leftPressed)
           FIx -= speed;
         if(rightPressed)
           FIx += speed;  
         if(FIx<0)
           FIx = 0;
         if(FIx>590)
           FIx = 590;
         if(FIy<0)
           FIy = 0;
         if(FIy>430)
           FIy = 430;
         image(fighter,FIx,FIy);
         //enemy
         ENx += 4;
         if(ENy < -51 || ENy > 531)
           ENySpeed +=0;
         else{
           if(ENy < (FIy))
             ENySpeed += 0.2;
           if(ENy > (FIy))
             ENySpeed -= 0.2;
         }
         if(ENx > 640){
           ENx = -61;
           ENySpeed = 0;
           ENy = floor(random(60,401));
         }
         ENy = ENy + ENySpeed;
         image(enemy,ENx,ENy);
         break;
      case GAME_OVER:
         if(mouseY >305 && mouseY < 350 && mouseX > 205 && mouseX < 440){
           //click
           if(mousePressed){
             FIx = 550;
             FIy = 240;
             TRx = floor(random(20,501));
             TRy = floor(random(60,401));
             HPw = 40;
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
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
