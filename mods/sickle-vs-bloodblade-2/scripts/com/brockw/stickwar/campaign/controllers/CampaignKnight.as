package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.FlyingCrossbowman;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Medusa;
     import com.brockw.stickwar.engine.units.Miner;
     import com.brockw.stickwar.engine.units.Monk;
     import com.brockw.stickwar.engine.units.Ninja;
     import com.brockw.stickwar.engine.units.Skelator;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     import com.brockw.stickwar.engine.units.elementals.FireElement;
     import com.brockw.stickwar.engine.units.elementals.WaterElement;
     
     public class CampaignKnight extends CampaignController
     {
           
          
          private var StatueFire:FireElement;
          
          private var CrystalArcher:Archer;
          
          private var CrystalSpear:Spearton;
          
          private var CrystalNinja:Ninja;
          
          private var CrystalWing:Wingidon;
          
          private var CrystalMage:Magikill;
          
          private var CrystalMarrow:Skelator;
          
          private var cat:Cat;
          
          private var bomber:Bomber;
          
          private var Fire_1:FireElement;
          
          private var MegaKnight:Knight;
          
          private var MegaKnight_2:Knight;
          
          private var MegaKnight_3:Knight;
          
          private var Test_1:WaterElement;
          
          private var FireKnight:Knight;
          
          private var VampMage:Magikill;
          
          private var VampKnight:Knight;
          
          private var Barin:Spearton;
          
          private var Undead_2:Spearton;
          
          private var SuperNinja_2:Ninja;
          
          private var LavaPrince:Spearton;
          
          private var Heavy:Archer;
          
          private var LeafArcher:Archer;
          
          private var CrystalSword:Swordwrath;
          
          private var Crystalsickle:Swordwrath;
          
          private var ChaosArcher:Archer;
          
          private var IceSword:Swordwrath;
          
          private var Thera:Monk;
          
          private var Kai:Skelator;
          
          private var FastMonk:Monk;
          
          private var Super_3:Spearton;
          
          private var Ultra_2:Spearton;
          
          private var Mega_2:Spearton;
          
          private var Spear_4:Spearton;
          
          private var SW3Atreyos:Spearton;
          
          private var SWLAtreyos:Spearton;
          
          private var Stone:Spearton;
          
          private var Leaf:Spearton;
          
          private var VampSword:Swordwrath;
          
          private var TankyMonk:Monk;
          
          private var BossMonk:Monk;
          
          private var Monk_1:Monk;
          
          private var StatueDead:Dead;
          
          private var Monk_2:Monk;
          
          private var HighHealMonk:Monk;
          
          private var statue:Statue;
          
          private var PackLeader:Cat;
          
          private var archer:Archer;
          
          private var knight:Knight;
          
          private var DemonKnight:Knight;
          
          private var DemonKnight_2:Knight;
          
          private var Frost_1:Archer;
          
          private var CrystalKnight:Knight;
          
          private var giant:Giant;
          
          private var LavaGiant:Giant;
          
          private var UndeadGiant:Giant;
          
          private var Griffin:Giant;
          
          private var wingidon:Wingidon;
          
          private var magikill:Magikill;
          
          private var SW1Mage:Magikill;
          
          private var nah:Boolean = false;
          
          private var Clone_5:Archer;
          
          private var Adicai:Spearton;
          
          private var Native_2:Archer;
          
          private var Toxic:Dead;
          
          private var DeadBoss:Dead;
          
          private var Bone_1:Skelator;
          
          private var StoneArcher:Archer;
          
          private var MedusaClone:Medusa;
          
          private var SickleSpear:Spearton;
          
          private var BloodSpear:Spearton;
          
          private var SpearDeadBoss:Dead;
          
          private var GoldenSpear_3:Spearton;
          
          private var EliteSpear:Spearton;
          
          private var SpeedDead:Dead;
          
          private var electricBomber:Bomber;
          
          private var poisonBomber:Bomber;
          
          private var stunBomber:Bomber;
          
          private var BuffSpear:Spearton;
          
          private var BuffSpear_3:Spearton;
          
          private var Speedy:Spearton;
          
          private var HeavySpear:Spearton;
          
          private var Master:Spearton;
          
          private var Mega:Spearton;
          
          private var Dark:Spearton;
          
          private var Light:Spearton;
          
          private var Silver:Spearton;
          
          private var Clone_6:Archer;
          
          private var s07:Spearton;
          
          private var Ultra:Spearton;
          
          private var Super:Spearton;
          
          private var Giga:Spearton;
          
          private var BuffSpear_2:Spearton;
          
          private var Blazing:FlyingCrossbowman;
          
          private var flyingCrossbowman:FlyingCrossbowman;
          
          private var SuperWing_1:Wingidon;
          
          private var SuperWing_2:Wingidon;
          
          private var SuperWing_4:Wingidon;
          
          private var Elite:Spearton;
          
          private var Atreyos:Spearton;
          
          private var SplashKytchu:Archer;
          
          private var Atreyos_2:Spearton;
          
          private var spearton:Spearton;
          
          private var GoldSword:Swordwrath;
          
          private var GoldSword_2:Swordwrath;
          
          private var FireMage:Magikill;
          
          private var IceMage:Magikill;
          
          private var Spearos:Spearton;
          
          private var Spearos_2:Spearton;
          
          private var Vamp:Spearton;
          
          private var FireSword:Swordwrath;
          
          private var MillionHP:Spearton;
          
          private var FireArcher:Archer;
          
          private var FireArcher_2:Archer;
          
          private var Undead:Spearton;
          
          private var Xiphos:Swordwrath;
          
          private var Wrathnar:Swordwrath;
          
          private var Leader:Knight;
          
          private var GoldenArcher:Archer;
          
          private var Kytchu:Archer;
          
          private var Kytchu_2:Archer;
          
          private var SavageMage:Magikill;
          
          private var DarkKytchu:Archer;
          
          private var Sicklewrath:Swordwrath;
          
          private var SickleGeneral:Swordwrath;
          
          private var SickleLeader:Swordwrath;
          
          private var Leafsickle:Swordwrath;
          
          private var Icesickle:Swordwrath;
          
          private var Savagesickle:Swordwrath;
          
          private var Lavasickle:Swordwrath;
          
          private var Vampsickle:Swordwrath;
          
          private var Xenophon:Swordwrath;
          
          private var BloodBlade:Swordwrath;
          
          private var Baron:Swordwrath;
          
          private var Boss_1:Spearton;
          
          private var Boss_2:Spearton;
          
          private var Lava:Spearton;
          
          private var spawnNumber:int;
          
          private var VampArcher:Archer;
          
          private var GoldenSpear:Spearton;
          
          private var GoldenSpear_2:Spearton;
          
          private var SuperNinja:Ninja;
          
          private var Lavish:Miner;
          
          private var DarkSpear:Spearton;
          
          private var LeafMage:Magikill;
          
          private var StatueArcher:Archer;
          
          private var Miner_1:Miner;
          
          private var Miner_2:Miner;
          
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
          
          public function CampaignKnight(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 120;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 150;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 310;
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
                    this.BloodSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.BloodSpear,param1.game);
                    this.BloodSpear.speartonType = "BloodSpear";
                    this.SickleSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.SickleSpear,param1.game);
                    this.SickleSpear.speartonType = "SickleSpear";
                    this.SickleGeneral = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.SickleGeneral,param1.game);
                    this.SickleGeneral.swordwrathType = "SickleGeneral";
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
                    this.Baron = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.spawn(this.Baron,param1.game);
                    this.Baron.swordwrathType = "Baron";
                    this.SickleLeader = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.SickleLeader,param1.game);
                    this.SickleLeader.swordwrathType = "SickleLeader";
                    this.nah = true;
               }
               if(this.SickleLeader.isDead)
               {
                    if(param1.game.frame % (30 * 170) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.SickleLeader = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.SickleLeader,param1.game);
                              this.SickleLeader.swordwrathType = "SickleLeader";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(this.SickleGeneral.isDead)
                    {
                         if(param1.game.frame % (30 * 170) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.SickleGeneral = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                                   param1.team.enemyTeam.spawn(this.SickleGeneral,param1.game);
                                   this.SickleGeneral.swordwrathType = "SickleGeneral";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.Baron.isDead)
               {
                    if(param1.game.frame % (30 * 170) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Baron = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.Baron,param1.game);
                              this.Baron.swordwrathType = "Baron";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 85) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.BloodSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.BloodSpear,param1.game);
                              this.BloodSpear.speartonType = "BloodSpear";
                              this.SickleSpear = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.SickleSpear,param1.game);
                              this.SickleSpear.speartonType = "SickleSpear";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 135) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 45) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.Sicklewrath = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(this.Sicklewrath,param1.game);
                         this.Sicklewrath.swordwrathType = "Sicklewrath";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 110) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Leafsickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Leafsickle,param1.game);
                              this.Leafsickle.swordwrathType = "Leafsickle";
                              this.Crystalsickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Crystalsickle,param1.game);
                              this.Crystalsickle.swordwrathType = "Crystalsickle";
                              this.Icesickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Icesickle,param1.game);
                              this.Icesickle.swordwrathType = "Icesickle";
                              this.Savagesickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Savagesickle,param1.game);
                              this.Savagesickle.swordwrathType = "Savagesickle";
                              this.Lavasickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Lavasickle,param1.game);
                              this.Lavasickle.swordwrathType = "Lavasickle";
                              this.Vampsickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Vampsickle,param1.game);
                              this.Vampsickle.swordwrathType = "Vampsickle";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 45) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.spawn(this.BloodBlade,param1.game);
                         this.BloodBlade.swordwrathType = "BloodBlade";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 70) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 70) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Sicklewrath = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Sicklewrath,param1.game);
                              this.Sicklewrath.swordwrathType = "Sicklewrath";
                              this.Sicklewrath = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Sicklewrath,param1.game);
                              this.Sicklewrath.swordwrathType = "Sicklewrath";
                              this.Sicklewrath = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Sicklewrath,param1.game);
                              this.Sicklewrath.swordwrathType = "Sicklewrath";
                              this.Sicklewrath = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Sicklewrath,param1.game);
                              this.Sicklewrath.swordwrathType = "Sicklewrath";
                              this.Sicklewrath = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Sicklewrath,param1.game);
                              this.Sicklewrath.swordwrathType = "Sicklewrath";
                              this.Sicklewrath = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Sicklewrath,param1.game);
                              this.Sicklewrath.swordwrathType = "Sicklewrath";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 93) == 0)
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
               if(this.tenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 275) == 0)
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
               if(param1.game.frame % (30 * 63) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 120) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 165) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 90) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 190) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 35) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 220) == 0)
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
               if(param1.game.frame % (30 * 120) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.team.statue.health <= 1000 && param1.team.statue.maxHealth != 39500)
               {
                    param1.team.statue.health += 38500;
                    param1.team.statue.maxHealth = 39500;
                    param1.team.statue.healthBar.totalHealth = param1.team.statue.maxHealth;
                    param1.team.gold += 500;
                    param1.team.mana += 500;
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 11500)
               {
                    param1.team.enemyTeam.statue.health += 10700;
                    param1.team.enemyTeam.statue.maxHealth = 11500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 5000;
                    param1.team.enemyTeam.mana += 5000;
                    this.frames = 0;
               }
          }
     }
}
