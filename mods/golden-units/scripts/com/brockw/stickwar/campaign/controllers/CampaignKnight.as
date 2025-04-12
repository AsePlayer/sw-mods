package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.HoldCommand;
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
     import com.brockw.stickwar.engine.units.elementals.FireElement;
     import com.brockw.stickwar.engine.units.elementals.WaterElement;
     
     public class CampaignKnight extends CampaignController
     {
           
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var message3:InGameMessage;
          
          private var message4:InGameMessage;
          
          private var message5:InGameMessage;
          
          private var message6:InGameMessage;
          
          private var StatueFire:FireElement;
          
          private var Fire_1:FireElement;
          
          private var Test_1:WaterElement;
          
          private var FireKnight:Knight;
          
          private var VampKnight:Knight;
          
          private var IceSword:Swordwrath;
          
          private var Thera:Monk;
          
          private var FastMonk:Monk;
          
          private var Stone:Spearton;
          
          private var Leaf:Spearton;
          
          private var TankyMonk:Monk;
          
          private var BossMonk:Monk;
          
          private var Monk_1:Monk;
          
          private var Monk_2:Monk;
          
          private var HighHealMonk:Monk;
          
          private var statue:Statue;
          
          private var archer:Archer;
          
          private var knight:Knight;
          
          private var giant:Giant;
          
          private var Griffin:Giant;
          
          private var wingidon:Wingidon;
          
          private var magikill:Magikill;
          
          private var SW1Mage:Magikill;
          
          private var nah:Boolean = false;
          
          private var Clone_5:Archer;
          
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
          
          private var Clone_6:Archer;
          
          private var s07:Spearton;
          
          private var Ultra:Spearton;
          
          private var Super:Spearton;
          
          private var Giga:Spearton;
          
          private var BuffSpear_2:Spearton;
          
          private var Blazing:FlyingCrossbowman;
          
          private var SuperWing_1:Wingidon;
          
          private var Elite:Spearton;
          
          private var Atreyos:Spearton;
          
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
               this.oneMinTimer = 30 * 210;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 285;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 340;
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
                    this.spearton = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.spearton,param1.game);
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
                    this.Atreyos_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Atreyos_2,param1.game);
                    this.Atreyos_2.speartonType = "Atreyos_2";
                    this.Atreyos = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Atreyos,param1.game);
                    this.Atreyos.speartonType = "Atreyos";
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
                    this.StatueArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.spawn(this.StatueArcher,param1.game);
                    this.StatueArcher.archerType = "StatueArcher";
                    this.StatueArcher.px = 1346;
                    this.StatueArcher.py = 140;
                    this.nah = true;
               }
               this.StatueArcher.ai.setCommand(param1.game,new HoldCommand(param1.game));
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 140) == 0)
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
               }
               if(this.twoMinTimer < 0)
               {
                    if(this.Atreyos.isDead)
                    {
                         if(param1.game.frame % (30 * 230) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.Atreyos = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                                   param1.team.spawn(this.Atreyos,param1.game);
                                   this.Atreyos.speartonType = "Atreyos";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(this.Atreyos_2.isDead)
                    {
                         if(param1.game.frame % (30 * 205) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.Atreyos_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                                   param1.team.enemyTeam.spawn(this.Atreyos_2,param1.game);
                                   this.Atreyos_2.speartonType = "Atreyos_2";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(param1.team.statue.health <= 1000 && param1.team.statue.maxHealth != 35500)
               {
                    param1.team.statue.health += 30500;
                    param1.team.statue.maxHealth = 35500;
                    param1.team.statue.healthBar.totalHealth = param1.team.statue.maxHealth;
                    param1.team.gold += 0;
                    param1.team.mana += 0;
                    this.s07 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.s07,param1.game);
                    this.s07.speartonType = "s07";
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 21500)
               {
                    param1.team.enemyTeam.statue.health += 19700;
                    param1.team.enemyTeam.statue.maxHealth = 21500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 5000;
                    param1.team.enemyTeam.mana += 5000;
                    this.Super = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Super,param1.game);
                    this.Super.speartonType = "Super";
                    this.frames = 0;
               }
          }
     }
}
