package com.brockw.stickwar.engine
{
     import flash.display.MovieClip;
     
     public class SnowDrop extends Entity
     {
          
          public static const RAIN_FALL_HEIGHT:Number = 600;
          
          public static const RAIN_FALL_VELOCITY:Number = 5;
           
          
          private var rainDrop:MovieClip;
          
          public function SnowDrop(param1:StickWar)
          {
               super();
               this.rainDrop = new _snowDrop();
               addChild(this.rainDrop);
               this.rainDrop.scaleX *= 0.35;
               this.rainDrop.scaleY *= -0.35;
               this.rainDrop.rotation = 1;
               this.alpha = 1;
               this.init(param1,param1.random.nextNumber() * 4);
          }
          
          public function init(param1:StickWar, param2:Number) : void
          {
               px = param1.screenX + param1.map.screenWidth * 5 * param1.random.nextNumber();
               py = param1.map.height * param1.random.nextNumber();
               pz = 0 - param2 * 600;
               scaleX = param1.getPerspectiveScale(py);
               scaleY = param1.getPerspectiveScale(py);
               this.rainDrop.gotoAndStop(1);
          }
          
          public function update(param1:StickWar) : void
          {
               if(pz >= 250)
               {
                    pz = 250;
                    this.rainDrop.nextFrame();
                    if(this.rainDrop.currentFrame == this.rainDrop.totalFrames)
                    {
                         this.init(param1,1);
                    }
               }
               else
               {
                    pz += RAIN_FALL_VELOCITY;
                    px -= 2;
                    x = px;
                    y = param1.map.y + py + pz;
               }
          }
     }
}
