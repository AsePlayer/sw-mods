package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Bomber;
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
     import com.brockw.stickwar.engine.units.elementals.EarthElement;
     import com.brockw.stickwar.engine.units.elementals.FireElement;
     import com.brockw.stickwar.engine.units.elementals.LavaElement;
     import com.brockw.stickwar.engine.units.elementals.WaterElement;
     
     public class CampaignArcher extends CampaignController
     {
           
          
          private var Charrog_1:LavaElement;
          
          private var StatueFire:FireElement;
          
          private var Fire_1:FireElement;
          
          private var earthElement:EarthElement;
          
          private var Test_1:WaterElement;
          
          private var Earth_1:EarthElement;
          
          private var FireKnight:Knight;
          
          private var SecondCommand:Knight;
          
          private var GoldKnight:Knight;
          
          private var medusa:Medusa;
          
          private var IceKnight:Knight;
          
          private var VampKnight:Knight;
          
          private var IceSword:Swordwrath;
          
          private var Thera:Monk;
          
          private var SW3CA:Archer;
          
          private var SW3CA_2:Archer;
          
          private var SW3CA_3:Archer;
          
          private var SW3CA_4:Archer;
          
          private var FastMonk:Monk;
          
          private var Stone:Spearton;
          
          private var Leaf:Spearton;
          
          private var TankyMonk:Monk;
          
          private var skelator:Skelator;
          
          private var GoldMarrow:Skelator;
          
          private var goldBomber:Bomber;
          
          private var BossMonk:Monk;
          
          private var Monk_1:Monk;
          
          private var Monk_2:Monk;
          
          private var HighHealMonk:Monk;
          
          private var statue:Statue;
          
          private var archer:Archer;
          
          private var ninja:Ninja;
          
          private var LeafSword:Swordwrath;
          
          private var SavageSword:Swordwrath;
          
          private var Kai:Skelator;
          
          private var Savage:Spearton;
          
          private var knight:Knight;
          
          private var giant:Giant;
          
          private var Griffin:Giant;
          
          private var wingidon:Wingidon;
          
          private var magikill:Magikill;
          
          private var SW1Mage:Magikill;
          
          private var SW3Mage:Magikill;
          
          private var GoldMage:Magikill;
          
          private var nah:Boolean = false;
          
          private var Clone_5:Archer;
          
          private var Clone_4:Archer;
          
          private var Native:Archer;
          
          private var Clone_3:Archer;
          
          private var Barin:Spearton;
          
          private var Adicai:Spearton;
          
          private var DeadBoss:Dead;
          
          private var Bone_1:Skelator;
          
          private var StoneArcher:Archer;
          
          private var MedusaClone:Medusa;
          
          private var SpearDeadBoss:Dead;
          
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
          
          private var Native_2:Archer;
          
          private var Clone_6:Archer;
          
          private var SWLAtreyos:Spearton;
          
          private var s07:Spearton;
          
          private var Ultra:Spearton;
          
          private var Super:Spearton;
          
          private var Giga:Spearton;
          
          private var BuffSpear_2:Spearton;
          
          private var Blazing:FlyingCrossbowman;
          
          private var SuperWing_1:Wingidon;
          
          private var SuperWing_2:Wingidon;
          
          private var SuperWing_4:Wingidon;
          
          private var Elite:FlyingCrossbowman;
          
          private var Atreyos:Spearton;
          
          private var spearton:Spearton;
          
          private var GoldSword:Swordwrath;
          
          private var GoldSword_2:Swordwrath;
          
          private var SW1_Sword1:Swordwrath;
          
          private var SW1_Sword2:Swordwrath;
          
          private var FireMage:Magikill;
          
          private var IceMage:Magikill;
          
          private var Spearos:Spearton;
          
          private var Spearos_2:Spearton;
          
          private var OldSpearos:Spearton;
          
          private var NativeSpear:Spearton;
          
          private var NativeSpear_2:Spearton;
          
          private var Minion_2:Swordwrath;
          
          private var Zarek:Magikill;
          
          private var Zarek_2:Magikill;
          
          private var Vamp:Spearton;
          
          private var FireSword:Swordwrath;
          
          private var MillionHP:Spearton;
          
          private var FireArcher:Archer;
          
          private var Frost_1:Archer;
          
          private var dead:Dead;
          
          private var FireArcher_2:Archer;
          
          private var Undead:Spearton;
          
          private var Undead_2:Spearton;
          
          private var Xiphos:Swordwrath;
          
          private var Wrathnar:Swordwrath;
          
          private var Leader:Knight;
          
          private var Leader_2:Knight;
          
          private var GoldenArcher:Archer;
          
          private var Kytchu:Archer;
          
          private var Kytchu_2:Archer;
          
          private var SplashKytchu:Archer;
          
          private var SplashKytchu_2:Archer;
          
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
          
          private var NativeXeno:Swordwrath;
          
          private var NativeXiphos:Swordwrath;
          
          private var BloodBlade:Swordwrath;
          
          private var Baron:Swordwrath;
          
          private var Boss_1:Spearton;
          
          private var Boss_2:Spearton;
          
          private var Lava:Spearton;
          
          private var Ice:Spearton;
          
          private var spawnNumber:int;
          
          private var Hybrid:Spearton;
          
          private var GoldenSpear:Spearton;
          
          private var GoldenSpear_2:Spearton;
          
          private var SuperNinja:Ninja;
          
          private var Lavish:Miner;
          
          private var DarkSpear:Spearton;
          
          private var LeafMage:Magikill;
          
          private var MegaKnight:Knight;
          
          private var StatueArcher:Archer;
          
          private var StatueArcher_2:Archer;
          
          private var Miner_1:Miner;
          
          private var Elite_1:Spearton;
          
          private var Miner_2:Miner;
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var FireNinja:Ninja;
          
          private var tenMinTimer:int;
          
          private var tenMinConstant:int;
          
          private var frames:int;
          
          private var RandomAnimation:int;
          
          private var comment:String = "--------------------";
          
          public function CampaignArcher(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 170;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 200;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 235;
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
                    this.GoldKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.GoldKnight,param1.game);
                    this.GoldKnight.knightType = "GoldKnight";
                    this.GoldenSpear_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.GoldenSpear_2,param1.game);
                    this.GoldenSpear_2.speartonType = "GoldenSpear_2";
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
                    this.medusa = Medusa(param1.game.unitFactory.getUnit(Unit.U_MEDUSA));
                    param1.team.enemyTeam.spawn(this.medusa,param1.game);
                    this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(this.giant,param1.game);
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
                    this.GoldMarrow = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                    param1.team.enemyTeam.spawn(this.GoldMarrow,param1.game);
                    this.GoldMarrow.skelatorType = "GoldMarrow";
                    this.GoldMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.spawn(this.GoldMage,param1.game);
                    this.GoldMage.magikillType = "GoldMage";
                    this.tenMinTimer = -10;
               }
               if(!this.nah)
               {
                    this.nah = true;
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 140) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                              param1.team.enemyTeam.spawn(this.giant,param1.game);
                              this.medusa = Medusa(param1.game.unitFactory.getUnit(Unit.U_MEDUSA));
                              param1.team.enemyTeam.spawn(this.medusa,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 120) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.GoldenSpear_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.GoldenSpear_2,param1.game);
                              this.GoldenSpear_2.speartonType = "GoldenSpear_2";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 120) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.GoldKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                              param1.team.enemyTeam.spawn(this.GoldKnight,param1.game);
                              this.GoldKnight.knightType = "GoldKnight";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.tenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 300) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.GoldMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.spawn(this.GoldMage,param1.game);
                              this.GoldMage.magikillType = "GoldMage";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 115) == 0)
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
               if(this.tenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 300) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.GoldMarrow = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                              param1.team.enemyTeam.spawn(this.GoldMarrow,param1.game);
                              this.GoldMarrow.skelatorType = "GoldMarrow";
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
                    param1.team.gold += 500;
                    param1.team.mana += 500;
                    this.Elite_1 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Elite_1,param1.game);
                    this.Elite_1.speartonType = "Elite_1";
                    this.Elite_1 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Elite_1,param1.game);
                    this.Elite_1.speartonType = "Elite_1";
                    this.Elite_1 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Elite_1,param1.game);
                    this.Elite_1.speartonType = "Elite_1";
                    this.Elite_1 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Elite_1,param1.game);
                    this.Elite_1.speartonType = "Elite_1";
                    this.Elite_1 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Elite_1,param1.game);
                    this.Elite_1.speartonType = "Elite_1";
                    this.Elite_1 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Elite_1,param1.game);
                    this.Elite_1.speartonType = "Elite_1";
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 31500)
               {
                    param1.team.enemyTeam.statue.health += 29700;
                    param1.team.enemyTeam.statue.maxHealth = 31500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 6000;
                    param1.team.enemyTeam.mana += 4000;
                    this.MegaKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.MegaKnight,param1.game);
                    this.MegaKnight.knightType = "MegaKnight";
                    this.MegaKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.MegaKnight,param1.game);
                    this.MegaKnight.knightType = "MegaKnight";
                    this.MegaKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.MegaKnight,param1.game);
                    this.MegaKnight.knightType = "MegaKnight";
                    this.MegaKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.MegaKnight,param1.game);
                    this.MegaKnight.knightType = "MegaKnight";
                    this.frames = 0;
               }
          }
     }
}
