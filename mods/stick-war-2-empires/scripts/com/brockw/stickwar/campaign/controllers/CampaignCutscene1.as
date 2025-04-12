package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Ninja;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignCutscene1 extends CampaignController
     {
           
          
          private var state:int;
          
          private var counter:int = 0;
          
          private var message:InGameMessage;
          
          private var scrollingStoneX:Number;
          
          private var gameScreen:GameScreen;
          
          private var medusa:Unit;
          
          public var ninja:Ninja;
          
          public var isDone:Boolean = false;
          
          public var magik:Magikill;
          
          private var spawnNumber:int;
          
          public function CampaignCutscene1(param1:GameScreen)
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
               if(param1.game.team.type == 2 && isDone == false)
               {
                    _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    isDone = true;
                    trace("yeahhhhhhhhhhhh");
               }
               else if(isDone == false)
               {
                    _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    isDone = true;
                    trace("WEISGOOOOOOOD");
               }
               var _loc69_:* = null;
          }
     }
}
