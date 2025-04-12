package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.Ai.RangedAi;
     import com.brockw.stickwar.engine.Ai.command.MoveCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.EnslavedGiant;
     import com.brockw.stickwar.engine.units.FlyingCrossbowman;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Miner;
     import com.brockw.stickwar.engine.units.Ninja;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     import com.brockw.stickwar.engine.units.elementals.ChromeElement;
     import com.brockw.stickwar.engine.units.elementals.FireElement;
     import com.brockw.stickwar.engine.units.elementals.LavaElement;
     
     public class CampaignDeads extends CampaignController
     {
          
          private static const MIN_NUM_BOMBERS:int = 2;
          
          public static const MAX_NUM_BOMBERS:int = 10;
          
          private static const FREQUENCY_SPAWN:int = 45;
          
          private static const FREQUENCY_INCREASE:int = 60;
          
          private static const S_TEST:int = 0;
          
          private static const S_TEST_1:int = 1;
          
          private static const S_TEST_2:int = 2;
          
          private static const S_TEST_3:int = 3;
          
          private static const S_TEST_4:int = 4;
          
          private static const S_TEST_5:int = 5;
           
          
          private var numToSpawn:int = 0;
          
          private var chromeElement:ChromeElement;
          
          private var VoltArcher:Archer;
          
          private var Sicklebear:Swordwrath;
          
          private var Wrathnar:Swordwrath;
          
          private var Lava:Spearton;
          
          private var Just_K:Swordwrath;
          
          private var Magis:Magikill;
          
          private var FireSword:Swordwrath;
          
          private var VoltSword:Swordwrath;
          
          private var VoltSword_2:Swordwrath;
          
          private var GoldSword:Swordwrath;
          
          private var Voltaic_CA:Archer;
          
          private var Blazing:FlyingCrossbowman;
          
          private var VoltMage:Magikill;
          
          private var VoltNinja:Ninja;
          
          private var VoltMiner:Miner;
          
          private var SickleSpear:Spearton;
          
          private var Xiphos:Swordwrath;
          
          private var SW1_Native:Spearton;
          
          private var Archis:Archer;
          
          private var SW1_Spear_1:Spearton;
          
          private var SW1_Spear_2:Spearton;
          
          private var FireArcher:Archer;
          
          private var FireNinja:Ninja;
          
          private var FireMage:Magikill;
          
          private var Frost_1:Archer;
          
          private var statue:Statue;
          
          private var MeleeDead:Dead;
          
          private var GoldenArcher:Archer;
          
          private var stunBomber:Bomber;
          
          private var fireElement:FireElement;
          
          private var lavaElement:LavaElement;
          
          private var GoldenSpear:Spearton;
          
          private var deadTargeter:Bomber;
          
          private var Archer_1:Archer;
          
          private var VoltSpear:Spearton;
          
          private var Archer_2:Archer;
          
          private var Spear_2:Spearton;
          
          private var Leader_2:Knight;
          
          private var EliteKnight:Knight;
          
          private var SilverKnight:Knight;
          
          private var Silver:Spearton;
          
          private var archer:Archer;
          
          private var StatueArcher:Archer;
          
          private var Clone_5:Archer;
          
          private var Leaf:Spearton;
          
          private var Leaf_2:Spearton;
          
          private var LeafNinja:Ninja;
          
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
          
          private var spawnedDeadTargeter:Boolean = false;
          
          private var E_LavaGiant:EnslavedGiant;
          
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
          
          private var state:int;
          
          private var RandomAnimation:int;
          
          private var comment:String = "--------------------";
          
          public function CampaignDeads(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 80;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 265;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 300;
               this.sevenMinConstant = this.sevenMinTimer;
               this.tenMinTimer = 30 * 500;
               this.tenMinConstant = this.tenMinTimer;
               super(param1);
               this.state = S_TEST;
               this.numToSpawn = MIN_NUM_BOMBERS;
               this.deadTargeter = null;
               this.frames = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc3_:Archer = null;
               var _loc4_:MoveCommand = null;
               var _loc6_:int = 0;
               var _loc7_:* = undefined;
               var _loc8_:StickWar = null;
               var deadTargeter:Dead = null;
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
                    this.LeafMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.enemyTeam.spawn(this.LeafMage,param1.game);
                    this.LeafMage.magikillType = "LeafMage";
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
                    this.Voltaic_CA = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.spawn(this.Voltaic_CA,param1.game);
                    this.Voltaic_CA.archerType = "Voltaic_CA";
                    this.Archis = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Archis,param1.game);
                    this.Archis.archerType = "Archis";
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
                    this.Magis = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.spawn(this.Magis,param1.game);
                    this.Magis.magikillType = "Magis";
                    this.tenMinTimer = -10;
               }
               if(!this.nah)
               {
                    this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.spawn(this.VoltSword,param1.game);
                    this.VoltSword.swordwrathType = "VoltSword";
                    this.VoltArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.spawn(this.VoltArcher,param1.game);
                    this.VoltArcher.archerType = "VoltArcher";
                    param1.team.gold = 520;
                    this.nah = true;
               }
               if(this.state == S_TEST)
               {
                    this.state = S_TEST_1;
               }
               else if(this.state == S_TEST_1)
               {
               }
               for each(_loc3_ in param1.team.unitGroups[Unit.U_ARCHER])
               {
                    RangedAi(_loc3_.ai).mayKite = false;
               }
               if(!this.spawnedDeadTargeter)
               {
                    this.spawnedDeadTargeter = true;
               }
               if(this.sevenMinTimer < 0)
               {
                    if(this.Archis.isDead)
                    {
                         if(param1.game.frame % (30 * 150) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.Archis = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                                   param1.team.enemyTeam.spawn(this.Archis,param1.game);
                                   this.Archis.archerType = "Archis";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(this.Voltaic_CA.isDead)
                    {
                         if(param1.game.frame % (30 * 230) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.Voltaic_CA = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                                   param1.team.spawn(this.Voltaic_CA,param1.game);
                                   this.Voltaic_CA.archerType = "Voltaic_CA";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(param1.game.frame % (30 * 36) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,2);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.VoltSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.spawn(this.VoltSword,param1.game);
                         this.VoltSword.swordwrathType = "VoltSword";
                         param1.team.gold -= 50;
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
                         this.VoltArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.spawn(this.VoltArcher,param1.game);
                         this.VoltArcher.archerType = "VoltArcher";
                         param1.team.gold -= 120;
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 83) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.VoltSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.VoltSpear,param1.game);
                              this.VoltSpear.speartonType = "VoltSpear";
                              param1.team.gold -= 220;
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 68) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.VoltNinja = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.spawn(this.VoltNinja,param1.game);
                              this.VoltNinja.ninjaType = "VoltNinja";
                              param1.team.gold -= 160;
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 21) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.LeafSword_2 = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(this.LeafSword_2,param1.game);
                         this.LeafSword_2.swordwrathType = "LeafSword_2";
                         this.LeafSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(this.LeafSword,param1.game);
                         this.LeafSword.swordwrathType = "LeafSword";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 240) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.LeafSwordPrince = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.LeafSwordPrince,param1.game);
                              this.LeafSwordPrince.swordwrathType = "LeafSwordPrince";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 45) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,2);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.LeafArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.LeafArcher,param1.game);
                         this.LeafArcher.archerType = "LeafArcher";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 70) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.LeafArcher_2 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.LeafArcher_2,param1.game);
                         this.LeafArcher_2.archerType = "LeafArcher_2";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 71) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,2);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Leaf = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Leaf,param1.game);
                              this.Leaf.speartonType = "Leaf";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 153) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Leaf_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Leaf_2,param1.game);
                              this.Leaf_2.speartonType = "Leaf_2";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 68) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.LeafNinja = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.enemyTeam.spawn(this.LeafNinja,param1.game);
                              this.LeafNinja.ninjaType = "LeafNinja";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 170) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.LeafMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(this.LeafMage,param1.game);
                              this.LeafMage.magikillType = "LeafMage";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 300) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.VoltMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.spawn(this.VoltMage,param1.game);
                              this.VoltMage.magikillType = "VoltMage";
                              param1.team.gold -= 300;
                              param1.team.mana -= 300;
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 80) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,3);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 215) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,2);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 120) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,2);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 250) == 0)
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
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 115) == 0)
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
               if(param1.game.frame % (30 * 20) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,3);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 80) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,2);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 80) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,2);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 110) == 0)
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
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 185) == 0)
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
          }
     }
}
