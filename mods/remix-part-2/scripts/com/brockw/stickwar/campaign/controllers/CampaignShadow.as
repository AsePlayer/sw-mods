package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.CampaignGameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.MoveCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignShadow extends CampaignController
     {
          
          private static const S_AMBUSH:int = -1;
          
          private static const S_ALERT:int = 2;
          
          private static const S_BEGIN:int = 3;
          
          private static const S_INCOMING:int = 4;
          
          private static const S_FEELING:int = 5;
          
          private static const S_ALPHA_ARRIVES:int = 6;
          
          private static const S_ALPHA_PHASE_1:int = 7;
          
          private static const S_ALPHA_PHASE_2:int = 8;
          
          private static const S_ALPHA_DEFEAT:int = 9;
          
          private static const S_SUCCESS:int = 10;
           
          
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
          
          private var AlphaTimer:int;
          
          private var AlphaConstant:int;
          
          private var message:InGameMessage;
          
          private var frames:int;
          
          private var state:int;
          
          private var counter:int = 0;
          
          private var spawnNumber:int;
          
          private var AlphaPex:Cat;
          
          public function CampaignShadow(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 20;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 40;
               this.twoMinConstant = this.twoMinTimer;
               this.threeMinTimer = 30 * 60;
               this.threeMinConstant = this.threeMinTimer;
               this.fourMinTimer = 30 * 75;
               this.fourMinConstant = this.fourMinTimer;
               this.fiveMinTimer = 30 * 95;
               this.fiveMinConstant = this.fiveMinTimer;
               this.sixMinTimer = 30 * 115;
               this.sixMinConstant = this.sixMinTimer;
               this.sevenMinTimer = 30 * 140;
               this.sevenMinConstant = this.sevenMinTimer;
               this.eightMinTimer = 30 * 165;
               this.eightMinConstant = this.eightMinTimer;
               this.nineMinTimer = 30 * 185;
               this.nineMinConstant = this.nineMinTimer;
               this.tenMinTimer = 30 * 215;
               this.tenMinConstant = this.tenMinTimer;
               this.AlphaTimer = 30 * 240;
               this.AlphaConstant = this.AlphaTimer;
               super(param1);
               this.state = S_AMBUSH;
               this.counter = 0;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc6_:StickWar = null;
               var _loc9_:MoveCommand = null;
               if(this.message)
               {
                    this.message.update();
               }
               param1.team.enemyTeam.statue.health = 10;
               param1.team.enemyTeam.gold = 0;
               param1.team.enemyTeam.attack(true);
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
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.oneMinTimer = -10;
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
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.twoMinTimer = -10;
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
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.threeMinTimer = -10;
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
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.fourMinTimer = -10;
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
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.fiveMinTimer = -10;
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.sixMinTimer = -10;
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
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.sevenMinTimer = -10;
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.eightMinTimer = -10;
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
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.nineMinTimer = -10;
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.tenMinTimer = -10;
               }
               if(this.state == S_AMBUSH)
               {
                    if(param1.team.enemyTeam.statue.health < 100)
                    {
                         param1.team.enemyTeam.statue.health += 1500;
                         this.state = S_ALERT;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         param1.game.soundManager.playSoundInBackground("voiceTutorial12");
                    }
               }
               else if(this.state == S_ALERT)
               {
                    this.message.setMessage("We\'ve been ambushed! We must create a solid defense and repel the enemy as long as possible till backup arrives!","Spearton",0,"speartonHoghSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_BEGIN;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         param1.team.gold = 1000;
                         param1.team.mana = 1000;
                    }
               }
               else if(this.state == S_BEGIN)
               {
                    if(this.AlphaTimer > 0)
                    {
                         if(!param1.isPaused)
                         {
                              if(param1.isFastForward)
                              {
                                   --this.AlphaTimer;
                              }
                              --this.AlphaTimer;
                         }
                    }
                    else if(this.AlphaTimer != -10)
                    {
                         this.state = S_INCOMING;
                         this.counter = 0;
                         this.AlphaTimer = -10;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_INCOMING)
               {
                    this.message.setMessage("Sir, I am begining to feel quake shakes on the ground........and snarling?","Miner",0,"LoginSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_FEELING;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         this.AlphaPex = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(this.AlphaPex,param1.game);
                         this.AlphaPex.catType = "AlphaPex";
                         this.AlphaPex.pz = 0;
                         this.AlphaPex.py = _loc6_.map.height / 4;
                         this.AlphaPex.px = param1.team.statue.x + 3000;
                         this.AlphaPex.x = this.AlphaPex.px;
                         _loc9_ = new MoveCommand(_loc6_);
                         _loc9_.realX = _loc9_.goalX = this.AlphaPex.px - 200;
                         _loc9_.realY = _loc9_.goalY = this.AlphaPex.py;
                         this.AlphaPex.ai.setCommand(_loc6_,_loc9_);
                         this.AlphaPex.ai.mayAttack = false;
                         this.AlphaPex.ai.mayMoveToAttack = false;
                    }
               }
               else if(this.state == S_FEELING)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.AlphaPex.px - param1.game.map.screenWidth / 2;
                    CampaignGameScreen(param1).doAiUpdates = false;
                    param1.userInterface.isGlobalsEnabled = false;
                    param1.userInterface.hud.hud.fastForward.visible = false;
                    param1.game.fogOfWar.isFogOn = false;
                    ++this.counter;
                    if(this.counter > 100)
                    {
                         this.state = S_ALPHA_ARRIVES;
                         this.counter = 0;
                         param1.userInterface.isSlowCamera = true;
                         param1.game.targetScreenX = param1.game.team.statue.x - 325;
                         param1.game.screenX = param1.game.team.statue.x - 325;
                         CampaignGameScreen(param1).doAiUpdates = true;
                         param1.userInterface.isGlobalsEnabled = true;
                         param1.userInterface.hud.hud.fastForward.visible = true;
                         param1.game.fogOfWar.isFogOn = true;
                    }
               }
               else if(this.state == S_ALPHA_ARRIVES)
               {
                    param1.userInterface.isSlowCamera = false;
                    if(!this.AlphaPex.health < 1500)
                    {
                         this.state = S_ALPHA_PHASE_1;
                         this.counter = 0;
                         this.AlphaPex.px += 5600;
                    }
                    else
                    {
                         if(param1.game.frame % (30 * 3) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 12) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                    }
               }
               else if(this.state == S_ALPHA_PHASE_1)
               {
                    if(this.AlphaPex.health < 1000)
                    {
                         this.state = S_ALPHA_PHASE_2;
                         this.counter = 0;
                         this.AlphaPex.px += 5600;
                    }
                    else
                    {
                         if(param1.game.frame % (30 * 3) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 9) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 8) == 0)
                         {
                              _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                    }
               }
               else if(this.state == S_ALPHA_PHASE_2)
               {
                    if(this.AlphaPex.health < 500)
                    {
                         this.state = S_ALPHA_DEFEAT;
                         this.counter = 0;
                         this.AlphaPex.px += 5600;
                    }
                    else
                    {
                         param1.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 3) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 6) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 6) == 0)
                         {
                              _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 10) == 0)
                         {
                              _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                    }
               }
               else if(this.state == S_ALPHA_DEFEAT)
               {
                    if(!this.AlphaPex.isAlive())
                    {
                         this.state = S_SUCCESS;
                         this.counter = 0;
                    }
                    else
                    {
                         if(param1.game.frame % (30 * 3) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 6) == 0)
                         {
                              _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 6) == 0)
                         {
                              _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 10) == 0)
                         {
                              _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                    }
               }
               else if(this.state == S_SUCCESS)
               {
                    if(this.counter++ == 30 * 4)
                    {
                         param1.team.enemyTeam.statue.health = 0;
                    }
               }
          }
     }
}
