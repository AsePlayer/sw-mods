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
               this.sevenMinTimer = 30 * 360;
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
                    this.SuperWing_2 = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.SuperWing_2,param1.game);
                    this.SuperWing_2.wingidonType = "SuperWing_2";
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
                    this.SpearDeadBoss = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.SpearDeadBoss,param1.game);
                    this.SpearDeadBoss.deadType = "SpearDeadBoss";
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
                    this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(this.giant,param1.game);
                    this.tenMinTimer = -10;
               }
               if(!this.nah)
               {
                    this.nah = true;
               }
               if(param1.game.frame % (30 * 110) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 175) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.SuperWing_2 = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                              param1.team.enemyTeam.spawn(this.SuperWing_2,param1.game);
                              this.SuperWing_2.wingidonType = "SuperWing_2";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 255) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.SpearDeadBoss = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                              param1.team.spawn(this.SpearDeadBoss,param1.game);
                              this.SpearDeadBoss.deadType = "SpearDeadBoss";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.tenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 335) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                              param1.team.enemyTeam.spawn(this.giant,param1.game);
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
                    param1.team.gold += 2000;
                    param1.team.mana += 1500;
                    this.dead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.dead,param1.game);
                    this.dead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.dead,param1.game);
                    this.dead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.dead,param1.game);
                    this.dead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.dead,param1.game);
                    this.dead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.dead,param1.game);
                    this.dead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.dead,param1.game);
                    this.dead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.dead,param1.game);
                    this.dead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                    param1.team.spawn(this.dead,param1.game);
                    this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.spawn(this.giant,param1.game);
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 21500)
               {
                    param1.team.enemyTeam.statue.health += 19700;
                    param1.team.enemyTeam.statue.maxHealth = 21500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 25000;
                    param1.team.enemyTeam.mana += 5000;
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.wingidon = Wingidon(param1.game.unitFactory.getUnit(Unit.U_WINGIDON));
                    param1.team.enemyTeam.spawn(this.wingidon,param1.game);
                    this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(this.giant,param1.game);
                    this.giant.px = 6500;
                    this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(this.giant,param1.game);
                    this.giant.px = 6500;
                    this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(this.giant,param1.game);
                    this.giant.px = 6500;
                    this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(this.giant,param1.game);
                    this.giant = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                    param1.team.enemyTeam.spawn(this.giant,param1.game);
                    this.frames = 0;
               }
          }
     }
}
