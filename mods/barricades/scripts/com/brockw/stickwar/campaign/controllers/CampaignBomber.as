package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.EnslavedGiant;
     import com.brockw.stickwar.engine.units.FlyingCrossbowman;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Medusa;
     import com.brockw.stickwar.engine.units.Miner;
     import com.brockw.stickwar.engine.units.MinerChaos;
     import com.brockw.stickwar.engine.units.Ninja;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     import com.brockw.stickwar.engine.units.elementals.AirElement;
     import com.brockw.stickwar.engine.units.elementals.ChromeElement;
     import com.brockw.stickwar.engine.units.elementals.EarthElement;
     import com.brockw.stickwar.engine.units.elementals.FireElement;
     import com.brockw.stickwar.engine.units.elementals.FirestormElement;
     import com.brockw.stickwar.engine.units.elementals.HurricaneElement;
     import com.brockw.stickwar.engine.units.elementals.LavaElement;
     import com.brockw.stickwar.engine.units.elementals.TreeElement;
     import com.brockw.stickwar.engine.units.elementals.WaterElement;
     
     public class CampaignBomber extends CampaignController
     {
           
          
          private var Archis:Archer;
          
          private var Charrog_2:LavaElement;
          
          private var FutureSpear:Spearton;
          
          private var SecondCommand:Knight;
          
          private var Icaron:FlyingCrossbowman;
          
          private var CorruptBloodBlade:Swordwrath;
          
          private var CorruptBaron:Swordwrath;
          
          private var BloodBlade:Swordwrath;
          
          private var E_Giant_1:EnslavedGiant;
          
          private var Clone_5:Archer;
          
          private var E_Giant_2:EnslavedGiant;
          
          private var Sword_1:Swordwrath;
          
          private var Sicklebear:Swordwrath;
          
          private var Silver:Spearton;
          
          private var Sword_2:Swordwrath;
          
          private var BloodSpear_2:Spearton;
          
          private var flyingCrossbowman:FlyingCrossbowman;
          
          private var SickleLeader:Swordwrath;
          
          private var ChaosArcher:Archer;
          
          private var LeafSwordPrince:Swordwrath;
          
          private var SavageSwordPrince:Swordwrath;
          
          private var VoltMage:Magikill;
          
          private var Kytchu_2:Archer;
          
          private var OldSpearos:Spearton;
          
          private var OldSpearos_2:Spearton;
          
          private var Kytchu:Archer;
          
          private var Zarek:Magikill;
          
          private var Magis:Magikill;
          
          private var CrystalMage:Magikill;
          
          private var Fire_1:FireElement;
          
          private var SavageMage:Magikill;
          
          private var FireMage:Magikill;
          
          private var VampMage:Magikill;
          
          private var Magikill_1:Magikill;
          
          private var RGB_Knight:Knight;
          
          private var enslavedGiant:EnslavedGiant;
          
          private var Spear_1:Spearton;
          
          private var ChaosMiner_1:MinerChaos;
          
          private var MoltenSword:Swordwrath;
          
          private var MoltenSpear:Spearton;
          
          private var MoltenSpear_2:Spearton;
          
          private var ChaosLavish:MinerChaos;
          
          private var miner:Miner;
          
          private var SW1Mage:Magikill;
          
          private var SW3Mage:Magikill;
          
          private var Xiphos:Swordwrath;
          
          private var Spear_2:Spearton;
          
          private var SuperSpear:Spearton;
          
          private var spearton:Spearton;
          
          private var lavaElement:LavaElement;
          
          private var Charrog_1:LavaElement;
          
          private var Legend:ChromeElement;
          
          private var hurricaneElement:HurricaneElement;
          
          private var waterElement:WaterElement;
          
          private var earthElement:EarthElement;
          
          private var firestormElement:FirestormElement;
          
          private var chromeElement:ChromeElement;
          
          private var treeElement:TreeElement;
          
          private var giant:Giant;
          
          private var dead:Dead;
          
          private var wingidon:Wingidon;
          
          private var airElement:AirElement;
          
          private var fireElement:FireElement;
          
          private var statue:Statue;
          
          private var magikill:Magikill;
          
          private var medusa:Medusa;
          
          private var s07:Spearton;
          
          private var archer:Archer;
          
          private var EliteSpear:Spearton;
          
          private var Atreyos:Spearton;
          
          private var GoldenSpear:Spearton;
          
          private var SilverKnight:Knight;
          
          private var GoldenArcher:Archer;
          
          private var EliteKnight:Knight;
          
          private var LeGoldKnight:Knight;
          
          private var GoldKnight:Knight;
          
          private var knight:Knight;
          
          private var Leader:Knight;
          
          private var Leader_2:Knight;
          
          private var DemonKnight:Knight;
          
          private var DemonKnight_2:Knight;
          
          private var CrystalKnight:Knight;
          
          private var IceSword:Swordwrath;
          
          private var IceMage:Magikill;
          
          private var Archer_1:Archer;
          
          private var Archer_2:Archer;
          
          private var Boss_2:Spearton;
          
          private var Boss_1:Spearton;
          
          private var Ice:Spearton;
          
          private var Spearos:Spearton;
          
          private var Spearos_2:Spearton;
          
          private var nah:Boolean = false;
          
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
          
          private var comment:String = "--------------------";
          
          public function CampaignBomber(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 90;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 160;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 320;
               this.sevenMinConstant = this.sevenMinTimer;
               this.tenMinTimer = 30 * 94440;
               this.tenMinConstant = this.tenMinTimer;
               super(param1);
               this.frames = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc6_:int = 0;
               var _loc7_:* = undefined;
               var _loc2_:Unit = null;
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
                    this.Fire_1 = FireElement(param1.game.unitFactory.getUnit(Unit.U_FIRE_ELEMENT));
                    param1.team.enemyTeam.spawn(this.Fire_1,param1.game);
                    this.Fire_1.fireElementType = "Fire_1";
                    _loc2_ = FireElement(param1.game.unitFactory.getUnit(Unit.U_FIRE_ELEMENT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = AirElement(param1.game.unitFactory.getUnit(Unit.U_AIR_ELEMENT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    _loc2_ = FireElement(param1.game.unitFactory.getUnit(Unit.U_FIRE_ELEMENT));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    this.tenMinTimer = -10;
               }
               if(!this.nah)
               {
                    _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                    param1.team.spawn(_loc2_,param1.game);
                    _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                    param1.team.spawn(_loc2_,param1.game);
                    this.nah = true;
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 60) == 0)
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
                    if(param1.game.frame % (30 * 80) == 0)
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
               if(param1.game.frame % (30 * 25) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.twoMinTimer < 0)
               {
                    if(this.twoMinTimer < 0)
                    {
                         if(param1.game.frame % (30 * 100) == 0)
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
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 15) == 0)
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
                    if(param1.game.frame % (30 * 40) == 0)
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
                    if(param1.game.frame % (30 * 98) == 0)
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
               if(param1.game.frame % (30 * 40) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 60) == 0)
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
                    if(param1.game.frame % (30 * 100) == 0)
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
                    if(param1.game.frame % (30 * 70) == 0)
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
                    if(param1.game.frame % (30 * 151) == 0)
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
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 151) == 0)
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
                    if(param1.game.frame % (30 * 70) == 0)
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
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 50) == 0)
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
               if(this.sevenMinTimer < 0)
               {
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
               }
               if(this.sevenMinTimer < 0)
               {
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
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 40) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,2);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 50) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,2);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                              param1.team.spawn(_loc2_,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 51) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
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
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 65) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 50) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 60) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,2);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.CorruptBloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(this.CorruptBloodBlade,param1.game);
                         this.CorruptBloodBlade.swordwrathType = "CorruptBloodBlade";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 60) == 0)
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
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 220) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Clone_5 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.Clone_5,param1.game);
                              this.Clone_5.archerType = "Clone_5";
                              this.Clone_5 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(this.Clone_5,param1.game);
                              this.Clone_5.archerType = "Clone_5";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 100) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.CrystalKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                              param1.team.enemyTeam.spawn(this.CrystalKnight,param1.game);
                              this.CrystalKnight.knightType = "CrystalKnight";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 210) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.CrystalMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(this.CrystalMage,param1.game);
                              this.CrystalMage.magikillType = "CrystalMage";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 190) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Spearos = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.Spearos,param1.game);
                              this.Spearos.speartonType = "Spearos";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 220) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.E_Giant_1 = EnslavedGiant(param1.game.unitFactory.getUnit(Unit.U_ENSLAVED_GIANT));
                              param1.team.spawn(this.E_Giant_1,param1.game);
                              this.E_Giant_1.enslavedgiantType = "E_Giant_1";
                              this.E_Giant_2 = EnslavedGiant(param1.game.unitFactory.getUnit(Unit.U_ENSLAVED_GIANT));
                              param1.team.spawn(this.E_Giant_2,param1.game);
                              this.E_Giant_2.enslavedgiantType = "E_Giant_2";
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
                              _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.spawn(_loc2_,param1.game);
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
                              _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 380) == 0)
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
               if(param1.game.frame % (30 * 25) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 20) == 0)
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
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 45) == 0)
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
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 140) == 0)
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
               if(param1.game.frame % (30 * 41) == 0)
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
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
          }
     }
}
