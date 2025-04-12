package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     
     public class CampaignBomber extends CampaignController
     {
          
          private static const S_GLIDING:int = -1;
          
          private static const S_WARNING:int = 2;
          
          private static const S_GLIDINGSORS_ATTACK:int = 3;
          
          private static const S_NO_CHOICE:int = 4;
          
          private static const S_FINAL_PLAN:int = 5;
          
          private static const S_FINISH:int = 6;
           
          
          private var glideTimer:int;
          
          private var glideConstant:int;
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var glideAmbushTimer:int;
          
          private var glideAmbushConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var glideAmbush2Timer:int;
          
          private var glideAmbush2Constant:int;
          
          private var threeMinTimer:int;
          
          private var threeMinConstant:int;
          
          private var glideAmbush3Timer:int;
          
          private var glideAmbush3Constant:int;
          
          private var fourMinTimer:int;
          
          private var fourMinConstant:int;
          
          private var fiveMinTimer:int;
          
          private var fiveMinConstant:int;
          
          private var glideAmbush4Timer:int;
          
          private var glideAmbush4Constant:int;
          
          private var sixMinTimer:int;
          
          private var sixMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var glideAmbush5Timer:int;
          
          private var glideAmbush5Constant:int;
          
          private var eightMinTimer:int;
          
          private var eightMinConstant:int;
          
          private var nineMinTimer:int;
          
          private var nineMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var tenMinConstant:int;
          
          private var frames:int;
          
          private var state:int;
          
          private var counter:int;
          
          private var spawnNumber:int;
          
          private var Glidingsor:Wingidon;
          
          private var StatueBomber:Bomber;
          
          private var message:InGameMessage;
          
          public function CampaignBomber(param1:GameScreen)
          {
               this.glideTimer = 30 * 35;
               this.glideConstant = this.glideTimer;
               this.oneMinTimer = 30 * 45;
               this.oneMinConstant = this.oneMinTimer;
               this.glideAmbushTimer = 30 * 60;
               this.glideAmbushConstant = this.glideAmbushTimer;
               this.twoMinTimer = 30 * 90;
               this.twoMinConstant = this.twoMinTimer;
               this.glideAmbush2Timer = 30 * 120;
               this.glideAmbush2Constant = this.glideAmbush2Timer;
               this.threeMinTimer = 30 * 135;
               this.threeMinConstant = this.threeMinTimer;
               this.glideAmbush3Timer = 30 * 220;
               this.glideAmbush3Constant = this.glideAmbush3Timer;
               this.fourMinTimer = 30 * 180;
               this.fourMinConstant = this.fourMinTimer;
               this.fiveMinTimer = 30 * 225;
               this.fiveMinConstant = this.fiveMinTimer;
               this.glideAmbush4Timer = 30 * 250;
               this.glideAmbush4Constant = this.glideAmbush4Timer;
               this.sixMinTimer = 30 * 270;
               this.sixMinConstant = this.sixMinTimer;
               this.sevenMinTimer = 30 * 315;
               this.sevenMinConstant = this.sevenMinTimer;
               this.glideAmbush5Timer = 30 * 330;
               this.glideAmbush5Constant = this.glideAmbush5Timer;
               this.eightMinTimer = 30 * 350;
               this.eightMinConstant = this.eightMinTimer;
               this.nineMinTimer = 30 * 395;
               this.nineMinConstant = this.nineMinTimer;
               this.tenMinTimer = 30 * 440;
               this.tenMinConstant = this.tenMinTimer;
               super(param1);
               this.state = S_GLIDING;
               this.frames = 0;
               this.counter = 0;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc6_:int = 0;
               var _loc7_:int = 0;
               if(this.message)
               {
                    this.message.update();
               }
               if(this.oneMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.oneMinTimer;
                         }
                         --this.oneMinTimer;
                    }
               }
               else if(this.oneMinTimer != -10)
               {
               }
               if(this.glideAmbushTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.glideAmbushTimer;
                         }
                         --this.glideAmbushTimer;
                    }
               }
               else if(this.glideAmbushTimer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         this.Glidingsor = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(this.Glidingsor,param1.game);
                         this.Glidingsor.wingidonType = "Glidingsor";
                         this.Glidingsor.pz = 0;
                         this.Glidingsor.y = param1.game.map.height / 2;
                         this.Glidingsor.px = param1.team.statue.x + 2000;
                         this.Glidingsor.x = this.Glidingsor.px;
                         this.Glidingsor.team.enemyTeam.game.projectileManager.initTowerSpawn(this.Glidingsor.px,this.Glidingsor.py,this.Glidingsor.team.enemyTeam);
                    }
               }
               if(this.twoMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.twoMinTimer;
                         }
                         --this.twoMinTimer;
                    }
               }
               else if(this.twoMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         this.Glidingsor = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(this.Glidingsor,param1.game);
                         this.Glidingsor.wingidonType = "Glidingsor";
                    }
                    if(param1.game.frame % (30 * 30) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.glideAmbush2Timer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.glideAmbush2Timer;
                         }
                         --this.glideAmbush2Timer;
                    }
               }
               else if(this.glideAmbush2Timer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         this.Glidingsor = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(this.Glidingsor,param1.game);
                         this.Glidingsor.wingidonType = "Glidingsor";
                         this.Glidingsor.pz = 0;
                         this.Glidingsor.y = param1.game.map.height / 2;
                         this.Glidingsor.px = param1.team.statue.x + 600;
                         this.Glidingsor.x = this.Glidingsor.px;
                         this.Glidingsor.team.enemyTeam.game.projectileManager.initTowerSpawn(this.Glidingsor.px,this.Glidingsor.py,this.Glidingsor.team.enemyTeam);
                    }
                    if(param1.game.frame % (30 * 38) == 0)
                    {
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.threeMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.threeMinTimer;
                         }
                         --this.threeMinTimer;
                    }
               }
               else if(this.threeMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 45) == 0)
                    {
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
                    if(param1.game.frame % (30 * 45) == 0)
                    {
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.glideAmbush3Timer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.glideAmbush3Timer;
                         }
                         --this.glideAmbush3Timer;
                    }
               }
               else if(this.glideAmbush3Timer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         this.Glidingsor = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(this.Glidingsor,param1.game);
                         this.Glidingsor.wingidonType = "Glidingsor";
                         this.Glidingsor.pz = 0;
                         this.Glidingsor.y = param1.game.map.height / 2;
                         this.Glidingsor.px = param1.team.enemyTeam.statue.x - 800;
                         this.Glidingsor.x = this.Glidingsor.px;
                         this.Glidingsor.team.enemyTeam.game.projectileManager.initTowerSpawn(this.Glidingsor.px,this.Glidingsor.py,this.Glidingsor.team.enemyTeam);
                    }
               }
               if(this.fourMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.fourMinTimer;
                         }
                         --this.fourMinTimer;
                    }
               }
               else if(this.fourMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 45) == 0)
                    {
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.fiveMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.fiveMinTimer;
                         }
                         --this.fiveMinTimer;
                    }
               }
               else if(this.fiveMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 45) == 0)
                    {
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
                    if(param1.game.frame % (30 * 38) == 0)
                    {
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.glideAmbush4Timer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.glideAmbush4Timer;
                         }
                         --this.glideAmbush4Timer;
                    }
               }
               else if(this.glideAmbush4Timer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         this.Glidingsor = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(this.Glidingsor,param1.game);
                         this.Glidingsor.wingidonType = "Glidingsor";
                         this.Glidingsor.pz = 0;
                         this.Glidingsor.y = param1.game.map.height / 2;
                         this.Glidingsor.px = param1.team.enemyTeam.statue.x - 2700;
                         this.Glidingsor.x = this.Glidingsor.px;
                         this.Glidingsor.team.enemyTeam.game.projectileManager.initTowerSpawn(this.Glidingsor.px,this.Glidingsor.py,this.Glidingsor.team.enemyTeam);
                    }
               }
               if(this.sixMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.sixMinTimer;
                         }
                         --this.sixMinTimer;
                    }
               }
               else if(this.sixMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 45) == 0)
                    {
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.sevenMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.sevenMinTimer;
                         }
                         --this.sevenMinTimer;
                    }
               }
               else if(this.sevenMinTimer != -10)
               {
               }
               if(this.glideAmbush5Timer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.glideAmbush5Timer;
                         }
                         --this.glideAmbush5Timer;
                    }
               }
               else if(this.glideAmbush5Timer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         this.Glidingsor = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(this.Glidingsor,param1.game);
                         this.Glidingsor.wingidonType = "Glidingsor";
                         this.Glidingsor.pz = 0;
                         this.Glidingsor.y = param1.game.map.height / 2;
                         this.Glidingsor.px = param1.team.enemyTeam.statue.x - 100;
                         this.Glidingsor.x = this.Glidingsor.px;
                         this.Glidingsor.team.enemyTeam.game.projectileManager.initTowerSpawn(this.Glidingsor.px,this.Glidingsor.py,this.Glidingsor.team.enemyTeam);
                    }
               }
               if(this.eightMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.eightMinTimer;
                         }
                         --this.eightMinTimer;
                    }
               }
               else if(this.eightMinTimer != -10)
               {
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
               }
               if(this.nineMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.nineMinTimer;
                         }
                         --this.nineMinTimer;
                    }
               }
               else if(this.nineMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 45) == 0)
                    {
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.tenMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.tenMinTimer;
                         }
                         --this.tenMinTimer;
                    }
               }
               else if(this.tenMinTimer != -10)
               {
               }
               if(this.state == S_GLIDING)
               {
                    if(this.glideTimer > 0)
                    {
                         if(!param1.isPaused)
                         {
                              if(param1.isFastForward)
                              {
                                   --this.glideTimer;
                              }
                              --this.glideTimer;
                         }
                    }
                    else if(this.glideTimer != -10)
                    {
                         this.state = S_WARNING;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         this.glideTimer = -10;
                    }
               }
               else if(this.state == S_WARNING)
               {
                    this.message.setMessage("The Garrison\'s Castle Archers are warning us about loud whirling sounds above the skies. Stay Sharp!","Spearton",0,"speartonHoghSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_GLIDINGSORS_ATTACK;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_GLIDINGSORS_ATTACK)
               {
                    if(param1.team.enemyTeam.statue.health < 1200)
                    {
                         this.state = S_NO_CHOICE;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_NO_CHOICE)
               {
                    this.message.setMessage("Rats! My greatest of my plans foiled by the likings of you!","Queen Medusa",0,"youMustAllDie");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_FINAL_PLAN;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_FINAL_PLAN)
               {
                    this.message.setMessage("It seems like I have no choice but to execute Operation Havoc Offensive to even the stakes between us.","Queen Medusa",0,"medusaVoice3");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_FINISH;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_FINISH)
               {
               }
          }
     }
}
