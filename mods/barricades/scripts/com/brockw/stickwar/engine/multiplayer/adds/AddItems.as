package com.brockw.stickwar.engine.multiplayer.adds
{
     import com.brockw.game.*;
     import com.brockw.stickwar.engine.units.*;
     import flash.events.*;
     import flash.utils.*;
     
     public class AddItems extends Add
     {
           
          
          internal var mc:addPopUpShowItems;
          
          private var startAddTime:int;
          
          public function AddItems(param1:*)
          {
               super(param1);
               this.mc = new addPopUpShowItems();
               addChild(this.mc);
               addShowTime = 30;
          }
          
          override public function update() : void
          {
               var _loc1_:int = 0;
               super.update();
               Util.animateToNeutral(this.mc.mc);
               if(this.mc.mc.spearton2)
               {
                    Spearton.setItem(this.mc.mc.spearton2,"Native Spaer","Native Spearton","Native Shield");
               }
               if(this.mc.mc.spearton1)
               {
                    Spearton.setItem(this.mc.mc.spearton1,"British Spear","Gladiator Helmet","Roman Shield");
               }
               if(this.mc.mc.spearton3)
               {
                    Spearton.setItem(this.mc.mc.spearton3,"Dark Samurai Spear","Samurai Mask","Dark Wood Shield");
               }
               if(stage)
               {
                    this.mc.signUp.mouseEnabled = true;
                    this.mc.exit.mouseEnabled = true;
                    this.mc.signUp.buttonMode = true;
                    this.mc.exit.buttonMode = true;
                    this.mc.signUp.mouseChildren = false;
                    this.mc.exit.mouseChildren = false;
                    _loc1_ = int(addShowTime - (getTimer() - this.startAddTime) / 1000);
                    this.mc.signUp.gotoAndStop(1);
                    if(this.mc.signUp.hitTestPoint(stage.mouseX,stage.mouseY))
                    {
                         this.mc.signUp.gotoAndStop(2);
                    }
                    if(_loc1_ <= 0)
                    {
                         this.mc.exit.gotoAndStop(1);
                         if(this.mc.exit.hitTestPoint(stage.mouseX,stage.mouseY))
                         {
                              this.mc.exit.gotoAndStop(2);
                         }
                         this.mc.exit.text.text = "NOT NOW";
                         this.mc.exit.alpha = 1;
                    }
                    else
                    {
                         this.mc.exit.gotoAndStop(1);
                         this.mc.exit.alpha = 0.5;
                         this.mc.exit.text.text = "NOT NOW .. " + int(addShowTime - (getTimer() - this.startAddTime) / 1000);
                         this.mc.exit.mouseEnabled = false;
                         this.mc.exit.buttonMode = false;
                    }
               }
          }
          
          override public function enter() : void
          {
               Util.animateToNeutral(this.mc.mc);
               if(this.mc.mc.spearton2)
               {
                    Spearton.setItem(this.mc.mc.spearton2,"Native Spaer","Native Spearton","Native Shield");
               }
               if(this.mc.mc.spearton1)
               {
                    Spearton.setItem(this.mc.mc.spearton1,"British Spear","Gladiator Helmet","Roman Shield");
               }
               if(this.mc.mc.spearton3)
               {
                    Spearton.setItem(this.mc.mc.spearton3,"Dark Samurai Spear","Samurai Mask","Dark Wood Shield");
               }
               this.startAddTime = getTimer();
               this.mc.signUp.addEventListener(MouseEvent.CLICK,manager.signUp);
               this.mc.exit.addEventListener(MouseEvent.CLICK,manager.exit);
               this.mc.exit.alpha = 0.5;
               this.mc.exit.gotoAndStop(1);
               this.mc.signUp.gotoAndStop(1);
          }
          
          override public function leave() : void
          {
               this.mc.signUp.removeEventListener(MouseEvent.CLICK,manager.signUp);
               this.mc.exit.removeEventListener(MouseEvent.CLICK,manager.exit);
          }
     }
}
