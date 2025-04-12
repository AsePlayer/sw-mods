package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.BomberAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import flash.display.MovieClip;
     
     public class Bomber extends Unit
     {
           
          
          public var bomberType:String;
          
          public var didIBlowUp:Boolean = false;
          
          private var poisonRN:Boolean = false;
          
          private var noMorePoison:Boolean = false;
          
          private var divider:String;
          
          private var WEAPON_REACH:Number;
          
          public var explosionDamage:Number;
          
          private var clusterTime:Boolean = false;
          
          private var clusterTimer:Number;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Bomber;
          
          private var timeToRun:Boolean = false;
          
          public var newMinerTargeter:Boolean = false;
          
          public var detonated:Boolean = false;
          
          public var comment:String;
          
          public function Bomber(param1:StickWar)
          {
               super(param1);
               _mc = new _bomber();
               this.init(param1);
               addChild(_mc);
               ai = new BomberAi(this);
               this.bomberType = "Default";
               initSync();
               firstInit();
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_bomber = _bomber(param1);
               if(_loc5_.mc.dynamite2)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.dynamite2.gotoAndStop(param2);
                         Util.animateMovieClipBasic(_loc5_.mc.dynamite2.mc);
                    }
               }
               if(_loc5_.mc.dynamite)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.dynamite.gotoAndStop(param2);
                         Util.animateMovieClipBasic(_loc5_.mc.dynamite.mc);
                    }
               }
               if(_loc5_.mc.inner)
               {
                    if(_loc5_.mc.inner.dynamite)
                    {
                         if(param2 != "")
                         {
                              _loc5_.mc.inner.dynamite.gotoAndStop(param2);
                              Util.animateMovieClipBasic(_loc5_.mc.inner.dynamite.mc);
                         }
                    }
               }
               if(_loc5_.mc.head)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.head.gotoAndStop(param3);
                    }
               }
               if(_loc5_.mc.top)
               {
                    if(_loc5_.mc.top.head)
                    {
                         if(param3 != "")
                         {
                              _loc5_.mc.top.head.gotoAndStop(param3);
                         }
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return 0;
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               this.WEAPON_REACH = param1.xml.xml.Chaos.Units.bomber.weaponReach;
               population = param1.xml.xml.Chaos.Units.bomber.population;
               _mass = param1.xml.xml.Chaos.Units.bomber.mass;
               _maxForce = param1.xml.xml.Chaos.Units.bomber.maxForce;
               _dragForce = param1.xml.xml.Chaos.Units.bomber.dragForce;
               _scale = param1.xml.xml.Chaos.Units.bomber.scale;
               _maxVelocity = param1.xml.xml.Chaos.Units.bomber.maxVelocity;
               damageToDeal = param1.xml.xml.Chaos.Units.bomber.baseDamage;
               this.explosionDamage = param1.xml.xml.Chaos.Units.bomber.explosionDamage;
               this.createTime = param1.xml.xml.Chaos.Units.bomber.cooldown;
               maxHealth = health = param1.xml.xml.Chaos.Units.bomber.health;
               loadDamage(param1.xml.xml.Chaos.Units.bomber);
               type = Unit.U_BOMBER;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["BarracksBuilding"];
          }
          
          override public function update(param1:StickWar) : void
          {
               updateCommon(param1);
               this.customBomberSetUp(param1);
               if(!isDieing)
               {
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.attackLabel);
                         moveDualPartner(_dualPartner,_currentDual.xDiff);
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              _mc.gotoAndStop("run");
                              _isDualing = false;
                              _state = S_RUN;
                              px += Util.sgn(mc.scaleX) * _currentDual.finalXOffset * this.scaleX * this._scale * _worldScaleX * this.perspectiveScale;
                              dx = 0;
                              dy = 0;
                         }
                    }
                    else if(_state == S_RUN)
                    {
                         if(isFeetMoving())
                         {
                              _mc.gotoAndStop("run");
                         }
                         else
                         {
                              _mc.gotoAndStop("stand");
                         }
                    }
                    else if(_state == S_ATTACK)
                    {
                         damage(0,1000,null);
                    }
                    updateMotion(param1);
               }
               else if(isDead == false)
               {
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.defendLabel);
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              isDualing = false;
                              mc.filters = [];
                              this.team.removeUnit(this,param1);
                              isDead = true;
                         }
                    }
                    else
                    {
                         this.detonate();
                         _mc.gotoAndStop(getDeathLabel(param1));
                         this.team.removeUnit(this,param1);
                         isDead = true;
                    }
               }
               Util.animateMovieClipBasic(mc.mc);
               if(isDead)
               {
                    _mc.gotoAndStop(getDeathLabel(param1));
                    _mc.mc.alpha = 0;
               }
               if(this.bomberType == "medusaTargeter" && !specialTimeOver && !stoned)
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(_bomber(mc),"C4","Red Bike Helmet","");
               }
               else if(this.bomberType == "statueTargeter" && !specialTimeOver && !stoned)
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(_bomber(mc),"Rocket","Flash","");
               }
               else if(this.bomberType == "minerTargeter" && !specialTimeOver && !stoned)
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(_bomber(mc),"Flask","Scientist","");
               }
               else if(this.bomberType == "clusterBoi" && !specialTimeOver && !stoned)
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(_bomber(mc),"Round Cluster Bomb","Round Bomb","");
               }
               else if(this.bomberType == "Default")
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(_bomber(mc),"Default","Default","");
               }
          }
          
          public function detonate() : void
          {
               var _loc1_:int = 0;
               var _loc2_:int = 0;
               if(this.bomberType == "minerTargeter")
               {
                    team.game.projectileManager.initPoisonPool(px,py,this,5);
               }
               else if(this.bomberType == "clusterBoi" && !this.detonated)
               {
                    _loc1_ = Math.floor(Math.random() * 4) + 3;
                    _loc2_ = Math.floor(Math.random() * 3) + 1;
                    this.clusterLad = team.game.unitFactory.getUnit(Unit.U_BOMBER);
                    team.spawn(this.clusterLad,team.game);
                    this.clusterLad.px = px + 75;
                    this.clusterLad.py = py;
                    this.clusterLad.stun(_loc2_ * 10);
                    this.clusterLad.applyVelocity(-1 * _loc1_ * Util.sgn(mc.scaleX));
                    this.divider = "--------------------------------------------------------------------------";
                    _loc1_ = Math.floor(Math.random() * 4) + 3;
                    _loc2_ = Math.floor(Math.random() * 3) + 1;
                    this.clusterLad = team.game.unitFactory.getUnit(Unit.U_BOMBER);
                    team.spawn(this.clusterLad,team.game);
                    this.clusterLad.px = px;
                    this.clusterLad.py = py + 50;
                    this.clusterLad.stun(_loc2_ * 10);
                    this.clusterLad.applyVelocity(-1 * _loc2_ * Util.sgn(mc.scaleX));
                    this.divider = "--------------------------------------------------------------------------";
                    _loc1_ = Math.floor(Math.random() * 4) + 3;
                    _loc2_ = Math.floor(Math.random() * 3) + 1;
                    this.clusterLad = team.game.unitFactory.getUnit(Unit.U_BOMBER);
                    team.spawn(this.clusterLad,team.game);
                    this.clusterLad.px = px - 75;
                    this.clusterLad.py = py;
                    this.clusterLad.stun(_loc2_ * 10);
                    this.clusterLad.applyVelocity(1 * _loc1_ * Util.sgn(mc.scaleX));
                    team.population += 3;
               }
               team.game.soundManager.playSoundRandom("mediumExplosion",3,px,py);
               this.damage(0,this.maxHealth,null);
               team.game.projectileManager.initNuke(px,py,this,this.explosionDamage);
               trace("Bomber detonated");
          }
          
          public function customBomberSetUp(param1:StickWar) : void
          {
               if(this.bomberType == "minerTargeter")
               {
                    this.ai.minerTargeter = true;
                    isNormal = false;
               }
               if(this.bomberType == "medusaTargeter")
               {
                    this.ai.medusaTargeter = true;
                    isNormal = false;
               }
               if(this.bomberType == "statueTargeter" || this.bomberType == "statueEndsHere")
               {
                    this.ai.statueTargeter = true;
                    isNormal = false;
               }
               if(this.bomberType == "clusterBoi")
               {
                    isNormal = false;
                    this._maxHealth = param1.xml.xml.Chaos.Units.bomber.health * 2;
                    if(this.scale != 0.825)
                    {
                         this._health = this._maxHealth;
                         this.scale = 0.825;
                    }
                    else
                    {
                         this.scale = 0.825;
                    }
                    this.healthBar.totalHealth = this._maxHealth;
               }
               if(this.bomberType == "statueTargeter" && !this.timeToRun)
               {
                    isNormal = false;
                    this._maxForce = 140;
                    this._maxVelocity = 8;
               }
               else if(this.timeToRun)
               {
                    this.timeToRun = true;
                    this._maxVelocity = 8.75;
               }
               trace("Bomber detonated");
          }
          
          override public function get damageToArmour() : Number
          {
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               param1.setAction(0,0,UnitCommand.BOMBER_DETONATE);
          }
          
          override public function attack() : void
          {
               if(_state != S_ATTACK)
               {
                    _state = S_ATTACK;
                    hasHit = false;
               }
          }
          
          override public function mayAttack(param1:Unit) : Boolean
          {
               if(isIncapacitated())
               {
                    return false;
               }
               if(param1 == null)
               {
                    return false;
               }
               if(this.isDualing == true)
               {
                    return false;
               }
               if(_state == S_RUN)
               {
                    if(Math.abs(px - param1.px) < this.WEAPON_REACH && Math.abs(py - param1.py) < 40 && this.getDirection() == Util.sgn(param1.px - px))
                    {
                         return true;
                    }
               }
               return false;
          }
          
          public function aseSpeedUp() : void
          {
               this.timeToRun = true;
          }
          
          public function asePoisonNow() : void
          {
               this.poisonRN = true;
          }
          
          public function convertBomber(param1:String) : void
          {
               this.bomberType = param1;
          }
     }
}
