package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.Ai.command.HoldCommand;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignShadow extends CampaignController
     {
           
          
          private var statue:Statue;
          
          private var archer:Archer;
          
          private var knight:Knight;
          
          private var magikill:Magikill;
          
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
               this.twoMinTimer = 30 * 285;
               this.twoMinConstant = this.twoMinTimer;
               this.sevenMinTimer = 30 * 350;
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
                    this.knight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.knight,param1.game);
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
                    this.SecondCommand = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.spawn(this.SecondCommand,param1.game);
                    this.SecondCommand.knightType = "SecondCommand";
                    this.SecondCommand_2 = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.SecondCommand_2,param1.game);
                    this.SecondCommand_2.knightType = "SecondCommand_2";
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
                    this.Leader = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.spawn(this.Leader,param1.game);
                    this.Leader.knightType = "Leader";
                    this.Leader_2 = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                    param1.team.enemyTeam.spawn(this.Leader_2,param1.game);
                    this.Leader_2.knightType = "Leader_2";
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
                    if(param1.game.frame % (30 * 170) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.knight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                              param1.team.enemyTeam.spawn(this.knight,param1.game);
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(this.SecondCommand.isDead)
                    {
                         if(param1.game.frame % (30 * 190) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.SecondCommand = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                                   param1.team.spawn(this.SecondCommand,param1.game);
                                   this.SecondCommand.knightType = "SecondCommand";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(this.SecondCommand_2.isDead)
                    {
                         if(param1.game.frame % (30 * 175) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.SecondCommand_2 = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                                   param1.team.enemyTeam.spawn(this.SecondCommand_2,param1.game);
                                   this.SecondCommand_2.knightType = "SecondCommand_2";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(this.Leader.isDead)
                    {
                         if(param1.game.frame % (30 * 235) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.Leader = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                                   param1.team.spawn(this.Leader,param1.game);
                                   this.Leader.knightType = "Leader";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(this.Leader_2.isDead)
                    {
                         if(param1.game.frame % (30 * 210) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.Leader_2 = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                                   param1.team.enemyTeam.spawn(this.Leader_2,param1.game);
                                   this.Leader_2.knightType = "Leader_2";
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
                    param1.team.gold += 8500;
                    param1.team.mana += 7500;
                    this.frames = 0;
               }
               if(param1.team.enemyTeam.statue.health <= 1000 && param1.team.enemyTeam.statue.maxHealth != 31500)
               {
                    param1.team.enemyTeam.statue.health += 29700;
                    param1.team.enemyTeam.statue.maxHealth = 31500;
                    param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                    param1.team.enemyTeam.gold += 15000;
                    param1.team.enemyTeam.mana += 15000;
                    this.frames = 0;
               }
          }
     }
}
