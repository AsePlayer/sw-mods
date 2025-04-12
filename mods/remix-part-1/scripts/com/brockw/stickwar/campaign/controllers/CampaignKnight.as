package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.StandCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Monk;
     import com.brockw.stickwar.engine.units.Ninja;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignKnight extends CampaignController
     {
          
          private static const S_HERE_HE_COMES:int = -1;
          
          private static const S_SPEECH:int = 2;
          
          private static const S_ZILAROS_GO:int = 3;
          
          private static const S_OBJECTIVE:int = 4;
          
          private static const S_PHASE_1:int = 5;
          
          private static const S_DEMONSTRATION:int = 6;
          
          private static const S_PHASE_2:int = 7;
          
          private static const S_CAUSE_OF_EFFECT:int = 8;
          
          private static const S_PHASE_3:int = 9;
          
          private static const S_HOPES:int = 10;
          
          private static const S_END:int = 11;
           
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var TheMagikill:Magikill;
          
          private var TheMagikill2:Magikill;
          
          private var TheMagikill3:Magikill;
          
          private var Zilaros:Magikill;
          
          private var HankShadowrath:Ninja;
          
          private var EnchantedRebelArcher:Archer;
          
          private var EnchantedRebelSpearton:Spearton;
          
          private var frames:int;
          
          private var spawnNumber:int;
          
          private var state:int;
          
          private var counter:int = 0;
          
          public function CampaignKnight(param1:GameScreen)
          {
               super(param1);
               this.state = S_HERE_HE_COMES;
               this.counter = 0;
               this.TheMagikill = null;
               this.TheMagikill2 = null;
               this.TheMagikill3 = null;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var shadow:Ninja = null;
               var sword:Swordwrath = null;
               var enemyStatue:Statue = null;
               var _loc4_:int = 0;
               var _loc6_:int = 0;
               var _loc7_:int = 0;
               var _loc8_:StickWar = null;
               param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
               if(this.message)
               {
                    this.message.update();
               }
               if(this.state == S_HERE_HE_COMES)
               {
                    if(param1.team.enemyTeam.statue.health <= 200 && param1.team.enemyTeam.statue.maxHealth != 2600)
                    {
                         param1.team.enemyTeam.statue.health += 2600;
                         param1.team.enemyTeam.statue.maxHealth = 2600;
                         param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                         param1.team.enemyTeam.gold += 5000;
                         param1.team.enemyTeam.mana += 5000;
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                         this.TheMagikill = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(this.TheMagikill,param1.game);
                         this.TheMagikill.magikillType = "TheMagikill";
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         this.state = S_SPEECH;
                         this.counter = 0;
                         param1.game.soundManager.playSoundInBackground("lobbyMusic");
                    }
               }
               else if(this.state == S_SPEECH)
               {
                    this.message.setMessage("Today. We summon. UNITY!","The Magikill",0,"smallDragonRoarSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_ZILAROS_GO;
                         this.counter = 0;
                         param1.game.targetScreenX = param1.game.team.statue.x - 325;
                         param1.game.screenX = param1.game.team.statue.x - 325;
                         this.Zilaros = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.spawn(this.Zilaros,param1.game);
                         this.Zilaros.magikillType = "Zilaros";
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_ZILAROS_GO)
               {
                    param1.game.targetScreenX = param1.game.team.statue.x - 325;
                    param1.game.screenX = param1.game.team.statue.x - 325;
                    this.message.setMessage("Do not fear. I have arrived to aid our cause.","Zilaros",0,"voiceTutorial20");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_OBJECTIVE;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_OBJECTIVE)
               {
                    this.message.setMessage("Defeat The Magikill to force the Rebels to retreat!","",0,"Rage1");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_PHASE_1;
                         this.counter = 0;
                         _loc8_ = param1.game;
                         _loc8_.team.tech.isResearchedMap[Tech.MAGIKILL_POISON] = 1;
                         _loc8_.team.tech.isResearchedMap[Tech.MAGIKILL_WALL] = 1;
                    }
               }
               else if(this.state == S_PHASE_1)
               {
                    if(!this.TheMagikill.isAlive())
                    {
                         this.state = S_DEMONSTRATION;
                         this.counter = 0;
                         for each(_loc2_ in param1.team.enemyTeam.units)
                         {
                              _loc2_.health = -1;
                              _loc2_.setFire(30 * 35,900);
                         }
                         this.TheMagikill2 = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(this.TheMagikill2,param1.game);
                         this.TheMagikill2.magikillType = "TheMagikill2";
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
                    else
                    {
                         param1.game.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 30) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,2,3);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                                   param1.team.enemyTeam.spawn(_loc2_,param1.game);
                                   _loc2_.px = this.TheMagikill.px - 100;
                                   _loc2_.py = param1.game.map.height / (_loc6_ * 2) + _loc7_ / _loc6_ * param1.game.map.height;
                                   _loc2_.ai.setCommand(param1.game,new StandCommand(param1.game));
                                   param1.game.projectileManager.initTowerSpawn(this.TheMagikill.px - 100,_loc2_.py,param1.game.team.enemyTeam,0.6);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                         if(param1.game.frame % (30 * 10) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,2,3);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                                   param1.team.enemyTeam.spawn(_loc2_,param1.game);
                                   _loc2_.px = this.TheMagikill.px - 50;
                                   _loc2_.py = param1.game.map.height / (_loc6_ * 2) + _loc7_ / _loc6_ * param1.game.map.height;
                                   _loc2_.ai.setCommand(param1.game,new StandCommand(param1.game));
                                   param1.game.projectileManager.initTowerSpawn(this.TheMagikill.px - 50,_loc2_.py,param1.game.team.enemyTeam,0.6);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,2,3);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                                   param1.team.enemyTeam.spawn(_loc2_,param1.game);
                                   _loc2_.px = this.TheMagikill.px + 200;
                                   _loc2_.py = param1.game.map.height / (_loc6_ * 2) + _loc7_ / _loc6_ * param1.game.map.height;
                                   _loc2_.ai.setCommand(param1.game,new StandCommand(param1.game));
                                   param1.game.projectileManager.initTowerSpawn(this.TheMagikill.px + 200,_loc2_.py,param1.game.team.enemyTeam,0.6);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                    }
               }
               else if(this.state == S_DEMONSTRATION)
               {
                    this.message.setMessage("For my next trick. I will gladly demonstrate the art of elemential.","",0,"wizardVoiceOver1");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_PHASE_2;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_PHASE_2)
               {
                    if(!this.TheMagikill2.isAlive())
                    {
                         this.state = S_CAUSE_OF_EFFECT;
                         this.counter = 0;
                         for each(_loc2_ in param1.team.enemyTeam.units)
                         {
                              _loc2_.health = -1;
                              _loc2_.setFire(30 * 35,900);
                         }
                         this.TheMagikill3 = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(this.TheMagikill3,param1.game);
                         this.TheMagikill3.magikillType = "TheMagikill3";
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
                    else
                    {
                         param1.game.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 30) == 0)
                         {
                              _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              this.EnchantedRebelArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(this.EnchantedRebelArcher,param1.game);
                              this.EnchantedRebelArcher.archerType = "EnchantedRebelArcher";
                         }
                    }
               }
               else if(this.state == S_CAUSE_OF_EFFECT)
               {
                    this.message.setMessage("Your nation has brought nothing but Chaos to our people. Time to send this battle to oblivion once and for all.","",0,"wizardVoiceOver1");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_PHASE_3;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_PHASE_3)
               {
                    if(!this.TheMagikill3.isAlive())
                    {
                         this.state == S_HOPES;
                         this.counter = 0;
                         for each(_loc2_ in param1.team.enemyTeam.units)
                         {
                              _loc2_.health = -1;
                              _loc2_.setFire(30 * 35,900);
                         }
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
                    else
                    {
                         param1.game.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 30) == 0)
                         {
                              this.HankShadowrath = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.enemyTeam.spawn(this.HankShadowrath,param1.game);
                              this.HankShadowrath.ninjaType = "HankShadowrath";
                         }
                         if(param1.game.frame % (30 * 20) == 0)
                         {
                              this.EnchantedRebelSpearton = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.EnchantedRebelSpearton,param1.game);
                              this.EnchantedRebelSpearton.speartonType = "EnchantedRebelSpearton";
                         }
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,2,3);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
                                   param1.team.enemyTeam.spawn(_loc2_,param1.game);
                                   _loc2_.px = this.TheMagikill3.px + 100;
                                   _loc2_.py = param1.game.map.height / (_loc6_ * 2) + _loc7_ / _loc6_ * param1.game.map.height;
                                   _loc2_.ai.setCommand(param1.game,new StandCommand(param1.game));
                                   param1.game.projectileManager.initTowerSpawn(this.TheMagikill3.px + 100,_loc2_.py,param1.game.team.enemyTeam,0.6);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               else if(this.state == S_HOPES)
               {
                    this.message.setMessage("Has this madness finally ended........?","Zilaros",0,"voiceTutorial20");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_END;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_END)
               {
                    param1.team.enemyTeam.statue.health = 0;
               }
          }
     }
}
