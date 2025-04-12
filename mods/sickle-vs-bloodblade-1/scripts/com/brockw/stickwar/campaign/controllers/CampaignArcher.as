package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignArcher extends CampaignController
     {
           
          
          private var message:InGameMessage;
          
          private var nah:Boolean = false;
          
          private var Kytchu:Archer;
          
          private var Sicklewrath:Swordwrath;
          
          private var SickleGeneral:Swordwrath;
          
          private var SickleLeader:Swordwrath;
          
          private var Leafsickle:Swordwrath;
          
          private var Icesickle:Swordwrath;
          
          private var Savagesickle:Swordwrath;
          
          private var Lavasickle:Swordwrath;
          
          private var Vampsickle:Swordwrath;
          
          private var GoldSword:Swordwrath;
          
          private var Xenophon:Swordwrath;
          
          private var BloodBlade:Swordwrath;
          
          private var Baron:Swordwrath;
          
          private var Lava:Spearton;
          
          private var spawnNumber:int;
          
          private var Test:Spearton;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var tenMinConstant:int;
          
          private var frames:int;
          
          public function CampaignArcher(param1:GameScreen)
          {
               this.twoMinTimer = 30 * 190;
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
               var _loc2_:Unit = null;
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
                    this.Leafsickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.Leafsickle,param1.game);
                    this.Leafsickle.swordwrathType = "Leafsickle";
                    this.Icesickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.Icesickle,param1.game);
                    this.Icesickle.swordwrathType = "Icesickle";
                    this.Savagesickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.Savagesickle,param1.game);
                    this.Savagesickle.swordwrathType = "Savagesickle";
                    this.Lavasickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.Lavasickle,param1.game);
                    this.Lavasickle.swordwrathType = "Lavasickle";
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
                    this.SickleGeneral = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.SickleGeneral,param1.game);
                    this.SickleGeneral.swordwrathType = "SickleGeneral";
                    this.Baron = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.spawn(this.Baron,param1.game);
                    this.Baron.swordwrathType = "Baron";
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
                    this.SickleLeader = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                    param1.team.enemyTeam.spawn(this.SickleLeader,param1.game);
                    this.SickleLeader.swordwrathType = "SickleLeader";
                    this.tenMinTimer = -10;
               }
               if(!this.nah)
               {
                    this.nah = true;
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 35) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Savagesickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Savagesickle,param1.game);
                              this.Savagesickle.swordwrathType = "Savagesickle";
                              this.Leafsickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Leafsickle,param1.game);
                              this.Leafsickle.swordwrathType = "Leafsickle";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 140) == 0)
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
                    if(param1.game.frame % (30 * 50) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Icesickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Icesickle,param1.game);
                              this.Icesickle.swordwrathType = "Icesickle";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 63) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.Lavasickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(this.Lavasickle,param1.game);
                              this.Lavasickle.swordwrathType = "Lavasickle";
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
                         this.Vampsickle = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(this.Vampsickle,param1.game);
                         this.Vampsickle.swordwrathType = "Vampsickle";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
               if(this.sevenMinTimer < 0)
               {
                    if(this.SickleGeneral.isDead)
                    {
                         if(param1.game.frame % (30 * 50) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.SickleGeneral = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                                   param1.team.enemyTeam.spawn(this.SickleGeneral,param1.game);
                                   this.SickleGeneral.swordwrathType = "SickleGeneral";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.sevenMinTimer < 0)
               {
                    if(this.Baron.isDead)
                    {
                         if(param1.game.frame % (30 * 75) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.Baron = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                                   param1.team.spawn(this.Baron,param1.game);
                                   this.Baron.swordwrathType = "Baron";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.tenMinTimer < 0)
               {
                    if(this.SickleLeader.isDead)
                    {
                         if(param1.game.frame % (30 * 70) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,1);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   this.SickleLeader = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                                   param1.team.enemyTeam.spawn(this.SickleLeader,param1.game);
                                   this.SickleLeader.swordwrathType = "SickleLeader";
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                    }
               }
               if(this.twoMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 90) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 50) == 0)
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
               if(this.sevenMinTimer < 0)
               {
                    if(param1.game.frame % (30 * 155) == 0)
                    {
                         _loc6_ = Math.min(this.spawnNumber / 1,1);
                         _loc7_ = 0;
                         while(_loc7_ < _loc6_)
                         {
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              this.BloodBlade = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.spawn(this.BloodBlade,param1.game);
                              this.BloodBlade.swordwrathType = "BloodBlade";
                              _loc7_++;
                         }
                         ++this.spawnNumber;
                    }
               }
               if(param1.game.frame % (30 * 18) == 0)
               {
                    _loc6_ = Math.min(this.spawnNumber / 1,1);
                    _loc7_ = 0;
                    while(_loc7_ < _loc6_)
                    {
                         this.Sicklewrath = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(this.Sicklewrath,param1.game);
                         this.Sicklewrath.swordwrathType = "Sicklewrath";
                         _loc7_++;
                    }
                    ++this.spawnNumber;
               }
          }
     }
}
