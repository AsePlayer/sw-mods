package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.CampaignGameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.HoldCommand;
     import com.brockw.stickwar.engine.Ai.command.MoveCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.EnslavedGiant;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Medusa;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Swordwrath;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.MovieClip;
     import flash.geom.ColorTransform;
     
     public class CampaignCutScene1 extends CampaignController
     {
          
          private static const S_ARRIVED:int = -1;
          
          private static const S_MAN:int = 2;
          
          private static const S_OPINION:int = 3;
          
          private static const S_THE_GOAL:int = 4;
          
          private static const S_SET_UP:int = 5;
          
          private static const S_EXECUTION_1:int = 6;
          
          private static const S_MINER_WARNING:int = 7;
          
          private static const S_EXECUTION_2:int = 8;
          
          private static const S_MINER_WARNING_2:int = 9;
          
          private static const S_EXECUTION_3:int = 10;
          
          private static const S_MINER_WARNING_3:int = 11;
          
          private static const S_EXECUTION_4:int = 12;
          
          private static const S_MINER_WARNING_4:int = 13;
          
          private static const S_EXECUTION_5:int = 14;
          
          private static const S_MINER_WARNING_5:int = 15;
          
          private static const S_EXECUTION_6:int = 16;
          
          private static const S_MINER_WARNING_6:int = 17;
          
          private static const S_BEFORE_CUTSCENE:int = 18;
          
          private static const S_FADE_OUT:int = 19;
          
          private static const S_FADE_IN:int = 20;
          
          private static const S_MEDUSA_LEAVES:int = 21;
          
          private static const S_ENTER_REBELS:int = 22;
          
          private static const S_END:int = 23;
          
          private static const S_MEDUSA_TALKS_1:int = 24;
          
          private static const S_MEDUSA_TALKS_2:int = 25;
          
          private static const S_MEDUSA_TALKS_3:int = 26;
          
          private static const S_MEDUSA_TALKS_4:int = 27;
          
          private static const S_REBELS_TALK_1:int = 28;
          
          private static const S_REBELS_TALK_2:int = 29;
          
          private static const S_REBELS_TALK_3:int = 30;
          
          private static const S_REBELS_TALK_4:int = 31;
           
          
          private var state:int;
          
          private var counter:int;
          
          private var overlay:MovieClip;
          
          private var medusa:Unit;
          
          private var message:InGameMessage;
          
          private var rebelsAreEvil:Boolean;
          
          private var rebels:Array;
          
          private var CAP:Spearton;
          
          private var Bobby:Giant;
          
          private var spawnedCAP:Boolean;
          
          private var frames:int;
          
          public function CampaignCutScene1(param1:GameScreen)
          {
               super(param1);
               this.state = S_ARRIVED;
               this.counter = 0;
               this.CAP = null;
               this.Bobby = null;
               this.overlay = new MovieClip();
               this.overlay.graphics.beginFill(0,1);
               this.overlay.graphics.drawRect(0,0,850,750);
               this.rebels = [];
               this.rebelsAreEvil = true;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc3_:ColorTransform = null;
               var _loc4_:int = 0;
               var _loc5_:Giant = null;
               var _loc6_:StickWar = null;
               var _loc7_:Unit = null;
               var _loc8_:Number = NaN;
               var _loc9_:MoveCommand = null;
               var _loc10_:int = 0;
               var CAP:Spearton = null;
               var Bobby:Giant = null;
               if(this.message)
               {
                    this.message.update();
               }
               param1.team.enemyTeam.statue.health = 180;
               param1.team.enemyTeam.gold = 0;
               if(this.medusa)
               {
                    this.medusa.faceDirection(-1);
               }
               if(!this.rebelsAreEvil)
               {
                    for each(_loc2_ in this.rebels)
                    {
                         _loc3_ = _loc2_.mc.transform.colorTransform;
                         _loc3_.redOffset = 0;
                         _loc3_.blueOffset = 0;
                         _loc3_.greenOffset = 0;
                         _loc2_.mc.transform.colorTransform = _loc3_;
                    }
               }
               if(!this.spawnedCAP)
               {
                    this.state = S_ARRIVED;
                    this.counter = 0;
                    this.CAP = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                    param1.team.spawn(this.CAP,param1.game);
                    this.CAP.speartonType = "CAP";
                    _loc6_ = param1.game;
                    delete _loc6_.team.unitsAvailable[Unit.U_SWORDWRATH];
                    delete _loc6_.team.unitsAvailable[Unit.U_MINER];
                    delete _loc6_.team.unitsAvailable[Unit.U_NINJA];
                    delete _loc6_.team.unitsAvailable[Unit.U_ARCHER];
                    delete _loc6_.team.unitsAvailable[Unit.U_MONK];
                    delete _loc6_.team.unitsAvailable[Unit.U_MAGIKILL];
                    delete _loc6_.team.unitsAvailable[Unit.U_SPEARTON];
                    param1.game.soundManager.playSoundInBackground("");
                    this.spawnedCAP = true;
               }
               if(this.state == S_ARRIVED)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.CAP.px - param1.game.map.screenWidth / 2;
                    CampaignGameScreen(param1).doAiUpdates = false;
                    param1.userInterface.isGlobalsEnabled = false;
                    param1.userInterface.hud.hud.fastForward.visible = false;
                    param1.game.fogOfWar.isFogOn = true;
                    ++this.counter;
                    if(this.counter > 60)
                    {
                         this.state = S_MAN;
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
               else if(this.state == S_MAN)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.CAP.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("Man. I was just preparing to head back for Christmas. Now this place has swept away my holiday spirits.","Swordwrath",0,"LoginSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_OPINION;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_OPINION)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.CAP.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("I know you all don\'t wanna be here. But we need to figure out what\'s the cause of effect around here.","Scout Captain Stella",0,"speartonHoghSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         this.state = S_THE_GOAL;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_THE_GOAL)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = this.CAP.px - param1.game.map.screenWidth / 2;
                    this.message.setMessage("Let\'s find and capture any giants wandering around here. Perhaps Zilaros may have a trick up his sleeve with these evidence.","Scout Captain Stella",0,"speartonHoghSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_SET_UP;
                         this.counter = 0;
                         param1.userInterface.isSlowCamera = false;
                         CampaignGameScreen(param1).doAiUpdates = true;
                         param1.userInterface.isGlobalsEnabled = true;
                         param1.userInterface.hud.hud.fastForward.visible = true;
                         this.Bobby = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(this.Bobby,param1.game);
                         this.Bobby.giantType = "Bobby";
                    }
               }
               else if(this.state == S_SET_UP)
               {
                    if(this.Bobby.health < 2600)
                    {
                         this.state = S_EXECUTION_1;
                         this.counter = 0;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         param1.game.soundManager.playSoundInBackground("elementalInGame");
                    }
               }
               else if(this.state == S_EXECUTION_1)
               {
                    this.message.setMessage("How dare you meddle in these parts! Flee at once!.","????",0,"LoginSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_MINER_WARNING;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_MINER_WARNING)
               {
                    if(this.Bobby.health < 2100)
                    {
                         this.state = S_EXECUTION_2;
                         this.counter = 0;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_EXECUTION_2)
               {
                    this.message.setMessage("You must flee!","????",0,"LoginSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_MINER_WARNING_2;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_MINER_WARNING_2)
               {
                    if(this.Bobby.health < 1600)
                    {
                         this.state = S_EXECUTION_3;
                         this.counter = 0;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_EXECUTION_3)
               {
                    this.message.setMessage("If she finds out......We are all doom!","????",0,"LoginSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_MINER_WARNING_3;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_MINER_WARNING_3)
               {
                    if(this.Bobby.health < 1100)
                    {
                         this.state = S_EXECUTION_4;
                         this.counter = 0;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_EXECUTION_4)
               {
                    this.message.setMessage("We had no choice. You still have an option left.","????",0,"LoginSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_MINER_WARNING_4;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_MINER_WARNING_4)
               {
                    if(this.Bobby.health < 600)
                    {
                         this.state = S_EXECUTION_5;
                         this.counter = 0;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_EXECUTION_5)
               {
                    this.message.setMessage("It\'s too late.....","????",0,"LoginSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_MINER_WARNING_5;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_MINER_WARNING_5)
               {
                    if(this.Bobby.health < 200)
                    {
                         this.state = S_EXECUTION_6;
                         this.counter = 0;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         _loc2_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc2_,param1.game);
                         _loc2_.px = this.Bobby.px - 10;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_EXECUTION_6)
               {
                    this.message.setMessage("She\'s here......","????",0,"LoginSound");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_MINER_WARNING_6;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_MINER_WARNING_6)
               {
                    if(this.Bobby.isDead)
                    {
                         this.state = S_BEFORE_CUTSCENE;
                         this.counter = 0;
                         param1.game.soundManager.playSoundInBackground("");
                    }
               }
               if(this.state == S_BEFORE_CUTSCENE)
               {
                    _loc4_ = 0;
                    if(param1.team.enemyTeam.unitGroups[Unit.U_GIANT])
                    {
                         _loc4_ = 1;
                         if((_loc5_ = param1.team.enemyTeam.unitGroups[Unit.U_GIANT][0]) == null || _loc5_.health == 0)
                         {
                              _loc4_ = 0;
                         }
                    }
                    if(_loc4_ == 0)
                    {
                         this.state = S_FADE_OUT;
                         this.counter = 0;
                         param1.addChild(this.overlay);
                         this.overlay.alpha = 0;
                         param1.main.kongregateReportStatistic("killAGiant",1);
                         trace("Report Kill a giant");
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.isFastForward = false;
                         param1.userInterface.hud.hud.fastForward.visible = false;
                         param1.userInterface.selectedUnits.clear();
                    }
                    for each(_loc2_ in param1.game.team.units)
                    {
                         _loc2_.ai.mayAttack = false;
                    }
                    for each(_loc2_ in param1.game.team.enemyTeam.units)
                    {
                         _loc2_.ai.mayAttack = false;
                    }
               }
               else if(this.state == S_FADE_OUT)
               {
                    ++this.counter;
                    this.overlay.alpha = this.counter / 60;
                    if(this.counter > 45)
                    {
                         param1.game.team.cleanUpUnits();
                         param1.game.team.enemyTeam.cleanUpUnits();
                         param1.game.team.gold = param1.game.team.mana = 0;
                         param1.game.team.enemyTeam.gold = param1.game.team.enemyTeam.mana = 0;
                    }
                    if(this.counter > 60)
                    {
                         this.state = S_FADE_IN;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc7_ = EnslavedGiant(_loc6_.unitFactory.getUnit(Unit.U_ENSLAVED_GIANT));
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.enemyTeam.statue.x - 200;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc7_.ai.setCommand(_loc6_,new HoldCommand(_loc6_));
                         _loc7_.ai.mayAttack = false;
                         _loc7_ = Swordwrath(_loc6_.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.enemyTeam.statue.x - 200 + 50;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc7_.ai.setCommand(_loc6_,new HoldCommand(_loc6_));
                         _loc7_ = Swordwrath(_loc6_.unitFactory.getUnit(Unit.U_SWORDWRATH));
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.enemyTeam.statue.x - 200 + 50;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc7_.ai.setCommand(_loc6_,new HoldCommand(_loc6_));
                         _loc7_ = Spearton(_loc6_.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.enemyTeam.statue.x - 200 - 50;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc7_.ai.setCommand(_loc6_,new HoldCommand(_loc6_));
                         _loc7_ = Spearton(_loc6_.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.enemyTeam.statue.x - 200 - 50;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc7_.ai.setCommand(_loc6_,new HoldCommand(_loc6_));
                         this.CAP = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.spawn(this.CAP,param1.game);
                         this.CAP.speartonType = "CAP";
                         this.CAP.px = param1.team.enemyTeam.statue.x - 150;
                         this.CAP.py = _loc6_.map.height / 2;
                         this.CAP.ai.setCommand(_loc6_,new HoldCommand(_loc6_));
                         this.CAP.ai.mayAttack = false;
                         _loc7_ = Medusa(_loc6_.unitFactory.getUnit(Unit.U_MEDUSA));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         this.medusa = _loc7_;
                         _loc7_.ai.setCommand(_loc6_,new HoldCommand(_loc6_));
                         _loc7_.flyingHeight = 380;
                         _loc7_.pz = -_loc7_.flyingHeight;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc7_.y = 0;
                         _loc7_.px = param1.team.enemyTeam.homeX + param1.team.enemyTeam.direction * 100;
                         _loc7_.x = _loc7_.px;
                         _loc7_.faceDirection(-1);
                         param1.userInterface.selectedUnits.clear();
                         param1.game.soundManager.playSoundInBackground("chaosInGame");
                    }
               }
               else if(this.state == S_FADE_IN)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    ++this.counter;
                    this.overlay.alpha = (60 - this.counter) / 60;
                    if(this.counter > 60)
                    {
                         this.state = S_MEDUSA_TALKS_1;
                         param1.removeChild(this.overlay);
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                         param1.userInterface.selectedUnits.clear();
                    }
               }
               else if(this.state == S_MEDUSA_TALKS_1)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    this.message.setMessage("You fools thought Inamorta belonged to you!","????",0,"medusaVoice1");
                    ++this.counter;
                    if(this.counter > 150)
                    {
                         this.state = S_MEDUSA_TALKS_2;
                         this.counter = 0;
                         param1.userInterface.selectedUnits.clear();
                    }
               }
               else if(this.state == S_MEDUSA_TALKS_2)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    this.message.setMessage("We\'ve been here all along! Biding our time! Growing with power. While your armies destroy themselves in battles over lands that belongs to me!","????",0,"medusaVoice2");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_MEDUSA_TALKS_3;
                         this.counter = 0;
                         param1.userInterface.selectedUnits.clear();
                    }
               }
               else if(this.state == S_MEDUSA_TALKS_3)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    this.message.setMessage("But now you have enslaved my babies... and I, Queen Medusa, will wait no more... now you will feel the wrath of the Chaos Empire!","Queen Medusa",0,"medusaVoice3");
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_MEDUSA_LEAVES;
                         this.counter = 0;
                         param1.team.enemyTeam.garrison(true);
                         param1.userInterface.selectedUnits.clear();
                    }
               }
               else if(this.state == S_MEDUSA_LEAVES)
               {
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_ENTER_REBELS;
                         param1.game.soundManager.playSoundInBackground("");
                         for each(_loc2_ in param1.game.team.units)
                         {
                              _loc2_.forceFaceDirection(-1);
                         }
                         _loc8_ = param1.team.enemyTeam.statue.x - 600 - 400;
                         _loc7_ = (_loc6_ = param1.game).unitFactory.getUnit(Unit.U_NINJA);
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = _loc8_ - 75;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc9_ = new MoveCommand(_loc6_);
                         _loc9_.realX = _loc9_.goalX = _loc7_.px + 400;
                         _loc9_.realY = _loc9_.goalY = _loc7_.py;
                         _loc7_.ai.setCommand(_loc6_,_loc9_);
                         _loc7_.ai.mayAttack = false;
                         _loc7_.ai.mayMoveToAttack = false;
                         this.rebels.push(_loc7_);
                         _loc7_ = _loc6_.unitFactory.getUnit(Unit.U_MAGIKILL);
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = _loc8_;
                         _loc7_.py = _loc6_.map.height / 2;
                         (_loc9_ = new MoveCommand(_loc6_)).goalX = _loc7_.px + 400;
                         _loc9_.goalY = _loc7_.py;
                         _loc7_.ai.setCommand(_loc6_,_loc9_);
                         _loc7_.ai.mayAttack = false;
                         _loc7_.ai.mayMoveToAttack = false;
                         this.rebels.push(_loc7_);
                         _loc7_ = _loc6_.unitFactory.getUnit(Unit.U_MONK);
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = _loc8_ - 75;
                         _loc7_.py = _loc6_.map.height / 4;
                         (_loc9_ = new MoveCommand(_loc6_)).goalX = _loc7_.px + 400;
                         _loc9_.goalY = _loc7_.py;
                         _loc7_.ai.setCommand(_loc6_,_loc9_);
                         _loc7_.ai.mayAttack = false;
                         _loc7_.ai.mayMoveToAttack = false;
                         this.rebels.push(_loc7_);
                         _loc7_ = _loc6_.unitFactory.getUnit(Unit.U_ARCHER);
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = _loc8_ - 75;
                         _loc7_.py = 0;
                         (_loc9_ = new MoveCommand(_loc6_)).goalX = _loc7_.px + 400;
                         _loc9_.goalY = _loc7_.py;
                         _loc7_.ai.setCommand(_loc6_,_loc9_);
                         _loc7_.ai.mayAttack = false;
                         _loc7_.ai.mayMoveToAttack = false;
                         this.rebels.push(_loc7_);
                         _loc7_ = _loc6_.unitFactory.getUnit(Unit.U_SPEARTON);
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = _loc8_ - 75;
                         _loc7_.py = _loc6_.map.height;
                         (_loc9_ = new MoveCommand(_loc6_)).goalX = _loc7_.px + 400;
                         _loc9_.goalY = _loc7_.py;
                         _loc7_.ai.setCommand(_loc6_,_loc9_);
                         _loc7_.ai.mayAttack = false;
                         _loc7_.ai.mayMoveToAttack = false;
                         this.rebels.push(_loc7_);
                         for each(_loc2_ in this.rebels)
                         {
                              _loc3_ = _loc2_.mc.transform.colorTransform;
                              _loc10_ = _loc6_.random.nextInt();
                              _loc3_.redOffset = 75;
                              _loc3_.blueOffset = 0;
                              _loc3_.greenOffset = 0;
                              _loc2_.mc.transform.colorTransform = _loc3_;
                         }
                         this.counter = 0;
                    }
               }
               else if(this.state == S_ENTER_REBELS)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 900;
                    for each(_loc2_ in param1.game.team.units)
                    {
                         _loc2_.ai.mayAttack = false;
                         _loc2_.ai.mayMoveToAttack = false;
                    }
                    ++this.counter;
                    if(this.counter > 100)
                    {
                         this.state = S_REBELS_TALK_1;
                         this.counter = 0;
                         param1.userInterface.selectedUnits.clear();
                    }
               }
               else if(this.state == S_REBELS_TALK_1)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 900;
                    for each(_loc2_ in param1.game.team.units)
                    {
                         _loc2_.ai.mayAttack = false;
                         _loc2_.ai.mayMoveToAttack = false;
                    }
                    this.message.setMessage("Today we come together representing each of the rebel nations to offer a truce.","The Magikill",0,"wizardVoiceOver1");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_REBELS_TALK_2;
                         param1.userInterface.selectedUnits.clear();
                    }
               }
               else if(this.state == S_REBELS_TALK_2)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 900;
                    for each(_loc2_ in param1.game.team.units)
                    {
                         _loc2_.ai.mayAttack = false;
                         _loc2_.ai.mayMoveToAttack = false;
                    }
                    this.message.setMessage("We wish to join your Order Empire. Clearly there is a bigger threat that we can not face alone!","The Magikill",0,"wizardVoiceOver2");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_REBELS_TALK_3;
                         param1.userInterface.selectedUnits.clear();
                    }
               }
               else if(this.state == S_REBELS_TALK_3)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 900;
                    for each(_loc2_ in param1.game.team.units)
                    {
                         _loc2_.ai.mayAttack = false;
                         _loc2_.ai.mayMoveToAttack = false;
                    }
                    this.message.setMessage("That monster was right, all we\'ve been doing for years is making ourselves weak!","The Magikill",0,"wizardVoiceOver3");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_REBELS_TALK_4;
                         param1.game.soundManager.playSoundInBackground("OrderVictory");
                         param1.userInterface.selectedUnits.clear();
                         this.rebelsAreEvil = false;
                         for each(_loc2_ in this.rebels)
                         {
                              _loc2_.team.game.projectileManager.initTowerSpawn(_loc2_.px,_loc2_.py,_loc2_.team);
                         }
                    }
               }
               else if(this.state == S_REBELS_TALK_4)
               {
                    param1.userInterface.isSlowCamera = true;
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 900;
                    for each(_loc2_ in param1.game.team.units)
                    {
                         _loc2_.ai.mayAttack = false;
                         _loc2_.ai.mayMoveToAttack = false;
                    }
                    this.message.setMessage("Today, we can unite and share this new land so none shall live as rebels again!","The Magikill",0,"wizardVoiceOver4");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.team.enemyTeam.statue.health = 0;
                    }
               }
               super.update(param1);
          }
     }
}
