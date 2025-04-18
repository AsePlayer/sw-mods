package com.brockw.stickwar.engine
{
     import flash.display.MovieClip;
     
     public class RainDrop extends Entity
     {
          
          public static const RAIN_FALL_HEIGHT:Number = 600;
          
          public static const RAIN_FALL_VELOCITY:Number = 7.5;
           
          
          private var rainDrop:MovieClip;
          
          public function RainDrop(game:StickWar)
          {
               super();
               this.rainDrop = new _rainDrop();
               addChild(this.rainDrop);
               this.rainDrop.scaleX *= 0.2;
               this.rainDrop.scaleY *= -0.2;
               this.rainDrop.rotation = 5;
               this.alpha = 0.5;
               this.init(game,game.random.nextNumber() * 4);
          }
          
          public function init(game:StickWar, t:Number) : void
          {
               px = game.screenX + game.map.screenWidth * game.random.nextNumber();
               py = game.map.height * game.random.nextNumber();
               pz = 0 - t * 600;
               scaleX = game.getPerspectiveScale(py);
               scaleY = game.getPerspectiveScale(py);
               this.rainDrop.gotoAndStop(1);
          }
          
          public function update(game:StickWar) : void
          {
               if(!game.gameScreen._hasRain)
               {
                    this.alpha = 0;
               }
               else
               {
                    this.alpha = 1;
               }
               if(pz >= 250)
               {
                    pz = 250;
                    this.rainDrop.nextFrame();
                    if(this.rainDrop.currentFrame == this.rainDrop.totalFrames)
                    {
                         this.init(game,1);
                    }
               }
               else
               {
                    pz += RAIN_FALL_VELOCITY;
                    px -= 2;
                    x = px;
                    y = game.map.y + py + pz;
               }
          }
     }
}
