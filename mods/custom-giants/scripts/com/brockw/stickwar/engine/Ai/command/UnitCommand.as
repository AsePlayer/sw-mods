package com.brockw.stickwar.engine.Ai.command
{
     import com.brockw.game.Pool;
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.multiplayer.moves.*;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.Bitmap;
     import flash.display.MovieClip;
     import flash.display.Sprite;
     import flash.geom.Point;
     
     public class UnitCommand
     {
          
          public static const NO_COMMAND:int = 0;
          
          public static const ATTACK:int = 1;
          
          public static const ATTACK_MOVE:int = 2;
          
          public static const MOVE:int = 3;
          
          public static const STAND:int = 4;
          
          public static const SPELL:int = 5;
          
          public static const MINE:int = 6;
          
          public static const HOLD:int = 7;
          
          public static const GARRISON:int = 8;
          
          public static const UNGARRISON:int = 9;
          
          public static const TECH:int = 10;
          
          public static const ARCHER_HARD_SHOT:int = 20;
          
          public static const SWORDWRATH_RAGE:int = 21;
          
          public static const NUKE:int = 22;
          
          public static const STUN:int = 23;
          
          public static const STEALTH:int = 24;
          
          public static const HEAL:int = 25;
          
          public static const CURE:int = 26;
          
          public static const POISON_DART:int = 27;
          
          public static const SLOW_DART:int = 28;
          
          public static const ARCHER_POISON:int = 29;
          
          public static const ARCHER_FIRE:int = 30;
          
          public static const SPEARTON_BLOCK:int = 31;
          
          public static const FIST_ATTACK:int = 32;
          
          public static const REAPER:int = 33;
          
          public static const WINGIDON_SPEED:int = 34;
          
          public static const SHIELD_BASH:int = 35;
          
          public static const KNIGHT_CHARGE:int = 36;
          
          public static const CAT_FURY:int = 37;
          
          public static const CAT_PACK:int = 38;
          
          public static const DEAD_POISON:int = 39;
          
          public static const STONE:int = 41;
          
          public static const POISON_POOL:int = 42;
          
          public static const CONSTRUCT_TOWER:int = 43;
          
          public static const CONSTRUCT_WALL:int = 44;
          
          public static const BOMBER_DETONATE:int = 45;
          
          public static const NINJA_STACK:int = 46;
          
          public static const REMOVE_WALL_COMMAND:int = 47;
          
          public static const REMOVE_TOWER_COMMAND:int = 48;
          
          public static const actualButtonBitmap = new Bitmap(new CommandMove());
           
          
          protected var game:StickWar;
          
          protected var _intendedEntityType:int;
          
          private var _goalX:int;
          
          private var _goalY:int;
          
          private var _realX:int;
          
          private var _realY:int;
          
          private var _isGroup:Boolean;
          
          private var _requiresMouseInput:Boolean;
          
          private var _queued:Boolean;
          
          private var _pool:Pool;
          
          private var _type:int;
          
          protected var _hotKey:int;
          
          private var _isToggle:Boolean;
          
          private var _cursor:MovieClip;
          
          protected var _hasCoolDown:Boolean;
          
          private var _isSingleSpell:Boolean;
          
          protected var _buttonBitmap:Bitmap;
          
          private var _toolTip:String;
          
          protected var _team:Team;
          
          protected var _targetId:int;
          
          private var _unit:Unit;
          
          private var _isActivatable:Boolean;
          
          private var _xmlInfo:XMLList;
          
          protected var circleSprite:Sprite;
          
          private var mana:int;
          
          private var gold:int;
          
          public function UnitCommand()
          {
               super();
               this._queued = false;
               this.hotKey = 0;
               this._intendedEntityType = -1;
               this._isSingleSpell = false;
               this._cursor = new Cursor();
               this._requiresMouseInput = false;
               this._hasCoolDown = false;
               this._isToggle = false;
               this._buttonBitmap = actualButtonBitmap;
               this._isActivatable = true;
               this.circleSprite = new Sprite();
          }
          
          protected function loadXML(xmlList:XMLList) : void
          {
               this._xmlInfo = xmlList;
               this.hotKey = int(xmlList.hotkey);
               this.mana = int(xmlList.mana);
               this.gold = int(xmlList.gold);
          }
          
          public function playSound(game:StickWar) : void
          {
          }
          
          public function getGoldRequired() : int
          {
               return this.gold;
          }
          
          public function getManaRequired() : int
          {
               return this.mana;
          }
          
          public function mayCast(gameScreen:GameScreen, team:Team) : Boolean
          {
               return true;
          }
          
          public function unableToCastMessage() : String
          {
               return "Unable to cast";
          }
          
          public function drawCursorPreClick(canvas:Sprite, gameScreen:GameScreen) : Boolean
          {
               while(canvas.numChildren != 0)
               {
                    canvas.removeChildAt(0);
               }
               canvas.addChild(this.cursor);
               this.cursor.x = gameScreen.game.battlefield.mouseX;
               this.cursor.y = gameScreen.game.battlefield.mouseY;
               this.cursor.scaleX = 2 * gameScreen.game.getPerspectiveScale(gameScreen.game.battlefield.mouseY);
               this.cursor.scaleY = 2 * gameScreen.game.getPerspectiveScale(gameScreen.game.battlefield.mouseY);
               this.cursor.gotoAndStop(1);
               return true;
          }
          
          public function isToggled(entity:Entity) : Boolean
          {
               return false;
          }
          
          protected function drawRangeIndicators(canvas:Sprite, range:Number, showAll:Boolean, gameScreen:GameScreen) : void
          {
               var unit:Unit = null;
               var topPoint:Number = NaN;
               var bottomPoint:Number = NaN;
               canvas.addChild(this.circleSprite);
               this.circleSprite.graphics.clear();
               this.circleSprite.graphics.lineStyle(1,16777215,1);
               for each(unit in gameScreen.userInterface.selectedUnits.selected)
               {
                    if(unit.type == gameScreen.userInterface.selectedUnits.getSelectedType())
                    {
                         topPoint = Math.sqrt(Math.pow(range,2) - Math.pow(unit.py,2));
                         bottomPoint = Math.sqrt(Math.pow(range,2) - Math.pow(gameScreen.game.map.height - unit.py,2));
                         this.circleSprite.graphics.moveTo(unit.px + topPoint * unit.team.direction,0);
                         this.circleSprite.graphics.curveTo(unit.px + range * unit.team.direction,unit.py,unit.px + bottomPoint * unit.team.direction,gameScreen.game.map.height);
                         this.circleSprite.graphics.moveTo(unit.px + topPoint * -unit.team.direction,0);
                         this.circleSprite.graphics.curveTo(unit.px - range * unit.team.direction,unit.py,unit.px - bottomPoint * unit.team.direction,gameScreen.game.map.height);
                    }
               }
          }
          
          public function drawCursorPostClick(canvas:Sprite, game:GameScreen) : Boolean
          {
               if(canvas.contains(this.cursor))
               {
                    this.cursor.nextFrame();
                    if(this.cursor.currentFrame == this.cursor.totalFrames)
                    {
                         canvas.removeChild(this.cursor);
                         return true;
                    }
                    return false;
               }
               return true;
          }
          
          public function cleanUp() : void
          {
               this._team = null;
               if(this.buttonBitmap != null)
               {
                    this.buttonBitmap.bitmapData = null;
               }
               this._cursor = null;
               this._pool = null;
          }
          
          public function isEnabled(entity:Entity) : Boolean
          {
               return false;
          }
          
          public function coolDownTime(entity:Entity) : Number
          {
               return 0;
          }
          
          public function get goalY() : Number
          {
               return this._goalY;
          }
          
          public function set goalY(value:Number) : void
          {
               this._goalY = value;
          }
          
          public function get goalX() : Number
          {
               return this._goalX;
          }
          
          public function set goalX(value:Number) : void
          {
               this._goalX = value;
          }
          
          public function get realX() : Number
          {
               return this._realX;
          }
          
          public function set realX(value:Number) : void
          {
               this._realX = value;
          }
          
          public function get realY() : Number
          {
               return this._realY;
          }
          
          public function set realY(value:Number) : void
          {
               this._realY = value;
          }
          
          public function isFinished(unit:Unit) : Boolean
          {
               return false;
          }
          
          public function get type() : int
          {
               return this._type;
          }
          
          public function set type(value:int) : void
          {
               this._type = value;
          }
          
          public function get queued() : Boolean
          {
               return this._queued;
          }
          
          public function set queued(value:Boolean) : void
          {
               this._queued = value;
          }
          
          public function inRange(entity:Entity) : Boolean
          {
               return true;
          }
          
          public function cleanUpPreClick(canvas:Sprite) : void
          {
               if(canvas.contains(this.circleSprite))
               {
                    canvas.removeChild(this.circleSprite);
               }
          }
          
          public function prepareNetworkedMove(gameScreen:GameScreen) : *
          {
               var unit:String = null;
               var posX:Number = NaN;
               var posY:Number = NaN;
               var p:Point = null;
               var dposX:Number = NaN;
               var dposY:Number = NaN;
               var c:UnitCommand = null;
               var distanceNew:Number = NaN;
               this.playSound(gameScreen.game);
               var u:UnitMove = new UnitMove();
               u.moveType = this.type;
               var bestUnit:Unit = null;
               var distance:Number = 0;
               for(unit in gameScreen.team.units)
               {
                    if(this._isSingleSpell)
                    {
                         c = UnitCommand(gameScreen.game.commandFactory.createCommand(gameScreen.game,this.type,0,0,0,0,0,0,0));
                         if((this.intendedEntityType == -1 || this.intendedEntityType == gameScreen.team.units[unit].type) && Unit(gameScreen.team.units[unit]).selected && (!c.hasCoolDown || c.hasCoolDown && c.coolDownTime(gameScreen.team.units[unit]) == 0) && !Unit(gameScreen.team.units[unit]).isBusy())
                         {
                              distanceNew = Unit(gameScreen.team.units[unit]).px - this.realX * Unit(gameScreen.team.units[unit]).px - this.realX + Unit(gameScreen.team.units[unit]).py - this.realY * Unit(gameScreen.team.units[unit]).py - this.realY;
                              if(bestUnit == null)
                              {
                                   bestUnit = gameScreen.team.units[unit];
                                   distance = distanceNew;
                              }
                              else if(distanceNew < distance)
                              {
                                   bestUnit = gameScreen.team.units[unit];
                              }
                         }
                    }
                    else if(Unit(gameScreen.team.units[unit]).selected)
                    {
                         if(this.intendedEntityType == -1 || this.intendedEntityType == gameScreen.team.units[unit].type)
                         {
                              u.units.push(gameScreen.team.units[unit].id);
                         }
                    }
               }
               if(bestUnit != null)
               {
                    u.units.push(bestUnit.id);
               }
               for(unit in gameScreen.team.walls)
               {
                    if(this._isSingleSpell)
                    {
                         if(Unit(gameScreen.team.walls[unit]).selected)
                         {
                              if(this.intendedEntityType == -1 || this.intendedEntityType == gameScreen.team.walls[unit].type)
                              {
                                   u.units.push(gameScreen.team.walls[unit].id);
                              }
                         }
                    }
               }
               u.arg0 = gameScreen.game.battlefield.mouseX;
               u.arg1 = Math.max(0,Math.min(gameScreen.game.map.height,gameScreen.game.battlefield.mouseY));
               posX = gameScreen.userInterface.hud.hud.map.mouseX / gameScreen.userInterface.hud.hud.map.width;
               posY = gameScreen.userInterface.hud.hud.map.mouseY / gameScreen.userInterface.hud.hud.map.height;
               p = gameScreen.userInterface.hud.hud.map.globalToLocal(new Point(gameScreen.userInterface.mouseState.mouseDownX,gameScreen.userInterface.mouseState.mouseDownY));
               dposX = p.x / gameScreen.userInterface.hud.hud.map.width;
               dposY = p.y / gameScreen.userInterface.hud.hud.map.height;
               if(posX >= 0 && posX <= 1 && posY >= 0 && posY <= 1 && dposX >= 0 && dposX <= 1 && dposY >= 0 && dposY <= 1)
               {
                    u.arg0 = posX * gameScreen.game.map.width;
                    u.arg1 = posY * gameScreen.game.map.height;
               }
               u.arg4 = this.targetId;
               if(gameScreen.userInterface.keyBoardState.isShift)
               {
                    u.queued = true;
               }
               gameScreen.doMove(u,gameScreen.team.id);
          }
          
          public function get hotKey() : int
          {
               return this._hotKey;
          }
          
          public function set hotKey(value:int) : void
          {
               this._hotKey = value;
          }
          
          public function get requiresMouseInput() : Boolean
          {
               return this._requiresMouseInput;
          }
          
          public function set requiresMouseInput(value:Boolean) : void
          {
               this._requiresMouseInput = value;
          }
          
          public function get cursor() : MovieClip
          {
               return this._cursor;
          }
          
          public function set cursor(value:MovieClip) : void
          {
               this._cursor = value;
          }
          
          public function get hasCoolDown() : Boolean
          {
               return this._hasCoolDown;
          }
          
          public function set hasCoolDown(value:Boolean) : void
          {
               this._hasCoolDown = value;
          }
          
          public function get intendedEntityType() : int
          {
               return this._intendedEntityType;
          }
          
          public function set intendedEntityType(value:int) : void
          {
               this._intendedEntityType = value;
          }
          
          public function get isSingleSpell() : Boolean
          {
               return this._isSingleSpell;
          }
          
          public function set isSingleSpell(value:Boolean) : void
          {
               this._isSingleSpell = value;
          }
          
          public function get toolTip() : String
          {
               return this._toolTip;
          }
          
          public function set toolTip(value:String) : void
          {
               this._toolTip = value;
          }
          
          public function get team() : Team
          {
               return this._team;
          }
          
          public function set team(value:Team) : void
          {
               this._team = value;
          }
          
          public function get isToggle() : Boolean
          {
               return this._isToggle;
          }
          
          public function set isToggle(value:Boolean) : void
          {
               this._isToggle = value;
          }
          
          public function get buttonBitmap() : Bitmap
          {
               return this._buttonBitmap;
          }
          
          public function set buttonBitmap(value:Bitmap) : void
          {
               this._buttonBitmap = value;
          }
          
          public function get unit() : Unit
          {
               return this._unit;
          }
          
          public function set unit(value:Unit) : void
          {
               this._unit = value;
          }
          
          public function get targetId() : int
          {
               return this._targetId;
          }
          
          public function set targetId(value:int) : void
          {
               this._targetId = value;
          }
          
          public function get isActivatable() : Boolean
          {
               return this._isActivatable;
          }
          
          public function set isActivatable(value:Boolean) : void
          {
               this._isActivatable = value;
          }
          
          public function get xmlInfo() : XMLList
          {
               return this._xmlInfo;
          }
          
          public function set xmlInfo(value:XMLList) : void
          {
               this._xmlInfo = value;
          }
          
          public function get isGroup() : Boolean
          {
               return this._isGroup;
          }
          
          public function set isGroup(value:Boolean) : void
          {
               this._isGroup = value;
          }
     }
}
