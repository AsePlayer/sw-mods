package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.BomberAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     
     public class Bomber extends Unit
     {
           
          
          private var WEAPON_REACH:Number;
          
          private var explosionDamage:Number;
          
          public var bomberType:String;
          
          private var setupComplete:Boolean;
          
          private var fireDamage:Number;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Bomber;
          
          private var fireFrames:int;
          
          public function Bomber(param1:StickWar)
          {
               super(param1);
               _mc = new _bomber();
               this.init(param1);
               addChild(_mc);
               ai = new BomberAi(this);
               initSync();
               firstInit();
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_bomber = null;
               if((_loc5_ = _bomber(param1)).mc.dynamite2)
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
               this.fireFrames = param1.xml.xml.Chaos.Units.bomber.fireFrames;
               this.fireDamage = param1.xml.xml.Chaos.Units.bomber.fireDamage;
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
          
          override public function canAttackAir() : Boolean
          {
               return true;
          }
          
          override public function update(param1:StickWar) : void
          {
               updateCommon(param1);
               if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour = _damageToNotArmour / 2 * team.game.main.campaign.difficultyLevel + 1;
                    _damageToArmour = _damageToArmour / 2 * team.game.main.campaign.difficultyLevel + 1;
                    health = health / 2.5 * (team.game.main.campaign.difficultyLevel + 1);
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.05 - 0.05;
                    enemyBuffed = true;
               }
               if(this.bomberType == "stunBomber" && !this.setupComplete)
               {
                    stunUnit = true;
                    com.brockw.stickwar.engine.units.Bomber.setItem(mc,"","","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.bomberType == "poisonBomber" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(mc,"","","");
                    maxHealth = 30;
                    health = 30;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.bomberType == "goldBomber" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(mc,"Gold Bombs","Gold Head","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    _maxVelocity = 8;
                    this.setupComplete = true;
               }
               if(this.bomberType == "electricBomber" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(mc,"","","");
                    maxHealth = 200;
                    health = 200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.bomberType != "")
               {
                    isCustomUnit = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.bomberType == "electricBomber")
                    {
                         this.explosionDamage = 50;
                         this.fireFrames = 0.4;
                         this.fireDamage = 100;
                    }
                    if(this.bomberType == "goldBomber")
                    {
                         _maxVelocity = 10;
                    }
                    else
                    {
                         this.explosionDamage = param1.xml.xml.Chaos.Units.bomber.explosionDamage;
                         this.fireFrames = param1.xml.xml.Chaos.Units.bomber.fireFrames;
                         this.fireDamage = param1.xml.xml.Chaos.Units.bomber.fireDamage;
                         _maxVelocity = param1.xml.xml.Chaos.Units.bomber.maxVelocity;
                    }
               }
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
                    if(this.bomberType == "goldBomber")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_BOMBER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.bomberType = "electricBomber";
                    }
                    if(this.bomberType == "electricBomber")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_BOMBER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.bomberType = "poisonBomber";
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_BOMBER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.bomberType = "poisonBomber";
                    }
                    isDead = true;
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
                         this.makeExplosion();
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
               if(this.bomberType == "poisonBomber")
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(mc,"","","");
               }
               else if(this.bomberType == "electricBomber")
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(mc,"","","");
               }
               else if(this.bomberType == "stunBomber")
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(mc,"","","");
               }
               else if(this.bomberType == "goldBomber")
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(mc,"Gold Bombs","Gold Head","");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Bomber.setItem(_bomber(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
          }
          
          public function detonate() : void
          {
               this.damage(0,this.maxHealth * 2,null);
          }
          
          public function makeExplosion() : void
          {
               if(this.bomberType == "poisonBomber")
               {
                    team.game.projectileManager.initPoisonPool(this.px,this.py,this,0);
               }
               if(this.bomberType == "electricBomber")
               {
                    team.game.projectileManager.initStun(this.px,py,35,this);
               }
               team.game.soundManager.playSoundRandom("mediumExplosion",3,px,py);
               team.game.projectileManager.initNuke(px,py,this,this.explosionDamage,this.fireDamage,this.fireFrames);
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
     }
}
