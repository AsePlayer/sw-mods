package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.MoveCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Monk;
     import com.brockw.stickwar.engine.units.Skelator;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     
     public class CampaignKnight extends CampaignController
     {
          
          private static const S_SET_UP:int = -1;
          
          private static const S_PERSPECTIVE:int = 2;
          
          private static const S_INVENTION:int = 3;
          
          private static const S_GOOD_LUCK:int = 4;
           
          
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
          
          private var message:InGameMessage;
          
          private var frames:int;
          
          private var state:int;
          
          private var counter:int = 0;
          
          private var spawnNumber:int;
          
          public function CampaignKnight(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 25;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 50;
               this.twoMinConstant = this.twoMinTimer;
               this.threeMinTimer = 30 * 75;
               this.threeMinConstant = this.threeMinTimer;
               this.fourMinTimer = 30 * 100;
               this.fourMinConstant = this.fourMinTimer;
               this.fiveMinTimer = 30 * 125;
               this.fiveMinConstant = this.fiveMinTimer;
               this.sixMinTimer = 30 * 140;
               this.sixMinConstant = this.sixMinTimer;
               this.sevenMinTimer = 30 * 155;
               this.sevenMinConstant = this.sevenMinTimer;
               this.eightMinTimer = 30 * 170;
               this.eightMinConstant = this.eightMinTimer;
               this.nineMinTimer = 30 * 185;
               this.nineMinConstant = this.nineMinTimer;
               this.tenMinTimer = 30 * 200;
               this.tenMinConstant = this.tenMinTimer;
               this.loopMinTimer = 30 * 225;
               this.loopMinConstant = this.loopMinTimer;
               this.looptwoMinTimer = 30 * 250;
               this.looptwoMinConstant = this.looptwoMinTimer;
               this.loopthreeMinTimer = 30 * 275;
               this.loopthreeMinConstant = this.loopthreeMinTimer;
               this.loopfourMinTimer = 30 * 300;
               this.loopfourMinConstant = this.loopfourMinTimer;
               this.loopfiveMinTimer = 30 * 325;
               this.loopfiveMinConstant = this.loopfiveMinTimer;
               this.loopsixMinTimer = 30 * 350;
               this.loopsixMinConstant = this.loopsixMinTimer;
               this.loopsevenMinTimer = 30 * 375;
               this.loopsevenMinConstant = this.loopsevenMinTimer;
               this.loopeightMinTimer = 30 * 400;
               this.loopeightMinConstant = this.loopeightMinTimer;
               this.loopnineMinTimer = 30 * 425;
               this.loopnineMinConstant = this.loopnineMinTimer;
               this.looptenMinTimer = 30 * 450;
               this.looptenMinConstant = this.looptenMinTimer;
               super(param1);
               this.state = S_SET_UP;
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
               param1.team.enemyTeam.gold = 0;
               param1.team.enemyTeam.attack(true);
               if(param1.game.frame % (30 * 30) == 0)
               {
                    param1.team.gold += 2000;
                    param1.team.mana += 2000;
               }
               if(param1.game.frame % (30 * 45) == 0)
               {
                    _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.spawn(_loc2_,param1.game);
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
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
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
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
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
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
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
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
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
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
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
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
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
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
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
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
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
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
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
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
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
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
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
                    if(param1.game.frame % (30 * 225) == 0)
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
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
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
                    if(param1.game.frame % (30 * 250) == 0)
                    {
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
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
                    if(param1.game.frame % (30 * 275) == 0)
                    {
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
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
                    if(param1.game.frame % (30 * 300) == 0)
                    {
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
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
                    if(param1.game.frame % (30 * 325) == 0)
                    {
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
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
                    if(param1.game.frame % (30 * 350) == 0)
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
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
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
                    if(param1.game.frame % (30 * 375) == 0)
                    {
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
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
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
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
                    if(param1.game.frame % (30 * 400) == 0)
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
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
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
                    if(param1.game.frame % (30 * 425) == 0)
                    {
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
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
                    if(param1.game.frame % (30 * 450) == 0)
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
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.state == S_SET_UP)
               {
                    if(param1.game.team.gold > 10)
                    {
                         this.state = S_PERSPECTIVE;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         param1.game.soundManager.playSoundInBackground("elementalInGame");
                    }
               }
               else if(this.state == S_PERSPECTIVE)
               {
                    this.message.setMessage("It seems like Medusa\'s pulling out all the stops for her final trick.","Scout Captain Stella",0,"speartonHoghSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_INVENTION;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_INVENTION)
               {
                    this.message.setMessage("Use your latest invention to repel against the enemy attacks. Men and resources will be sent every once in a while.","Scout Captain Stella",0,"speartonHoghSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_GOOD_LUCK;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_GOOD_LUCK)
               {
               }
          }
     }
}
