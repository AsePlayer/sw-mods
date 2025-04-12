package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.Ai.command.StandCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Giant;
     import com.brockw.stickwar.engine.units.Knight;
     import com.brockw.stickwar.engine.units.Miner;
     import com.brockw.stickwar.engine.units.Skelator;
     import com.brockw.stickwar.engine.units.Spearton;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.Wingidon;
     
     public class CampaignDeads extends CampaignController
     {
          
          private static const S_SCENE:int = -1;
          
          private static const S_PERSPECTIVE:int = 2;
          
          private static const S_GUESS:int = 3;
          
          private static const S_FEAR:int = 4;
          
          private static const S_PUNY:int = 5;
          
          private static const S_NEWS:int = 6;
          
          private static const S_DEFENSE:int = 7;
          
          private static const S_DEFENSE_2:int = 8;
          
          private static const S_DEFENSE_3:int = 9;
          
          private static const S_DEFENSE_4:int = 10;
          
          private static const S_DEFENSE_5:int = 11;
          
          private static const S_FINALE:int = 12;
           
          
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
          
          private var Griffon:Giant;
          
          private var GateKnight:Knight;
          
          private var defenseline:Boolean;
          
          private var defense2line:Boolean;
          
          private var defense3line:Boolean;
          
          private var defense4line:Boolean;
          
          private var defense5line:Boolean;
          
          public function CampaignDeads(param1:GameScreen)
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
               this.state = S_SCENE;
               this.counter = 0;
               this.spawnNumber = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc7_:Unit = null;
               var _loc3_:StandCommand = null;
               var _loc6_:StickWar = null;
               if(this.message)
               {
                    this.message.update();
               }
               param1.team.enemyTeam.attack(true);
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
                    if(param1.game.frame % (30 * 30) == 0)
                    {
                         _loc7_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,param1.game);
                         _loc7_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,param1.game);
                         _loc7_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,param1.game);
                         _loc7_ = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,param1.game);
                         this.GateKnight = Knight(param1.game.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(this.GateKnight,param1.game);
                         this.GateKnight.knightType = "GateKnight";
                         _loc7_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,param1.game);
                         _loc7_ = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,param1.game);
                         _loc7_ = Skelator(param1.game.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc7_,param1.game);
                         _loc7_ = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc7_,param1.game);
                    }
               }
               if(this.state == S_SCENE)
               {
                    if(param1.game.team.gold > 10)
                    {
                         this.state = S_PERSPECTIVE;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc7_ = Spearton(_loc6_.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 50;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Miner(_loc6_.unitFactory.getUnit(Unit.U_MINER));
                         param1.team.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 50;
                         _loc7_.py = 2 * _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_PERSPECTIVE)
               {
                    this.message.setMessage("The Chaos Empire looks to had build a strong line around these grounds.","Miner",0,"LoginSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_GUESS;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_GUESS)
               {
                    this.message.setMessage("We must be getting close to the Chaos capital.","Spearton",0,"speartonHoghSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_FEAR;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_FEAR)
               {
                    this.message.setMessage("Their defenses looks greatly maned. I fear our men won\'t wistand long enough to break through those lines.","Spearton",0,"speartonHoghSound");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_PUNY;
                         this.counter = 0;
                         this.Griffon = Giant(param1.game.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(this.Griffon,param1.game);
                         this.Griffon.giantType = "Griffon";
                         this.Griffon.pz = 0;
                         this.Griffon.y = param1.game.map.height / 2;
                         this.Griffon.px = param1.team.statue.x - 200;
                         this.Griffon.x = this.Griffon.px;
                         param1.team.enemyTeam.switchTeams(this.Griffon);
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_PUNY)
               {
                    this.message.setMessage("Move aside, puny thing.","????",0,"GiantGrowl1");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_NEWS;
                         this.counter = 0;
                         this.message = new InGameMessage("",param1.game);
                         this.message.x = param1.game.stage.stageWidth / 2;
                         this.message.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message.scaleX *= 1.3;
                         this.message.scaleY *= 1.3;
                         param1.addChild(this.message);
                    }
               }
               else if(this.state == S_NEWS)
               {
                    this.message.setMessage("It\'s the Great Griffon from No Man\'s Land. He seems to have joined the battle to get his revenge over Medusa for capturing his followers!","Zilaros",0,"voiceTutorial18");
                    if(this.message.hasFinishedPlayingSound())
                    {
                         param1.removeChild(this.message);
                         this.state = S_DEFENSE;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc6_.team.spawnUnitGroup([Unit.U_MINER,Unit.U_MINER,Unit.U_MINER,Unit.U_MINER,Unit.U_MINER,Unit.U_SWORDWRATH,Unit.U_SWORDWRATH,Unit.U_SWORDWRATH,Unit.U_SWORDWRATH,Unit.U_SPEARTON,Unit.U_SPEARTON,Unit.U_SPEARTON,Unit.U_SPEARTON,Unit.U_ARCHER,Unit.U_ARCHER,Unit.U_ARCHER,Unit.U_ARCHER,Unit.U_MONK,Unit.U_MONK,Unit.U_MAGIKILL]);
                         _loc6_.team.enemyTeam.spawnUnitGroup([Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_CHAOS_MINER,Unit.U_DEAD,Unit.U_DEAD,Unit.U_WINGIDON,Unit.U_WINGIDON,Unit.U_KNIGHT,Unit.U_CAT,Unit.U_CAT,Unit.U_CAT,Unit.U_CAT,Unit.U_SKELATOR]);
                         _loc6_.team.gold = 10000;
                         _loc6_.team.mana = 10000;
                         _loc6_.team.enemyTeam.gold = 5000;
                         _loc6_.team.enemyTeam.mana = 5000;
                    }
               }
               else if(this.state == S_DEFENSE)
               {
                    if(this.Griffon.px > 200)
                    {
                         this.state = S_DEFENSE_2;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 700;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 700;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 700;
                         _loc7_.py = 2 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 700;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 700;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 800;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 800;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 800;
                         _loc7_.py = 2 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 900;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 800;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 900;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 900;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 900;
                         _loc7_.py = 2 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 900;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 900;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                    }
                    else if(this.Griffon.isDead)
                    {
                         param1.team.statue.health = 0;
                    }
               }
               else if(this.state == S_DEFENSE_2)
               {
                    if(this.Griffon.px > 2200)
                    {
                         this.state = S_DEFENSE_3;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc7_ = Giant(_loc6_.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2700;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Giant(_loc6_.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2700;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2700;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2700;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2700;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2700;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Skelator(_loc6_.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2800;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Bomber(_loc6_.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2800;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Bomber(_loc6_.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2800;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Bomber(_loc6_.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 2800;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                    }
                    else if(this.Griffon.isDead)
                    {
                         param1.team.statue.health = 0;
                    }
               }
               else if(this.state == S_DEFENSE_3)
               {
                    if(this.Griffon.px > 3600)
                    {
                         this.state = S_DEFENSE_4;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4200;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Wingidon(_loc6_.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4200;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Wingidon(_loc6_.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4200;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Giant(_loc6_.unitFactory.getUnit(Unit.U_GIANT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4200;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Skelator(_loc6_.unitFactory.getUnit(Unit.U_SKELATOR));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4300;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Wingidon(_loc6_.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4300;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Wingidon(_loc6_.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4300;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Wingidon(_loc6_.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4300;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Wingidon(_loc6_.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4300;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Wingidon(_loc6_.unitFactory.getUnit(Unit.U_WINGIDON));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 4300;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                    }
                    else if(this.Griffon.isDead)
                    {
                         param1.team.statue.health = 0;
                    }
               }
               else if(this.state == S_DEFENSE_4)
               {
                    if(this.Griffon.px > 4700)
                    {
                         this.state = S_DEFENSE_5;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5400;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5400;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5400;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5400;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5400;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5500;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5500;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5500;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5500;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Cat(_loc6_.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5500;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5600;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5600;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5600;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5600;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Knight(_loc6_.unitFactory.getUnit(Unit.U_KNIGHT));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 5600;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                    }
                    else if(this.Griffon.isDead)
                    {
                         param1.team.statue.health = 0;
                    }
               }
               else if(this.state == S_DEFENSE_5)
               {
                    if(this.Griffon.px > 5800)
                    {
                         this.state = S_FINALE;
                         this.counter = 0;
                         _loc6_ = param1.game;
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 6000;
                         _loc7_.py = _loc6_.map.height / 2;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 6000;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 6000;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 6000;
                         _loc7_.py = _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                         _loc7_ = Dead(_loc6_.unitFactory.getUnit(Unit.U_DEAD));
                         param1.team.enemyTeam.spawn(_loc7_,_loc6_);
                         _loc7_.px = param1.team.statue.x + 6000;
                         _loc7_.py = 3 * _loc6_.map.height / 4;
                         _loc3_ = new StandCommand(param1.game);
                         _loc7_.ai.setCommand(param1.game,_loc3_);
                    }
                    else if(this.Griffon.isDead)
                    {
                         param1.team.statue.health = 0;
                    }
               }
               else if(this.state == S_FINALE)
               {
               }
          }
     }
}
