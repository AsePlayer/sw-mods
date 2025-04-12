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
     import com.brockw.stickwar.engine.units.Monk;
     import com.brockw.stickwar.engine.units.Skelator;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     
     public class CampaignBomber extends CampaignController
     {
           
          
          private var FastMonk:Monk;
          
          private var TankyMonk:Monk;
          
          private var BossMonk:Monk;
          
          private var Monk_1:Monk;
          
          private var Monk_2:Monk;
          
          private var Boss_2:Spearton;
          
          private var HighHealMonk:Monk;
          
          private var MegaMarrow:Skelator;
          
          private var statue:Statue;
          
          private var archer:Archer;
          
          private var knight:Knight;
          
          private var giant:Giant;
          
          private var wingidon:Wingidon;
          
          private var magikill:Magikill;
          
          private var cat:Cat;
          
          private var AlphaCat:Cat;
          
          private var HeavySpear:Spearton;
          
          private var Spearos:Spearton;
          
          private var PackLeader:Cat;
          
          private var nah:Boolean = false;
          
          private var DeadBoss:Dead;
          
          private var GoldMage:Magikill;
          
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
          
          private var Dark:Spearton;
          
          private var Undead:Spearton;
          
          private var Xiphos:Swordwrath;
          
          private var Xiphos_2:Swordwrath;
          
          private var Wrathnar:Swordwrath;
          
          private var Wrathnar_2:Swordwrath;
          
          private var Leader:Knight;
          
          private var DarkKytchu:Archer;
          
          private var Clone_6:Archer;
          
          private var Lava:Spearton;
          
          private var Clone_3:Archer;
          
          private var Clone_4:Archer;
          
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
          
          private var Xenophon:Swordwrath;
          
          private var tenMinConstant:int;
          
          private var frames:int;
          
          private var comment:String = "--------------------";
          
          public function CampaignBomber(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 180;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 225;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 330;
               this.sevenMinConstant = this.sevenMinTimer;
               this.tenMinTimer = 30 * 600;
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
                    this.HeavySpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.HeavySpear,param1.game);
                    this.HeavySpear.speartonType = "HeavySpear";
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
                    this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                    this.Boss_2.speartonType = "Boss_2";
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
                    this.GoldMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.enemyTeam.spawn(this.GoldMage,param1.game);
                    this.GoldMage.magikillType = "GoldMage";
                    this.tenMinTimer = -10;
               }
               if(!this.nah)
               {
                    this.HeavySpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.HeavySpear,param1.game);
                    this.HeavySpear.speartonType = "HeavySpear";
                    this.nah = true;
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 245) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.HeavySpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.HeavySpear,param1.game);
                              this.HeavySpear.speartonType = "HeavySpear";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.tenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 385) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.GoldMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(this.GoldMage,param1.game);
                              this.GoldMage.magikillType = "GoldMage";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 285) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                              this.Boss_2.speartonType = "Boss_2";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 41) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.Clone_3 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.spawn(this.Clone_3,param1.game);
                         this.Clone_3.archerType = "Clone_3";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 13) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.Clone_4 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.Clone_4,param1.game);
                         this.Clone_4.archerType = "Clone_4";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 33) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.spearton = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.enemyTeam.spawn(this.spearton,param1.game);
                         _loc7_++;
                    }
                    ++this.spawnNumber;
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
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 22500)
               {
                    param1.team.enemyTeam.statue.health += 19700;
                    param1.team.enemyTeam.statue.maxHealth = 22500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 5000;
                    param1.team.enemyTeam.mana += 2000;
                    this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                    this.Boss_2.speartonType = "Boss_2";
                    this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                    this.Boss_2.speartonType = "Boss_2";
                    this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                    this.Boss_2.speartonType = "Boss_2";
                    this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                    this.Boss_2.speartonType = "Boss_2";
                    this.frames = 0;
               }
          }
     }
}
