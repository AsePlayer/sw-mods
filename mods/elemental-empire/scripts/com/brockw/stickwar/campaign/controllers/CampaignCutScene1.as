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
     
     public class CampaignCutScene1 extends CampaignController
     {
          
          private static const S_BEFORE_CUTSCENE:int = -1;
          
          private static const S_FADE_OUT:int = 0;
          
          private static const S_FADE_IN:int = 1;
          
          private static const S_KING_LEAVES:int = 3;
          
          private static const S_ENTER_REBELS:int = 4;
          
          private static const S_END:int = 6;
          
          private static const S_KING_TALKS_1:int = 2;
          
          private static const S_KING_TALKS_2:int = 7;
          
          private static const S_KING_TALKS_3:int = 8;
          
          private static const S_KING_TALKS_4:int = 9;
          
          private static const S_KING_TALKS_5:int = 10;
          
          private static const S_KING_TALKS_6:int = 11;
           
          
          private var state:int;
          
          private var frames:int;
          
          private var counter:int;
          
          private var overlay:MovieClip;
          
          private var c:Spearton;
          
          private var d:Spearton;
          
          private var v:ChromeElement;
          
          private var nah:Boolean = false;
          
          private var bruh:Boolean = false;
          
          private var check:Boolean = true;
          
          private var help:Boolean = false;
          
          private var die:Boolean = false;
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var rebelsAreEvil:Boolean;
          
          private var rebels:Array;
          
          public function CampaignCutScene1(param1:GameScreen)
          {
               super(param1);
               this.state = S_BEFORE_CUTSCENE;
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
               var _loc5_:Unit = null;
               var _loc6_:StickWar = null;
               var _loc7_:Unit = null;
               var _loc8_:Number = NaN;
               var _loc9_:MoveCommand = null;
               var _loc10_:int = 0;
               var c:Spearton = null;
               var d:Spearton = null;
               var v:ChromeElement = null;
               if(this.message)
               {
                    this.message.update();
               }
               else if(this.message2 && param1.contains(this.message2))
               {
                    this.message2.update();
                    if(this.frames++ > 30 * 5)
                    {
                         param1.removeChild(this.message2);
                    }
               }
               if(!this.nah)
               {
                    this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                    param1.team.spawn(this.v,param1.game);
                    this.v.vType = "v";
                    this.nah = true;
               }
               if(param1.team.statue.health < param1.team.statue.maxHealth / 2.5)
               {
                    if(!this.help)
                    {
                         this.message2 = new InGameMessage("",param1.game);
                         this.message2.x = param1.game.stage.stageWidth / 2;
                         this.message2.y = param1.game.stage.stageHeight / 4 - 75;
                         this.message2.scaleX *= 1.3;
                         this.message2.scaleY *= 1.3;
                         param1.addChild(this.message2);
                         this.message2.setMessage("We are here to help","Aid",0,"StartMatchmaking");
                         this.frames = 0;
                         param1.team.spawnUnitGroup([Unit.U_WATER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_AIR_ELEMENT,Unit.U_FIRE_ELEMENT,Unit.U_WATER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_MINER_ELEMENT,Unit.U_EARTH_ELEMENT,Unit.U_AIR_ELEMENT,Unit.U_FIRE_ELEMENT]);
                         this.help = true;
                    }
               }
               if(param1.team.enemyTeam.statue.health < param1.team.enemyTeam.statue.maxHealth / 1.5)
               {
                    if(!this.bruh)
                    {
                         param1.team.enemyTeam.statue.maxHealth += 750;
                         param1.team.enemyTeam.statue.health = param1.team.enemyTeam.statue.maxHealth / 1.5;
                         this.d = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.enemyTeam.spawn(this.d,param1.game);
                         this.d.speartonType = "d";
                         this.d = d;
                         _loc5_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.enemyTeam.spawn(_loc5_,param1.game);
                         _loc5_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.enemyTeam.spawn(_loc5_,param1.game);
                         _loc5_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.enemyTeam.spawn(_loc5_,param1.game);
                         _loc5_ = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.enemyTeam.spawn(_loc5_,param1.game);
                         _loc5_ = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                         param1.team.enemyTeam.spawn(_loc5_,param1.game);
                         _loc5_ = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                         param1.team.enemyTeam.spawn(_loc5_,param1.game);
                         _loc5_ = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                         param1.team.enemyTeam.spawn(_loc5_,param1.game);
                         _loc5_ = Miner(param1.game.unitFactory.getUnit(Unit.U_MINER));
                         param1.team.enemyTeam.spawn(_loc5_,param1.game);
                         this.bruh = true;
                    }
               }
               if(this.state != S_BEFORE_CUTSCENE)
               {
                    for each(_loc2_ in param1.game.team.units)
                    {
                         _loc2_.ai.mayAttack = false;
                    }
                    for each(_loc2_ in param1.game.team.enemyTeam.units)
                    {
                         _loc2_.ai.mayAttack = false;
                    }
                    param1.userInterface.selectedUnits.clear();
                    CampaignGameScreen(param1).doAiUpdates = false;
                    param1.userInterface.isGlobalsEnabled = false;
               }
               if(this.state == S_BEFORE_CUTSCENE)
               {
                    _loc4_ = 0;
                    if(param1.team.enemyTeam.statue.health > param1.team.enemyTeam.statue.maxHealth / 4)
                    {
                         _loc4_ = 1;
                         if(param1.team.enemyTeam.statue.health < param1.team.enemyTeam.statue.maxHealth / 4)
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
                         param1.team.enemyTeam.statue.health = param1.team.enemyTeam.statue.maxHealth / 4;
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
                         this.state = S_FADE_IN;
                         this.counter = 0;
                         this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                         param1.team.spawn(this.v,param1.game);
                         this.v.vType = "v";
                         this.v.px = param1.team.enemyTeam.statue.x - 200;
                         this.v.py = param1.game.map.height / 2;
                         this.v.ai.setCommand(param1.game,new HoldCommand(param1.game));
                         this.v.ai.mayAttack = false;
                         this.c = Spearton(param1.game.unitFactory.getUnit(Unit.U_SPEARTON));
                         param1.team.enemyTeam.spawn(this.c,param1.game);
                         this.c.speartonType = "c";
                         this.c.ai.setCommand(param1.game,new HoldCommand(param1.game));
                         this.c.py = param1.game.map.height / 2;
                         this.c.px = param1.team.enemyTeam.statue.x + 200;
                         this.c.faceDirection(-1);
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
                         this.state = S_KING_TALKS_1;
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
               else if(this.state == S_KING_TALKS_1)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    this.message.setMessage("Fools! Do you think you can defeat our Order Empire.","?",0,"medusaVoice1");
                    ++this.counter;
                    if(this.counter > 150)
                    {
                         this.state = S_KING_TALKS_2;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_KING_TALKS_2)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    this.message.setMessage("Don\'t forget we are the ones who rescued you from Medusa and her empire.","?",0,"medusaVoice2");
                    ++this.counter;
                    if(this.counter > 150)
                    {
                         this.state = S_KING_TALKS_3;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_KING_TALKS_3)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    this.message.setMessage("But now you dare to attack against us.","?",0,"medusaVoice3");
                    ++this.counter;
                    if(this.counter > 150)
                    {
                         this.state = S_KING_TALKS_4;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_KING_TALKS_4)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    this.message.setMessage("So prepare yourselves for your punishment!","?",0,"MedusaVoiceOverLevel5");
                    ++this.counter;
                    if(this.counter > 150)
                    {
                         this.state = S_KING_TALKS_5;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_KING_TALKS_5)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    this.message.setMessage("We\'ll meet again","?");
                    ++this.counter;
                    if(this.counter > 150)
                    {
                         this.c.kill();
                    }
                    if(this.counter > 240)
                    {
                         this.state = S_KING_TALKS_6;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_KING_TALKS_6)
               {
                    param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 350;
                    param1.game.screenX = param1.game.team.enemyTeam.statue.x - 350;
                    ++this.counter;
                    if(this.message.hasFinishedPlayingSound())
                    {
                         this.state = S_KING_LEAVES;
                         this.counter = 0;
                    }
               }
               else if(this.state == S_KING_LEAVES)
               {
                    param1.team.enemyTeam.statue.health = 0;
               }
               super.update(param1);
          }
     }
}
