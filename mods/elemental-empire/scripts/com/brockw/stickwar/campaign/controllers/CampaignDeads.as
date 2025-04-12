package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.*;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Miner;
     import com.brockw.stickwar.engine.units.Skelator;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.elementals.*;
     
     public class CampaignDeads extends CampaignController
     {
           
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var difficulty:int;
          
          private var frames:int;
          
          private var currentLevelTitle:String;
          
          private var nah:Boolean = false;
          
          private var bruh:Boolean = false;
          
          private var quack:Boolean = false;
          
          private var help:Boolean = false;
          
          private var v:ChromeElement;
          
          private var aid:EarthElement;
          
          private var bomber:Bomber;
          
          private var m:Magikill;
          
          private var w:Magikill;
          
          private var q:Skelator;
          
          private var s:Swordwrath;
          
          private var e:Swordwrath;
          
          private var f:Archer;
          
          private var spawnNumber:int;
          
          public function CampaignDeads(param1:GameScreen)
          {
               super(param1);
               this.currentLevelTitle = param1.main.campaign.getCurrentLevel().title;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var u1:Unit = null;
               if(!this.nah)
               {
                    this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                    param1.team.spawn(this.v,param1.game);
                    this.v.vType = "v";
                    param1.game.team.enemyTeam.tech.isResearchedMap[Tech.CASTLE_ARCHER_3] = true;
                    param1.game.fogOfWar.isFogOn = false;
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
               if(this.currentLevelTitle == "Remnants of Chaos: Meet Marrowkai")
               {
                    var _loc3_:int = 0;
                    var _loc7_:* = undefined;
                    if(param1.game.frame % (30 * 6) == 0)
                    {
                         _loc3_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc3_)
                         {
                              u1 = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                              param1.team.enemyTeam.spawn(u1,param1.game);
                              u1.ai.alwaysAttack = true;
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
                    if(param1.game.frame % (30 * 20) == 0)
                    {
                         _loc3_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc3_)
                         {
                              this.aid = EarthElement(param1.game.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
                              param1.team.spawn(this.aid,param1.game);
                              this.aid.aidType = "aid";
                              this.aid = EarthElement(param1.game.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
                              param1.team.spawn(this.aid,param1.game);
                              this.aid.aidType = "aid";
                              this.aid = EarthElement(param1.game.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
                              param1.team.spawn(this.aid,param1.game);
                              this.aid.aidType = "aid";
                              this.aid = EarthElement(param1.game.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
                              param1.team.spawn(this.aid,param1.game);
                              this.aid.aidType = "aid";
                              _loc7_++;
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
                         this.message.setMessage("Are you guys seriously? Don\'t you guys want to get out of the way for us?","V",0,"StartMatchmaking");
                         this.frames = 0;
                         this.bruh = true;
                    }
                    if(param1.team.enemyTeam.statue.health < param1.team.enemyTeam.statue.maxHealth / 2)
                    {
                         if(!this.quack)
                         {
                              this.q = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                              this.q.qType = "q";
                              param1.team.enemyTeam.spawn(this.q,param1.game);
                              param1.team.enemyTeam.statue.health = param1.team.enemyTeam.statue.maxHealth;
                              this.difficulty = param1.team.game.main.campaign.difficultyLevel;
                              param1.team.enemyTeam.spawnUnitGroup([Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_GIANT,Unit.U_GIANT,Unit.U_GIANT,Unit.U_WINGIDON,Unit.U_WINGIDON,Unit.U_KNIGHT,Unit.U_KNIGHT,Unit.U_DEAD,Unit.U_DEAD]);
                              this.message2 = new InGameMessage("",param1.game);
                              this.message2.x = param1.game.stage.stageWidth / 2;
                              this.message2.y = param1.game.stage.stageHeight / 4 - 75;
                              this.message2.scaleX *= 1.3;
                              this.message2.scaleY *= 1.3;
                              param1.addChild(this.message2);
                              this.message2.setMessage("How dare you make a mess here?","Kai",0,"blindGateSound");
                              this.frames = 0;
                              this.quack = true;
                         }
                         if(this.q.health < 401)
                         {
                              if(param1.game.frame % (30 * 4) == 0)
                              {
                                   _loc3_ = Math.min(this.spawnNumber / 1,1);
                                   _loc7_ = 0;
                                   while(_loc7_ < _loc3_)
                                   {
                                        param1.team.enemyTeam.statue.health = 0;
                                        _loc7_++;
                                   }
                                   ++this.spawnNumber;
                              }
                              param1.userInterface.isGlobalsEnabled = false;
                         }
                    }
               }
               if(this.currentLevelTitle == "Test2")
               {
                    if(!this.bruh)
                    {
                         this.s = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         this.s.sType = "s";
                         param1.team.enemyTeam.spawn(this.s,param1.game);
                         this.bruh = true;
                    }
               }
               else if(this.currentLevelTitle == "Order\'s Conquest: Swordwrath Attack")
               {
                    if(param1.team.enemyTeam.statue.health < 750)
                    {
                         if(!this.bruh && !this.message2)
                         {
                              this.s = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              this.s.sType = "s";
                              param1.team.enemyTeam.spawn(this.s,param1.game);
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
                              this.message2 = new InGameMessage("",param1.game);
                              this.message2.x = param1.game.stage.stageWidth / 2;
                              this.message2.y = param1.game.stage.stageHeight / 4 - 75;
                              this.message2.scaleX *= 1.3;
                              this.message2.scaleY *= 1.3;
                              param1.addChild(this.message2);
                              this.message2.setMessage("It\'s not easy, you have to defeat me to take down my statue","Sword General",0,"UnitUnlock");
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
                    if(this.frames++ > 30 * 5)
                    {
                         param1.removeChild(this.message2);
                    }
               }
          }
     }
}
