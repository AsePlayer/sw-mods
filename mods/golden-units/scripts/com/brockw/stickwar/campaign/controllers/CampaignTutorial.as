package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Medusa;
     import com.brockw.stickwar.engine.units.Skelator;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     
     public class CampaignTutorial extends CampaignController
     {
           
          
          private var MegaMarrow:Skelator;
          
          private var statue:Statue;
          
          private var archer:Archer;
          
          private var knight:Knight;
          
          private var giant:Giant;
          
          private var wingidon:Wingidon;
          
          private var magikill:Magikill;
          
          private var cat:Cat;
          
          private var AlphaCat:Cat;
          
          private var PackLeader:Cat;
          
          private var nah:Boolean = false;
          
          private var DeadBoss:Dead;
          
          private var Bone_1:Skelator;
          
          private var MedusaClone:Medusa;
          
          private var SecondCommand:Knight;
          
          private var SpearDeadBoss:Dead;
          
          private var FireKnight:Knight;
          
          private var VampKnight:Knight;
          
          private var SpeedDead:Dead;
          
          private var electricBomber:Bomber;
          
          private var poisonBomber:Bomber;
          
          private var stunBomber:Bomber;
          
          private var SuperWing_1:Wingidon;
          
          private var SuperWing_3:Wingidon;
          
          private var SuperWing_4:Wingidon;
          
          private var FireArcher_2:Archer;
          
          private var spearton:Spearton;
          
          private var Undead:Spearton;
          
          private var Leader:Knight;
          
          private var DarkKytchu:Archer;
          
          private var Clone_6:Archer;
          
          private var Lava:Spearton;
          
          private var Clone_5:Archer;
          
          private var GoldenArcher:Archer;
          
          private var spawnNumber:int;
          
          private var DarkSpear:Spearton;
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var StatueArcher:Archer;
          
          private var tenMinConstant:int;
          
          private var frames:int;
          
          private var comment:String = "--------------------";
          
          public function CampaignTutorial(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 120;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 285;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 390;
               this.sevenMinConstant = this.sevenMinTimer;
               this.tenMinTimer = 30 * 400;
               this.tenMinConstant = this.tenMinTimer;
               super(param1);
               this.frames = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc6_:int = 0;
               var _loc7_:* = undefined;
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
                    this.knight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.knight,param1.game);
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
                    this.Spearos = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Spearos,param1.game);
                    this.Spearos.speartonType = "Spearos";
                    this.SuperWing_1 = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.SuperWing_1,param1.game);
                    this.SuperWing_1.wingidonType = "SuperWing_1";
                    this.VampKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.VampKnight,param1.game);
                    this.VampKnight.knightType = "VampKnight";
                    this.twoMinTimer = -10;
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
                    this.Spearos_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Spearos_2,param1.game);
                    this.Spearos_2.speartonType = "Spearos_2";
                    this.sevenMinTimer = -10;
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
                    this.tenMinTimer = -10;
               }
               if(!this.nah)
               {
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.FireArcher_2 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.FireArcher_2,param1.game);
                    this.FireArcher_2.archerType = "FireArcher_2";
                    this.SuperWing_1 = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.SuperWing_1,param1.game);
                    this.SuperWing_1.wingidonType = "SuperWing_1";
                    this.nah = true;
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 130) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.knight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                              param1.team.enemyTeam.spawn(this.knight,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 150) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.SuperWing_4 = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(this.SuperWing_4,param1.game);
                         this.SuperWing_4.wingidonType = "SuperWing_4";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 250) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.FireArcher_2 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.FireArcher_2,param1.game);
                         this.FireArcher_2.archerType = "FireArcher_2";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 140) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Spearos = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Spearos,param1.game);
                              this.Spearos.speartonType = "Spearos";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 170) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Spearos_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Spearos_2,param1.game);
                              this.Spearos_2.speartonType = "Spearos_2";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.team.statue.health <= 1000 && param1.team.statue.maxHealth != 45500)
               {
                    param1.team.statue.health += 40500;
                    param1.team.statue.maxHealth = 45500;
                    param1.team.statue.healthBar.totalHealth = param1.team.statue.maxHealth;
                    param1.team.gold += 1000;
                    param1.team.mana += 1000;
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 31500)
               {
                    param1.team.enemyTeam.statue.health += 29700;
                    param1.team.enemyTeam.statue.maxHealth = 31500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 2000;
                    param1.team.enemyTeam.mana += 2000;
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.Clone_6 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Clone_6,param1.game);
                    this.Clone_6.archerType = "Clone_6";
                    this.frames = 0;
               }
          }
     }
}
