package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignTutorial extends CampaignController
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
          
          public function CampaignTutorial(param1:GameScreen)
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
               (_loc5_ = []).push(Unit.U_MINER);
               _loc5_.push(Unit.U_SWORDWRATH);
               var _loc69_:* = null;
               for(_loc69_ in _loc5_)
               {
                    if(param1.game.team.type == 2)
                    {
                         if(_loc5_[_loc69_] == Unit.U_MONK)
                         {
                              _loc5_[_loc69_] = Unit.U_HURRICANE_ELEMENT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_ARCHER)
                         {
                              _loc5_[_loc69_] = Unit.U_FIRE_ELEMENT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_FLYING_CROSSBOWMAN)
                         {
                              _loc5_[_loc69_] = Unit.U_AIR_ELEMENT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_NINJA)
                         {
                              _loc5_[_loc69_] = Unit.U_WATER_ELEMENT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_SWORDWRATH)
                         {
                              _loc5_[_loc69_] = Unit.U_EARTH_ELEMENT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_SPEARTON)
                         {
                              _loc5_[_loc69_] = Unit.U_LAVA_ELEMENT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_ENSLAVED_GIANT)
                         {
                              _loc5_[_loc69_] = Unit.U_TREE_ELEMENT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_MINER)
                         {
                              _loc5_[_loc69_] = Unit.U_MINER_ELEMENT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_MAGIKILL)
                         {
                              _loc5_[_loc69_] = Unit.U_FIRESTORM_ELEMENT;
                         }
                    }
                    if(param1.game.team.type == 1)
                    {
                         if(_loc5_[_loc69_] == Unit.U_MONK)
                         {
                              _loc5_[_loc69_] = Unit.U_MEDUSA;
                         }
                         if(_loc5_[_loc69_] == Unit.U_ARCHER)
                         {
                              _loc5_[_loc69_] = Unit.U_DEAD;
                         }
                         if(_loc5_[_loc69_] == Unit.U_FLYING_CROSSBOWMAN)
                         {
                              _loc5_[_loc69_] = Unit.U_WINGIDON;
                         }
                         if(_loc5_[_loc69_] == Unit.U_NINJA)
                         {
                              _loc5_[_loc69_] = Unit.U_BOMBER;
                         }
                         if(_loc5_[_loc69_] == Unit.U_SWORDWRATH)
                         {
                              _loc5_[_loc69_] = Unit.U_CAT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_SPEARTON)
                         {
                              _loc5_[_loc69_] = Unit.U_KNIGHT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_ENSLAVED_GIANT)
                         {
                              _loc5_[_loc69_] = Unit.U_GIANT;
                         }
                         if(_loc5_[_loc69_] == Unit.U_MINER)
                         {
                              _loc5_[_loc69_] = Unit.U_CHAOS_MINER;
                         }
                         if(_loc5_[_loc69_] == Unit.U_MAGIKILL)
                         {
                              _loc5_[_loc69_] = Unit.U_SKELATOR;
                         }
                    }
               }
               if(isDone == false)
               {
                    param1.team.spawnUnitGroup(_loc5_);
                    isDone = true;
               }
          }
     }
}
