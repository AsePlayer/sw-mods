package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignBomber extends CampaignController
     {
           
          
          private var statue:Statue;
          
          private var IceSword:Swordwrath;
          
          private var IceMage:Magikill;
          
          private var Frost_1:Archer;
          
          private var Boss_2:Spearton;
          
          private var Boss_1:Spearton;
          
          private var Ice:Spearton;
          
          private var Spearos:Spearton;
          
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
               this.oneMinTimer = 30 * 120;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 225;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 260;
               this.sevenMinConstant = this.sevenMinTimer;
               this.tenMinTimer = 30 * 600;
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
                    this.IceSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.IceSword,param1.game);
                    this.IceSword.swordwrathType = "IceSword";
                    this.Frost_1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Frost_1,param1.game);
                    this.Frost_1.archerType = "Frost_1";
                    this.Frost_1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.Frost_1,param1.game);
                    this.Frost_1.archerType = "Frost_1";
                    this.Ice = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Ice,param1.game);
                    this.Ice.speartonType = "Ice";
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
                    this.IceMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.enemyTeam.spawn(this.IceMage,param1.game);
                    this.IceMage.magikillType = "IceMage";
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
                    this.Spearos = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Spearos,param1.game);
                    this.Spearos.speartonType = "Spearos";
                    this.nah = true;
               }
               if(this.Spearos.isDead)
               {
                    if(param1.game.frame % (30 * 120) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Spearos = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Spearos,param1.game);
                              this.Spearos.speartonType = "Spearos";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 50) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.IceSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.IceSword,param1.game);
                              this.IceSword.swordwrathType = "IceSword";
                              this.IceSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.IceSword,param1.game);
                              this.IceSword.swordwrathType = "IceSword";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.oneMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 32) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Frost_1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(this.Frost_1,param1.game);
                              this.Frost_1.archerType = "Frost_1";
                              this.Frost_1 = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                              param1.team.enemyTeam.spawn(this.Frost_1,param1.game);
                              this.Frost_1.archerType = "Frost_1";
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
                              this.Ice = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Ice,param1.game);
                              this.Ice.speartonType = "Ice";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.tenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 385) == 0)
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
                              this.IceMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(this.IceMage,param1.game);
                              this.IceMage.magikillType = "IceMage";
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
               if(param1.game.frame % (30 * 13) == 0)
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
               if(param1.team.statue.health <= 1000 && param1.team.statue.maxHealth != 45500)
               {
                    param1.team.statue.health += 40500;
                    param1.team.statue.maxHealth = 45500;
                    param1.team.statue.healthBar.totalHealth = param1.team.statue.maxHealth;
                    param1.team.gold += 500;
                    param1.team.mana += 500;
                    this.Boss_1 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.Boss_1,param1.game);
                    this.Boss_1.speartonType = "Boss_1";
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 22500)
               {
                    param1.team.enemyTeam.statue.health += 19700;
                    param1.team.enemyTeam.statue.maxHealth = 22500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 5000;
                    param1.team.enemyTeam.mana += 2000;
                    this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                    this.Boss_2.speartonType = "Boss_2";
                    this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                    this.Boss_2.speartonType = "Boss_2";
                    this.Boss_2 = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Boss_2,param1.game);
                    this.Boss_2.speartonType = "Boss_2";
                    this.frames = 0;
               }
          }
     }
}
