package com.brockw.stickwar.engine.Ai.command
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.Bitmap;
     import flash.display.Sprite;
     
     public class FreezingCommand extends UnitCommand
     {
          
          public static const actualButtonBitmap:Bitmap = new Bitmap(new poisonSprayBitmap());
           
          
          private var poisonRange:Number;
          
          private var poisonArea:Number;
          
          public function FreezingCommand(param1:StickWar)
          {
               super();
               this.game = param1;
               type = UnitCommand.FREEZING;
               hotKey = 65;
               _hasCoolDown = true;
               _intendedEntityType = Unit.U_MAGIKILL;
               requiresMouseInput = true;
               isSingleSpell = true;
               this.buttonBitmap = actualButtonBitmap;
               cursor = new nukeCursor();
               if(param1 != null)
               {
                    this.loadXML(param1.xml.xml.Order.Units.magikill.freezing);
                    this.poisonRange = param1.xml.xml.Order.Units.magikill.freezing.range;
                    this.poisonArea = param1.xml.xml.Order.Units.magikill.freezing.area;
               }
          }
          
          override public function cleanUpPreClick(param1:Sprite) : void
          {
               super.cleanUpPreClick(param1);
               if(param1.contains(cursor))
               {
                    param1.removeChild(cursor);
               }
          }
          
          override public function drawCursorPreClick(param1:Sprite, param2:GameScreen) : Boolean
          {
               while(param1.numChildren != 0)
               {
                    param1.removeChildAt(0);
               }
               param1.addChild(cursor);
               cursor.x = param2.game.battlefield.mouseX;
               cursor.y = param2.game.battlefield.mouseY;
               cursor.width = Number(this.poisonRange) / 2;
               cursor.height = Number(this.poisonArea) * param2.game.getPerspectiveScale(param2.game.battlefield.mouseY);
               if(cursor.y + cursor.height < 0)
               {
                    cursor.alpha = 1 - Math.abs(cursor.y) / 200;
               }
               else
               {
                    cursor.alpha = 1;
               }
               cursor.gotoAndStop(1);
               this.drawRangeIndicators(param1,this.poisonRange,true,param2);
               return true;
          }
          
          override public function drawCursorPostClick(param1:Sprite, param2:GameScreen) : Boolean
          {
               super.drawCursorPostClick(param1,param2);
               return true;
          }
          
          override public function coolDownTime(param1:Entity) : Number
          {
               return Magikill(param1).freezingCooldown();
          }
          
          override public function isFinished(param1:Unit) : Boolean
          {
               return Magikill(param1).freezingCooldown() != 0;
          }
          
          override public function inRange(param1:Entity) : Boolean
          {
               return Math.pow(Number(realX) - param1.px,2) + Math.pow(Number(realY) - param1.py,2) < Math.pow(this.poisonRange,2);
          }
     }
}
