package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
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
     import com.brockw.stickwar.engine.units.elementals.ChromeElement;
     import com.brockw.stickwar.engine.units.elementals.EarthElement;
     import com.brockw.stickwar.engine.units.elementals.FireElement;
     import com.brockw.stickwar.engine.units.elementals.LavaElement;
     import com.brockw.stickwar.engine.units.elementals.WaterElement;
     import flash.events.Event;
     import flash.events.MouseEvent;
     
     public class CampaignArcher extends CampaignController
     {
          
          private static const S_INTRO:int = -1;
          
          private static const S_INTRO_2:int = 0;
          
          private static const S_INTRO_3:int = 1;
          
          private static const S_INTRO_4:int = 2;
          
          private static const S_INTRO_5:int = 3;
          
          private static const S_INTRO_6:int = 4;
          
          private static const S_COMPLETE:int = 5;
           
          
          private var gameScreen:GameScreen;
          
          private var skipTutorialButton:skipTutorial;
          
          private var state:int;
          
          private var chromeElement:ChromeElement;
          
          private var lavaElement:LavaElement;
          
          private var WoodlandPrincess:Archer;
          
          private var BackLineTargeter:Spearton;
          
          private var MagikillTargeter:Spearton;
          
          private var Prince_1:Swordwrath;
          
          private var Prince_2:Archer;
          
          private var Prince_3:Spearton;
          
          private var NewCA:Archer;
          
          private var VoltWing:Wingidon;
          
          private var Archis:Archer;
          
          private var Silver:Spearton;
          
          private var VoltDead:Dead;
          
          private var MeleeDead:Dead;
          
          private var VoltMarrow:Skelator;
          
          private var Black:Spearton;
          
          private var counter:int;
          
          private var Pink:Spearton;
          
          private var Ceramic:Spearton;
          
          private var Leonidas:Spearton;
          
          private var MOAB:Spearton;
          
          private var BFB:Spearton;
          
          private var ZOMG:Spearton;
          
          private var VoltNinja:Ninja;
          
          private var VoltSword:Swordwrath;
          
          private var VoltSword_2:Swordwrath;
          
          private var VoltArcher:Archer;
          
          private var VoltMage:Magikill;
          
          private var VoltKnight:Knight;
          
          private var VoltKnight_2:Knight;
          
          private var Magis:Magikill;
          
          private var Charrog_1:LavaElement;
          
          private var StatueFire:FireElement;
          
          private var CrystalArcher:Archer;
          
          private var Fire_1:FireElement;
          
          private var GoldGiant:Giant;
          
          private var earthElement:EarthElement;
          
          private var Test_1:WaterElement;
          
          private var Earth_1:EarthElement;
          
          private var FireKnight:Knight;
          
          private var SecondCommand:Knight;
          
          private var SilverKnight:Knight;
          
          private var EliteKnight:Knight;
          
          private var LeGoldKnight:Knight;
          
          private var GoldKnight:Knight;
          
          private var GoldKnight_2:Knight;
          
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
          
          private var VampArcher:Archer;
          
          private var SavageArcher:Archer;
          
          private var SavageArcherPrince:Archer;
          
          private var ninja:Ninja;
          
          private var LeafSword:Swordwrath;
          
          private var SavageSword:Swordwrath;
          
          private var SavageSwordPrince:Swordwrath;
          
          private var Kai:Skelator;
          
          private var Savage:Spearton;
          
          private var SavagePrince:Spearton;
          
          private var knight:Knight;
          
          private var SW3Atreyos:Spearton;
          
          private var giant:Giant;
          
          private var Griffin:Giant;
          
          private var wingidon:Wingidon;
          
          private var magikill:Magikill;
          
          private var SW1Mage:Magikill;
          
          private var SW3Mage:Magikill;
          
          private var GoldMage:Magikill;
          
          private var nah:Boolean = false;
          
          private var LeafArcher:Archer;
          
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
          
          private var MedusaSummoner:Medusa;
          
          private var SpearDeadBoss:Dead;
          
          private var EliteSpear:Spearton;
          
          private var EliteSpear_2:Spearton;
          
          private var SpeedDead:Dead;
          
          private var VoltBomber:Bomber;
          
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
          
          private var SuperAlbow:FlyingCrossbowman;
          
          private var Elite:FlyingCrossbowman;
          
          private var Atreyos:Spearton;
          
          private var flyingCrossbowman:FlyingCrossbowman;
          
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
          
          private var VampSword:Swordwrath;
          
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
          
          private var VampMage:Magikill;
          
          private var SavageMage:Magikill;
          
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
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var comment:String = "--------------------";
          
          public function CampaignArcher(param1:GameScreen)
          {
               this.gameScreen = param1;
               this.skipTutorialButton = new skipTutorial();
               this.skipTutorialButton.addEventListener(MouseEvent.CLICK,this.skipTutorialClick,false,0,true);
               this.oneMinTimer = 30 * 130;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 200;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 190;
               this.sevenMinConstant = this.sevenMinTimer;
               this.tenMinTimer = 30 * 300;
               this.tenMinConstant = this.tenMinTimer;
               super(param1);
               this.state = S_INTRO;
               this.counter = 0;
               this.s07 = null;
               this.BuffSpear = null;
               this.frames = 0;
          }
          
          private function skipTutorialClick(param1:Event) : void
          {
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc6_:int = 0;
               var _loc7_:* = undefined;
               var _loc2_:Unit = null;
               if(this.message)
               {
                    this.message.update();
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
                    _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
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
                    this.Spearos = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Spearos,param1.game);
                    this.Spearos.speartonType = "Spearos";
                    this.Spearos_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Spearos_2,param1.game);
                    this.Spearos_2.speartonType = "Spearos_2";
                    this.tenMinTimer = -10;
               }
               if(!this.nah)
               {
                    this.nah = true;
               }
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
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 190) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.CrystalArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.CrystalArcher,param1.game);
                              this.CrystalArcher.archerType = "CrystalArcher";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 320) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Clone_5 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.Clone_5,param1.game);
                              this.Clone_5.archerType = "Clone_5";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.state == S_INTRO)
               {
                    this.state = S_INTRO_2;
               }
               else if(this.state == S_INTRO_2)
               {
                    this.state = S_INTRO_3;
               }
               else if(this.state == S_INTRO_3)
               {
                    this.state = S_INTRO_4;
               }
               else if(this.state == S_INTRO_4)
               {
                    this.state = S_INTRO_5;
               }
               else if(this.state == S_INTRO_5)
               {
                    this.state = S_INTRO_6;
               }
               else if(this.state == S_INTRO_6)
               {
                    this.state = S_COMPLETE;
               }
               else if(this.state == S_COMPLETE)
               {
               }
               if(param1.game.frame % (30 * 270) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.tenMinTimer < 0)
               {
                    if(this.Spearos_2.isDead)
                    {
                         if(param1.game.frame % (30 * 200) == 0)
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
               }
               if(this.tenMinTimer < 0)
               {
                    if(this.Spearos.isDead)
                    {
                         if(param1.game.frame % (30 * 180) == 0)
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
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 87) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc2_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 108) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc2_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
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
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 70) == 0)
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
               if(param1.game.frame % (30 * 10) == 0)
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
                    if(param1.game.frame % (30 * 30) == 0)
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
               if(param1.game.frame % (30 * 14) == 0)
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
               if(param1.game.frame % (30 * 27) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 5,10);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 47) == 0)
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
               if(param1.game.frame % (30 * 270) == 0)
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
               if(this.oneMinTimer < 0)
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
               if(this.tenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 490) == 0)
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
                    if(param1.game.frame % (30 * 615) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              if(param1.game.frame % (30 * 400) == 0)
                              {
                                   _loc6_ = Math.min(this.spawnNumber / 1,1);
                                   _loc7_ = 0;
                                   while(_loc7_ < _loc6_)
                                   {
                                        _loc7_++;
                                   }
                                   ++this.spawnNumber;
                              }
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 27) == 0)
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
               if(this.oneMinTimer < 0)
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
          }
     }
}
