package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.Ai.command.MoveCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignTutorial extends CampaignController
     {
           
          
          private var Mega_2:Spearton;
          
          private var Magis:Magikill;
          
          private var VoltSpear:Spearton;
          
          private var VoltSword:Swordwrath;
          
          private var VoltArcher:Archer;
          
          private var AlphaCat:Cat;
          
          private var GiantCat:Cat;
          
          private var GiantCat_2:Cat;
          
          private var Cat_1:Cat;
          
          private var PackLeader:Cat;
          
          private var swordwrath:Swordwrath;
          
          private var archer:Archer;
          
          private var MeleeDead:Dead;
          
          private var spearton:Spearton;
          
          private var magikill:Magikill;
          
          private var statue:Statue;
          
          private var nah:Boolean = false;
          
          private var spawnNumber:int;
          
          private var waveOneTimer:int;
          
          private var waveOneConstant:int;
          
          private var waveTwoTimer:int;
          
          private var waveTwoConstant:int;
          
          private var waveThreeTimer:int;
          
          private var waveThreeConstant:int;
          
          private var waveFourTimer:int;
          
          private var waveFourConstant:int;
          
          private var waveFiveTimer:int;
          
          private var waveFiveConstant:int;
          
          private var waveSixTimer:int;
          
          private var waveSixConstant:int;
          
          private var waveSevenTimer:int;
          
          private var waveSevenConstant:int;
          
          private var ambushEndTimer:int;
          
          private var ambushEndConstant:int;
          
          private var frames:int;
          
          private var RandomAnimation:int;
          
          private var comment:String = "--------------------";
          
          public function CampaignTutorial(param1:GameScreen)
          {
               this.waveOneTimer = 30 * 30;
               this.waveOneConstant = this.waveOneTimer;
               this.waveTwoTimer = 30 * 90;
               this.waveTwoConstant = this.waveTwoTimer;
               this.waveThreeTimer = 30 * 110;
               this.waveThreeConstant = this.waveThreeTimer;
               this.waveFourTimer = 30 * 130;
               this.waveFourConstant = this.waveFourTimer;
               this.waveFiveTimer = 30 * 150;
               this.waveFiveConstant = this.waveFiveTimer;
               this.waveSixTimer = 30 * 240;
               this.waveSixConstant = this.waveSixTimer;
               this.waveSevenTimer = 30 * 300;
               this.waveSevenConstant = this.waveSevenTimer;
               this.ambushEndTimer = 30 * 480;
               this.ambushEndConstant = this.ambushEndTimer;
               super(param1);
               this.frames = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc6_:int = 0;
               var _loc7_:* = undefined;
               var _loc2_:Unit = null;
               var _loc5_:Unit = null;
               var _loc8_:StickWar = null;
               var _loc9_:MoveCommand = null;
               param1.team.enemyTeam.attack(true);
               if(this.waveOneTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.waveOneTimer;
                         }
                         --this.waveOneTimer;
                    }
               }
               else if(this.waveOneTimer != -10)
               {
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.waveOneTimer = -10;
               }
               if(this.waveTwoTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.waveTwoTimer;
                         }
                         --this.waveTwoTimer;
                    }
               }
               else if(this.waveTwoTimer != -10)
               {
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                    this.AlphaCat.catType = "AlphaCat";
                    this.waveTwoTimer = -10;
               }
               if(this.waveThreeTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.waveThreeTimer;
                         }
                         --this.waveThreeTimer;
                    }
               }
               else if(this.waveThreeTimer != -10)
               {
                    this.PackLeader = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.PackLeader,param1.game);
                    this.PackLeader.catType = "PackLeader";
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
                    this.waveThreeTimer = -10;
               }
               if(this.waveFourTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.waveFourTimer;
                         }
                         --this.waveFourTimer;
                    }
               }
               else if(this.waveFourTimer != -10)
               {
                    this.GiantCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.GiantCat,param1.game);
                    this.GiantCat.catType = "GiantCat";
                    _loc8_ = param1.game;
                    _loc9_ = new MoveCommand(_loc8_);
                    _loc9_.realX = _loc9_.goalX = this.GiantCat.px;
                    this.GiantCat.ai.mayAttack = true;
                    this.GiantCat.ai.mayMoveToAttack = true;
                    this.GiantCat.ai.setCommand(_loc8_,_loc9_);
                    this.waveFourTimer = -10;
               }
               if(this.waveFiveTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.waveFiveTimer;
                         }
                         --this.waveFiveTimer;
                    }
               }
               else if(this.waveFiveTimer != -10)
               {
                    this.GiantCat_2 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.GiantCat_2,param1.game);
                    this.GiantCat_2.catType = "GiantCat_2";
                    this.waveFiveTimer = -10;
               }
               if(this.waveSixTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.waveSixTimer;
                         }
                         --this.waveSixTimer;
                    }
               }
               else if(this.waveSixTimer != -10)
               {
                    this.waveSixTimer = -10;
               }
               if(this.waveSevenTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.waveSevenTimer;
                         }
                         --this.waveSevenTimer;
                    }
               }
               else if(this.waveSevenTimer != -10)
               {
                    this.waveSevenTimer = -10;
               }
               if(this.ambushEndTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.ambushEndTimer;
                         }
                         --this.ambushEndTimer;
                    }
               }
               else if(this.ambushEndTimer != -10)
               {
                    param1.team.enemyTeam.statue.health = 0;
                    this.ambushEndTimer = -10;
               }
               if(!this.nah)
               {
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
                    _loc2_ = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.spawn(_loc2_,param1.game);
                    param1.game.fogOfWar.isFogOn = false;
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
                    this.Cat_1 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(this.Cat_1,param1.game);
                    this.Cat_1.catType = "Cat_1";
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
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.nah = true;
               }
               for each(_loc5_ in param1.team.enemyTeam.unitGroups[Unit.U_CHAOS_MINER])
               {
                    param1.team.enemyTeam.removeUnitCompletely(_loc5_,param1.game);
               }
               if(param1.game.frame % (30 * 5) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.waveOneTimer < 0)
               {
                    if(param1.game.frame % (30 * 32) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                              this.AlphaCat.catType = "AlphaCat";
                              this.AlphaCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.AlphaCat,param1.game);
                              this.AlphaCat.catType = "AlphaCat";
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
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.waveTwoTimer < 0)
               {
                    if(param1.game.frame % (30 * 160) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.waveThreeTimer < 0)
               {
                    if(this.PackLeader.isDead)
                    {
                         if(param1.game.frame % (30 * 10) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.PackLeader = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                                   param1.team.enemyTeam.spawn(this.PackLeader,param1.game);
                                   this.PackLeader.catType = "PackLeader";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.waveFourTimer < 0)
               {
                    if(param1.game.frame % (30 * 30) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.GiantCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat,param1.game);
                              this.GiantCat.catType = "GiantCat";
                              this.GiantCat.px = 2200;
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.waveFiveTimer < 0)
               {
                    if(param1.game.frame % (30 * 34) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.GiantCat_2 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat_2,param1.game);
                              this.GiantCat_2.catType = "GiantCat_2";
                              this.GiantCat_2 = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat_2,param1.game);
                              this.GiantCat_2.catType = "GiantCat_2";
                              this.GiantCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat,param1.game);
                              this.GiantCat.catType = "GiantCat";
                              this.GiantCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat,param1.game);
                              this.GiantCat.catType = "GiantCat";
                              this.GiantCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat,param1.game);
                              this.GiantCat.catType = "GiantCat";
                              this.GiantCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat,param1.game);
                              this.GiantCat.catType = "GiantCat";
                              this.GiantCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat,param1.game);
                              this.GiantCat.catType = "GiantCat";
                              this.GiantCat = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                              param1.team.enemyTeam.spawn(this.GiantCat,param1.game);
                              this.GiantCat.catType = "GiantCat";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.waveFourTimer < 0)
               {
                    if(param1.game.frame % (30 * 30) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.VoltSword,param1.game);
                              this.VoltSword.swordwrathType = "VoltSword";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.waveFiveTimer < 0)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.waveFiveTimer < 0)
               {
                    if(param1.game.frame % (30 * 40) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.VoltArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.VoltArcher,param1.game);
                              this.VoltArcher.archerType = "VoltArcher";
                              this.VoltArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.VoltArcher,param1.game);
                              this.VoltArcher.archerType = "VoltArcher";
                              this.VoltArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.VoltArcher,param1.game);
                              this.VoltArcher.archerType = "VoltArcher";
                              this.VoltArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.VoltArcher,param1.game);
                              this.VoltArcher.archerType = "VoltArcher";
                              this.VoltArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.VoltArcher,param1.game);
                              this.VoltArcher.archerType = "VoltArcher";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.team.statue.health <= 500 && param1.team.statue.maxHealth != 16200)
               {
                    param1.team.statue.health += 14000;
                    param1.team.statue.maxHealth = 16200;
                    param1.team.statue.healthBar.totalHealth = param1.team.statue.maxHealth;
                    param1.team.gold += 200;
                    param1.team.mana += 400;
                    this.Magis = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.spawn(this.Magis,param1.game);
                    this.Magis.magikillType = "Magis";
                    this.Magis.px = 1100;
                    this.frames = 0;
               }
          }
     }
}
