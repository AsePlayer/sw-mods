package com.brockw.stickwar.engine
{
     import com.brockw.game.*;
     import com.brockw.stickwar.*;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.Team.*;
     import com.brockw.stickwar.engine.Team.Chaos.*;
     import com.brockw.stickwar.engine.Team.Elementals.*;
     import com.brockw.stickwar.engine.Team.Order.*;
     import com.brockw.stickwar.engine.multiplayer.*;
     import com.brockw.stickwar.engine.multiplayer.moves.*;
     import com.brockw.stickwar.engine.units.*;
     import com.smartfoxserver.v2.entities.data.*;
     import com.smartfoxserver.v2.requests.*;
     import flash.display.*;
     import flash.events.*;
     import flash.geom.*;
     import flash.ui.*;
     import flash.utils.*;
     
     public class UserInterface extends Screen
     {
          
          public static const FRAME_RATE:int = 30;
           
          
          public var keyBoardState:KeyboardState;
          
          public var mouseState:MouseState;
          
          private var _main:BaseMain;
          
          private var _box:com.brockw.stickwar.engine.Box;
          
          private var SCROLL_SPEED:Number = 100;
          
          private var SCROLL_GAIN:Number = 20;
          
          private var _team:Team;
          
          private var _selectedUnits:com.brockw.stickwar.engine.SelectedUnits;
          
          private var _pauseMenu:com.brockw.stickwar.engine.PauseMenu;
          
          private var _hud:Hud;
          
          private var _actionInterface:com.brockw.stickwar.engine.ActionInterface;
          
          private var _chat:com.brockw.stickwar.engine.Chat;
          
          private var _isSlowCamera:Boolean;
          
          private var timeOfLastUpdate:Number;
          
          private var _period:Number = 33.333333333333336;
          
          private var _beforeTime:int = 0;
          
          private var _afterTime:int = 0;
          
          private var _timeDiff:int = 0;
          
          private var _sleepTime:int = 0;
          
          private var _overSleepTime:int = 0;
          
          private var _excess:int = 0;
          
          private var gameTimer:Timer;
          
          private var spacePressTimer:int;
          
          private var replayData:Array;
          
          private var _gameScreen:GameScreen;
          
          public var lastSentScreenPosition:int;
          
          public var isGlobalsEnabled:Boolean = true;
          
          private var isUnitCreationEnabled:Boolean = true;
          
          private var _helpMessage:com.brockw.stickwar.engine.HelpMessage;
          
          private var _isMusic:Boolean;
          
          private var mouseOverFrames:int;
          
          private var lastButton:SimpleButton;
          
          public function UserInterface(param1:BaseMain, param2:GameScreen)
          {
               ++param1.loadingFraction;
               this.lastButton = null;
               this.main = param1;
               this.gameScreen = param2;
               super();
               ++param1.loadingFraction;
               this.mouseOverFrames = 0;
          }
          
          public function init(param1:Team) : void
          {
               this.team = param1;
               this.isMusic = this.main.soundManager.isMusic;
               this.lastSentScreenPosition = 0;
               this.spacePressTimer = getTimer();
               this.box = new Box();
               this.selectedUnits = new SelectedUnits(this.gameScreen);
               ++this.main.loadingFraction;
               if(this.gameScreen is MultiplayerGameScreen)
               {
                    this.pauseMenu = new MultiplayerPauseMenu(this.gameScreen);
               }
               else
               {
                    this.pauseMenu = new CampaignPauseMenu(this.gameScreen);
               }
               ++this.main.loadingFraction;
               this.SCROLL_SPEED = this.gameScreen.game.xml.xml.screenScrollSpeed;
               this.SCROLL_GAIN = this.gameScreen.game.xml.xml.screenScrollGain;
               this.isSlowCamera = false;
               if(param1.type == Team.T_GOOD)
               {
                    this._hud = new GoodHud();
               }
               else if(param1.type == Team.T_CHAOS)
               {
                    this._hud = new ChaosHud();
               }
               else
               {
                    this._hud = new ElementalHud();
               }
               this.actionInterface = new ActionInterface(this);
               ++this.main.loadingFraction;
               addChild(this._actionInterface);
               this._actionInterface.mouseEnabled = false;
               this._actionInterface.mouseChildren = false;
               addChild(this._hud);
               this._chat = new Chat(this.gameScreen);
               ++this.main.loadingFraction;
               addChild(this._chat);
               this.gameScreen.addChild(this.pauseMenu);
               this.helpMessage = new HelpMessage(this.gameScreen.game);
               ++this.main.loadingFraction;
               addChild(this.helpMessage);
               this._chat.mouseEnabled = false;
               this._chat.mouseChildren = false;
               this.mouseEnabled = false;
               this.keyBoardState = new KeyboardState(stage);
               this.mouseState = new MouseState(stage);
               this.gameScreen.game.screenX = param1.homeX;
               if(this.gameScreen.game.team == this.gameScreen.game.teamB)
               {
                    this.gameScreen.game.screenX -= this.gameScreen.game.map.screenWidth;
               }
               this.gameScreen.game.targetScreenX = this.gameScreen.game.screenX;
               this.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownEvent);
               this.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpEvent);
               this.stage.addEventListener(Event.MOUSE_LEAVE,this.mouseUpEvent);
               this.hud.hud.defendButton.addEventListener(MouseEvent.CLICK,this.defendButton);
               if(param1 == this.gameScreen.game.teamA)
               {
                    this.hud.hud.garrisonButton.addEventListener(MouseEvent.CLICK,this.garrisonButton);
                    this.hud.hud.attackButton.addEventListener(MouseEvent.CLICK,this.attackButton);
                    this.hud.hud.leftMinerButton.addEventListener(MouseEvent.CLICK,this.garrisonMinerButton);
                    this.hud.hud.rightMinerButton.addEventListener(MouseEvent.CLICK,this.unGarrisonMinerButton);
               }
               else
               {
                    this.hud.hud.attackButton.addEventListener(MouseEvent.CLICK,this.garrisonButton);
                    this.hud.hud.garrisonButton.addEventListener(MouseEvent.CLICK,this.attackButton);
                    this.hud.hud.leftMinerButton.addEventListener(MouseEvent.CLICK,this.unGarrisonMinerButton);
                    this.hud.hud.rightMinerButton.addEventListener(MouseEvent.CLICK,this.garrisonMinerButton);
               }
               this.hud.hud.menuButton.addEventListener(MouseEvent.CLICK,this.openMenu);
               ++this.main.loadingFraction;
               this.gameScreen.team.initTeamButtons(this.gameScreen);
               ++this.main.loadingFraction;
               if(param1.type == Team.T_GOOD)
               {
                    this.gameScreen.game.soundManager.playSoundInBackground("orderInGame");
               }
               else if(param1.type == Team.T_CHAOS)
               {
                    this.gameScreen.game.soundManager.playSoundInBackground("chaosInGame");
               }
               else
               {
                    this.gameScreen.game.soundManager.playSoundInBackground("elementalInGame");
               }
               this.addChild(this.gameScreen.game.cursorSprite);
               this.setUpQualityButtons();
               if(this.hud.hud.fastForward)
               {
                    if(!(this.gameScreen is MultiplayerGameScreen))
                    {
                         this.hud.hud.fastForward.visible = true;
                         this.hud.hud.fastForward.addEventListener(MouseEvent.CLICK,this.clickFastForward,true);
                         MovieClip(this.hud.hud.fastForward).buttonMode = true;
                    }
                    else
                    {
                         this.hud.hud.fastForward.visible = false;
                    }
               }
          }
          
          public function setUpQualityButtons() : void
          {
               this.hud.hud.lowButton.addEventListener(MouseEvent.CLICK,this.lowButton);
               this.hud.hud.medButton.addEventListener(MouseEvent.CLICK,this.medButton);
               this.hud.hud.highButton.addEventListener(MouseEvent.CLICK,this.highButton);
          }
          
          public function cleanUpQualityButtons() : void
          {
               this.hud.hud.lowButton.removeEventListener(MouseEvent.CLICK,this.lowButton);
               this.hud.hud.medButton.removeEventListener(MouseEvent.CLICK,this.medButton);
               this.hud.hud.highButton.removeEventListener(MouseEvent.CLICK,this.highButton);
          }
          
          private function exitButton(param1:Event) : void
          {
               trace("hit the quit");
               trace("QUIT GAME");
               this.gameScreen.doMove(new ForfeitMove(),this.team.id);
          }
          
          private function pauseButton(param1:Event) : void
          {
               trace("PAUSE GAME");
               this.gameScreen.doMove(new PauseMove(),this.team.id);
          }
          
          private function openMenu(param1:Event) : void
          {
               this.pauseMenu.showMenu();
          }
          
          private function lowButton(param1:Event) : void
          {
               this.gameScreen.quality = GameScreen.S_HIGH_QUALITY;
          }
          
          private function medButton(param1:Event) : void
          {
               this.gameScreen.quality = GameScreen.S_LOW_QUALITY;
          }
          
          private function highButton(param1:Event) : void
          {
               this.gameScreen.quality = GameScreen.S_MEDIUM_QUALITY;
          }
          
          public function cleanUp() : void
          {
               if(this.hud.hud.fastForward)
               {
                    if(!(this.gameScreen is MultiplayerGameScreen))
                    {
                         this.hud.hud.fastForward.removeEventListener(MouseEvent.CLICK,this.clickFastForward);
                    }
               }
               if(this.gameScreen.contains(this.pauseMenu))
               {
                    this.gameScreen.removeChild(this.pauseMenu);
               }
               this.pauseMenu.cleanUp();
               this.pauseMenu = null;
               removeChild(this._hud);
               this.keyBoardState.cleanUp();
               this.mouseState.cleanUp();
               if(stage)
               {
                    this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownEvent);
                    this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpEvent);
                    this.stage.removeEventListener(Event.MOUSE_LEAVE,this.mouseUpEvent);
               }
               if(this.team == this.gameScreen.game.teamA)
               {
                    this.hud.hud.garrisonButton.removeEventListener(MouseEvent.CLICK,this.garrisonButton);
                    this.hud.hud.attackButton.removeEventListener(MouseEvent.CLICK,this.attackButton);
               }
               else
               {
                    this.hud.hud.attackButton.removeEventListener(MouseEvent.CLICK,this.garrisonButton);
                    this.hud.hud.garrisonButton.removeEventListener(MouseEvent.CLICK,this.attackButton);
               }
               this.hud.hud.defendButton.removeEventListener(MouseEvent.CLICK,this.defendButton);
               this.hud.hud.menuButton.removeEventListener(MouseEvent.CLICK,this.openMenu);
               this.cleanUpQualityButtons();
               this.hud.hud.leftMinerButton.removeEventListener(MouseEvent.CLICK,this.unGarrisonMinerButton);
               this.hud.hud.rightMinerButton.removeEventListener(MouseEvent.CLICK,this.garrisonMinerButton);
               this._hud = null;
               Util.recursiveRemoval(Sprite(this));
          }
          
          private function economyButton(param1:MouseEvent) : void
          {
          }
          
          private function battlefieldButton(param1:MouseEvent) : void
          {
          }
          
          public function garrisonMinerButton(param1:MouseEvent) : void
          {
               if(!this.isGlobalsEnabled)
               {
                    return;
               }
               var _loc2_:GlobalMove = new GlobalMove();
               _loc2_.globalMoveType = Team.G_GARRISON_MINER;
               this.gameScreen.doMove(_loc2_,this.team.id);
               if(this.team.type == Team.T_GOOD)
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("manthefortSoundOrder");
               }
               else
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("manthefortSoundChaos");
               }
          }
          
          public function unGarrisonMinerButton(param1:MouseEvent) : void
          {
               if(!this.isGlobalsEnabled)
               {
                    return;
               }
               var _loc2_:GlobalMove = new GlobalMove();
               _loc2_.globalMoveType = Team.G_UNGARRISON_MINER;
               this.gameScreen.doMove(_loc2_,this.team.id);
               if(this.team.type == Team.T_GOOD)
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("defendSoundOrder");
               }
               else
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("defendSoundChaos");
               }
          }
          
          public function garrisonButton(param1:MouseEvent) : void
          {
               if(!this.isGlobalsEnabled)
               {
                    return;
               }
               var _loc2_:GlobalMove = new GlobalMove();
               _loc2_.globalMoveType = Team.G_GARRISON;
               this.gameScreen.doMove(_loc2_,this.team.id);
               if(this.team.type == Team.T_GOOD)
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("manthefortSoundOrder");
               }
               else
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("manthefortSoundChaos");
               }
          }
          
          public function defendButton(param1:MouseEvent) : void
          {
               if(!this.isGlobalsEnabled)
               {
                    return;
               }
               var _loc2_:GlobalMove = new GlobalMove();
               _loc2_.globalMoveType = Team.G_DEFEND;
               this.gameScreen.doMove(_loc2_,this.team.id);
               if(this.team.type == Team.T_GOOD)
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("defendSoundOrder");
               }
               else
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("defendSoundChaos");
               }
          }
          
          public function attackButton(param1:MouseEvent) : void
          {
               if(!this.isGlobalsEnabled)
               {
                    return;
               }
               var _loc2_:GlobalMove = new GlobalMove();
               _loc2_.globalMoveType = Team.G_ATTACK;
               this.gameScreen.doMove(_loc2_,this.team.id);
               if(this.team.type == Team.T_GOOD)
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("attackSoundOrder");
               }
               else
               {
                    this.gameScreen.game.soundManager.playSoundFullVolume("attackSoundChaos");
               }
          }
          
          private function tryToSelectABuilding() : void
          {
               var _loc1_:String = null;
               var _loc2_:Building = null;
               for(_loc1_ in this.team.buildings)
               {
                    _loc2_ = Building(this.team.buildings[_loc1_]);
                    if(_loc2_.hitAreaMovieClip.hitTestPoint(stage.mouseX,stage.mouseY,true))
                    {
                         if(this.mouseState.clicked)
                         {
                              this.mouseState.mouseDown = false;
                              this.mouseState.oldMouseDown = false;
                              this.mouseState.clicked = false;
                              _loc2_.selected = true;
                              this.selectedUnits.add(Unit(_loc2_));
                              this.mouseState.clicked = false;
                              if(_loc2_.button.currentFrame != 3)
                              {
                                   _loc2_.button.gotoAndStop(3);
                                   Util.animateToNeutral(MovieClip(_loc2_.button),-1);
                              }
                              _loc2_.button.gotoAndStop(3);
                         }
                         else
                         {
                              if(_loc2_.button.currentFrame != 2)
                              {
                                   _loc2_.button.gotoAndStop(2);
                                   Util.animateToNeutral(MovieClip(_loc2_.hitAreaMovieClip));
                                   Util.animateToNeutral(MovieClip(_loc2_.button),-1);
                              }
                              _loc2_.button.gotoAndStop(2);
                         }
                    }
                    else
                    {
                         if(_loc2_.button.currentFrame != 1)
                         {
                              _loc2_.button.gotoAndStop(1);
                              Util.animateToNeutral(MovieClip(_loc2_.button),-1);
                         }
                         _loc2_.button.gotoAndStop(1);
                    }
                    Util.animateMovieClip(MovieClip(_loc2_.button),0,-1);
               }
          }
          
          private function clickFastForward(param1:Event) : void
          {
               this.gameScreen.isFastForward = !this.gameScreen.isFastForward;
               this.mouseState.mouseDown = false;
          }
          
          private function checkInputForSelectAllOfType() : void
          {
               var _loc1_:int = 0;
               if(this.keyBoardState.isCtrl)
               {
                    _loc1_ = 0;
                    while(_loc1_ < 10)
                    {
                         if(this.keyBoardState.isPressed(48 + _loc1_))
                         {
                              this.team.checkInputForSelect(_loc1_ - 1,this.checkInputForSelect);
                         }
                         _loc1_++;
                    }
               }
          }
          
          private function checkInputForSelect(param1:int) : void
          {
               var _loc2_:String = null;
               var _loc3_:int = 0;
               var _loc4_:int = 0;
               if(!this.keyBoardState.isShift)
               {
                    this.selectedUnits.clear();
               }
               for(_loc2_ in this.team.units)
               {
                    _loc3_ = this.team.units[_loc2_].x - this.gameScreen.game.screenX;
                    _loc4_ = this.team.units[_loc2_].y + this.gameScreen.game.battlefield.y;
                    if((Unit(this.team.units[_loc2_]).type == param1 || Boolean(Unit(this.team.units[_loc2_]).selected) && this.keyBoardState.isShift) && !Unit(this.team.units[_loc2_]).isGarrisoned)
                    {
                         Unit(this.team.units[_loc2_]).selected = true;
                    }
                    else
                    {
                         Unit(this.team.units[_loc2_]).selected = false;
                    }
                    if(Unit(this.team.units[_loc2_]).selected)
                    {
                         this.selectedUnits.add(Unit(this.team.units[_loc2_]));
                    }
               }
          }
          
          public function update(param1:Event, param2:Number) : void
          {
               var _loc5_:Unit = null;
               var _loc6_:Team = null;
               var _loc7_:ScreenPositionUpdateMove = null;
               var _loc8_:int = 0;
               var _loc9_:Number = NaN;
               var _loc10_:Number = NaN;
               var _loc11_:Point = null;
               var _loc12_:Number = NaN;
               var _loc13_:Number = NaN;
               var _loc14_:Wall = null;
               var _loc15_:Entity = null;
               var _loc16_:int = 0;
               var _loc17_:String = null;
               var _loc18_:int = 0;
               var _loc19_:int = 0;
               if(!(this.gameScreen is MultiplayerGameScreen))
               {
                    if(this.hud.hud.fastForward)
                    {
                         if(this.gameScreen.isFastForward)
                         {
                              this.hud.hud.fastForward.gotoAndStop(2);
                         }
                         else
                         {
                              this.hud.hud.fastForward.gotoAndStop(1);
                         }
                    }
               }
               this.checkInputForSelectAllOfType();
               var _loc3_:int = 23;
               if(this.hud.hud.attackButton.hitTestPoint(stage.mouseX,stage.mouseY,true))
               {
                    if(this.lastButton != this.hud.hud.attackButton && !this.gameScreen.isFastForwardFrame)
                    {
                         this.mouseOverFrames = 0;
                    }
                    ++this.mouseOverFrames;
                    if(this.mouseOverFrames > _loc3_)
                    {
                         if(this.gameScreen.team == this.gameScreen.game.teamB)
                         {
                              this.gameScreen.game.tipBox.displayTip("Garrison","Command all units to garrison inside the castle.",0,0,0,0,true);
                         }
                         else
                         {
                              this.gameScreen.game.tipBox.displayTip("Attack","Command all units to attack the enemy.",0,0,0,0,true);
                         }
                    }
                    this.lastButton = this.hud.hud.attackButton;
               }
               else if(this.hud.hud.defendButton.hitTestPoint(stage.mouseX,stage.mouseY,true))
               {
                    if(this.lastButton != this.hud.hud.defendButton && !this.gameScreen.isFastForwardFrame)
                    {
                         this.mouseOverFrames = 0;
                    }
                    ++this.mouseOverFrames;
                    if(this.mouseOverFrames > _loc3_)
                    {
                         this.gameScreen.game.tipBox.displayTip("Defend","Command all units to defend the statue.",0,0,0,0,true);
                    }
                    this.lastButton = this.hud.hud.defendButton;
               }
               else if(this.hud.hud.garrisonButton.hitTestPoint(stage.mouseX,stage.mouseY,true))
               {
                    if(this.lastButton != this.hud.hud.garrisonButton && !this.gameScreen.isFastForwardFrame)
                    {
                         this.mouseOverFrames = 0;
                    }
                    ++this.mouseOverFrames;
                    if(this.mouseOverFrames > _loc3_)
                    {
                         if(this.gameScreen.team == this.gameScreen.game.teamA)
                         {
                              this.gameScreen.game.tipBox.displayTip("Garrison","Command all units to garrison inside the castle.",0,0,0,0,true);
                         }
                         else
                         {
                              this.gameScreen.game.tipBox.displayTip("Attack","Command all units to attack the enemy.",0,0,0,0,true);
                         }
                    }
                    this.lastButton = this.hud.hud.garrisonButton;
               }
               else if(this.hud.hud.rightMinerButton.hitTestPoint(stage.mouseX,stage.mouseY,true))
               {
                    if(this.lastButton != this.hud.hud.rightMinerButton && !this.gameScreen.isFastForwardFrame)
                    {
                         this.mouseOverFrames = 0;
                    }
                    ++this.mouseOverFrames;
                    if(this.mouseOverFrames > _loc3_)
                    {
                         if(this.gameScreen.team == this.gameScreen.game.teamB)
                         {
                              this.gameScreen.game.tipBox.displayTip("Garrison Miners","Command all miners to garrison within the castle.",0,0,0,0,true);
                         }
                         else
                         {
                              this.gameScreen.game.tipBox.displayTip("Resume Mining","Command all miners to resume mining.",0,0,0,0,true);
                         }
                    }
                    this.lastButton = this.hud.hud.rightMinerButton;
               }
               else if(this.hud.hud.leftMinerButton.hitTestPoint(stage.mouseX,stage.mouseY,true))
               {
                    if(this.lastButton != this.hud.hud.leftMinerButton && !this.gameScreen.isFastForwardFrame)
                    {
                         this.mouseOverFrames = 0;
                    }
                    ++this.mouseOverFrames;
                    if(this.mouseOverFrames > _loc3_)
                    {
                         if(this.gameScreen.team == this.gameScreen.game.teamA)
                         {
                              this.gameScreen.game.tipBox.displayTip("Garrison Miners","Command all miners to garrison within the castle.",0,0,0,0,true);
                         }
                         else
                         {
                              this.gameScreen.game.tipBox.displayTip("Resume Mining","Command all miners to resume mining.",0,0,0,0,true);
                         }
                    }
                    this.lastButton = this.hud.hud.leftMinerButton;
               }
               else if(this.hud.hud.lowButton.hitTestPoint(stage.mouseX,stage.mouseY,true))
               {
                    if(this.lastButton != this.hud.hud.lowButton && !this.gameScreen.isFastForwardFrame)
                    {
                         this.mouseOverFrames = 0;
                    }
                    ++this.mouseOverFrames;
                    if(this.mouseOverFrames > _loc3_)
                    {
                         this.gameScreen.game.tipBox.displayTip("Toggle Quality","Toggles graphics quality to improve performance for slower computers.",0,0,0,0,true);
                    }
                    this.lastButton = this.hud.hud.lowButton;
               }
               else
               {
                    if(!this.gameScreen.isFastForwardFrame)
                    {
                         this.mouseOverFrames = 0;
                    }
                    this.lastButton = null;
               }
               this.helpMessage.update(this.gameScreen.game);
               this.pauseMenu.update();
               this.selectedUnits.update(this.gameScreen.game);
               this.mouseState.update();
               this.gameScreen.team.checkUnitCreateMouseOver(this.gameScreen);
               this.selectedUnits.refresh();
               this.actionInterface.update(this.gameScreen);
               this.selectedUnits.hasChanged = false;
               this._chat.update();
               this.keyBoardState.isDisabled = this.chat.isInput;
               if(this.keyBoardState.isPressed(80) || this.keyBoardState.isPressed(Keyboard.ESCAPE))
               {
                    this.pauseMenu.toggleMenu();
               }
               this.gameScreen.game.soundManager.setPosition(this.gameScreen.game.screenX,0);
               if(this.gameScreen.isPaused)
               {
                    return;
               }
               if(this.keyBoardState.isPressed(9))
               {
                    this.selectedUnits.nextSelectedUnitType();
               }
               if(this.keyBoardState.isPressed(32))
               {
                    this.selectedUnits.clear();
                    for each(_loc5_ in this.team.units)
                    {
                         if(Boolean(_loc5_.isInteractable) && !_loc5_.isMiner() && !_loc5_.isDead && _loc5_.isGarrisoned == false && _loc5_.type != Unit.U_CHAOS_TOWER)
                         {
                              this.selectedUnits.add(_loc5_);
                              _loc5_.selected = true;
                         }
                    }
                    if(getTimer() - this.spacePressTimer < 400 && this.team.forwardUnitNotSpawn != null)
                    {
                         this.gameScreen.game.targetScreenX = this.team.forwardUnitNotSpawn.px - this.gameScreen.game.map.screenWidth / 2;
                         this.isSlowCamera = false;
                    }
                    this.spacePressTimer = getTimer();
               }
               if(this.keyBoardState.isDown(39))
               {
                    this.gameScreen.game.targetScreenX += this.SCROLL_SPEED * 1;
                    this.isSlowCamera = false;
               }
               if(this.keyBoardState.isDown(37))
               {
                    this.gameScreen.game.targetScreenX -= this.SCROLL_SPEED * 1;
                    this.isSlowCamera = false;
               }
               if(this.gameScreen.game.showGameOverAnimation)
               {
                    this.gameScreen.game.fogOfWar.isFogOn = false;
                    _loc6_ = this.gameScreen.game.teamA;
                    if(this.gameScreen.game.teamA == this.gameScreen.game.winner)
                    {
                         _loc6_ = this.gameScreen.game.teamB;
                    }
                    this.gameScreen.game.targetScreenX += (_loc6_.statue.px - this.gameScreen.game.map.screenWidth / 2 - this.gameScreen.game.targetScreenX) * 0.3;
                    _loc6_.statue.mc.nextFrame();
                    Util.animateMovieClip(_loc6_.statue.mc,0);
                    if(_loc6_.statue.mc.currentFrame == _loc6_.statue.mc.totalFrames)
                    {
                         this.gameScreen.game.gameOver = true;
                    }
                    _loc6_.updateStatue();
               }
               var _loc4_:int = (this.gameScreen.game.targetScreenX - this.gameScreen.game.screenX) * this.SCROLL_GAIN * 1;
               if(this.isSlowCamera)
               {
                    _loc4_ = (this.gameScreen.game.targetScreenX - this.gameScreen.game.screenX) * 0.05 * 1;
               }
               this.gameScreen.game.screenX += _loc4_;
               if(this.gameScreen.game.screenX > this.gameScreen.game.background.maxScreenX())
               {
                    this.gameScreen.game.screenX = this.gameScreen.game.targetScreenX = this.gameScreen.game.background.maxScreenX();
               }
               if(this.gameScreen.game.screenX < this.gameScreen.game.background.minScreenX())
               {
                    this.gameScreen.game.screenX = this.gameScreen.game.targetScreenX = this.gameScreen.game.background.minScreenX();
               }
               if(this.gameScreen.game.inEconomy)
               {
                    this.gameScreen.game.screenX = this.gameScreen.team.homeX - this.gameScreen.team.direction * this.gameScreen.game.map.screenWidth;
               }
               this.gameScreen.game.battlefield.x = -this.gameScreen.game.screenX;
               this.gameScreen.game.fogOfWar.update(this.gameScreen.game);
               this.gameScreen.game.cursorSprite.x = -this.gameScreen.game.screenX;
               this.gameScreen.game.fogOfWar.x = -this.gameScreen.game.screenX;
               this.gameScreen.game.bloodManager.x = -this.gameScreen.game.screenX;
               this.gameScreen.game.background.update(this.gameScreen.game);
               if(Math.abs(this.lastSentScreenPosition - this.gameScreen.game.screenX) > 100)
               {
                    _loc7_ = new ScreenPositionUpdateMove();
                    this.lastSentScreenPosition = _loc7_.pos = this.gameScreen.game.screenX;
                    this.gameScreen.doMove(_loc7_,this.team.id);
               }
               if(this.keyBoardState.isShift)
               {
                    this.team.enemyTeam.detectedUserInput(this);
               }
               else
               {
                    this.team.detectedUserInput(this);
               }
               if(this.keyBoardState.isPressed(71))
               {
               }
               if(this.mouseState.mouseIn && this.stage.mouseY < this.gameScreen.game.battlefield.y + 240)
               {
                    _loc8_ = 120;
                    if(this.stage.mouseX < _loc8_)
                    {
                         this.gameScreen.game.targetScreenX -= this.SCROLL_SPEED * (_loc8_ - stage.mouseX) / _loc8_;
                         this.isSlowCamera = false;
                    }
                    if(this.stage.mouseX > this.gameScreen.game.map.screenWidth - _loc8_)
                    {
                         this.gameScreen.game.targetScreenX -= this.SCROLL_SPEED * (this.gameScreen.game.map.screenWidth - _loc8_ - stage.mouseX) / _loc8_;
                         this.isSlowCamera = false;
                    }
               }
               if(this.mouseState.mouseDown)
               {
                    _loc9_ = this.hud.hud.map.mouseX / this.hud.hud.map.width;
                    _loc10_ = this.hud.hud.map.mouseY / this.hud.hud.map.height;
                    _loc12_ = (_loc11_ = this.hud.hud.map.globalToLocal(new Point(this.mouseState.mouseDownX,this.mouseState.mouseDownY))).x / this.hud.hud.map.width;
                    _loc13_ = _loc11_.y / this.hud.hud.map.height;
                    if(_loc9_ >= 0 && _loc9_ <= 1 && _loc10_ >= 0 && _loc10_ <= 1 && _loc12_ >= 0 && _loc12_ <= 1 && _loc13_ >= 0 && _loc13_ <= 1 && !(_loc12_ > 0.95 && _loc13_ < 0.54))
                    {
                         this.gameScreen.game.targetScreenX = _loc9_ * this.gameScreen.game.map.width - this.gameScreen.game.map.screenWidth / 2;
                         this.isSlowCamera = false;
                    }
               }
               if(!this.actionInterface.isInCommand() && this.stage.mouseY <= 700 - 125)
               {
                    this.tryToSelectABuilding();
                    if(this.mouseState.clicked)
                    {
                         if(!this.keyBoardState.isShift)
                         {
                              this.selectedUnits.clear();
                         }
                         for each(_loc14_ in this.team.walls)
                         {
                              if(_loc14_.checkForHitPoint3(new Point(stage.mouseX,stage.mouseY)))
                              {
                                   this.selectedUnits.add(Unit(_loc14_));
                                   Unit(_loc14_).selected = true;
                              }
                              else
                              {
                                   Unit(_loc14_).selected = false;
                              }
                         }
                         if((_loc15_ = this.gameScreen.game.mouseOverUnit) != null && _loc15_ is Unit && Unit(_loc15_).team == this.team && !(_loc15_ is Statue))
                         {
                              if(this.keyBoardState.isShift)
                              {
                                   Unit(_loc15_).selected = true;
                              }
                              else
                              {
                                   Unit(_loc15_).selected = true;
                              }
                              this.selectedUnits.add(Unit(_loc15_));
                         }
                    }
                    if(this.mouseState.doubleClicked)
                    {
                         _loc16_ = -1;
                         if(this.gameScreen.game.mouseOverUnit != null && this.gameScreen.game.mouseOverUnit is Unit && Unit(this.gameScreen.game.mouseOverUnit).team == this.team)
                         {
                              _loc16_ = this.gameScreen.game.mouseOverUnit.type;
                         }
                         this.checkInputForSelect(_loc16_);
                    }
               }
               this.box.update(this.gameScreen.game.battlefield.mouseX,this.gameScreen.game.battlefield.mouseY);
               if(this.box.isOn)
               {
                    for(_loc17_ in this.team.units)
                    {
                         if(this.team.units[_loc17_].isAlive())
                         {
                              if(!(Unit(this.team.units[_loc17_]).interactsWith & Unit.I_IS_BUILDING))
                              {
                                   _loc18_ = int(this.team.units[_loc17_].x);
                                   _loc19_ = int(this.team.units[_loc17_].y);
                                   if(this.keyBoardState.isShift)
                                   {
                                        Unit(this.team.units[_loc17_]).selected = this.box.isInside(_loc18_,_loc19_,this.team.units[_loc17_].mc.height / 2,20) || Boolean(Unit(this.team.units[_loc17_]).selected) || this.gameScreen.game.mouseOverUnit == this.team.units[_loc17_];
                                   }
                                   else
                                   {
                                        Unit(this.team.units[_loc17_]).selected = this.box.isInside(_loc18_,_loc19_,this.team.units[_loc17_].mc.height / 2,20) || this.gameScreen.game.mouseOverUnit == this.team.units[_loc17_];
                                   }
                                   if(Unit(this.team.units[_loc17_]).selected)
                                   {
                                        this.selectedUnits.add(Unit(this.team.units[_loc17_]));
                                   }
                              }
                         }
                    }
               }
               this._hud.update(this.gameScreen.game,this.team);
               this.hud.hud.lowButton.visible = false;
               this.hud.hud.medButton.visible = false;
               this.hud.hud.highButton.visible = false;
               if(this.gameScreen.quality == GameScreen.S_LOW_QUALITY)
               {
                    this.hud.hud.lowButton.visible = true;
               }
               else if(this.gameScreen.quality == GameScreen.S_MEDIUM_QUALITY)
               {
                    this.hud.hud.medButton.visible = true;
               }
               else if(this.gameScreen.quality == GameScreen.S_HIGH_QUALITY)
               {
                    this.hud.hud.highButton.visible = true;
               }
               this.actionInterface.updateActionAlpha(this.gameScreen);
          }
          
          public function mouseUpEvent(param1:Event) : void
          {
               if(stage == null)
               {
                    return;
               }
               if(this.gameScreen.game != null && this.gameScreen.game.cusorSprite.contains(this.box))
               {
                    this.gameScreen.game.cusorSprite.removeChild(this.box);
                    this.box.end();
                    this.selectedUnits.hasFinishedSelecting = true;
                    if(this.selectedUnits.selected.length == 0)
                    {
                         this.mouseState.clicked = true;
                         this.tryToSelectABuilding();
                    }
               }
          }
          
          public function mouseDownEvent(param1:MouseEvent) : void
          {
               if(stage == null)
               {
                    return;
               }
               if(!this.actionInterface.isInCommand() && param1.stageY <= 700 - 125)
               {
                    this.box.start(this.gameScreen.game.battlefield.mouseX,this.gameScreen.game.battlefield.mouseY);
                    this.gameScreen.game.cusorSprite.addChild(this.box);
                    if(!this.keyBoardState.isShift)
                    {
                         this.selectedUnits.clear();
                    }
                    this.selectedUnits.hasFinishedSelecting = false;
               }
          }
          
          public function get hud() : Hud
          {
               return this._hud;
          }
          
          public function set hud(param1:Hud) : void
          {
               this._hud = param1;
          }
          
          public function get actionInterface() : com.brockw.stickwar.engine.ActionInterface
          {
               return this._actionInterface;
          }
          
          public function set actionInterface(param1:com.brockw.stickwar.engine.ActionInterface) : void
          {
               this._actionInterface = param1;
          }
          
          public function get team() : Team
          {
               return this._team;
          }
          
          public function set team(param1:Team) : void
          {
               this._team = param1;
          }
          
          public function get selectedUnits() : com.brockw.stickwar.engine.SelectedUnits
          {
               return this._selectedUnits;
          }
          
          public function set selectedUnits(param1:com.brockw.stickwar.engine.SelectedUnits) : void
          {
               this._selectedUnits = param1;
          }
          
          public function get main() : BaseMain
          {
               return this._main;
          }
          
          public function set main(param1:BaseMain) : void
          {
               this._main = param1;
          }
          
          public function get chat() : com.brockw.stickwar.engine.Chat
          {
               return this._chat;
          }
          
          public function set chat(param1:com.brockw.stickwar.engine.Chat) : void
          {
               this._chat = param1;
          }
          
          public function get gameScreen() : GameScreen
          {
               return this._gameScreen;
          }
          
          public function set gameScreen(param1:GameScreen) : void
          {
               this._gameScreen = param1;
          }
          
          public function get box() : com.brockw.stickwar.engine.Box
          {
               return this._box;
          }
          
          public function set box(param1:com.brockw.stickwar.engine.Box) : void
          {
               this._box = param1;
          }
          
          public function get isSlowCamera() : Boolean
          {
               return this._isSlowCamera;
          }
          
          public function set isSlowCamera(param1:Boolean) : void
          {
               this._isSlowCamera = param1;
          }
          
          public function get helpMessage() : com.brockw.stickwar.engine.HelpMessage
          {
               return this._helpMessage;
          }
          
          public function set helpMessage(param1:com.brockw.stickwar.engine.HelpMessage) : void
          {
               this._helpMessage = param1;
          }
          
          public function get isMusic() : Boolean
          {
               return this._isMusic;
          }
          
          public function set isMusic(param1:Boolean) : void
          {
               this.gameScreen.game.soundManager.isMusic = param1;
               this._isMusic = param1;
          }
          
          public function get pauseMenu() : com.brockw.stickwar.engine.PauseMenu
          {
               return this._pauseMenu;
          }
          
          public function set pauseMenu(param1:com.brockw.stickwar.engine.PauseMenu) : void
          {
               this._pauseMenu = param1;
          }
     }
}
