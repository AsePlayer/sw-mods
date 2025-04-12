package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.ChaosTower;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.EnslavedGiant;
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
     import com.brockw.stickwar.engine.units.elementals.AirElement;
     import com.brockw.stickwar.engine.units.elementals.FireElement;
     import com.brockw.stickwar.engine.units.elementals.LavaElement;
     import com.brockw.stickwar.engine.units.elementals.WaterElement;
     
     public class CampaignShadow extends CampaignController
     {
          
          private static const S_TEST:int = 0;
          
          private static const S_TEST_1:int = 1;
          
          private static const S_TEST_2:int = 2;
          
          private static const S_TEST_3:int = 3;
          
          private static const S_TEST_4:int = 4;
          
          private static const S_TEST_5:int = 5;
           
          
          private var miner:Miner;
          
          private var bomber:Bomber;
          
          private var MeleeDead:Dead;
          
          private var Spearos:Spearton;
          
          private var lavaElement:LavaElement;
          
          private var RandomSpear:Spearton;
          
          private var ArmoredNinja:Ninja;
          
          private var ArmoredNinja_2:Ninja;
          
          private var Cat_1:Cat;
          
          private var ChaosNinja:Ninja;
          
          private var ChaosNinja_2:Ninja;
          
          private var AlphaCat:Cat;
          
          private var electricBomber:Bomber;
          
          private var frostBomber:Bomber;
          
          private var poisonBomber:Bomber;
          
          private var Atreyos:Spearton;
          
          private var Atreyos_2:Spearton;
          
          private var DarkKytchu:Archer;
          
          private var stunBomber:Bomber;
          
          private var enslavedGiant:EnslavedGiant;
          
          private var MoltenSpear:Spearton;
          
          private var MoltenSpear_2:Spearton;
          
          private var MegaSword:Swordwrath;
          
          private var SWLAtreyos:Spearton;
          
          private var Dark:Spearton;
          
          private var Kytchu:Archer;
          
          private var Clone_5:Archer;
          
          private var Light:Spearton;
          
          private var Silver:Spearton;
          
          private var SW1Mage:Magikill;
          
          private var SW3Mage:Magikill;
          
          private var waterElement:WaterElement;
          
          private var airElement:AirElement;
          
          private var RGB_Knight:Knight;
          
          private var fireElement:FireElement;
          
          private var Kai_2:Skelator;
          
          private var Kai:Skelator;
          
          private var SavagePrince:Spearton;
          
          private var LavaPrince:Spearton;
          
          private var LeafPrince:Spearton;
          
          private var Ice:Spearton;
          
          private var Lava:Spearton;
          
          private var SickleSpear:Spearton;
          
          private var GoldenSpear:Spearton;
          
          private var MegaKnight:Knight;
          
          private var Tower_1:ChaosTower;
          
          private var ChaosSickle:Swordwrath;
          
          private var statue:Statue;
          
          private var MoltenSword:Swordwrath;
          
          private var MoltenSword_2:Swordwrath;
          
          private var archer:Archer;
          
          private var MinionBomber:Swordwrath;
          
          private var spearton:Spearton;
          
          private var BuffKnight:Knight;
          
          private var knight:Knight;
          
          private var VampClipsor:Wingidon;
          
          private var SuperWing_5:Wingidon;
          
          private var MedusaSummoner:Medusa;
          
          private var VoltSword:Swordwrath;
          
          private var VoltSword_2:Swordwrath;
          
          private var VoltSpear:Spearton;
          
          private var VoltArcher:Archer;
          
          private var VoltMage:Magikill;
          
          private var Magis:Magikill;
          
          private var VoltKnight:Knight;
          
          private var SilverKnight:Knight;
          
          private var TeleportMage:Magikill;
          
          private var TeleportMage_2:Magikill;
          
          private var BuffSpear:Spearton;
          
          private var Xiphos:Swordwrath;
          
          private var Wrathnar:Swordwrath;
          
          private var EliteKnight:Knight;
          
          private var Zarek:Magikill;
          
          private var VoltKnight_2:Knight;
          
          private var BomberGiant:Giant;
          
          private var LavaGiant:Giant;
          
          private var VoltGiant:Giant;
          
          private var magikill:Magikill;
          
          private var VampSword:Swordwrath;
          
          private var VampKnight:Knight;
          
          private var giant:Giant;
          
          private var VampArcher:Archer;
          
          private var Vamp:Spearton;
          
          private var Thera:Monk;
          
          private var VampMage:Magikill;
          
          private var nah:Boolean = false;
          
          private var Leader:Knight;
          
          private var LeGoldKnight:Knight;
          
          private var Leader_2:Knight;
          
          private var SecondCommand:Knight;
          
          private var s07:Spearton;
          
          private var s07_Crippled:Spearton;
          
          private var Ice_CA:Archer;
          
          private var Lava_CA:Archer;
          
          private var Voltaic_CA:Archer;
          
          private var EliteSpear_2:Spearton;
          
          private var EliteSpear:Spearton;
          
          private var Leonidas:Spearton;
          
          private var AncientSpear:Spearton;
          
          private var SecondCommand_2:Knight;
          
          private var CrystalKnight:Knight;
          
          private var CrystalSpear:Spearton;
          
          private var DemonKnight_2:Knight;
          
          private var DemonKnight:Knight;
          
          private var GoldKnight:Knight;
          
          private var spawnNumber:int;
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var StatueArcher:Archer;
          
          private var tenMinConstant:int;
          
          private var statueKillTimer:int;
          
          private var statueKillConstant:int;
          
          private var startingDelayTimer:int;
          
          private var startingDelayConstant:int;
          
          private var frames:int;
          
          private var RandomAnimation:int;
          
          private var state:int;
          
          private var counter:int;
          
          private var comment:String = "--------------------";
          
          private var message:InGameMessage;
          
          public function CampaignShadow(param1:GameScreen)
          {
               this.startingDelayTimer = 30 * 190;
               this.startingDelayConstant = this.startingDelayTimer;
               this.oneMinTimer = 30 * 130;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 130;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 335;
               this.sevenMinConstant = this.sevenMinTimer;
               this.tenMinTimer = 30 * 210;
               this.tenMinConstant = this.tenMinTimer;
               this.statueKillTimer = 30 * 9000;
               this.statueKillConstant = this.statueKillTimer;
               super(param1);
               this.state = S_TEST;
               this.counter = 0;
               this.frames = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc6_:int = 0;
               var _loc7_:* = undefined;
               var _loc2_:Unit = null;
               if(this.startingDelayTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.startingDelayTimer;
                         }
                         --this.startingDelayTimer;
                    }
               }
               else if(this.startingDelayTimer != -10)
               {
                    this.startingDelayTimer = -10;
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
               if(this.statueKillTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.statueKillTimer;
                         }
                         --this.statueKillTimer;
                    }
               }
               else if(this.statueKillTimer != -10)
               {
                    param1.team.enemyTeam.statue.health = 0;
                    this.statueKillTimer = -10;
               }
               if(!this.nah)
               {
                    this.nah = true;
               }
               if(this.state == S_TEST)
               {
                    this.state = S_TEST_1;
               }
               else if(this.state != S_TEST_1)
               {
                    if(this.state == S_TEST_2)
                    {
                         this.state = S_TEST_3;
                    }
                    else if(this.state == S_TEST_3)
                    {
                         this.state = S_TEST_4;
                    }
                    else if(this.state == S_TEST_4)
                    {
                         this.state = S_TEST_5;
                    }
                    else if(this.state == S_TEST_5)
                    {
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
               if(param1.game.frame % (30 * 28) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.MeleeDead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(this.MeleeDead,param1.game);
                         this.MeleeDead.deadType = "MeleeDead";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 81) == 0)
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
                    if(param1.game.frame % (30 * 245) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
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
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 200) == 0)
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
                    if(param1.game.frame % (30 * 210) == 0)
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
                    if(param1.game.frame % (30 * 300) == 0)
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
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 300) == 0)
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
                    if(param1.game.frame % (30 * 55) == 0)
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
                    if(param1.game.frame % (30 * 130) == 0)
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
                    if(param1.game.frame % (30 * 350) == 0)
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
                    if(param1.game.frame % (30 * 90) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 2,4);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 69) == 0)
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
                    if(param1.game.frame % (30 * 145) == 0)
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
               if(this.twoMinTimer < 0)
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
                    if(param1.game.frame % (30 * 95) == 0)
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
               if(this.twoMinTimer < 0)
               {
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
               }
               if(param1.game.frame % (30 * 900) == 0)
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
                    if(param1.game.frame % (30 * 340) == 0)
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
                    if(param1.game.frame % (30 * 340) == 0)
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
               if(param1.team.statue.health <= 100 && param1.team.statue.maxHealth != 26200)
               {
                    param1.team.statue.health += 24000;
                    param1.team.statue.maxHealth = 26200;
                    param1.team.statue.healthBar.totalHealth = param1.team.statue.maxHealth;
                    param1.team.gold += 1000;
                    param1.team.mana += 1000;
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 5000)
               {
                    param1.team.enemyTeam.statue.health += 0;
                    param1.team.enemyTeam.statue.maxHealth = 5000;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 15000;
                    param1.team.enemyTeam.mana += 15000;
                    this.frames = 0;
               }
          }
     }
}
