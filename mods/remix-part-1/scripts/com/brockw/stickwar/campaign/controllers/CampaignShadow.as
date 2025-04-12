package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Archer;
     import com.brockw.stickwar.engine.units.Ninja;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignShadow extends CampaignController
     {
          
          private static const S_WRATH_ATTACK:int = -1;
          
          private static const S_UNDERESTIMATE:int = 2;
          
          private static const S_RELEASE:int = 3;
          
          private static const S_GOOD_LUCK:int = 4;
          
          private static const S_CONTINUE:int = 4;
           
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var threeMinTimer:int;
          
          private var threeMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var tenMinConstant:int;
          
          private var message:InGameMessage;
          
          private var frames:int;
          
          private var HankShadowrath:Ninja;
          
          private var EnchantedRebelSword:Swordwrath;
          
          private var EnchantedRebelArcher:Archer;
          
          private var SpeartonLeader:Spearton;
          
          private var swordSpawner:Boolean = false;
          
          private var ninjaSpawner:Boolean = false;
          
          private var state:int;
          
          private var counter:int = 0;
          
          private var spawnNumber:int;
          
          public function CampaignShadow(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 60;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 120;
               this.twoMinConstant = this.twoMinTimer;
               this.threeMinTimer = 30 * 180;
               this.threeMinConstant = this.threeMinTimer;
               super(param1);
               this.state = S_WRATH_ATTACK;
               this.counter = 0;
               this.spawnNumber = 0;
               this.SpeartonLeader = null;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc3_:StickWar = null;
               var _loc6_:int = 0;
               var _loc7_:int = 0;
               var enemyStatue:Statue = null;
               param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
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
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
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
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.threeMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.threeMinTimer;
                         }
                         --this.threeMinTimer;
                    }
               }
               else if(this.threeMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 90) == 0)
                    {
                         this.HankShadowrath = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                         param1.team.enemyTeam.spawn(this.HankShadowrath,param1.game);
                         this.HankShadowrath.ninjaType = "HankShadowrath";
                    }
               }
               if(this.state == S_WRATH_ATTACK)
               {
                    if(param1.team.enemyTeam.statue.health <= 200 && param1.team.enemyTeam.statue.maxHealth != 1600)
                    {
                         param1.team.enemyTeam.statue.health += 1600;
                         param1.team.enemyTeam.statue.maxHealth = 1600;
                         param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                         param1.team.enemyTeam.gold += 5000;
                         param1.team.enemyTeam.mana += 5000;
                         this.SpeartonLeader = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.enemyTeam.spawn(this.SpeartonLeader,param1.game);
                         this.SpeartonLeader.speartonType = "SpeartonLeader";
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         this.state = S_UNDERESTIMATE;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_UNDERESTIMATE)
               {
                    this.message.setMessage("Suprised! Did you expect us to go down without a backup plan?","",0,"Rage1");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_RELEASE;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_RELEASE)
               {
                    if(!this.SpeartonLeader.isAlive())
                    {
                         this.state = S_GOOD_LUCK;
                         this.counter = 0;
                    }
                    else
                    {
                         param1.game.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 15) == 0)
                         {
                              _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                         if(param1.game.frame % (30 * 25) == 0)
                         {
                              _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         }
                    }
               }
               else if(this.state == S_GOOD_LUCK)
               {
                    if(this.SpeartonLeader.isDead)
                    {
                         param1.game.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 5) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 4,6,8,10);
                              _loc7_ = 0;
                              while(_loc7_ < _loc6_)
                              {
                                   _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                                   param1.team.enemyTeam.spawn(_loc2_,param1.game);
                                   _loc7_++;
                              }
                              ++this.spawnNumber;
                         }
                         if(param1.game.frame % (30 * 7) == 0)
                         {
                              _loc6_ = Math.min(this.spawnNumber / 1,2,3);
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
               }
               else if(this.state == S_CONTINUE)
               {
               }
          }
     }
}
