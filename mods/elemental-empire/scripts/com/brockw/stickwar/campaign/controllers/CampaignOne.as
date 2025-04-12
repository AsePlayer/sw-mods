package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.*;
     import com.brockw.stickwar.engine.Ai.*;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.Team.*;
     import com.brockw.stickwar.engine.multiplayer.moves.*;
     import com.brockw.stickwar.engine.units.*;
     import com.brockw.stickwar.engine.units.elementals.*;
     
     public class CampaignOne extends CampaignController
     {
          
          private static const S_BEFORE_CUTSCENE:int = -1;
          
          private static const S_ENTER_MEDUSA:int = 0;
          
          private static const S_MEDUSA_YOU_MUST_ALL_DIE:int = 1;
          
          private static const S_SCROLLING_STONE:int = 2;
          
          private static const S_DONE:int = 3;
          
          private static const S_WAIT_FOR_END:int = 4;
           
          
          private var state:int;
          
          private var counter:int = 0;
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var message3:InGameMessage;
          
          private var message4:InGameMessage;
          
          private var scrollingStoneX:Number;
          
          private var gameScreen:GameScreen;
          
          private var medusa:Unit;
          
          private var spawnNumber:int;
          
          private var frames:int;
          
          private var nah:Boolean = false;
          
          private var help:Boolean = false;
          
          private var bruh:Boolean = false;
          
          private var quack:Boolean = false;
          
          private var v:ChromeElement;
          
          private var aid:EarthElement;
          
          private var q:Skelator;
          
          public function CampaignOne(param1:GameScreen)
          {
               super(param1);
               this.gameScreen = param1;
               this.state = S_BEFORE_CUTSCENE;
               this.counter = 0;
               this.q = null;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc3_:StandCommand = null;
               var _loc4_:Number = NaN;
               var _loc5_:Array = null;
               var _loc6_:int = 0;
               var _loc7_:int = 0;
               var _loc8_:int = 0;
               var _loc9_:* = undefined;
               if(this.message && param1.contains(this.message))
               {
                    this.message.update();
                    if(this.frames++ > 30 * 3)
                    {
                         param1.removeChild(this.message);
                    }
               }
               else if(this.message2 && param1.contains(this.message2))
               {
                    this.message2.update();
                    if(this.frames++ > 30 * 3)
                    {
                         param1.removeChild(this.message2);
                    }
               }
               else if(this.message3 && param1.contains(this.message3))
               {
                    this.message3.update();
                    if(this.frames++ > 30 * 5)
                    {
                         param1.removeChild(this.message3);
                    }
               }
               else if(this.message4 && param1.contains(this.message4))
               {
                    this.message4.update();
                    if(this.frames++ > 30 * 5)
                    {
                         param1.removeChild(this.message4);
                    }
               }
               if(!this.nah)
               {
                    this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                    param1.team.spawn(this.v,param1.game);
                    this.v.vType = "v";
                    param1.game.fogOfWar.isFogOn = false;
                    param1.team.gold = 700;
                    param1.team.mana = 400;
                    this.nah = true;
               }
               if(param1.team.statue.health < param1.team.statue.maxHealth / 2.5)
               {
                    if(!this.help)
                    {
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         this.message.setMessage("We are here to help","Aid",0,"StartMatchmaking");
                         this.frames = 0;
                         param1.team.spawnUnitGroup([Unit.U_WATER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_AIR_ELEMENT,Unit.U_FIRE_ELEMENT,Unit.U_WATER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_AIR_ELEMENT,Unit.U_FIRE_ELEMENT]);
                         this.help = true;
                    }
               }
               if(param1.game.frame % (30 * 8) == 0)
               {
                    _loc8_ = Math.min(this.spawnNumber / 1,1);
                    _loc9_ = 0;
                    while(_loc9_ < _loc8_)
                    {
                         u1 = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(u1,param1.game);
                         _loc9_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 60) == 0)
               {
                    _loc8_ = Math.min(this.spawnNumber / 1,1);
                    _loc9_ = 0;
                    while(_loc9_ < _loc8_)
                    {
                         u1 = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(u1,param1.game);
                         param1.team.enemyTeam.population += 7;
                         _loc9_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 18) == 0)
               {
                    _loc8_ = Math.min(this.spawnNumber / 1,1);
                    _loc9_ = 0;
                    while(_loc9_ < _loc8_)
                    {
                         this.aid = EarthElement(param1.game.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
                         param1.team.spawn(this.aid,param1.game);
                         this.aid.aidType = "aid";
                         _loc9_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 21) == 0)
               {
                    _loc8_ = Math.min(this.spawnNumber / 1,1);
                    _loc9_ = 0;
                    while(_loc9_ < _loc8_)
                    {
                         this.aid = EarthElement(param1.game.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
                         param1.team.spawn(this.aid,param1.game);
                         this.aid.aidType = "aid";
                         _loc9_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 36) == 0)
               {
                    _loc8_ = Math.min(this.spawnNumber / 1,1);
                    _loc9_ = 0;
                    while(_loc9_ < _loc8_)
                    {
                         this.aid = EarthElement(param1.game.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
                         param1.team.spawn(this.aid,param1.game);
                         this.aid.aidType = "aid";
                         _loc9_++;
                    }
                    ++this.spawnNumber;
               }
               if(!this.bruh)
               {
                    this.message2 = new InGameMessage("",param1.game);
                    this.message2.x = param1.game.stage.stageWidth / 2;
                    this.message2.y = param1.game.stage.stageHeight / 4 - 75;
                    this.message2.scaleX *= 1.3;
                    this.message2.scaleY *= 1.3;
                    param1.addChild(this.message2);
                    this.message2.setMessage("Are you guys seriously? Don\'t you guys want to get out of the way for us?","V",0,"StartMatchmaking");
                    this.frames = 0;
                    this.bruh = true;
               }
               if(this.state != S_BEFORE_CUTSCENE)
               {
                    param1.team.enemyTeam.statue.health = 750;
               }
               if(this.state == S_BEFORE_CUTSCENE)
               {
                    if(param1.team.enemyTeam.statue.health < 750)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                         param1.userInterface.isSlowCamera = true;
                         this.q = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         this.q.qType = "q";
                         param1.team.enemyTeam.spawn(this.q,param1.game);
                         this.q.pz = 0;
                         this.q.y = param1.game.map.height / 2;
                         this.q.px = param1.team.enemyTeam.homeX - 200;
                         this.q.x = this.q.px;
                         _loc3_ = new StandCommand(param1.game);
                         this.q.ai.setCommand(param1.game,_loc3_);
                         param1.team.enemyTeam.population += 10;
                         this.state = S_ENTER_MEDUSA;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_ENTER_MEDUSA)
               {
                    _loc3_ = new StandCommand(param1.game);
                    this.q.ai.setCommand(param1.game,_loc3_);
                    param1.game.fogOfWar.isFogOn = false;
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                    if(this.counter++ > 20)
                    {
                         this.state = S_MEDUSA_YOU_MUST_ALL_DIE;
                         this.counter = 0;
                         this.message3 = new InGameMessage("",param1.game);
                         this.message3.x = param1.game.stage.stageWidth / 2;
                         this.message3.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message3.scaleX *= 1.3;
                         this.message3.scaleY *= 1.3;
                         param1.addChild(this.message3);
                         this.message3.setMessage("How dare u make a mess here, stupid Element!","Kai",0,"blindGateSound");
                         this.frames = 0;
                    }
               }
               else if(this.state == S_MEDUSA_YOU_MUST_ALL_DIE)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                    if(this.counter == 75)
                    {
                         Skelator(this.q).reaperAttack(this.v);
                         param1.game.spatialHash.mapInArea(param1.team.enemyTeam.statue.px - 500,0,param1.team.enemyTeam.statue.px + 500,param1.game.map.height,this.pushUnit);
                    }
                    if(this.counter++ > 100)
                    {
                         this.state = S_SCROLLING_STONE;
                         param1.team.enemyTeam.spawnUnitGroup([Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_GIANT,Unit.U_WINGIDON,Unit.U_WINGIDON,Unit.U_KNIGHT,Unit.U_KNIGHT,Unit.U_DEAD,Unit.U_DEAD]);
                    }
               }
               else if(this.state == S_SCROLLING_STONE)
               {
                    if(this.counter++ > 100)
                    {
                         this.state = S_DONE;
                    }
               }
               if(this.state == S_DONE)
               {
                    if(!this.q.isAlive())
                    {
                         this.state = S_WAIT_FOR_END;
                         this.message4 = new InGameMessage("",param1.game);
                         this.message4.x = param1.game.stage.stageWidth / 2;
                         this.message4.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message4.scaleX *= 1.3;
                         this.message4.scaleY *= 1.3;
                         param1.addChild(this.message4);
                         this.message4.setMessage("Damn stupid eleme..ack*","Kai");
                         this.frames = 0;
                         this.counter = 0;
                    }
                    else
                    {
                         param1.game.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 10) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                                   param1.team.enemyTeam.spawn(_loc2_,param1.game);
                                   _loc2_.px = this.q.px + 100;
                                   _loc2_.py = param1.game.map.height / (_loc6_ * 2) + _loc7_ / _loc6_ * param1.game.map.height;
                                   _loc2_.ai.setCommand(param1.game,new StandCommand(param1.game));
                                   param1.team.enemyTeam.population += 3;
                                   param1.game.projectileManager.initTowerSpawn(this.q.px + 100,_loc2_.py,param1.game.team.enemyTeam,0.6);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               else if(this.state == S_WAIT_FOR_END)
               {
                    if(this.counter++ == 30 * 4)
                    {
                         param1.team.enemyTeam.statue.health = 0;
                    }
               }
               super.update(param1);
          }
          
          private function freezeUnit(param1:Unit) : void
          {
               if(param1.team == this.gameScreen.team && !(param1 is Statue))
               {
                    param1.stoneAttack(10000);
               }
          }
          
          private function pushUnit(param1:Unit) : void
          {
               if(param1.team == this.gameScreen.team && !(param1 is Statue))
               {
                    param1.stun(30 * 2);
                    param1.applyVelocity(-200);
               }
          }
     }
}
