package com.brockw.stickwar.engine.Team.Order
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.Ai.command.StandCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Building;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.UserInterface;
     import com.brockw.stickwar.engine.units.Statue;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.MovieClip;
     import flash.text.TextField;
     import flash.text.TextFormat;
     import flash.utils.Dictionary;
     
     public class TeamGood extends Team
     {
           
          
          public function TeamGood(param1:StickWar, param2:int, param3:Dictionary = null, param4:* = 1, param5:Number = 1)
          {
               var _loc9_:Building = null;
               var _loc10_:* = null;
               var _loc11_:Unit = null;
               var _loc6_:Entity = new Entity();
               _loc6_.addChild(new _castleFrontMc());
               castleFront = _loc6_;
               _loc6_ = new Entity();
               _loc6_.addChild(new _castleBackMc());
               castleBack = _loc6_;
               var _loc7_:Statue = new Statue(new _statueMc(),param1,param2);
               param1.units[_loc7_.id] = _loc7_;
               statue = _loc7_;
               super(param1);
               this.handicap = param4;
               this.techAllowed = param3;
               type = T_GOOD;
               buttonOver = null;
               sameButtonCount = 0;
               _loc6_ = new Entity();
               var _loc8_:baseMc = new baseMc();
               _loc8_.baseBacking.cacheAsBitmap = true;
               _loc8_.baseFront.cacheAsBitmap = true;
               Util.animateToNeutral(_loc8_,4);
               _loc6_.addChild(_loc8_);
               base = _loc6_;
               tech = new GoodTech(param1,this);
               buildings["BarracksBuilding"] = new BarracksBuilding(param1,GoodTech(tech),_loc8_.barracksMc,_loc8_.barracksHitArea);
               buildings["ArcheryBuilding"] = new ArcheryBuilding(param1,GoodTech(tech),_loc8_.archeryRangeMc,_loc8_.fletcherHitArea);
               buildings["MagicGuildBuilding"] = new MagicGuildBuilding(param1,GoodTech(tech),_loc8_.magicShopMc,_loc8_.magicHitArea);
               buildings["SiegeBuilding"] = new SiegeBuilding(param1,GoodTech(tech),_loc8_.siegeShop,_loc8_.dungeonHitArea);
               buildings["TempleBuilding"] = new TempleBuilding(param1,GoodTech(tech),_loc8_.templeMc,_loc8_.templeHitArea);
               buildings["BankBuilding"] = new BankBuilding(param1,GoodTech(tech),_loc8_.bankMc,_loc8_.bankHitArea);
               for each(_loc9_ in buildings)
               {
                    this._unitProductionQueue[_loc9_.type] = [];
               }
               castleDefence = new CastleArchers(param1,this);
               unitInfo[Unit.U_MINER] = [param1.xml.xml.Order.Units.miner.gold * param4,param1.xml.xml.Order.Units.miner.mana * param4];
               unitInfo[Unit.U_MAGIKILL] = [param1.xml.xml.Order.Units.magikill.gold * param4,param1.xml.xml.Order.Units.magikill.mana * param4];
               unitInfo[Unit.U_SWORDWRATH] = [param1.xml.xml.Order.Units.swordwrath.gold * param4,param1.xml.xml.Order.Units.swordwrath.mana * param4];
               unitInfo[Unit.U_ARCHER] = [param1.xml.xml.Order.Units.archer.gold * param4,param1.xml.xml.Order.Units.archer.mana * param4];
               unitInfo[Unit.U_SPEARTON] = [param1.xml.xml.Order.Units.spearton.gold * param4,param1.xml.xml.Order.Units.spearton.mana * param4];
               unitInfo[Unit.U_NINJA] = [param1.xml.xml.Order.Units.ninja.gold * param4,param1.xml.xml.Order.Units.ninja.mana * param4];
               unitInfo[Unit.U_FLYING_CROSSBOWMAN] = [param1.xml.xml.Order.Units.flyingCrossbowman.gold * param4,param1.xml.xml.Order.Units.flyingCrossbowman.mana * param4];
               unitInfo[Unit.U_MONK] = [param1.xml.xml.Order.Units.monk.gold * param4,param1.xml.xml.Order.Units.monk.mana * param4];
               unitInfo[Unit.U_ENSLAVED_GIANT] = [param1.xml.xml.Order.Units.giant.gold * param4,param1.xml.xml.Order.Units.giant.mana * param4];
               if(param1.unitFactory)
               {
                    for(_loc10_ in unitInfo)
                    {
                         _loc11_ = param1.unitFactory.getUnit(int(_loc10_));
                         _loc11_.team = this;
                         _loc11_.setBuilding();
                         unitInfo[_loc10_].push(_loc11_.building.type);
                         unitGroups[_loc11_.type] = [];
                         param1.unitFactory.returnUnit(_loc11_.type,_loc11_);
                    }
               }
               this.healthModifier = param5;
          }
          
          override protected function getSpawnUnitType(param1:StickWar) : int
          {
               if(tech.isResearched(Tech.TOWER_SPAWN_II))
               {
                    return Unit.U_ENSLAVED_GIANT;
               }
               return Unit.U_SPEARTON;
          }
          
          override public function getNumberOfMiners() : int
          {
               return unitGroups[Unit.U_MINER].length;
          }
          
          override public function detectedUserInput(param1:UserInterface) : void
          {
               singlePlayerDebugInputSwitch(param1,Unit.U_MINER,49);
               singlePlayerDebugInputSwitch(param1,Unit.U_SWORDWRATH,50);
               singlePlayerDebugInputSwitch(param1,Unit.U_ARCHER,51);
               singlePlayerDebugInputSwitch(param1,Unit.U_MONK,52);
               singlePlayerDebugInputSwitch(param1,Unit.U_MAGIKILL,53);
               singlePlayerDebugInputSwitch(param1,Unit.U_SPEARTON,54);
               singlePlayerDebugInputSwitch(param1,Unit.U_NINJA,55);
               singlePlayerDebugInputSwitch(param1,Unit.U_FLYING_CROSSBOWMAN,56);
               singlePlayerDebugInputSwitch(param1,Unit.U_ENSLAVED_GIANT,57);
          }
          
          override public function getMinerType() : int
          {
               return Unit.U_MINER;
          }
          
          override public function spawnMiners() : void
          {
               var _loc1_:Unit = null;
               var _loc2_:Unit = null;
               _loc1_ = game.unitFactory.getUnit(Unit.U_MINER);
               _loc2_ = game.unitFactory.getUnit(Unit.U_MINER);
               spawn(_loc1_,game);
               spawn(_loc2_,game);
               _loc1_.px = homeX + 650 * direction;
               _loc2_.px = homeX + 650 * direction;
               _loc1_.py = game.map.height / 3;
               _loc2_.py = game.map.height / 3 * 2;
               _loc1_.ai.setCommand(game,new StandCommand(game));
               _loc2_.ai.setCommand(game,new StandCommand(game));
               this.population += 4;
          }
          
          override public function initTeamButtons(param1:GameScreen) : void
          {
               var _loc2_:* = null;
               var _loc3_:MovieClip = null;
               var _loc4_:MovieClip = null;
               var _loc5_:MovieClip = null;
               var _loc6_:TextField = null;
               var _loc7_:TextFormat = null;
               buttonInfoMap = new Dictionary();
               buttonInfoMap[Unit.U_MINER] = [param1.userInterface.hud.hud.minerButton,param1.userInterface.hud.hud.minerOverlay,param1.game.xml.xml.Order.Units.miner,0,new cancelButton(),game.xml.xml.Order.Units.miner.gold * handicap,new MovieClip(),param1.userInterface.hud.hud.bankHighlight,null];
               buttonInfoMap[Unit.U_SWORDWRATH] = [param1.userInterface.hud.hud.swordwrathButton,param1.userInterface.hud.hud.swordwrathOverlay,param1.game.xml.xml.Order.Units.swordwrath,0,new cancelButton(),game.xml.xml.Order.Units.swordwrath.gold * handicap,new MovieClip(),param1.userInterface.hud.hud.barracksHighlight,param1.userInterface.hud.hud.barracksUnderlay];
               buttonInfoMap[Unit.U_ARCHER] = [param1.userInterface.hud.hud.archerButton,param1.userInterface.hud.hud.archerOverlay,param1.game.xml.xml.Order.Units.archer,0,new cancelButton(),game.xml.xml.Order.Units.archer.gold * handicap,new MovieClip(),param1.userInterface.hud.hud.archerHighlight,param1.userInterface.hud.hud.archerUnderlay];
               buttonInfoMap[Unit.U_SPEARTON] = [param1.userInterface.hud.hud.speartonButton,param1.userInterface.hud.hud.speartonOverlay,param1.game.xml.xml.Order.Units.spearton,0,new cancelButton(),game.xml.xml.Order.Units.spearton.gold * handicap,new MovieClip(),param1.userInterface.hud.hud.barracksHighlight,param1.userInterface.hud.hud.barracksUnderlay];
               buttonInfoMap[Unit.U_NINJA] = [param1.userInterface.hud.hud.ninjaButton,param1.userInterface.hud.hud.ninjaOverlay,param1.game.xml.xml.Order.Units.ninja,0,new cancelButton(),game.xml.xml.Order.Units.ninja.gold * handicap,new MovieClip(),param1.userInterface.hud.hud.barracksHighlight,param1.userInterface.hud.hud.barracksUnderlay];
               buttonInfoMap[Unit.U_FLYING_CROSSBOWMAN] = [param1.userInterface.hud.hud.flyingcrossbowmanButton,param1.userInterface.hud.hud.flyingcrossbowmanOverlay,param1.game.xml.xml.Order.Units.flyingCrossbowman,0,new cancelButton(),game.xml.xml.Order.Units.flyingcrossbowman.gold * handicap,new MovieClip(),param1.userInterface.hud.hud.archerHighlight,param1.userInterface.hud.hud.archerUnderlay];
               buttonInfoMap[Unit.U_MONK] = [param1.userInterface.hud.hud.monkButton,param1.userInterface.hud.hud.monkOverlay,param1.game.xml.xml.Order.Units.monk,0,new cancelButton(),game.xml.xml.Order.Units.monk.gold,new MovieClip(),param1.userInterface.hud.hud.templeHighlight,null];
               buttonInfoMap[Unit.U_MAGIKILL] = [param1.userInterface.hud.hud.magikillButton,param1.userInterface.hud.hud.magikillOverlay,param1.game.xml.xml.Order.Units.magikill,0,new cancelButton(),game.xml.xml.Order.Units.magikill.gold * handicap,new MovieClip(),param1.userInterface.hud.hud.magikillHighlight,null];
               buttonInfoMap[Unit.U_ENSLAVED_GIANT] = [param1.userInterface.hud.hud.giantButton,param1.userInterface.hud.hud.giantOverlay,param1.game.xml.xml.Order.Units.giant,0,new cancelButton(),game.xml.xml.Order.Units.giant.gold * handicap,new MovieClip(),param1.userInterface.hud.hud.giantHighlight,null];
               buildingHighlights = [param1.userInterface.hud.hud.bankHighlight,param1.userInterface.hud.hud.barracksHighlight,param1.userInterface.hud.hud.archerHighlight,param1.userInterface.hud.hud.templeHighlight,param1.userInterface.hud.hud.giantHighlight,param1.userInterface.hud.hud.magikillHighlight,param1.userInterface.hud.hud.barracksUnderlay,param1.userInterface.hud.hud.archerUnderlay];
               for(_loc2_ in buttonInfoMap)
               {
                    _loc3_ = buttonInfoMap[_loc2_][1];
                    _loc4_ = buttonInfoMap[_loc2_][0];
                    _loc4_.addChild(buttonInfoMap[_loc2_][6]);
                    _loc5_ = buttonInfoMap[_loc2_][4];
                    _loc5_.x = _loc4_.x + _loc4_.width - _loc5_.width;
                    _loc5_.y = _loc4_.y;
                    param1.userInterface.hud.hud.addChild(_loc5_);
                    _loc5_.visible = false;
                    _loc6_ = new TextField();
                    _loc6_.name = "number";
                    _loc7_ = new TextFormat(null,20,16777215);
                    _loc6_.defaultTextFormat = _loc7_;
                    _loc6_.width = 25;
                    _loc6_.height = 25;
                    _loc6_.x = 25;
                    _loc6_.y = 15;
                    _loc6_.selectable = false;
                    _loc6_.text = "0";
                    _loc4_.addChild(_loc6_);
               }
          }
     }
}
