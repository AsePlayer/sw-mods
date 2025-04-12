package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignKnight extends CampaignController
     {
           
          
          private var state:int;
          
          private var counter:int = 0;
          
          private var message:InGameMessage;
          
          private var scrollingStoneX:Number;
          
          private var gameScreen:GameScreen;
          
          private var medusa:Unit;
          
          private var V:Unit;
          
          private var big:Unit;
          
          private var isDone:Boolean = false;
          
          private var spawnNumber:int;
          
          public function CampaignKnight(param1:GameScreen)
          {
               super(param1);
               this.gameScreen = param1;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:* = null;
               var _loc3_:* = null;
               var _loc4_:Number = NaN;
               var _loc5_:* = null;
               var _loc6_:int = 0;
               var _loc7_:int = 0;
               var _loc69_:* = null;
               if(param1.game.team.type == 0)
               {
                    (_loc5_ = []).push(Unit.U_MONK);
                    if(isDone == false)
                    {
                         param1.team.spawnUnitGroup(_loc5_);
                         isDone = true;
                    }
               }
               if(param1.game.team.type == 1)
               {
                    (_loc5_ = []).push(Unit.U_CHAOS_MINER);
                    _loc5_.push(Unit.U_DEAD);
                    _loc5_.push(Unit.U_CAT);
                    _loc5_.push(Unit.U_BOMBER);
                    if(isDone == false)
                    {
                         param1.team.spawnUnitGroup(_loc5_);
                         isDone = true;
                    }
               }
               if(param1.game.team.type == 2)
               {
                    (_loc5_ = []).push(Unit.U_HURRICANE_ELEMENT);
                    if(isDone == false)
                    {
                         param1.team.spawnUnitGroup(_loc5_);
                         isDone = true;
                    }
               }
          }
     }
}
