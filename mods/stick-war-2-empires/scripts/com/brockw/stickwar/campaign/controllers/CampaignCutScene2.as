package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.StandCommand;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Medusa;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.elementals.ChromeElement;
     
     public class CampaignCutScene2 extends CampaignController
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
          
          private var scrollingStoneX:Number;
          
          private var gameScreen:GameScreen;
          
          private var medusa:Unit;
          
          private var V:Unit;
          
          private var big:Unit;
          
          private var spawnNumber:int;
          
          public function CampaignCutScene2(param1:GameScreen)
          {
               super(param1);
               this.gameScreen = param1;
               this.state = S_BEFORE_CUTSCENE;
               this.counter = 0;
               this.medusa = null;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc3_:StandCommand = null;
               var _loc4_:Number = NaN;
               var _loc5_:* = null;
               var _loc6_:int = 0;
               var _loc7_:int = 0;
               param1.team.gold = 9000;
               param1.team.mana = 9000;
               if(this.message)
               {
                    this.message.update();
               }
               if(this.state != S_BEFORE_CUTSCENE)
               {
                    param1.team.enemyTeam.statue.health = 750;
                    param1.team.enemyTeam.gold = 0;
                    param1.team.enemyTeam.mana = 200;
                    param1.isFastForward = false;
               }
               if(this.state == S_BEFORE_CUTSCENE)
               {
                    if(param1.team.enemyTeam.statue.health < 750)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                         param1.userInterface.isSlowCamera = true;
                         _loc2_ = Medusa(param1.game.unitFactory.getUnit(Unit.U_MEDUSA));
                         this.medusa = _loc2_;
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         Medusa(_loc2_).enableSuperMedusa();
                         this.V = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                         param1.team.enemyTeam.spawn(this.V,param1.game);
                         this.big = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(this.big,param1.game);
                         V.health = V.maxHealth = this.medusa.health;
                         V.scale = this.medusa.scale;
                         V.isStoneable = false;
                         V.damageToArmour = this.medusa.damageToArmour * 1.5;
                         V.damageToNotArmour = this.medusa.damageToNotArmour * 1.5;
                         V.healthBar.totalHealth = V.maxHealth;
                         big.health = big.maxHealth = this.medusa.health;
                         big.scale = this.medusa.scale;
                         big.damageToArmour = this.medusa.damageToArmour;
                         big.damageToNotArmour = this.medusa.damageToNotArmour;
                         big.healthBar.totalHealth = big.maxHealth;
                         big.isStoneable = false;
                         _loc2_.pz = 0;
                         _loc2_.y = param1.game.map.height / 2;
                         _loc2_.px = param1.team.enemyTeam.homeX - 200;
                         _loc2_.x = _loc2_.px;
                         _loc3_ = new StandCommand(param1.game);
                         _loc2_.ai.setCommand(param1.game,_loc3_);
                         this.state = S_ENTER_MEDUSA;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_ENTER_MEDUSA)
               {
                    _loc3_ = new StandCommand(param1.game);
                    this.medusa.ai.setCommand(param1.game,_loc3_);
                    param1.game.fogOfWar.isFogOn = false;
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                    if(this.counter++ > 20)
                    {
                         this.state = S_MEDUSA_YOU_MUST_ALL_DIE;
                         this.counter = 0;
                         param1.game.soundManager.playSoundFullVolume("youMustAllDie");
                    }
               }
               else if(this.state == S_MEDUSA_YOU_MUST_ALL_DIE)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                    if(this.counter == 75)
                    {
                         Medusa(this.medusa).stone(null);
                    }
                    if(this.counter++ > 100)
                    {
                         this.state = S_SCROLLING_STONE;
                         this.scrollingStoneX = param1.game.team.enemyTeam.statue.x - 325;
                    }
               }
               else if(this.state == S_SCROLLING_STONE)
               {
                    param1.game.targetScreenX = this.scrollingStoneX;
                    param1.game.screenX = this.scrollingStoneX;
                    if(param1.game.targetScreenX < param1.game.team.statue.px - 300)
                    {
                         param1.game.targetScreenX = param1.game.team.statue.px - 300;
                    }
                    this.scrollingStoneX -= 20;
                    _loc4_ = this.scrollingStoneX + param1.game.map.screenWidth / 2;
                    param1.game.spatialHash.mapInArea(_loc4_ - 100,0,_loc4_ + 100,param1.game.map.height,this.freezeUnit);
                    if(_loc4_ < param1.team.homeX)
                    {
                         this.state = S_DONE;
                         (_loc5_ = []).push(Unit.U_MINER);
                         _loc5_.push(Unit.U_MINER);
                         _loc5_.push(Unit.U_SPEARTON);
                         _loc5_.push(Unit.U_SPEARTON);
                         _loc5_.push(Unit.U_SPEARTON);
                         _loc5_.push(Unit.U_SPEARTON);
                         _loc5_.push(Unit.U_MAGIKILL);
                         _loc5_.push(Unit.U_MONK);
                         _loc5_.push(Unit.U_ENSLAVED_GIANT);
                         _loc5_.push(Unit.U_MINER);
                         if(param1.game.team.type != 2)
                         {
                              _loc5_.push(Unit.U_SPEARTON);
                              _loc5_.push(Unit.U_SPEARTON);
                              _loc5_.push(Unit.U_SPEARTON);
                              _loc5_.push(Unit.U_SPEARTON);
                              _loc5_.push(Unit.U_MAGIKILL);
                              _loc5_.push(Unit.U_MONK);
                              _loc5_.push(Unit.U_ENSLAVED_GIANT);
                         }
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
                         param1.team.spawnUnitGroup(_loc5_);
                         param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                         param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                         param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                         param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                    }
               }
               if(this.state == S_DONE)
               {
                    if(!this.medusa.isAlive() && !this.V.isAlive() && !this.big.isAlive())
                    {
                         this.state = S_WAIT_FOR_END;
                         this.counter = 0;
                    }
                    else
                    {
                         param1.game.team.enemyTeam.attack(true);
                    }
               }
               else if(this.state == S_WAIT_FOR_END)
               {
                    if(this.counter++ == 120)
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
     }
}
