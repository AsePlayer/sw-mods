package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.*;
     import com.brockw.stickwar.engine.Ai.*;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.*;
     import com.brockw.stickwar.engine.multiplayer.moves.*;
     import com.brockw.stickwar.engine.units.*;
     import com.brockw.stickwar.engine.units.elementals.*;
     import flash.display.*;
     import flash.geom.ColorTransform;
     
     public class CampaignRebels extends CampaignController
     {
          
          private static const S_FADE_OUT:int = 0;
          
          private static const S_FADE_IN:int = 1;
          
          private static const S_KING_LEAVES:int = 3;
          
          private static const S_ENTER_REBELS:int = 4;
          
          private static const S_END:int = 6;
          
          private static const S_KING_TALKS_1:int = 2;
          
          private static const S_KING_TALKS_2:int = 7;
          
          private static const S_KING_TALKS_3:int = 8;
          
          private static const S_KING_TALKS_4:int = 9;
          
          private static const S_TALKS_0:int = 10;
          
          private static const S_TALKS_1:int = 11;
          
          private static const S_TALKS_2:int = 12;
          
          private static const S_TALKS_3:int = 13;
          
          private static const S_TALKS_4:int = 14;
          
          private static const S_TALKS_5:int = 15;
          
          private static const S_TALKS_6:int = 16;
          
          private static const S_TALKS_7:int = 17;
          
          private static const S_TALKS_8:int = 18;
          
          private static const S_TALKS_9:int = 19;
          
          private static const S_END_TALKS:int = 20;
          
          private static const S_DONE:int = -1;
           
          
          private var state:int;
          
          private var counter:int;
          
          private var overlay:MovieClip;
          
          private var v:ChromeElement;
          
          private var scrollingStoneX:Number;
          
          private var nah:Boolean = false;
          
          private var bruh:Boolean = false;
          
          private var message:InGameMessage;
          
          private var message3:InGameMessage;
          
          private var rebelsAreEvil:Boolean;
          
          private var rebels:Array;
          
          private var frames:int;
          
          public function CampaignRebels(param1:GameScreen)
          {
               super(param1);
               this.state = S_FADE_OUT;
               this.counter = 0;
               this.overlay = new MovieClip();
               this.overlay.graphics.beginFill(0,1);
               this.overlay.graphics.drawRect(0,0,850,750);
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               var _loc3_:ColorTransform = null;
               var _loc4_:int = 0;
               var _loc5_:ChromeElement = null;
               var _loc6_:StickWar = null;
               var _loc7_:Unit = null;
               var _loc8_:Number = NaN;
               var _loc9_:MoveCommand = null;
               var _loc10_:int = 0;
               var _loc11_:Number = NaN;
               var c:Spearton = null;
               var d:Spearton = null;
               var v:ChromeElement = null;
               if(this.message)
               {
                    this.message.update();
               }
               if(this.message3 && param1.contains(this.message3))
               {
                    this.message3.update();
                    if(this.frames++ > 30 * 3)
                    {
                         param1.removeChild(this.message3);
                    }
               }
               if(!this.bruh && param1.team.statue.health < param1.team.statue.maxHealth / 2.5)
               {
                    this.message3 = new InGameMessage("",param1.game);
                    this.message3.x = param1.game.stage.stageWidth / 2;
                    this.message3.y = param1.game.stage.stageHeight / 4 - 75;
                    this.message3.scaleX *= 1.3;
                    this.message3.scaleY *= 1.3;
                    param1.addChild(this.message3);
                    this.message3.setMessage("We are here to help","Aid",0,"StartMatchmaking");
                    this.frames = 0;
                    param1.team.spawnUnitGroup([Unit.U_WATER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_AIR_ELEMENT,Unit.U_FIRE_ELEMENT,Unit.U_WATER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_AIR_ELEMENT,Unit.U_FIRE_ELEMENT]);
                    this.bruh = true;
               }
               if(!param1.isPaused)
               {
                    if(this.state == S_FADE_OUT)
                    {
                         ++this.counter;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         param1.game.targetScreenX = param1.team.homeX;
                         param1.game.screenX = param1.team.homeX;
                         if(this.counter > 60)
                         {
                              this.state = S_FADE_IN;
                              this.counter = 0;
                              _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 2;
                              _loc2_.px = param1.game.map.width / 2 + 500;
                              _loc2_.faceDirection(-1);
                              this.scrollingStoneX = param1.team.homeX;
                         }
                    }
                    else if(this.state == S_FADE_IN)
                    {
                         param1.game.targetScreenX = this.scrollingStoneX;
                         param1.game.screenX = this.scrollingStoneX;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.scrollingStoneX += 20;
                         if(this.scrollingStoneX > param1.game.map.width / 2 + 100)
                         {
                              this.scrollingStoneX = param1.game.map.width / 2 + 100;
                         }
                         ++this.counter;
                         if(this.counter > 150)
                         {
                              this.state = S_KING_TALKS_1;
                              this.counter = 0;
                              this.message = new InGameMessage("",param1.game);
                              this.message.x = param1.game.stage.stageWidth / 2;
                              this.message.y = param1.game.stage.stageHeight / 4 - 75;
                              this.message.scaleX *= 1.3;
                              this.message.scaleY *= 1.3;
                              param1.addChild(this.message);
                         }
                    }
                    else if(this.state == S_KING_TALKS_1)
                    {
                         param1.game.targetScreenX = this.scrollingStoneX;
                         param1.game.screenX = this.scrollingStoneX;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("Who are they?","Shadowrath");
                         ++this.counter;
                         if(this.counter > 90)
                         {
                              this.state = S_KING_TALKS_2;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_KING_TALKS_2)
                    {
                         param1.game.targetScreenX = this.scrollingStoneX;
                         param1.game.screenX = this.scrollingStoneX;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("Could it be that you are the people of the Order Empire?","Shadowrath");
                         ++this.counter;
                         if(this.counter > 90)
                         {
                              this.state = S_KING_TALKS_3;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_KING_TALKS_3)
                    {
                         param1.game.targetScreenX = this.scrollingStoneX;
                         param1.game.screenX = this.scrollingStoneX;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("Damn! Could it be the Chaos Empire has been defeated?","Shadowrath");
                         ++this.counter;
                         if(this.counter > 90)
                         {
                              this.state = S_KING_TALKS_4;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_KING_TALKS_4)
                    {
                         param1.game.targetScreenX = this.scrollingStoneX;
                         param1.game.screenX = this.scrollingStoneX;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("I must urgently mobilize the army.","Shadowrath");
                         ++this.counter;
                         if(this.counter > 90)
                         {
                              param1.game.team.enemyTeam.defend(true);
                         }
                         if(this.counter > 120)
                         {
                              this.state = S_KING_LEAVES;
                              this.counter = 0;
                              param1.game.team.enemyTeam.defend(true);
                              param1.removeChild(this.message);
                         }
                    }
                    else if(this.state == S_KING_LEAVES)
                    {
                         CampaignGameScreen(param1).doAiUpdates = true;
                         param1.userInterface.isGlobalsEnabled = true;
                         param1.game.fogOfWar.isFogOn = true;
                         param1.userInterface.isSlowCamera = false;
                         param1.userInterface.selectedUnits.refresh();
                         ++this.counter;
                         if(!this.nah)
                         {
                              param1.game.targetScreenX = param1.team.homeX;
                              this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                              param1.team.spawn(this.v,param1.game);
                              this.v.vType = "v";
                              param1.team.enemyTeam.spawnUnitGroup([Unit.U_MONK,Unit.U_ARCHER]);
                              this.nah = true;
                         }
                         if(this.counter > 10)
                         {
                              this.state = S_DONE;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_DONE)
                    {
                         _loc4_ = 0;
                         if(param1.team.enemyTeam.statue.health > param1.team.enemyTeam.statue.maxHealth / 2.5)
                         {
                              _loc4_ = 1;
                              if(param1.team.enemyTeam.statue.health < param1.team.enemyTeam.statue.maxHealth / 2.5)
                              {
                                   _loc4_ = 0;
                              }
                         }
                         if(_loc4_ == 0)
                         {
                              this.state = S_TALKS_0;
                              this.counter = 0;
                              param1.addChild(this.overlay);
                              this.overlay.alpha = 0;
                              param1.main.kongregateReportStatistic("killAGiant",1);
                              trace("Report Kill a giant");
                         }
                    }
                    else if(this.state == S_TALKS_0)
                    {
                         ++this.counter;
                         this.overlay.alpha = this.counter / 60;
                         if(this.counter > 45)
                         {
                              param1.game.fogOfWar.isFogOn = false;
                              CampaignGameScreen(param1).doAiUpdates = false;
                              param1.userInterface.isGlobalsEnabled = false;
                              param1.userInterface.isSlowCamera = true;
                              param1.game.team.cleanUpUnits();
                              param1.game.team.enemyTeam.cleanUpUnits();
                              param1.game.team.gold = param1.game.team.mana = 0;
                              param1.game.team.enemyTeam.gold = param1.game.team.enemyTeam.mana = 0;
                              param1.team.enemyTeam.statue.health = param1.team.enemyTeam.statue.maxHealth / 2.5;
                              param1.userInterface.selectedUnits.clear();
                              if(param1.game.team.enemyTeam.tech.isResearchedMap[Tech.CASTLE_ARCHER_3] == true)
                              {
                                   delete param1.game.team.enemyTeam.tech.isResearchedMap[Tech.CASTLE_ARCHER_3];
                              }
                              if(param1.game.team.enemyTeam.tech.isResearchedMap[Tech.CASTLE_ARCHER_2] == true)
                              {
                                   delete param1.game.team.enemyTeam.tech.isResearchedMap[Tech.CASTLE_ARCHER_2];
                              }
                              if(param1.game.team.enemyTeam.tech.isResearchedMap[Tech.CASTLE_ARCHER_1] == true)
                              {
                                   delete param1.game.team.enemyTeam.tech.isResearchedMap[Tech.CASTLE_ARCHER_1];
                              }
                              if(param1.game.team.enemyTeam.tech.isResearchedMap[Tech.TOWER_SPAWN_II] == true)
                              {
                                   delete param1.game.team.enemyTeam.tech.isResearchedMap[Tech.TOWER_SPAWN_II];
                              }
                              if(param1.game.team.enemyTeam.tech.isResearchedMap[Tech.TOWER_SPAWN_I] == true)
                              {
                                   delete param1.game.team.enemyTeam.tech.isResearchedMap[Tech.TOWER_SPAWN_I];
                              }
                              if(param1.game.team.tech.isResearchedMap[Tech.TOWER_SPAWN_II] == true)
                              {
                                   delete param1.game.team.tech.isResearchedMap[Tech.TOWER_SPAWN_II];
                              }
                              if(param1.game.team.tech.isResearchedMap[Tech.TOWER_SPAWN_I] == true)
                              {
                                   delete param1.game.team.tech.isResearchedMap[Tech.TOWER_SPAWN_I];
                              }
                         }
                         if(this.counter > 60)
                         {
                              this.state = S_TALKS_1;
                              this.counter = 0;
                              this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                              param1.team.spawn(this.v,param1.game);
                              this.v.vType = "v";
                              this.v.px = param1.team.enemyTeam.statue.x - 700;
                              this.v.py = param1.game.map.height / 2;
                              this.v.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              this.v.ai.mayAttack = false;
                              _loc2_ = EarthElement(param1.game.unitFactory.getUnit(Unit.U_EARTH_ELEMENT));
                              param1.team.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 3 * 2;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 650;
                              _loc2_.ai.mayAttack = false;
                              _loc2_ = WaterElement(param1.game.unitFactory.getUnit(Unit.U_WATER_ELEMENT));
                              param1.team.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 3;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 650;
                              _loc2_.ai.mayAttack = false;
                              _loc2_ = FireElement(param1.game.unitFactory.getUnit(Unit.U_FIRE_ELEMENT));
                              param1.team.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 3 * 2;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 750;
                              _loc2_.ai.mayAttack = false;
                              _loc2_ = AirElement(param1.game.unitFactory.getUnit(Unit.U_AIR_ELEMENT));
                              param1.team.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 3;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 750;
                              _loc2_.ai.mayAttack = false;
                              _loc2_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 3 * 2;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 300;
                              _loc2_.faceDirection(-1);
                              _loc2_ = Swordwrath(param1.game.unitFactory.getUnit(Unit.U_SWORDWRATH));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 3;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 300;
                              _loc2_.faceDirection(-1);
                              _loc2_ = Magikill(param1.game.unitFactory.getUnit(Unit.U_MAGIKILL));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 2;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 200;
                              _loc2_.faceDirection(-1);
                              _loc2_ = Monk(param1.game.unitFactory.getUnit(Unit.U_MONK));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 3;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 100;
                              _loc2_.faceDirection(-1);
                              _loc2_ = Ninja(param1.game.unitFactory.getUnit(Unit.U_NINJA));
                              param1.team.enemyTeam.spawn(_loc2_,param1.game);
                              _loc2_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                              _loc2_.py = param1.game.map.height / 3 * 2;
                              _loc2_.px = param1.team.enemyTeam.statue.x - 100;
                              _loc2_.faceDirection(-1);
                         }
                    }
                    else if(this.state == S_TALKS_1)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         ++this.counter;
                         this.overlay.alpha = (60 - this.counter) / 60;
                         if(this.counter > 60)
                         {
                              this.state = S_TALKS_2;
                              param1.removeChild(this.overlay);
                              this.counter = 0;
                              this.message = new InGameMessage("",param1.game);
                              this.message.x = param1.game.stage.stageWidth / 2;
                              this.message.y = param1.game.stage.stageHeight / 4 - 75;
                              this.message.scaleX *= 1.3;
                              this.message.scaleY *= 1.3;
                              param1.addChild(this.message);
                         }
                    }
                    else if(this.state == S_TALKS_2)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("Oh, so you guys are not from the Order Empire. Sorry for our mistake.","The Rebels");
                         ++this.counter;
                         if(this.counter > 120)
                         {
                              this.state = S_TALKS_3;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_TALKS_3)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("We are an independent alliance in Inamorta and have no connection to the Order Empire since the death of Queen Medusa","The Rebels");
                         ++this.counter;
                         if(this.counter > 120)
                         {
                              this.state = S_TALKS_4;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_TALKS_4)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("But you know what, in recent years, the Order Empire has become more warlike than ever","The Rebels");
                         ++this.counter;
                         if(this.counter > 90)
                         {
                              this.state = S_TALKS_5;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_TALKS_5)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("Our neighboring alliances have been conquered by them and reduced to ruins","The Rebels");
                         ++this.counter;
                         if(this.counter > 120)
                         {
                              this.state = S_TALKS_6;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_TALKS_6)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("After we sent people to spy on the Empire of Order, we knew that their next target for conquest was us","The Rebels");
                         ++this.counter;
                         if(this.counter > 120)
                         {
                              this.state = S_TALKS_7;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_TALKS_7)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("That\'s why we think you\'re the Order Empire","The Rebels");
                         ++this.counter;
                         if(this.counter > 120)
                         {
                              this.state = S_TALKS_8;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_TALKS_8)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("After fighting with you, we think you have what it takes to defeat a war-hungry Order Empire","The Rebels");
                         ++this.counter;
                         if(this.counter > 120)
                         {
                              this.state = S_TALKS_9;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_TALKS_9)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 850;
                         param1.game.fogOfWar.isFogOn = false;
                         CampaignGameScreen(param1).doAiUpdates = false;
                         param1.userInterface.isGlobalsEnabled = false;
                         param1.userInterface.isSlowCamera = true;
                         param1.game.team.enemyTeam.garrison(true);
                         param1.userInterface.selectedUnits.clear();
                         this.message.setMessage("We hope that you can help us in our fight against them","The Rebels");
                         ++this.counter;
                         if(this.counter > 180)
                         {
                              this.state = S_END_TALKS;
                              this.counter = 0;
                         }
                    }
                    else if(this.state == S_END_TALKS)
                    {
                         param1.team.enemyTeam.statue.health = 0;
                    }
               }
               super.update(param1);
          }
     }
}
