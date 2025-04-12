package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.CampaignGameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.MoveCommand;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Monk;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignDeads extends CampaignController
     {
          
          private static const S_PREPARING_THE_OLD_GAG:int = -1;
          
          private static const S_THE_MAGIKILL_1:int = 2;
          
          private static const S_THE_MAGIKILL_2:int = 3;
          
          private static const S_THE_MAGIKILL_3:int = 4;
          
          private static const S_RELEASE_THE_FUCKING_WAVE:int = 2;
          
          private static const S_JUST_WAITING:int = 2;
           
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var threeMinTimer:int;
          
          private var threeMinConstant:int;
          
          private var fourMinTimer:int;
          
          private var fourMinConstant:int;
          
          private var fiveMinTimer:int;
          
          private var fiveMinConstant:int;
          
          private var sixMinTimer:int;
          
          private var sixMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var eightMinTimer:int;
          
          private var eightMinConstant:int;
          
          private var nineMinTimer:int;
          
          private var nineMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var tenMinConstant:int;
          
          private var spawnedTheMagikill:Boolean;
          
          private var TheMagikill:Magikill;
          
          private var TheMagikillDead:Boolean = false;
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var message3:InGameMessage;
          
          private var frames:int;
          
          private var state:int;
          
          private var counter:int;
          
          private var spawnNumber:int;
          
          public function CampaignDeads(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 60;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 120;
               this.twoMinConstant = this.twoMinTimer;
               this.threeMinTimer = 30 * 180;
               this.threeMinConstant = this.threeMinTimer;
               this.fourMinTimer = 30 * 240;
               this.fourMinConstant = this.fourMinTimer;
               this.fiveMinTimer = 30 * 300;
               this.fiveMinConstant = this.fiveMinTimer;
               this.sixMinTimer = 30 * 360;
               this.sixMinConstant = this.sixMinTimer;
               this.sevenMinTimer = 30 * 420;
               this.sevenMinConstant = this.sevenMinTimer;
               this.eightMinTimer = 30 * 480;
               this.eightMinConstant = this.eightMinTimer;
               this.nineMinTimer = 30 * 540;
               this.nineMinConstant = this.nineMinTimer;
               this.tenMinTimer = 30 * 600;
               this.tenMinConstant = this.tenMinTimer;
               super(param1);
               this.state = S_PREPARING_THE_OLD_GAG;
               this.counter = 0;
               this.TheMagikill = null;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc6_:* = null;
               var _loc9_:MoveCommand = null;
               var _loc4_:int = 0;
               var _loc7_:int = 0;
               var TheMagikill:Magikill = null;
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
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc7_++;
                    }
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
                    param1.game.team.enemyTeam.attack(true);
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
                         _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
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
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
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
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
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
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
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
               if(!this.spawnedTheMagikill)
               {
                    this.state = S_PREPARING_THE_OLD_GAG;
                    this.counter = 0;
                    this.TheMagikill = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.enemyTeam.spawn(this.TheMagikill,param1.game);
                    this.TheMagikill.magikillType = "TheMagikill";
                    _loc6_ = param1.game;
                    delete _loc6_.team.unitsAvailable[Unit.U_SWORDWRATH];
                    delete _loc6_.team.unitsAvailable[Unit.U_MINER];
                    delete _loc6_.team.unitsAvailable[Unit.U_NINJA];
                    delete _loc6_.team.unitsAvailable[Unit.U_ARCHER];
                    delete _loc6_.team.unitsAvailable[Unit.U_SPEARTON];
                    this.spawnedTheMagikill = true;
               }
               if(this.state == S_PREPARING_THE_OLD_GAG)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.TheMagikill.px - param1.game.map.screenWidth / 2;
                    CampaignGameScreen(param1).doAiUpdates = false;
                    param1.userInterface.isGlobalsEnabled = false;
                    param1.userInterface.hud.hud.fastForward.visible = false;
                    param1.game.fogOfWar.isFogOn = false;
                    ++this.counter;
                    if(this.counter > 420)
                    {
                         this.state = S_THE_MAGIKILL_1;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_THE_MAGIKILL_1)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.TheMagikill.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("I don\'t usually intend to reveal myself this early to your likings, but I must say, I\'m impressed you withstanded our attacks with the remnants left along you..","The Magikill",0,"wizardVoiceOver2");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_THE_MAGIKILL_2;
                         this.counter = 0;
                         this.message2 = new InGameMessage("",param1.game);
                         this.message2.x = param1.game.stage.stageWidth / 2;
                         this.message2.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message2.scaleX *= 1.3;
                         this.message2.scaleY *= 1.3;
                         param1.addChild(this.message2);
                    }
               }
               else if(this.state == S_THE_MAGIKILL_2)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.TheMagikill.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("However. I must heed you a warning that any futile attempts of your nation\'s restoration shall meet loose ends by my nation until you formally surrender to us.","The Magikill",0,"wizardVoiceOver1");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_THE_MAGIKILL_3;
                    }
               }
               else if(this.state == S_THE_MAGIKILL_3)
               {
                    this.message.setMessage("Now enough talk. It\'s time to demonstrate to you our new ways of magic. All we do is cast this spell.\'","The Magikill",0,"wizardVoiceOver4");
                    if(this.message && param1.contains(this.message))
                    {
                         this.message.update();
                         if(this.frames++ > 30 * 10)
                         {
                              param1.removeChild(this.message);
                              this.state == S_RELEASE_THE_FUCKING_WAVE;
                              this.counter = 0;
                              this.TheMagikill.health = 0;
                              this.TheMagikill.setFire(30 * 35,900);
                              param1.userInterface.isSlowCamera = false;
                              param1.game.targetScreenX = param1.game.team.statue.x - 325;
                              param1.game.screenX = param1.game.team.statue.x - 325;
                              CampaignGameScreen(param1).doAiUpdates = true;
                              param1.userInterface.isGlobalsEnabled = true;
                              param1.userInterface.hud.hud.fastForward.visible = true;
                              param1.game.fogOfWar.isFogOn = true;
                              _loc6_ = param1.game;
                              param1.team.unitsAvailable[Unit.U_SWORDWRATH] = 1;
                              param1.team.unitsAvailable[Unit.U_MINER] = 1;
                              param1.team.unitsAvailable[Unit.U_NINJA] = 1;
                              param1.team.unitsAvailable[Unit.U_ARCHER] = 1;
                              param1.team.unitsAvailable[Unit.U_SPEARTON] = 1;
                              _loc6_.team.spawnUnitGroup([Unit.U_MINER,Unit.U_MINER,Unit.U_MINER,Unit.U_SWORDWRATH,Unit.U_NINJA]);
                              _loc6_.team.enemyTeam.spawnUnitGroup([Unit.U_MINER,Unit.U_MINER,Unit.U_MINER]);
                              _loc6_.team.gold = 500;
                              _loc6_.team.mana = 500;
                              _loc6_.team.enemyTeam.gold = 0;
                              _loc6_.team.enemyTeam.mana = 0;
                         }
                    }
               }
               else if(this.state == S_RELEASE_THE_FUCKING_WAVE)
               {
                    ++this.counter;
                    if(this.frames++ > 30 * 10)
                    {
                         this.counter = 0;
                         this.state == S_JUST_WAITING;
                    }
               }
               else if(this.state == S_JUST_WAITING)
               {
               }
          }
     }
}
