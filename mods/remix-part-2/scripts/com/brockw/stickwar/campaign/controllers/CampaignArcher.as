package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.CampaignGameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.MoveCommand;
     import com.brockw.stickwar.engine.Ai.command.StandCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Medusa;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignArcher extends CampaignController
     {
          
          private static const S_SHE:int = -1;
          
          private static const S_NO_WORRY_1:int = 0;
          
          private static const S_REVEAL:int = 1;
          
          private static const S_APPLAUSE:int = 2;
          
          private static const S_INTRO:int = 3;
          
          private static const S_NO_WORRY:int = 4;
          
          private static const S_REVEAL_1:int = 5;
          
          private static const S_LAUGH:int = 6;
          
          private static const S_FUCK_EM:int = 7;
          
          private static const S_STONE_DEAD:int = 8;
          
          private static const S_BRAINS:int = 9;
          
          private static const S_AFTERMATH:int = 10;
          
          private static const S_GG:int = 11;
           
          
          private var spawnedMedusa:Boolean;
          
          private var creation:Unit;
          
          private var GAG:Medusa;
          
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
          
          private var message:InGameMessage;
          
          private var frames:int;
          
          private var state:int;
          
          private var counter:int;
          
          private var spawnNumber:int;
          
          private var StoneDead:Dead;
          
          private var StoneDeadCracked:Dead;
          
          private var StoneDeadDown:Dead;
          
          private var MeatShield:Dead;
          
          public function CampaignArcher(param1:GameScreen)
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
               this.state = S_SHE;
               this.counter = 0;
               this.GAG = null;
               this.frames = 0;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc5_:Unit = null;
               var _loc3_:StandCommand = null;
               var _loc6_:StickWar = null;
               var _loc4_:int = 0;
               var _loc7_:int = 0;
               var _loc8_:Number = NaN;
               var _loc9_:MoveCommand = null;
               var GAG:Medusa = null;
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
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
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
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
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
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
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
               }
               if(this.sixMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.sixMinTimer;
                         }
                         --this.sixMinTimer;
                    }
               }
               else if(this.sixMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
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
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                    }
               }
               if(!this.spawnedMedusa)
               {
                    this.state = S_SHE;
                    this.counter = 0;
                    this.GAG = Medusa(param1.game.unitFactory.getUnit(Unit.U_MEDUSA));
                    param1.team.enemyTeam.spawn(this.GAG,param1.game);
                    this.GAG.medusaType = "GAG";
                    this.GAG.pz = 0;
                    this.GAG.y = param1.game.map.height / 2;
                    this.GAG.px = param1.team.statue.x + 600;
                    this.GAG.x = this.GAG.px;
                    _loc3_ = new StandCommand(param1.game);
                    this.GAG.ai.setCommand(param1.game,_loc3_);
                    this.GAG.ai.mayAttack = false;
                    this.GAG.ai.mayMoveToAttack = false;
                    _loc6_ = param1.game;
                    delete _loc6_.team.unitsAvailable[Unit.U_SWORDWRATH];
                    delete _loc6_.team.unitsAvailable[Unit.U_MINER];
                    delete _loc6_.team.unitsAvailable[Unit.U_NINJA];
                    delete _loc6_.team.unitsAvailable[Unit.U_ARCHER];
                    delete _loc6_.team.unitsAvailable[Unit.U_MONK];
                    delete _loc6_.team.unitsAvailable[Unit.U_MAGIKILL];
                    delete _loc6_.team.unitsAvailable[Unit.U_SPEARTON];
                    delete _loc6_.team.unitsAvailable[Unit.U_ENSLAVED_GIANT];
                    this.spawnedMedusa = true;
               }
               if(this.state == S_SHE)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.GAG.px - param1.game.map.screenWidth / 2;
                    CampaignGameScreen(param1).doAiUpdates = false;
                    param1.userInterface.isGlobalsEnabled = false;
                    param1.userInterface.hud.hud.fastForward.visible = false;
                    param1.game.fogOfWar.isFogOn = true;
                    ++this.counter;
                    if(this.counter > 60)
                    {
                         this.state = S_APPLAUSE;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_APPLAUSE)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.GAG.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("So you managed to prevailed. Impressive. Perhaps that leader of yours wasn\'t a fool as I thought.","Queen Medusa",0,"medusaVoice1");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_INTRO;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_INTRO)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.GAG.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("But do they know that The Conquering of theirs has perished nearly 100000 lives of Inamorta? Those who fought for what they deemed is right, were slaughtered without mercy?","Queen Medusa",0,"medusaVoice2");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_NO_WORRY;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_NO_WORRY)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.GAG.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("Well. You are lucky. I never let dead boddies go to waste. My mages and I have discovered a way to bring back these dead beings.","Queen Medusa",0,"medusaVoice2");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_NO_WORRY_1;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_NO_WORRY_1)
               {
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_REVEAL;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc2_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         this.creation = _loc2_;
                         this.creation.pz = 0;
                         this.creation.py = 3 * _loc6_.map.height / 4;
                         this.creation.px = param1.team.statue.x + 800;
                         this.creation.x = this.creation.px;
                         _loc9_ = new MoveCommand(_loc6_);
                         _loc9_.realX = _loc9_.goalX = this.creation.px - 200;
                         _loc9_.realY = _loc9_.goalY = this.creation.py;
                         this.creation.ai.setCommand(_loc6_,_loc9_);
                         this.creation.ai.mayAttack = false;
                         this.creation.ai.mayMoveToAttack = false;
                    }
               }
               else if(this.state == S_REVEAL)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.GAG.px - param1.game.map.screenWidth / 2;
                    ++this.counter;
                    if(this.counter > 100)
                    {
                         this.creation.ai.mayAttack = false;
                         this.creation.ai.mayMoveToAttack = false;
                         this.state = S_REVEAL_1;
                         this.counter = 0;
                    }
                    else
                    {
                         this.creation.ai.mayAttack = false;
                         this.creation.ai.mayMoveToAttack = false;
                    }
               }
               else if(this.state == S_REVEAL_1)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.GAG.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("Impressed by the major improvements my loyalists did? Now their hatred has consumed them, with an intention for your delicious mind set.","Queen Medusa",0,"medusaVoice2");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_LAUGH;
                         this.counter = 0;
                         this.creation.ai.mayAttack = false;
                         this.creation.ai.mayMoveToAttack = false;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_LAUGH)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.GAG.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("Muahahahahahahahaha.","Queen Medusa",0,"CancelMatchmakingSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_FUCK_EM;
                         this.counter = 0;
                         this.GAG.health = 0;
                         this.GAG.setFire(30 * 35,900);
                         this.creation.health = -1;
                         this.creation.setFire(30 * 35,900);
                         param1.game.targetScreenX = param1.game.team.statue.x - 325;
                         param1.game.screenX = param1.game.team.statue.x - 325;
                         param1.userInterface.isSlowCamera = false;
                         CampaignGameScreen(param1).doAiUpdates = true;
                         param1.userInterface.isGlobalsEnabled = true;
                         param1.userInterface.hud.hud.fastForward.visible = true;
                         _loc6_ = param1.game;
                         param1.team.unitsAvailable[Unit.U_SWORDWRATH] = 1;
                         param1.team.unitsAvailable[Unit.U_MINER] = 1;
                         param1.team.unitsAvailable[Unit.U_NINJA] = 1;
                         param1.team.unitsAvailable[Unit.U_ARCHER] = 1;
                         param1.team.unitsAvailable[Unit.U_SPEARTON] = 1;
                         param1.team.unitsAvailable[Unit.U_MONK] = 1;
                         param1.team.unitsAvailable[Unit.U_MAGIKILL] = 1;
                         param1.team.unitsAvailable[Unit.U_ENSLAVED_GIANT] = 1;
                         _loc6_.team.spawnUnitGroup([Unit.U_MINER,Unit.U_MINER,Unit.U_MINER,Unit.U_MINER,Unit.U_SWORDWRATH]);
                         _loc6_.team.enemyTeam.spawnUnitGroup([Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_DEAD]);
                         _loc6_.team.gold = 500;
                         _loc6_.team.mana = 0;
                         _loc6_.team.enemyTeam.gold = 500;
                         _loc6_.team.enemyTeam.mana = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_FUCK_EM)
               {
                    this.message.setMessage("Feast your eyes upon this toxidieous creation. WITH A MILLION MORE ON THE WAY!","Queen Medusa",0,"youMustAllDie");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_STONE_DEAD;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_STONE_DEAD)
               {
                    if(param1.team.enemyTeam.statue.health <= 200 && param1.team.enemyTeam.statue.maxHealth != 2800)
                    {
                         param1.team.enemyTeam.statue.health += 2800;
                         param1.team.enemyTeam.statue.maxHealth = 2800;
                         param1.team.enemyTeam.statue.healthBar.totalHealth = param1.team.enemyTeam.statue.maxHealth;
                         param1.team.enemyTeam.gold += 0;
                         param1.team.enemyTeam.mana += 0;
                         this.StoneDead = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(this.StoneDead,param1.game);
                         this.StoneDead.deadType = "StoneDead";
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         this.state = S_BRAINS;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_BRAINS)
               {
                    this.message.setMessage("Braaainsss..........","????",0,"GiantGrowl1");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_AFTERMATH;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_AFTERMATH)
               {
                    if(!this.StoneDead.isAlive())
                    {
                         this.state = S_GG;
                         this.counter = 0;
                    }
                    else
                    {
                         param1.game.team.enemyTeam.attack(true);
                         if(param1.game.frame % (30 * 30) == 0)
                         {
                              this.MeatShield = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                              param1.team.enemyTeam.spawn(this.MeatShield,param1.game);
                              this.MeatShield.deadType = "MeatShield";
                         }
                    }
               }
               else if(this.state == S_GG)
               {
               }
          }
     }
}
