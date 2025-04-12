package com.brockw.stickwar.campaign
{
     import com.brockw.game.*;
     import com.brockw.simulationSync.*;
     import com.brockw.stickwar.*;
     import com.brockw.stickwar.campaign.controllers.CampaignController;
     import com.brockw.stickwar.engine.*;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.Team.*;
     import com.brockw.stickwar.engine.multiplayer.*;
     import com.brockw.stickwar.engine.multiplayer.moves.*;
     import com.brockw.stickwar.engine.units.*;
     import com.brockw.stickwar.singleplayer.*;
     import com.smartfoxserver.v2.requests.*;
     import flash.display.*;
     import flash.events.*;
     
     public class CampaignGameScreen extends GameScreen
     {
           
          
          public var oos_epire:int = 0;
          
          private var enemyTeamAi:EnemyTeamAi;
          
          private var controller:CampaignController;
          
          public var doAiUpdates:Boolean;
          
          public function CampaignGameScreen(param1:BaseMain)
          {
               super(param1);
          }
          
          override public function enter() : void
          {
               var _loc771_:int = 0;
               var _loc772_:int = 0;
               var _loc777_:* = null;
               var _loc778_:* = null;
               var _loc779_:* = null;
               var _loc837_:* = null;
               if(main is stickwar2 && false)
               {
                    main.tracker.trackEvent(main.campaign.getLevelDescription(),"start");
               }
               var _loc769_:Level = main.campaign.getCurrentLevel();
               _loc769_.player.josecancer = main.raceSelected;
               trace("JOSE = " + _loc769_.player.josecancer);
               var _loc770_:Class = _loc769_.controller;
               if(_loc770_ != null)
               {
                    this.controller = new _loc770_(this);
               }
               else
               {
                    this.controller = null;
               }
               if(true)
               {
                    main.stickWar = new StickWar(main,this);
               }
               game = main.stickWar;
               simulation = new SimulationSyncronizer(game,main,this.endTurn,this.endGame);
               simulation.init(0);
               this.addChild(game);
               game.initGame(main,this,_loc769_.mapName);
               userInterface = new UserInterface(main,this);
               addChild(userInterface);
               _loc771_ = 0;
               _loc772_ = 1;
               var _loc773_:* = _loc769_.normalModifier;
               if(main.campaign.difficultyLevel == Campaign.D_HARD)
               {
                    _loc773_ = _loc769_.hardModifier;
               }
               else if(main.campaign.difficultyLevel == Campaign.D_INSANE)
               {
                    _loc773_ = _loc769_.insaneModifier;
               }
               var _loc774_:* = 1;
               if(main.campaign.difficultyLevel == 1)
               {
                    _loc774_ = _loc769_.normalHealthScale;
               }
               var _loc775_:* = 1;
               if(main.campaign.difficultyLevel == Campaign.D_NORMAL)
               {
                    _loc775_ = _loc769_.normalDamageModifier;
               }
               if(_loc769_.player.unitsAvailable[Unit.U_NINJA])
               {
                    (_loc777_ = CampaignUpgrade(main.campaign.upgradeMap["Cloak_BASIC"])).upgraded = true;
                    main.campaign.techAllowed[Tech.CLOAK] = 1;
               }
               game.initTeams(main.raceSelected,Team.getIdFromRaceName(_loc769_.oponent.race),_loc769_.player.statueHealth,_loc769_.oponent.statueHealth,null,null,1,_loc769_.insaneModifier,1,_loc774_,1,_loc775_);
               team = game.teamA;
               game.team = team;
               game.teamA.id = _loc771_;
               game.teamB.id = _loc772_;
               game.teamA.unitsAvailable = _loc769_.player.unitsAvailable;
               this.oos_epire = _loc769_.player.josecancer;
               if(_loc769_.player.josecancer == 1)
               {
                    trace("Chaos units");
                    if(game.teamA.unitsAvailable[Unit.U_MONK] == 1)
                    {
                         trace("Medusa. Meric val = " + game.teamA.unitsAvailable[Unit.U_MONK]);
                         game.teamA.unitsAvailable[Unit.U_MONK] = 0;
                         game.teamA.unitsAvailable[Unit.U_WINGIDON] = 1;
                    }
                    if(game.teamA.unitsAvailable[Unit.U_ARCHER] == 1)
                    {
                         game.teamA.unitsAvailable[Unit.U_ARCHER] = 0;
                         game.teamA.unitsAvailable[Unit.U_DEAD] = 1;
                    }
                    if(game.teamA.unitsAvailable[Unit.U_FLYING_CROSSBOWMAN] == 1)
                    {
                         game.teamA.unitsAvailable[Unit.U_FLYING_CROSSBOWMAN] = 0;
                         game.teamA.unitsAvailable[Unit.U_MEDUSA] = 1;
                    }
                    if(game.teamA.unitsAvailable[Unit.U_NINJA] == 1)
                    {
                         game.teamA.unitsAvailable[Unit.U_NINJA] = 0;
                         game.teamA.unitsAvailable[Unit.U_BOMBER] = 1;
                    }
                    if(game.teamA.unitsAvailable[Unit.U_SWORDWRATH] == 1)
                    {
                         game.teamA.unitsAvailable[Unit.U_SWORDWRATH] = 0;
                         game.teamA.unitsAvailable[Unit.U_CAT] = 1;
                    }
                    if(game.teamA.unitsAvailable[Unit.U_SPEARTON] == 1)
                    {
                         game.teamA.unitsAvailable[Unit.U_SPEARTON] = 0;
                         game.teamA.unitsAvailable[Unit.U_KNIGHT] = 1;
                    }
                    if(game.teamA.unitsAvailable[Unit.U_ENSLAVED_GIANT] == 1)
                    {
                         game.teamA.unitsAvailable[Unit.U_ENSLAVED_GIANT] = 0;
                         game.teamA.unitsAvailable[Unit.U_GIANT] = 1;
                    }
                    if(game.teamA.unitsAvailable[Unit.U_MINER] == 1)
                    {
                         game.teamA.unitsAvailable[Unit.U_MINER] = 0;
                         game.teamA.unitsAvailable[Unit.U_CHAOS_MINER] = 1;
                    }
                    if(game.teamA.unitsAvailable[Unit.U_MAGIKILL] == 1)
                    {
                         game.teamA.unitsAvailable[Unit.U_MAGIKILL] = 0;
                         game.teamA.unitsAvailable[Unit.U_SKELATOR] = 1;
                    }
               }
               if(_loc769_.player.josecancer == 2)
               {
                    if(_loc769_.player.josecancer == 2)
                    {
                         if(game.teamA.unitsAvailable[Unit.U_MONK] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_MONK] = 0;
                              game.teamA.unitsAvailable[Unit.U_WATER_ELEMENT] = 1;
                              game.teamA.unitsAvailable[Unit.U_TREE_ELEMENT] = 1;
                         }
                         if(main.campaign.currentLevel > 6)
                         {
                              game.teamA.unitsAvailable[Unit.U_STEAM_EXPLOSION] = 1;
                         }
                         if(main.campaign.currentLevel > 11)
                         {
                              game.teamA.unitsAvailable[Unit.U_CHROME_ELEMENT] = 1;
                         }
                         if(game.teamA.unitsAvailable[Unit.U_ARCHER] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_ARCHER] = 0;
                              game.teamA.unitsAvailable[Unit.U_FIRE_ELEMENT] = 1;
                         }
                         if(game.teamA.unitsAvailable[Unit.U_FLYING_CROSSBOWMAN] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_FLYING_CROSSBOWMAN] = 0;
                              game.teamA.unitsAvailable[Unit.U_HURRICANE_ELEMENT] = 1;
                         }
                         if(game.teamA.unitsAvailable[Unit.U_NINJA] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_NINJA] = 0;
                              game.teamA.unitsAvailable[Unit.U_WATER_ELEMENT] = 1;
                         }
                         if(game.teamA.unitsAvailable[Unit.U_SWORDWRATH] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_SWORDWRATH] = 0;
                              game.teamA.unitsAvailable[Unit.U_EARTH_ELEMENT] = 1;
                         }
                         if(game.teamA.unitsAvailable[Unit.U_SPEARTON] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_SPEARTON] = 0;
                              game.teamA.unitsAvailable[Unit.U_FIRE_ELEMENT] = 1;
                              game.teamA.unitsAvailable[Unit.U_EARTH_ELEMENT] = 1;
                              game.teamA.unitsAvailable[Unit.U_LAVA_ELEMENT] = 1;
                         }
                         if(game.teamA.unitsAvailable[Unit.U_ENSLAVED_GIANT] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_ENSLAVED_GIANT] = 0;
                              game.teamA.unitsAvailable[Unit.U_WATER_ELEMENT] = 1;
                              game.teamA.unitsAvailable[Unit.U_EARTH_ELEMENT] = 1;
                              game.teamA.unitsAvailable[Unit.U_SCORPION_ELEMENT] = 1;
                         }
                         if(game.teamA.unitsAvailable[Unit.U_MINER] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_MINER] = 0;
                              game.teamA.unitsAvailable[Unit.U_MINER_ELEMENT] = 1;
                              game.teamA.unitsAvailable[Unit.U_EARTH_ELEMENT] = 1;
                         }
                         if(game.teamA.unitsAvailable[Unit.U_MAGIKILL] == 1)
                         {
                              game.teamA.unitsAvailable[Unit.U_MAGIKILL] = 0;
                              game.teamA.unitsAvailable[Unit.U_AIR_ELEMENT] = 1;
                              game.teamA.unitsAvailable[Unit.U_FIRESTORM_ELEMENT] = 1;
                         }
                    }
               }
               trace("DICTIONARY = " + game.teamA.unitsAvailable.toString());
               game.teamB.unitsAvailable = _loc769_.oponent.unitsAvailable;
               game.teamA.name = _loc771_;
               game.teamB.name = _loc772_;
               this.team.enemyTeam.isEnemy = true;
               this.team.enemyTeam.isAi = true;
               team.realName = "Player";
               team.enemyTeam.realName = "Computer";
               game.teamA.statueType = _loc769_.player.statue;
               game.teamB.statueType = _loc769_.oponent.statue;
               game.teamA.gold = _loc769_.player.gold;
               game.teamA.mana = _loc769_.player.mana;
               game.teamB.gold = _loc769_.oponent.gold;
               game.teamB.mana = _loc769_.oponent.mana;
               game.teamA.loadout.fromString(main.loadout1);
               game.teamB.loadout.fromString(main.loadout1);
               var _loc776_:Array = _loc769_.player.startingUnits.slice(0,_loc769_.player.startingUnits.length);
               if(main.campaign.difficultyLevel == Campaign.D_NORMAL)
               {
                    game.teamA.gold += 200;
                    game.teamA.mana += 200;
                    _loc776_.push(Unit.U_MINER);
                    _loc776_.push(Unit.U_SWORDWRATH);
               }
               trace("LOC8 = " + _loc776_);
               _loc837_ = null;
               for(_loc837_ in _loc776_)
               {
                    if(_loc769_.player.josecancer == 2)
                    {
                         if(_loc776_[_loc837_] == Unit.U_MONK)
                         {
                              _loc776_[_loc837_] = Unit.U_HURRICANE_ELEMENT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_ARCHER)
                         {
                              _loc776_[_loc837_] = Unit.U_FIRE_ELEMENT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_FLYING_CROSSBOWMAN)
                         {
                              _loc776_[_loc837_] = Unit.U_AIR_ELEMENT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_NINJA)
                         {
                              _loc776_[_loc837_] = Unit.U_WATER_ELEMENT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_SWORDWRATH)
                         {
                              _loc776_[_loc837_] = Unit.U_EARTH_ELEMENT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_SPEARTON)
                         {
                              _loc776_[_loc837_] = Unit.U_LAVA_ELEMENT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_ENSLAVED_GIANT)
                         {
                              _loc776_[_loc837_] = Unit.U_TREE_ELEMENT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_MINER)
                         {
                              _loc776_[_loc837_] = Unit.U_MINER_ELEMENT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_MAGIKILL)
                         {
                              _loc776_[_loc837_] = Unit.U_FIRESTORM_ELEMENT;
                         }
                    }
                    if(_loc769_.player.josecancer == 1)
                    {
                         if(_loc776_[_loc837_] == Unit.U_MONK)
                         {
                              _loc776_[_loc837_] = Unit.U_MEDUSA;
                         }
                         if(_loc776_[_loc837_] == Unit.U_ARCHER)
                         {
                              _loc776_[_loc837_] = Unit.U_DEAD;
                         }
                         if(_loc776_[_loc837_] == Unit.U_FLYING_CROSSBOWMAN)
                         {
                              _loc776_[_loc837_] = Unit.U_WINGIDON;
                         }
                         if(_loc776_[_loc837_] == Unit.U_NINJA)
                         {
                              _loc776_[_loc837_] = Unit.U_BOMBER;
                         }
                         if(_loc776_[_loc837_] == Unit.U_SWORDWRATH)
                         {
                              _loc776_[_loc837_] = Unit.U_CAT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_SPEARTON)
                         {
                              _loc776_[_loc837_] = Unit.U_KNIGHT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_ENSLAVED_GIANT)
                         {
                              _loc776_[_loc837_] = Unit.U_GIANT;
                         }
                         if(_loc776_[_loc837_] == Unit.U_MINER)
                         {
                              _loc776_[_loc837_] = Unit.U_CHAOS_MINER;
                         }
                         if(_loc776_[_loc837_] == Unit.U_MAGIKILL)
                         {
                              _loc776_[_loc837_] = Unit.U_SKELATOR;
                         }
                    }
               }
               trace("LOC69 = " + _loc776_);
               if(main.campaign.getCurrentLevel().hasInsaneWall && main.campaign.difficultyLevel == Campaign.D_INSANE)
               {
                    if(game.teamB.type == Team.T_GOOD)
                    {
                         (_loc778_ = team.enemyTeam.addWall(team.enemyTeam.homeX - 900)).setConstructionAmount(1);
                    }
                    else
                    {
                         _loc779_ = ChaosTower(game.unitFactory.getUnit(int(Unit.U_CHAOS_TOWER)));
                         team.enemyTeam.spawn(_loc779_,game);
                         _loc779_.scaleX *= team.enemyTeam.direction * -1;
                         _loc779_.px = team.enemyTeam.homeX - 900;
                         _loc779_.py = game.map.height / 2;
                         _loc779_.setConstructionAmount(1);
                    }
               }
               if(main.campaign.currentLevel != 0)
               {
                    if(main.campaign.difficultyLevel == Campaign.D_HARD)
                    {
                         _loc776_.push(game.team.getMinerType());
                    }
                    else if(main.campaign.difficultyLevel == Campaign.D_NORMAL)
                    {
                         _loc776_.push([game.team.getMinerType()]);
                         trace("JOSEFGHJ = " + _loc769_.player.josecancer);
                         if(_loc769_.player.josecancer != 1)
                         {
                              if(_loc769_.player.josecancer != 2)
                              {
                                   (_loc778_ = team.addWall(team.homeX + 1200)).setConstructionAmount(1);
                              }
                         }
                    }
               }
               else
               {
                    game.teamB.gold = 0;
               }
               game.teamA.spawnUnitGroup(_loc776_);
               game.teamB.spawnUnitGroup(_loc769_.oponent.startingUnits);
               if(main.campaign.difficultyLevel > Campaign.D_NORMAL || Team.getIdFromRaceName(main.campaign.getCurrentLevel().oponent.race) == Team.T_CHAOS)
               {
                    if(_loc769_.oponent.castleArcherLevel >= 1)
                    {
                         game.teamB.tech.isResearchedMap[Tech.CASTLE_ARCHER_1] = 1;
                    }
                    if(_loc769_.oponent.castleArcherLevel >= 2)
                    {
                         game.teamB.tech.isResearchedMap[Tech.CASTLE_ARCHER_2] = 1;
                    }
                    if(_loc769_.oponent.castleArcherLevel >= 3)
                    {
                         game.teamB.tech.isResearchedMap[Tech.CASTLE_ARCHER_3] = 1;
                    }
                    if(_loc769_.oponent.castleArcherLevel >= 4)
                    {
                         game.teamB.tech.isResearchedMap[Tech.CASTLE_ARCHER_4] = 1;
                    }
               }
               if(_loc769_.player.castleArcherLevel >= 1)
               {
                    game.teamA.tech.isResearchedMap[Tech.CASTLE_ARCHER_1] = 1;
               }
               if(_loc769_.player.castleArcherLevel >= 2)
               {
                    game.teamA.tech.isResearchedMap[Tech.CASTLE_ARCHER_2] = 1;
               }
               if(_loc769_.player.castleArcherLevel >= 3)
               {
                    game.teamA.tech.isResearchedMap[Tech.CASTLE_ARCHER_3] = 1;
               }
               if(_loc769_.player.castleArcherLevel >= 4)
               {
                    game.teamA.tech.isResearchedMap[Tech.CASTLE_ARCHER_4] = 1;
               }
               userInterface.init(game.team);
               if(team.enemyTeam.type == Team.T_GOOD)
               {
                    this.enemyTeamAi = new EnemyGoodTeamAi(team.enemyTeam,main,game);
               }
               else
               {
                    this.enemyTeamAi = new EnemyChaosTeamAi(team.enemyTeam,main,game);
               }
               game.init(0);
               game.postInit();
               simulation.hasStarted = true;
               super.enter();
               this.doAiUpdates = true;
               if(game.teamA.type == Team.T_GOOD)
               {
                    game.soundManager.playSoundInBackground("orderInGame");
               }
               else if(game.teamA.type == Team.T_CHAOS)
               {
                    game.soundManager.playSoundInBackground("chaosInGame");
               }
               else
               {
                    game.soundManager.playSoundInBackground("elementalInGame");
               }
          }
          
          override public function update(param1:Event, param2:Number) : void
          {
               if(userInterface.keyBoardState.isDown(78) && userInterface.keyBoardState.isShift)
               {
                    game.teamB.statue.kill();
               }
               if(this.doAiUpdates)
               {
                    this.enemyTeamAi.update(game);
               }
               if(this.controller != null)
               {
                    this.controller.update(this);
               }
               super.update(param1,param2);
          }
          
          override public function leave() : void
          {
               this.cleanUp();
          }
          
          override public function endTurn() : void
          {
               simulation.endOfTurnMove = new EndOfTurnMove();
               simulation.endOfTurnMove.expectedNumberOfMoves = this.simulation.movesInTurn;
               simulation.endOfTurnMove.frameRate = simulation.frameRate;
               simulation.endOfTurnMove.turnSize = 5;
               simulation.endOfTurnMove.turn = simulation.turn;
               simulation.processMove(simulation.endOfTurnMove);
               simulation.movesInTurn = 0;
          }
          
          override public function endGame() : void
          {
               var _loc2_:int = 0;
               gameTimer.removeEventListener(TimerEvent.TIMER,updateGameLoop);
               gameTimer.stop();
               var _loc1_:EndOfGameMove = new EndOfGameMove();
               _loc1_.winner = game.winner.id;
               _loc1_.turn = simulation.turn;
               simulation.processMove(_loc1_);
               trace("UPDATE TIME");
               main.campaign.getCurrentLevel().updateTime(game.frame / 30 + main.campaign.OldRetry / 30);
               if(main is stickwar2 && false)
               {
                    if(_loc1_.winner == team.id)
                    {
                         main.tracker.trackEvent(main.campaign.getLevelDescription(),"finish","win",game.economyRecords.length);
                    }
                    else
                    {
                         main.tracker.trackEvent(main.campaign.getLevelDescription(),"finish","lose",game.economyRecords.length);
                    }
               }
               main.postGameScreen.setWinner(_loc1_.winner,team.type,main.campaign.getCurrentLevel().player.raceName,main.campaign.getCurrentLevel().oponent.raceName,team.id);
               main.postGameScreen.setRecords(game.economyRecords,game.militaryRecords);
               if(_loc1_.winner == team.id)
               {
                    main.campaign.campaignPoints += main.campaign.getCurrentLevel().points;
                    ++main.campaign.currentLevel;
               }
               if(!main.campaign.isGameFinished() && _loc1_.winner == team.id)
               {
                    for each(_loc2_ in main.campaign.getCurrentLevel().unlocks)
                    {
                         main.postGameScreen.appendUnitUnlocked(_loc2_,game);
                    }
               }
               if(_loc1_.winner == team.id)
               {
                    main.postGameScreen.showNextUnitUnlocked();
               }
               main.postGameScreen.setMode(PostGameScreen.M_CAMPAIGN);
               if(_loc1_.winner == team.id)
               {
                    main.postGameScreen.setTipText("");
               }
               else
               {
                    main.postGameScreen.setTipText(main.campaign.getCurrentLevel().tip);
               }
               if(main.campaign.justTutorial)
               {
                    if(_loc1_.winner == team.id)
                    {
                         main.sfs.send(new ExtensionRequest("SetDoneTutorialHandler",null));
                    }
                    main.showScreen("lobby");
               }
               else
               {
                    main.showScreen("postGame",false,true);
               }
          }
          
          override public function doMove(param1:Move, param2:int) : void
          {
               param1.init(param2,simulation.frame,simulation.turn);
               simulation.processMove(param1);
               ++simulation.movesInTurn;
          }
          
          override public function cleanUp() : void
          {
               trace("Do the cleanup");
               super.cleanUp();
          }
          
          override public function maySwitchOnDisconnect() : Boolean
          {
               return false;
          }
     }
}
