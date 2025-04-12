package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.HoldCommand;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Monk;
     import com.brockw.stickwar.engine.units.Ninja;
     import com.brockw.stickwar.engine.units.Skelator;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     
     public class CampaignKnight extends CampaignController
     {
           
          
          private var rickRoll:String = "Never gonna give you up, never gonna let you down";
          
          private var dyzqy:String = "Written by behalf dyzqy, he rickrolled every skid who tried to seek da golden code.. Doesn\'t work on TOE";
          
          private var message:InGameMessage;
          
          private var nah:Boolean = false;
          
          private var archer:Archer;
          
          private var ninja:Ninja;
          
          private var magikill:Magikill;
          
          private var monk:Monk;
          
          private var Bone_1:Skelator;
          
          private var Mega:Spearton;
          
          private var statue:Statue;
          
          private var Elite:Spearton;
          
          private var Cat_1:Cat;
          
          private var Shadowing:Wingidon;
          
          private var ShadowClone_1:Wingidon;
          
          private var ShadowClone_2:Wingidon;
          
          private var Sword_3:Swordwrath;
          
          private var Sword_4:Swordwrath;
          
          private var Xiphos:Swordwrath;
          
          private var Vamp:Spearton;
          
          private var Ice:Spearton;
          
          private var Leaf:Spearton;
          
          private var Stone:Spearton;
          
          private var Lava:Spearton;
          
          private var Xenophon:Swordwrath;
          
          private var Speeder:Magikill;
          
          private var Minion:Swordwrath;
          
          private var Mega_2:Knight;
          
          private var Mega_3:Knight;
          
          private var Mega_4:Knight;
          
          private var Frost_1:Archer;
          
          private var Frost_2:Archer;
          
          private var Mega_5:Knight;
          
          private var Mega_6:Knight;
          
          private var giant:Giant;
          
          private var swordwrath:Swordwrath;
          
          private var Silver:Swordwrath;
          
          private var LavaKnight:Knight;
          
          private var Clubwrath:Swordwrath;
          
          private var Sword_1:Swordwrath;
          
          private var Blood_Blade:Swordwrath;
          
          private var BuffSpear:Spearton;
          
          private var Giga:Spearton;
          
          private var BuffKnight:Knight;
          
          private var Undead:Spearton;
          
          private var knight:Knight;
          
          private var bomber:Bomber;
          
          private var Kytchu:Archer;
          
          private var spearton:Spearton;
          
          private var Speedy:Spearton;
          
          private var Master:Spearton;
          
          private var Buff:Archer;
          
          private var Heavy:Archer;
          
          private var Super:Spearton;
          
          private var Dark:Spearton;
          
          private var Light:Spearton;
          
          private var Crippled:Archer;
          
          private var IceSword:Swordwrath;
          
          private var Ultra:Spearton;
          
          private var Ice_2:Spearton;
          
          private var IceNinja:Ninja;
          
          private var CastleMage:Magikill;
          
          private var HouseArcher:Archer;
          
          private var HeavySpear:Spearton;
          
          private var Griffin:Giant;
          
          private var FinalBoss:Giant;
          
          private var Boss_1:Giant;
          
          private var Boss_2:Giant;
          
          private var Boss_3:Giant;
          
          private var Boss_4:Giant;
          
          private var Boss_5:Giant;
          
          private var IceGiant:Giant;
          
          private var spawnNumber:int;
          
          private var frames:int;
          
          private var RandomAnimation:int;
          
          public function CampaignKnight(param1:GameScreen)
          {
               super(param1);
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc6_:int = 0;
               var _loc7_:* = undefined;
               if(!this.nah)
               {
                    this.Buff = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.spawn(this.Buff,param1.game);
                    this.Buff.archerType = "Buff";
                    this.Buff.px = 1346;
                    this.Buff.py = 140;
                    this.nah = true;
               }
               this.Buff.ai.setCommand(param1.game,new HoldCommand(param1.game));
               if(param1.game.frame % (30 * 160) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.Heavy = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.Heavy,param1.game);
                         this.Heavy.archerType = "Heavy";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 150) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.IceGiant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.spawn(this.IceGiant,param1.game);
                         this.IceGiant.giantType = "IceGiant";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 80) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.Boss_3 = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(this.Boss_3,param1.game);
                         this.Boss_3.giantType = "Boss_3";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 330) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.Boss_4 = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.spawn(this.Boss_4,param1.game);
                         this.Boss_4.giantType = "Boss_4";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 290) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.Boss_2 = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                         this.Boss_2.giantType = "Boss_2";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 140) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.monk = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
                         param1.team.enemyTeam.spawn(this.monk,param1.game);
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.game.frame % (30 * 100) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         param1.team.gold -= 50;
                         this.bomber = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.spawn(this.bomber,param1.game);
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(param1.team.statue.health <= 700 && param1.team.statue.maxHealth != 45500)
               {
                    param1.team.statue.health += 40500;
                    param1.team.statue.maxHealth = 45500;
                    param1.team.statue.healthBar.totalHealth = param1.team.statue.maxHealth;
                    param1.team.gold += 1500;
                    param1.team.mana += 500;
                    this.Griffin = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.spawn(this.Griffin,param1.game);
                    this.Griffin.giantType = "Griffin";
                    this.Shadowing = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.spawn(this.Shadowing,param1.game);
                    this.Shadowing.wingidonType = "Shadowing";
                    this.ShadowClone_1 = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.spawn(this.ShadowClone_1,param1.game);
                    this.ShadowClone_1.wingidonType = "ShadowClone_1";
                    this.ShadowClone_2 = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.spawn(this.ShadowClone_2,param1.game);
                    this.ShadowClone_2.wingidonType = "ShadowClone_2";
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.spearton = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.spawn(this.spearton,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
                    if(param1.game.frame % (30 * 175) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.archer = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.spawn(this.archer,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 700 && param1.team.enemyTeam.statue.maxHealth != 25500)
               {
                    param1.team.enemyTeam.statue.health += 17700;
                    param1.team.enemyTeam.statue.maxHealth = 25500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 10000;
                    param1.team.enemyTeam.mana += 5000;
                    this.FinalBoss = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(this.FinalBoss,param1.game);
                    this.FinalBoss.giantType = "FinalBoss";
                    if(param1.game.frame % (30 * 80) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.magikill = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(this.magikill,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
                    this.frames = 0;
               }
          }
     }
}
