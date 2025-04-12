package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignBomber extends CampaignController
     {
           
          
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
          
          private var loopMinTimer:int;
          
          private var loopMinConstant:int;
          
          private var looptwoMinTimer:int;
          
          private var looptwoMinConstant:int;
          
          private var loopthreeMinTimer:int;
          
          private var loopthreeMinConstant:int;
          
          private var loopfourMinTimer:int;
          
          private var loopfourMinConstant:int;
          
          private var loopfiveMinTimer:int;
          
          private var loopfiveMinConstant:int;
          
          private var loopsixMinTimer:int;
          
          private var loopsixMinConstant:int;
          
          private var loopsevenMinTimer:int;
          
          private var loopsevenMinConstant:int;
          
          private var loopeightMinTimer:int;
          
          private var loopeightMinConstant:int;
          
          private var loopnineMinTimer:int;
          
          private var loopnineMinConstant:int;
          
          private var looptenMinTimer:int;
          
          private var looptenMinConstant:int;
          
          private var frames:int;
          
          private var state:int;
          
          private var counter:int;
          
          private var spawnNumber:int;
          
          private var StatueBomber:Bomber;
          
          private var message:InGameMessage;
          
          public function CampaignBomber(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 30;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 60;
               this.twoMinConstant = this.twoMinTimer;
               this.threeMinTimer = 30 * 90;
               this.threeMinConstant = this.threeMinTimer;
               this.fourMinTimer = 30 * 120;
               this.fourMinConstant = this.fourMinTimer;
               this.fiveMinTimer = 30 * 150;
               this.fiveMinConstant = this.fiveMinTimer;
               this.sixMinTimer = 30 * 180;
               this.sixMinConstant = this.sixMinTimer;
               this.sevenMinTimer = 30 * 210;
               this.sevenMinConstant = this.sevenMinTimer;
               this.eightMinTimer = 30 * 240;
               this.eightMinConstant = this.eightMinTimer;
               this.nineMinTimer = 30 * 270;
               this.nineMinConstant = this.nineMinTimer;
               this.tenMinTimer = 30 * 300;
               this.tenMinConstant = this.tenMinTimer;
               this.loopMinTimer = 30 * 330;
               this.loopMinConstant = this.loopMinTimer;
               this.looptwoMinTimer = 30 * 360;
               this.looptwoMinConstant = this.looptwoMinTimer;
               this.loopthreeMinTimer = 30 * 390;
               this.loopthreeMinConstant = this.loopthreeMinTimer;
               this.loopfourMinTimer = 30 * 420;
               this.loopfourMinConstant = this.loopfourMinTimer;
               this.loopfiveMinTimer = 30 * 450;
               this.loopfiveMinConstant = this.loopfiveMinTimer;
               this.loopsixMinTimer = 30 * 480;
               this.loopsixMinConstant = this.loopsixMinTimer;
               this.loopsevenMinTimer = 30 * 510;
               this.loopsevenMinConstant = this.loopsevenMinTimer;
               this.loopeightMinTimer = 30 * 540;
               this.loopeightMinConstant = this.loopeightMinTimer;
               this.loopnineMinTimer = 30 * 570;
               this.loopnineMinConstant = this.loopnineMinTimer;
               this.looptenMinTimer = 30 * 600;
               this.looptenMinConstant = this.looptenMinTimer;
               super(param1);
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
               param1.game.team.enemyTeam.attack(true);
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
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
                    if(param1.game.frame % (30 * 120) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.threeMinTimer = -10;
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                    this.StatueBomber.bomberType = "StatueBomber";
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
                    if(param1.game.frame % (30 * 180) == 0)
                    {
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                         this.fiveMinTimer = -10;
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                    this.StatueBomber.bomberType = "StatueBomber";
                    this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                    this.StatueBomber.bomberType = "StatueBomber";
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
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                    this.StatueBomber.bomberType = "StatueBomber";
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
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                    this.StatueBomber.bomberType = "StatueBomber";
                    this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                    this.StatueBomber.bomberType = "StatueBomber";
                    this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                    this.StatueBomber.bomberType = "StatueBomber";
                    this.tenMinTimer = -10;
               }
               if(this.loopMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.loopMinTimer;
                         }
                         --this.loopMinTimer;
                    }
               }
               else if(this.loopMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 330) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.looptwoMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.looptwoMinTimer;
                         }
                         --this.looptwoMinTimer;
                    }
               }
               else if(this.looptwoMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 360) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.loopthreeMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.loopthreeMinTimer;
                         }
                         --this.loopthreeMinTimer;
                    }
               }
               else if(this.loopthreeMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 390) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.loopfourMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.loopfourMinTimer;
                         }
                         --this.loopfourMinTimer;
                    }
               }
               else if(this.loopfourMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 420) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                    }
               }
               if(this.loopfiveMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.loopfiveMinTimer;
                         }
                         --this.loopfiveMinTimer;
                    }
               }
               else if(this.loopfiveMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 450) == 0)
                    {
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                    }
               }
               if(this.loopsixMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.loopsixMinTimer;
                         }
                         --this.loopsixMinTimer;
                    }
               }
               else if(this.loopsixMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 480) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.loopsevenMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.loopsevenMinTimer;
                         }
                         --this.loopsevenMinTimer;
                    }
               }
               else if(this.loopsevenMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 510) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                    }
               }
               if(this.loopeightMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.loopeightMinTimer;
                         }
                         --this.loopeightMinTimer;
                    }
               }
               else if(this.loopeightMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 540) == 0)
                    {
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.loopnineMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.loopnineMinTimer;
                         }
                         --this.loopnineMinTimer;
                    }
               }
               else if(this.loopnineMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 570) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                    }
               }
               if(this.looptenMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.looptenMinTimer;
                         }
                         --this.looptenMinTimer;
                    }
               }
               else if(this.looptenMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 600) == 0)
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
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                         this.StatueBomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(this.StatueBomber,param1.game);
                         this.StatueBomber.bomberType = "StatueBomber";
                    }
               }
          }
     }
}
