package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.StandCommand;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.EnslavedGiant;
     import com.brockw.stickwar.engine.units.FlyingCrossbowman;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Medusa;
     import com.brockw.stickwar.engine.units.Monk;
     import com.brockw.stickwar.engine.units.Ninja;
     import com.brockw.stickwar.engine.units.Skelator;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     
     public class CampaignCutScene2 extends CampaignController
     {
          
          private static const S_BEFORE_CUTSCENE:int = -1;
          
          private static const S_ENTER_MEDUSA:int = 0;
          
          private static const S_MEDUSA_YOU_MUST_ALL_DIE:int = 1;
          
          private static const S_SCROLLING_STONE:int = 2;
          
          private static const S_ARRIVED:int = 3;
          
          private static const S_DIE:int = 4;
          
          private static const S_SHOWDOWN:int = 5;
          
          private static const S_WAIT_FOR_END:int = 6;
           
          
          private var state:int;
          
          private var counter:int = 0;
          
          private var message:InGameMessage;
          
          private var scrollingStoneX:Number;
          
          private var gameScreen:GameScreen;
          
          private var medusa:Unit;
          
          private var Zilaros:Magikill;
          
          private var CAP:Spearton;
          
          private var Glidingsor:Wingidon;
          
          private var StatueBomber:Bomber;
          
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
               var _loc5_:Array = null;
               var _loc6_:int = 0;
               var _loc7_:int = 0;
               if(this.message)
               {
                    this.message.update();
               }
               if(this.state == S_BEFORE_CUTSCENE)
               {
                    if(param1.team.enemyTeam.statue.health <= 750 && param1.team.enemyTeam.statue.maxHealth != 4100)
                    {
                         param1.team.enemyTeam.statue.health += 4100;
                         param1.team.enemyTeam.statue.maxHealth = 4100;
                         param1.team.enemyTeam.gold = 0;
                         param1.team.enemyTeam.mana = 200;
                         param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.hud.hud.fastForward.visible = false;
                         param1.isFastForward = false;
                         _loc2_ = Medusa(param1.game.unitFactory.getUnit(Unit.U_MEDUSA));
                         this.medusa = _loc2_;
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         Medusa(_loc2_).enableSuperMedusa();
                         _loc2_.pz = 0;
                         _loc2_.y = param1.game.map.height / 2;
                         _loc2_.px = param1.team.enemyTeam.homeX - 200;
                         _loc2_.x = _loc2_.px;
                         _loc3_ = new StandCommand(param1.game);
                         _loc2_.ai.setCommand(param1.game,_loc3_);
                         this.state = S_ENTER_MEDUSA;
                         this.counter = 0;
                         param1.game.soundManager.playSoundInBackground("lobbyMusic");
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
                         this.state = S_ARRIVED;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         (_loc5_ = []).push(Unit.U_MINER);
                         _loc5_.push(Unit.U_MINER);
                         _loc5_.push(Unit.U_SPEARTON);
                         _loc5_.push(Unit.U_SPEARTON);
                         _loc5_.push(Unit.U_SPEARTON);
                         _loc5_.push(Unit.U_SPEARTON);
                         _loc5_.push(Unit.U_MAGIKILL);
                         _loc5_.push(Unit.U_MONK);
                         _loc5_.push(Unit.U_ENSLAVED_GIANT);
                         param1.team.spawnUnitGroup(_loc5_);
                         this.CAP = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.spawn(this.CAP,param1.game);
                         this.CAP.speartonType = "CAP";
                         this.Zilaros = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.spawn(this.Zilaros,param1.game);
                         this.Zilaros.magikillType = "Zilaros";
                         param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                         param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                         param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                         param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                    }
               }
               else if(this.state == S_ARRIVED)
               {
                    this.message.setMessage("Welcome to Oblivion!","Zilaros, Stella and the Order Empire",0,"speartonHoghSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_DIE;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_DIE)
               {
                    this.message.setMessage("You must all DIEEEEEEEEEE!","Queen Medusa",0,"youMustAllDie");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_SHOWDOWN;
                         this.counter = 0;
                         param1.userInterface.hud.hud.fastForward.visible = true;
                    }
               }
               else if(this.state == S_SHOWDOWN)
               {
                    if(!this.medusa.isAlive())
                    {
                         this.state = S_WAIT_FOR_END;
                         this.counter = 0;
                    }
                    else
                    {
                         param1.game.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 10) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 2,4);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                                   param1.team.enemyTeam.spawn(_loc2_,param1.game);
                                   _loc2_.px = this.medusa.px + 100;
                                   _loc2_.py = param1.game.map.height / (_loc6_ * 2) + _loc7_ / _loc6_ * param1.game.map.height;
                                   _loc2_.ai.setCommand(param1.game,new StandCommand(param1.game));
                                   ++param1.team.enemyTeam.population;
                                   param1.game.projectileManager.initTowerSpawn(this.medusa.px + 100,_loc2_.py,param1.game.team.enemyTeam,0.6);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 2,4);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                                   param1.team.enemyTeam.spawn(_loc2_,param1.game);
                                   _loc2_.px = this.medusa.px - 50;
                                   _loc2_.py = param1.game.map.height / (_loc6_ * 2) + _loc7_ / _loc6_ * param1.game.map.height;
                                   _loc2_.ai.setCommand(param1.game,new StandCommand(param1.game));
                                   ++param1.team.enemyTeam.population;
                                   param1.game.projectileManager.initTowerSpawn(this.medusa.px - 50,_loc2_.py,param1.game.team.enemyTeam,0.6);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 25) == 0)
                         {
                              _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 10) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 10) == 0)
                         {
                              this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                              param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                              this.StatueBomber.bomberType = "StatueBomber";
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              this.Glidingsor = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                              param1.team.enemyTeam.spawn(this.Glidingsor,param1.game);
                              this.Glidingsor.wingidonType = "Glidingsor";
                              this.Glidingsor.px = this.medusa.px + 200;
                              this.Glidingsor.ai.setCommand(param1.game,new StandCommand(param1.game));
                              param1.game.projectileManager.initTowerSpawn(this.medusa.px + 100,this.Glidingsor.py,param1.game.team.enemyTeam,0.6);
                         }
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(_loc2_,param1.game);
                              _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 2,4);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                                   param1.team.spawn(_loc2_,param1.game);
                                   _loc2_.px = this.Zilaros.px - 50;
                                   _loc2_.py = param1.game.map.height / (_loc6_ * 2) + _loc7_ / _loc6_ * param1.game.map.height;
                                   _loc2_.ai.setCommand(param1.game,new StandCommand(param1.game));
                                   param1.game.projectileManager.initTowerSpawn(this.Zilaros.px - 50,_loc2_.py,param1.game.team.enemyTeam,0.6);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              _loc2_ = FlyingCrossbowman(param1.game.unitFactory.getUnit(Unit.U_FLYING_CROSSBOWMAN));
                              param1.team.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc2_ = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(_loc2_,param1.game);
                              _loc2_ = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
                              param1.team.spawn(_loc2_,param1.game);
                              _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 25) == 0)
                         {
                              _loc2_ = EnslavedGiant(param1.game.unitFactory.getUnit(Unit.U_ENSLAVED_GIANT));
                              param1.team.spawn(_loc2_,param1.game);
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
     }
}
