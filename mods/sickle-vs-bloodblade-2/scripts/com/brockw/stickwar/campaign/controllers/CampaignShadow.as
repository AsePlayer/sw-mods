package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Monk;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignShadow extends CampaignController
     {
           
          
          private var statue:Statue;
          
          private var archer:Archer;
          
          private var knight:Knight;
          
          private var magikill:Magikill;
          
          private var VampSword:Swordwrath;
          
          private var VampArcher:Archer;
          
          private var Vamp:Spearton;
          
          private var Thera:Monk;
          
          private var VampMage:Magikill;
          
          private var nah:Boolean = false;
          
          private var Leader:Knight;
          
          private var Leader_2:Knight;
          
          private var SecondCommand:Knight;
          
          private var SecondCommand_2:Knight;
          
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
          
          private var frames:int;
          
          private var RandomAnimation:int;
          
          private var comment:String = "--------------------";
          
          public function CampaignShadow(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 210;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 180;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 220;
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
                    this.Vamp = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.enemyTeam.spawn(this.Vamp,param1.game);
                    this.Vamp.speartonType = "Vamp";
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
                    this.VampMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                    param1.team.enemyTeam.spawn(this.VampMage,param1.game);
                    this.VampMage.magikillType = "VampMage";
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
                    this.nah = true;
               }
               if(param1.game.frame % (30 * 40) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                         param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                         this.VampArcher.archerType = "VampArcher";
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
                         this.VampSword = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(this.VampSword,param1.game);
                         this.VampSword.swordwrathType = "VampSword";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 65) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Vamp = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(this.Vamp,param1.game);
                              this.Vamp.speartonType = "Vamp";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 235) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.VampMage = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(this.VampMage,param1.game);
                              this.VampMage.magikillType = "VampMage";
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
                    param1.team.gold += 500;
                    param1.team.mana += 500;
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 17500)
               {
                    param1.team.enemyTeam.statue.health += 15700;
                    param1.team.enemyTeam.statue.maxHealth = 17500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 15000;
                    param1.team.enemyTeam.mana += 15000;
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.VampArcher = Archer(param1.game.unitFactory.getUnit(Unit.U_ARCHER));
                    param1.team.enemyTeam.spawn(this.VampArcher,param1.game);
                    this.VampArcher.archerType = "VampArcher";
                    this.frames = 0;
               }
          }
     }
}
