package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.*;
     
     public class CampaignArcher extends CampaignController
     {
           
          
          private var state:int;
          
          private var counter:int = 0;
          
          private var message:InGameMessage;
          
          private var scrollingStoneX:Number;
          
          private var gameScreen:GameScreen;
          
          private var medusa:Unit;
          
          public var ninja:Ninja;
          
          public var cat:Cat;
          
          public var isDone:Boolean = false;
          
          public var magik:Magikill;
          
          private var spawnNumber:int;
          
          public function CampaignArcher(param1:GameScreen)
          {
               super(param1);
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:* = null;
               var _loc3_:* = null;
               var _loc4_:Number = NaN;
               var _loc5_:* = null;
               var _loc6_:int = 0;
               var _loc7_:int = 0;
               trace("Type = " + param1.game.team.type);
               if(param1.game.team.type == 1 && isDone == false)
               {
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    cat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.spawn(_loc2_,param1.game);
                    param1.team.spawn(cat,param1.game);
                    isDone = true;
                    trace("DEADAF");
               }
               var _loc69_:* = null;
          }
     }
}
