package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.*;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.units.*;
     import com.brockw.stickwar.engine.units.elementals.ChromeElement;
     
     public class CampaignMarrowkai extends CampaignController
     {
           
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var message3:InGameMessage;
          
          private var frames:int;
          
          private var currentLevelTitle:String;
          
          private var nah:Boolean = false;
          
          private var bruh:Boolean = false;
          
          private var quack:Boolean = false;
          
          private var help:Boolean = false;
          
          private var op:Boolean = false;
          
          private var rebelsTime1:Boolean = false;
          
          private var rebelsTime2:Boolean = false;
          
          private var rebelsTime3:Boolean = false;
          
          private var v:ChromeElement;
          
          private var bomber:Bomber;
          
          private var m:Magikill;
          
          private var w:Magikill;
          
          private var q:Skelator;
          
          private var s:Swordwrath;
          
          private var rebels:Swordwrath;
          
          private var f:Archer;
          
          private var spawnNumber:int;
          
          private var miniMessage:InGameMessage;
          
          public function CampaignMarrowkai(param1:GameScreen)
          {
               super(param1);
               this.currentLevelTitle = param1.main.campaign.getCurrentLevel().title;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var u1:Unit = null;
               var _loc2_:Unit = null;
               var _loc3_:int = 0;
               var _loc4_:* = undefined;
               var _loc5_:int = 0;
               var _loc6_:* = undefined;
               var _loc12_:Wall = null;
               var _loc13_:Wall = null;
               var min:int = 45;
               var max:int = 90;
               var coopmin:int = 55;
               var coopmax:int = 85;
               var randomNumber1:int = min + Math.floor(Math.random() * (max - min + 1));
               var randomNumber2:int = min + Math.floor(Math.random() * (max - min + 1));
               var randomNumber3:int = min + Math.floor(Math.random() * (max - min + 1));
               var randomNumber4:int = coopmin + Math.floor(Math.random() * (coopmax - coopmin + 1));
               var randomNumber5:int = coopmin + Math.floor(Math.random() * (coopmax - coopmin + 1));
               var randomNumber6:int = coopmin + Math.floor(Math.random() * (coopmax - coopmin + 1));
               trace(randomNumber1);
               trace(randomNumber2);
               trace(randomNumber3);
               trace(randomNumber4);
               trace(randomNumber5);
               trace(randomNumber6);
               if(!this.nah)
               {
                    this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                    param1.team.spawn(this.v,param1.game);
                    this.v.vType = "v";
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
               if(this.currentLevelTitle == "Remnants of Chaos: Eclipsors and Bomber attack")
               {
                    _loc3_ = 0;
                    _loc4_ = undefined;
                    if(param1.game.frame % (30 * 15) == 0)
                    {
                         _loc3_ = Math.min(this.spawnNumber / 1,1);
                         _loc4_ = 0;
                         while(_loc4_ < _loc3_)
                         {
                              u1 = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1.ai.alwaysAttack = true;
                              _loc4_++;
                         }
                         ++this.spawnNumber;
                    }
                    if(!this.bruh)
                    {
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         this.message.setMessage("You guys quickly get out of the way.","V",0,"StartMatchmaking");
                         this.frames = 0;
                         this.bruh = true;
                    }
                    if(param1.team.enemyTeam.statue.health < param1.team.enemyTeam.statue.maxHealth / 2)
                    {
                         if(!this.quack)
                         {
                              param1.team.enemyTeam.statue.health = param1.team.enemyTeam.statue.maxHealth;
                              param1.team.enemyTeam.spawnUnitGroup([Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_WINGIDON,Unit.U_WINGIDON,Unit.U_KNIGHT,Unit.U_KNIGHT,Unit.U_KNIGHT,Unit.U_KNIGHT,Unit.U_DEAD,Unit.U_DEAD]);
                              this.message2 = new InGameMessage("",param1.game);
                              this.message2.x = param1.game.stage.stageWidth / 2;
                              this.message2.y = param1.game.stage.stageHeight / 4 - 75;
                              this.message2.scaleX *= 1.3;
                              this.message2.scaleY *= 1.3;
                              param1.addChild(this.message2);
                              this.message2.setMessage("Get out here!","",0,"StartMatchmaking");
                              this.frames = 0;
                              this.quack = true;
                         }
                    }
               }
               if(this.currentLevelTitle == "Gold rush: Contra the expansion of the Order Empire")
               {
                    _loc3_ = 0;
                    _loc4_ = undefined;
                    if(param1.team.enemyTeam.population < 125)
                    {
                         if(param1.game.frame % (30 * randomNumber1) == 0)
                         {
                              _loc3_ = Math.min(this.spawnNumber / 1,1);
                              _loc4_ = 0;
                              while(_loc4_ < _loc3_)
                              {
                                   param1.team.enemyTeam.spawnUnitGroup([Unit.U_ARCHER]);
                                   _loc4_++;
                              }
                              ++this.spawnNumber;
                         }
                         else if(param1.game.frame % (30 * randomNumber2) == 0)
                         {
                              _loc3_ = Math.min(this.spawnNumber / 1,1);
                              _loc4_ = 0;
                              while(_loc4_ < _loc3_)
                              {
                                   param1.team.enemyTeam.spawnUnitGroup([Unit.U_SWORDWRATH,Unit.U_MINER,Unit.U_SPEARTON]);
                                   _loc4_++;
                              }
                              ++this.spawnNumber;
                         }
                         else if(param1.game.frame % (30 * randomNumber3) == 0)
                         {
                              _loc3_ = Math.min(this.spawnNumber / 1,1);
                              _loc4_ = 0;
                              while(_loc4_ < _loc3_)
                              {
                                   param1.team.enemyTeam.spawnUnitGroup([Unit.U_MINER,Unit.U_SPEARTON,Unit.U_MONK]);
                                   _loc4_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
                    if(param1.team.enemyTeam.population > 100)
                    {
                         param1.game.team.enemyTeam.attack(true);
                    }
                    if(param1.game.frame > 30 * 75)
                    {
                         if(!this.quack)
                         {
                              param1.userInterface.helpMessage.showMessage("Reinforcements of Rebels: We go to help.");
                              param1.game.team.tech.isResearchedMap[Tech.SWORDWRATH_RAGE] = true;
                              param1.game.team.tech.isResearchedMap[Tech.BLOCK] = true;
                              param1.game.team.tech.isResearchedMap[Tech.SHIELD_BASH] = true;
                              this.quack = true;
                         }
                         if(!this.rebelsTime1)
                         {
                              _loc2_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.coopSpawn(_loc2_,param1.game);
                              _loc2_.speartonType = "aid";
                              this.rebelsTime1 = true;
                         }
                         if(!this.rebelsTime2)
                         {
                              _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.coopSpawn(_loc2_,param1.game);
                              _loc2_.sType = "aid";
                              this.rebelsTime2 = true;
                         }
                         if(!this.rebelsTime3)
                         {
                              _loc2_ = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.coopSpawn(_loc2_,param1.game);
                              _loc2_.fType = "aid";
                              this.rebelsTime3 = true;
                         }
                         if(param1.game.frame % (30 * randomNumber4) == 0)
                         {
                              if(this.rebelsTime1)
                              {
                                   this.rebelsTime1 = false;
                              }
                         }
                         if(param1.game.frame % (30 * randomNumber5) == 0)
                         {
                              if(this.rebelsTime2)
                              {
                                   this.rebelsTime2 = false;
                              }
                         }
                         if(param1.game.frame % (30 * randomNumber6) == 0)
                         {
                              if(this.rebelsTime3)
                              {
                                   this.rebelsTime3 = false;
                              }
                         }
                    }
                    if(param1.game.frame > 30 * 65)
                    {
                         if(!this.op)
                         {
                              this.message3 = new InGameMessage("",param1.game);
                              this.message3.x = param1.game.stage.stageWidth / 2;
                              this.message3.y = param1.game.stage.stageHeight / 4 - 75;
                              this.message3.scaleX *= 1.3;
                              this.message3.scaleY *= 1.3;
                              param1.addChild(this.message3);
                              this.message3.setMessage("Surrender now, stupid rebels!","Order Army");
                              this.frames = 0;
                              this.op = true;
                         }
                    }
                    if(!this.bruh)
                    {
                         _loc12_ = param1.team.enemyTeam.addWall(param1.game.map.width / 2 - 350);
                         _loc12_.setConstructionAmount(1);
                         _loc12_.health = 8000;
                         _loc12_.maxHealth = 8000;
                         _loc12_.healthBar.totalHealth = _loc12_.maxHealth;
                         _loc13_ = param1.team.addWall(param1.game.map.width / 2 + 350);
                         _loc13_.setConstructionAmount(1);
                         _loc13_.health = 8000;
                         _loc13_.maxHealth = 8000;
                         _loc13_.healthBar.totalHealth = _loc13_.maxHealth;
                         this.bruh = true;
                    }
               }
               else if(this.currentLevelTitle == "Test2")
               {
                    if(!this.bruh)
                    {
                         this.m = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         this.m.mType = "royal";
                         param1.team.enemyTeam.spawn(this.m,param1.game);
                         this.bruh = true;
                    }
               }
               else if(this.currentLevelTitle == "Order\'s Conquest: Swordwrath Attack")
               {
                    if(param1.team.enemyTeam.statue.health < 750)
                    {
                         if(!this.bruh && !this.message)
                         {
                              this.s = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              this.s.sType = "s";
                              param1.team.enemyTeam.spawn(this.s,param1.game);
                              this.e = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              this.e.eType = "e";
                              param1.team.enemyTeam.spawn(this.e,param1.game);
                              this.e = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              this.e.eType = "e";
                              param1.team.enemyTeam.spawn(this.e,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                              param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                              param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                              param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                              this.message = new InGameMessage("",param1.game);
                              this.message.x = param1.game.stage.stageWidth / 2;
                              this.message.y = param1.game.stage.stageHeight / 4 - 75;
                              this.message.scaleX *= 1.3;
                              this.message.scaleY *= 1.3;
                              param1.addChild(this.message);
                              this.message.setMessage("It\'s not easy, you have to defeat me to take down my statue","Sword General",0,"UnitUnlock");
                              this.frames = 0;
                              this.bruh = true;
                         }
                         if(param1.team.enemyTeam.population = 50)
                         {
                              param1.game.team.enemyTeam.attack(true);
                         }
                    }
               }
               else if(this.currentLevelTitle == "Order\'s Conquest: Archer Attack")
               {
                    if(param1.team.enemyTeam.statue.health < 750)
                    {
                         if(!this.quack && !this.message2)
                         {
                              this.f = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              this.f.fType = "f";
                              param1.team.enemyTeam.spawn(this.f,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1 = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                              param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                              param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                              param1.game.soundManager.playSoundFullVolumeRandom("Rage",3);
                              this.message2 = new InGameMessage("",param1.game);
                              this.message2.x = param1.game.stage.stageWidth / 2;
                              this.message2.y = param1.game.stage.stageHeight / 4 - 75;
                              this.message2.scaleX *= 1.3;
                              this.message2.scaleY *= 1.3;
                              param1.addChild(this.message2);
                              this.message2.setMessage("Hey! what are you doing?","Archer General",0,"UnitUnlock");
                              this.frames = 0;
                              this.quack = true;
                         }
                         param1.game.team.enemyTeam.attack(true);
                    }
               }
               else if(this.currentLevelTitle == "!!!")
               {
                    param1.team.statue.health = 0;
               }
               if(this.message && param1.contains(this.message))
               {
                    this.message.update();
                    if(this.frames++ > 30 * 5)
                    {
                         param1.removeChild(this.message);
                    }
               }
               else if(this.message2 && param1.contains(this.message2))
               {
                    this.message2.update();
                    if(this.frames++ > 30 * 5)
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
               else if(this.miniMessage && param1.contains(this.miniMessage))
               {
                    this.miniMessage.update();
                    if(this.frames++ > 30 * 5)
                    {
                         param1.removeChild(this.miniMessage);
                    }
               }
          }
     }
}
