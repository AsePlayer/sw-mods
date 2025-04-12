package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignTutorial extends CampaignController
     {
          
          private static const S_BULL:int = -1;
          
          private static const S_BULLDOZER_WARNING:int = 2;
          
          private static const S_MINI_PHASE:int = 3;
           
          
          private var counter:int;
          
          private var message:InGameMessage;
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var threeMinTimer:int;
          
          private var threeMinConstant:int;
          
          private var fourMinTimer:int;
          
          private var fourMinConstant:int;
          
          private var fiveMinTimer:int;
          
          private var fiveMinConstant:int;
          
          private var sixMinTimer:int;
          
          private var sixMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var eightMinTimer:int;
          
          private var eightMinConstant:int;
          
          private var nineMinTimer:int;
          
          private var nineMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var tenMinConstant:int;
          
          private var frames:int;
          
          private var state:int;
          
          private var spawnNumber:int;
          
          private var BullKnight:Knight;
          
          private var StoneDead:Dead;
          
          private var StoneDeadCracked:Dead;
          
          private var StoneDeadDown:Dead;
          
          private var TheMagikill:Magikill;
          
          private var Ilovefuckingswordwraths:Knight;
          
          private var Archeraboooose:Knight;
          
          private var MeatShield:Dead;
          
          public function CampaignTutorial(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 60;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 120;
               this.twoMinConstant = this.twoMinTimer;
               this.threeMinTimer = 30 * 180;
               this.threeMinConstant = this.threeMinTimer;
               this.fourMinTimer = 30 * 240;
               this.fourMinConstant = this.fourMinTimer;
               this.fiveMinTimer = 30 * 300;
               this.fiveMinConstant = this.fiveMinTimer;
               this.sixMinTimer = 30 * 360;
               this.sixMinConstant = this.sixMinTimer;
               this.sevenMinTimer = 30 * 420;
               this.sevenMinConstant = this.sevenMinTimer;
               this.eightMinTimer = 30 * 480;
               this.eightMinConstant = this.eightMinTimer;
               this.nineMinTimer = 30 * 540;
               this.nineMinConstant = this.nineMinTimer;
               this.tenMinTimer = 30 * 600;
               this.tenMinConstant = this.tenMinTimer;
               super(param1);
               this.state = S_BULL;
               this.frames = 0;
               this.counter = 0;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var enemyStatue:Statue = null;
               if(param1.game.frame % (30 * 30) == 0)
               {
                    _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                    param1.team.enemyTeam.spawn(_loc2_,param1.game);
               }
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
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
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
                    if(param1.game.frame % (30 * 30) == 0)
                    {
                         _loc2_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.fourMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.fourMinTimer;
                         }
                         --this.fourMinTimer;
                    }
               }
               else if(this.fourMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.fiveMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.fiveMinTimer;
                         }
                         --this.fiveMinTimer;
                    }
               }
               else if(this.fiveMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 120) == 0)
                    {
                         _loc2_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(this.state == S_BULL)
               {
                    if(param1.team.enemyTeam.statue.health <= 200 && param1.team.enemyTeam.statue.maxHealth != 2700)
                    {
                         param1.team.enemyTeam.statue.health += 2700;
                         param1.team.enemyTeam.statue.maxHealth = 2700;
                         param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                         param1.team.enemyTeam.gold += 0;
                         param1.team.enemyTeam.mana += 0;
                         this.BullKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(this.BullKnight,param1.game);
                         this.BullKnight.knightType = "BullKnight";
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         this.state = S_BULLDOZER_WARNING;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_BULLDOZER_WARNING)
               {
                    this.message.setMessage("Release the Bull Knight. Fuck these foolish rats.","Queen Medusa",0,"medusaVoice1");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_MINI_PHASE;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_MINI_PHASE)
               {
               }
          }
     }
}
