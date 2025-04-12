package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     
     public class CampaignDeads extends CampaignController
     {
           
          
          private var statue:Statue;
          
          private var archer:Archer;
          
          private var StatueArcher:Archer;
          
          private var Clone_5:Archer;
          
          private var Leaf:Spearton;
          
          private var Leaf_2:Spearton;
          
          private var LeafPrince:Spearton;
          
          private var LeafSword:Swordwrath;
          
          private var LeafSword_2:Swordwrath;
          
          private var LeafSwordPrince:Swordwrath;
          
          private var LeafArcher:Archer;
          
          private var IceMage:Magikill;
          
          private var LeafMage:Magikill;
          
          private var LeafArcher_2:Archer;
          
          private var magikill:Magikill;
          
          private var nah:Boolean = false;
          
          private var Ice:Spearton;
          
          private var Atreyos:Spearton;
          
          private var spearton:Spearton;
          
          private var Spearos:Spearton;
          
          private var Spearos_2:Spearton;
          
          private var SpikeSword:Swordwrath;
          
          private var Clubwrath:Swordwrath;
          
          private var SpearDeadBoss:Dead;
          
          private var giant:Giant;
          
          private var dead:Dead;
          
          private var wingidon:Wingidon;
          
          private var SuperWing_2:Wingidon;
          
          private var HeavySpear:Spearton;
          
          private var Boss_1:Spearton;
          
          private var Boss_2:Spearton;
          
          private var spawnNumber:int;
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var tenMinConstant:int;
          
          private var frames:int;
          
          private var RandomAnimation:int;
          
          private var comment:String = "--------------------";
          
          public function CampaignDeads(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 210;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 185;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 230;
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
                    this.Leaf_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Leaf_2,param1.game);
                    this.Leaf_2.speartonType = "Leaf_2";
                    param1.team.gold += 350;
                    this.Leaf = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Leaf,param1.game);
                    this.Leaf.speartonType = "Leaf";
                    param1.team.enemyTeam.gold += 400;
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
                    this.LeafMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.enemyTeam.spawn(this.LeafMage,param1.game);
                    this.LeafMage.magikillType = "LeafMage";
                    param1.team.enemyTeam.gold += 1000;
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
                    this.nah = true;
               }
               if(param1.game.frame % (30 * 30) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.LeafSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(this.LeafSword,param1.game);
                         this.LeafSword.swordwrathType = "LeafSword";
                         param1.team.enemyTeam.gold += 170;
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 40) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.LeafSword_2 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.spawn(this.LeafSword_2,param1.game);
                         this.LeafSword_2.swordwrathType = "LeafSword_2";
                         param1.team.gold += 100;
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 75) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.LeafArcher_2 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.spawn(this.LeafArcher_2,param1.game);
                         this.LeafArcher_2.archerType = "LeafArcher_2";
                         param1.team.gold += 150;
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 26) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.LeafArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.LeafArcher,param1.game);
                         this.LeafArcher.archerType = "LeafArcher";
                         this.LeafArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.LeafArcher,param1.game);
                         this.LeafArcher.archerType = "LeafArcher";
                         this.LeafArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.LeafArcher,param1.game);
                         this.LeafArcher.archerType = "LeafArcher";
                         param1.team.enemyTeam.gold += 145;
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 62) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Leaf = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Leaf,param1.game);
                              this.Leaf.speartonType = "Leaf";
                              this.Leaf = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Leaf,param1.game);
                              this.Leaf.speartonType = "Leaf";
                              param1.team.enemyTeam.gold += 175;
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 95) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Leaf_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.Leaf_2,param1.game);
                              this.Leaf_2.speartonType = "Leaf_2";
                              param1.team.gold += 150;
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 185) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.LeafMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(this.LeafMage,param1.game);
                              this.LeafMage.magikillType = "LeafMage";
                              param1.team.enemyTeam.gold += 1000;
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.team.statue.health <= 1000 && param1.team.statue.maxHealth != 35500)
               {
                    param1.team.statue.health += 30500;
                    param1.team.statue.maxHealth = 35500;
                    param1.team.statue.healthBar.totalHealth = param1.team.statue.maxHealth;
                    param1.team.gold += 500;
                    param1.team.mana += 500;
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 21500)
               {
                    param1.team.enemyTeam.statue.health += 19700;
                    param1.team.enemyTeam.statue.maxHealth = 21500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 25000;
                    param1.team.enemyTeam.mana += 5000;
                    this.LeafSwordPrince = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.LeafSwordPrince,param1.game);
                    this.LeafSwordPrince.swordwrathType = "LeafSwordPrince";
                    this.LeafSwordPrince = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.LeafSwordPrince,param1.game);
                    this.LeafSwordPrince.swordwrathType = "LeafSwordPrince";
                    this.LeafPrince = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.LeafPrince,param1.game);
                    this.LeafPrince.speartonType = "LeafPrince";
                    this.frames = 0;
               }
          }
     }
}
