package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.MonkAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.geom.Point;
     
     public class Monk extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var cureSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var healSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var slowSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var isCuring:Boolean;
          
          private var isHealing:Boolean;
          
          private var isSlowing:Boolean;
          
          private var isShielding:Boolean;
          
          private var spellX:Number;
          
          private var spellY:Number;
          
          private var _isCureToggled:Boolean;
          
          private var cureTarget:com.brockw.stickwar.engine.units.Unit;
          
          private var _healAmount:Number;
          
          private var _healDuration:Number;
          
          private var _isHealToggled:Boolean;
          
          private var healTarget:com.brockw.stickwar.engine.units.Unit;
          
          public var monkType:String;
          
          private var setupComplete:Boolean;
          
          public function Monk(param1:StickWar)
          {
               super(param1);
               _mc = new _cleric();
               this.init(param1);
               addChild(_mc);
               ai = new MonkAi(this);
               initSync();
               firstInit();
               this.monkType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_cleric = null;
               if((_loc5_ = _cleric(param1)).mc.clericwand)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.clericwand.gotoAndStop(param2);
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return WEAPON_REACH;
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               WEAPON_REACH = param1.xml.xml.Order.Units.magikill.weaponReach;
               population = param1.xml.xml.Order.Units.monk.population;
               _mass = param1.xml.xml.Order.Units.monk.mass;
               _maxForce = param1.xml.xml.Order.Units.monk.maxForce;
               _dragForce = param1.xml.xml.Order.Units.monk.dragForce;
               _scale = param1.xml.xml.Order.Units.monk.scale;
               _maxVelocity = param1.xml.xml.Order.Units.monk.maxVelocity;
               damageToDeal = param1.xml.xml.Order.Units.monk.baseDamage;
               this.createTime = param1.xml.xml.Order.Units.monk.cooldown;
               loadDamage(param1.xml.xml.Order.Units.monk);
               maxHealth = health = param1.xml.xml.Order.Units.monk.health;
               this._healAmount = param1.xml.xml.Order.Units.monk.heal.amount;
               this._healDuration = param1.xml.xml.Order.Units.monk.heal.duration;
               type = com.brockw.stickwar.engine.units.Unit.U_MONK;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.radiantDamage = param1.xml.xml.Elemental.Units.lavaElement.radiant.damage;
               this.radiantRange = param1.xml.xml.Elemental.Units.lavaElement.radiant.range;
               this.radiantFrames = param1.xml.xml.Elemental.Units.lavaElement.radiant.frames;
               this.healSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.monk.heal.effect,param1.xml.xml.Order.Units.monk.heal.cooldown,param1.xml.xml.Order.Units.monk.heal.mana);
               this.cureSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.monk.cure.effect,param1.xml.xml.Order.Units.monk.cure.cooldown,param1.xml.xml.Order.Units.monk.cure.mana);
               this.slowSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.monk.slow.effect,param1.xml.xml.Order.Units.monk.slow.cooldown,param1.xml.xml.Order.Units.monk.slow.mana);
               this.isCuring = false;
               this.isHealing = false;
               this.isShielding = false;
               this.cureTarget = null;
               this.healTarget = null;
               this._isCureToggled = true;
               this._isHealToggled = true;
          }
          
          override public function setBuilding() : void
          {
               if(this.team.type == Team.T_GOOD)
               {
                    building = team.buildings["TempleBuilding"];
               }
               else
               {
                    building = team.buildings["UndeadBuilding"];
               }
          }
          
          private function burnInArea(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team || this.monkType == "Thera")
               {
                    if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                    {
                         param1.heal(0.4,1);
                    }
               }
          }
          
          override public function getDamageToDeal() : Number
          {
               return damageToDeal;
          }
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:com.brockw.stickwar.engine.units.Unit = null;
               var _loc3_:Point = null;
               this.healSpellCooldown.update();
               this.cureSpellCooldown.update();
               this.slowSpellCooldown.update();
               updateCommon(param1);
               if(!isUC)
               {
                    damageToDeal = param1.xml.xml.Order.Units.monk.baseDamage;
                    this._healAmount = param1.xml.xml.Order.Units.monk.heal.amount;
                    this._healDuration = param1.xml.xml.Order.Units.monk.heal.duration;
                    _maxVelocity = param1.xml.xml.Order.Units.monk.maxVelocity;
               }
               if(isUC)
               {
                    this._healAmount = param1.xml.xml.Order.Units.monk.heal.amount * 2;
                    this._healDuration = param1.xml.xml.Order.Units.monk.heal.duration * 2;
                    _maxVelocity = param1.xml.xml.Order.Units.monk.maxVelocity * 1.2;
                    _damageToNotArmour = (Number(param1.xml.xml.Order.Units.monk.damage) + Number(param1.xml.xml.Order.Units.monk.toNotArmour)) * 10;
                    _damageToArmour = (Number(param1.xml.xml.Order.Units.monk.damage) + Number(param1.xml.xml.Order.Units.monk.toArmour)) * 10;
               }
               else if(!team.isEnemy)
               {
                    this._healAmount = param1.xml.xml.Order.Units.monk.heal.amount;
                    this._healDuration = param1.xml.xml.Order.Units.monk.heal.duration;
                    _maxVelocity = param1.xml.xml.Order.Units.monk.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Order.Units.monk.damage) + Number(param1.xml.xml.Order.Units.monk.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Order.Units.monk.damage) + Number(param1.xml.xml.Order.Units.monk.toArmour);
               }
               else if(!team.isEnemy)
               {
                    this._healAmount = param1.xml.xml.Order.Units.monk.heal.amount;
                    this._healDuration = param1.xml.xml.Order.Units.monk.heal.duration;
                    _maxVelocity = param1.xml.xml.Order.Units.monk.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Order.Units.monk.damage) + Number(param1.xml.xml.Order.Units.monk.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Order.Units.monk.damage) + Number(param1.xml.xml.Order.Units.monk.toArmour);
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    health = Number(param1.xml.xml.Order.Units.monk.health) * 1.2;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.01 - 0.01;
                    enemyBuffed = true;
               }
               if(this.monkType == "Thera")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               if(this.monkType == "Thera" && !this.setupComplete)
               {
                    Monk.setItem(_mc,"Thera Staff","","");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 3.5;
                    this.healSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.monk.heal.effect,170,param1.xml.xml.Order.Units.monk.heal.mana);
                    this.setupComplete = true;
               }
               if(this.monkType == "LeafMonk" && !this.setupComplete)
               {
                    Monk.setItem(_mc,"Leaf Wand","","");
                    maxHealth = 250;
                    health = 250;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 3.8;
                    this.setupComplete = true;
               }
               if(this.monkType == "FastMonk" && !this.setupComplete)
               {
                    this.isCuring = false;
                    this.isHealing = false;
                    Monk.setItem(_mc,"","","");
                    maxHealth = 250;
                    health = 250;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 10.5;
                    this.setupComplete = true;
               }
               if(this.monkType == "TankyMonk" && !this.setupComplete)
               {
                    this.isCuring = false;
                    this.isHealing = false;
                    Monk.setItem(_mc,"","","");
                    maxHealth = 2150;
                    health = 2150;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.4;
                    _maxVelocity = 3.1;
                    this.setupComplete = true;
               }
               if(this.monkType == "BossMonk" && !this.setupComplete)
               {
                    this.isCuring = false;
                    this.isHealing = false;
                    Monk.setItem(_mc,"","","");
                    maxHealth = 10850;
                    health = 10850;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.3;
                    _maxVelocity = 2.5;
                    this.setupComplete = true;
               }
               if(this.monkType == "Monk_1" && !this.setupComplete)
               {
                    Monk.setItem(_mc,"","","");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.5;
                    this.setupComplete = true;
               }
               if(this.monkType == "Monk_2" && !this.setupComplete)
               {
                    this.isCuring = false;
                    this.isHealing = false;
                    Monk.setItem(_mc,"","","");
                    maxHealth = 750;
                    health = 750;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.5;
                    this.setupComplete = true;
               }
               if(this.monkType == "HighHealMonk" && !this.setupComplete)
               {
                    Monk.setItem(_mc,"","","");
                    maxHealth = 300;
                    health = 300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 3.5;
                    this.healSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.monk.heal.effect,200,param1.xml.xml.Order.Units.monk.heal.mana);
                    this.setupComplete = true;
               }
               if(this.monkType != "")
               {
                    isCustomUnit = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.monkType == "Thera")
                    {
                         this.radiantRange = 100;
                         this._healAmount = 40;
                         this._healDuration = 2;
                    }
                    else if(isUC)
                    {
                         _maxVelocity = param1.xml.xml.Order.Units.monk.maxVelocity * 1.2;
                    }
                    else if(this.monkType == "HighHealMonk")
                    {
                         this._healAmount = 100;
                         this._healDuration = 1;
                    }
                    else if(this.monkType == "FastMonk" || this.monkType == "TankyMonk" || this.monkType == "BossMonk" || this.monkType == "Monk_1" || this.monkType == "Monk_2")
                    {
                         stunTimeLeft = 0;
                         this.isCuring = false;
                         this.isHealing = false;
                    }
                    else
                    {
                         this._healAmount = param1.xml.xml.Order.Units.monk.heal.amount;
                         this._healDuration = param1.xml.xml.Order.Units.monk.heal.duration;
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
                    else if(this.isHealing == true)
                    {
                         _mc.gotoAndStop("attack_1");
                         if(MovieClip(_mc.mc).currentFrame == 25 && !hasHit)
                         {
                              if(this.healTarget != null)
                              {
                                   if(this.monkType == "Thera")
                                   {
                                        this.cure();
                                        this.heal(15,2);
                                        this.protect(110);
                                        this.healTarget.protect(58);
                                   }
                                   this.healTarget.heal(this.healAmount,this.healDuration);
                                   team.game.soundManager.playSound("HealSpellFinish",this.healTarget.px,this.healTarget.py);
                              }
                              hasHit = true;
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isHealing = false;
                              _state = S_RUN;
                         }
                    }
                    else if(this.isCuring == true)
                    {
                         _mc.gotoAndStop("attack_2");
                         if(MovieClip(_mc.mc).currentFrame == 25 && !hasHit)
                         {
                              if(this.monkType == "Thera")
                              {
                                   this.cure();
                                   this.heal(30,2);
                                   this.protect(110);
                              }
                              this.cureTarget.cure();
                              trace("DO THE CURE",this.cureTarget,this.cureTarget.id);
                              team.game.soundManager.playSound("PoisonCureSpellFinish",this.cureTarget.px,this.cureTarget.py);
                              hasHit = true;
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              MovieClip(_mc.mc).gotoAndStop(1);
                              this.isCuring = false;
                              _state = S_RUN;
                         }
                    }
                    else if(this.isSlowing == true)
                    {
                         _mc.gotoAndStop("attack_1");
                         if(MovieClip(_mc.mc).currentFrame == Math.floor(MovieClip(_mc.mc).totalFrames / 2) && !hasHit)
                         {
                              if(int(this.spellX) in param1.units)
                              {
                                   _loc2_ = param1.units[this.spellX];
                                   _loc3_ = mc.mc.clericwand.localToGlobal(new Point(0,0));
                                   _loc3_ = param1.battlefield.globalToLocal(_loc3_);
                                   param1.projectileManager.initSlowDart(_loc3_.x,_loc3_.y,0,this,_loc2_);
                              }
                              hasHit = true;
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isSlowing = false;
                              _state = S_RUN;
                         }
                    }
                    else if(_state == S_RUN)
                    {
                         if(isFeetMoving())
                         {
                              if(this.monkType == "Thera")
                              {
                                   this.heal(1,1);
                              }
                              _mc.gotoAndStop("run");
                         }
                         else
                         {
                              _mc.gotoAndStop("stand");
                         }
                    }
                    else if(_state == S_ATTACK)
                    {
                         if(!hasHit)
                         {
                              hasHit = this.checkForHit();
                              if(hasHit)
                              {
                              }
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
                    }
                    updateMotion(param1);
               }
               else if(isDead == false)
               {
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
                         _mc.gotoAndStop(getDeathLabel(param1));
                         this.team.removeUnit(this,param1);
                         isDead = true;
                    }
               }
               if(!isDead && MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
               {
                    MovieClip(_mc.mc).gotoAndStop(1);
               }
               if(isDead)
               {
                    Util.animateMovieClip(mc,3);
               }
               else
               {
                    MovieClip(_mc.mc).nextFrame();
                    _mc.mc.stop();
               }
               if(this.monkType == "Thera")
               {
                    Monk.setItem(_mc,"Thera Staff","","");
               }
               else if(this.monkType == "LeafMonk")
               {
                    Monk.setItem(_mc,"Leaf Wand","","");
               }
               else
               {
                    Monk.setItem(_mc,"","","");
               }
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               param1.setAction(0,0,UnitCommand.HEAL);
               if(techTeam.tech.isResearched(Tech.MONK_CURE))
               {
                    param1.setAction(1,0,UnitCommand.CURE);
               }
          }
          
          override public function attack() : void
          {
               var _loc1_:int = 0;
               if(_state != S_ATTACK)
               {
                    _loc1_ = team.game.random.nextInt() % this._attackLabels.length;
                    _mc.gotoAndStop("attack_" + this._attackLabels[_loc1_]);
                    MovieClip(_mc.mc).gotoAndStop(1);
                    _state = S_ATTACK;
                    hasHit = false;
                    attackStartFrame = team.game.frame;
                    framesInAttack = MovieClip(_mc.mc).totalFrames;
                    trace(framesInAttack);
               }
          }
          
          override public function isBusy() : Boolean
          {
               return this.isCuring || this.isHealing || this.isShielding || isBusyForSpell;
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.monkType == "FastMonk")
               {
                    return 95;
               }
               if(this.monkType == "TankyMonk")
               {
                    return 15;
               }
               if(this.monkType == "BossMonk")
               {
                    return 2000;
               }
               if(this.monkType == "Monk_1")
               {
                    return 60;
               }
               if(this.monkType == "Monk_2")
               {
                    return 60;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.monkType == "FastMonk")
               {
                    return 150;
               }
               if(this.monkType == "TankyMonk")
               {
                    return 30;
               }
               if(this.monkType == "BossMonk")
               {
                    return 3800;
               }
               if(this.monkType == "Monk_1")
               {
                    return 90;
               }
               if(this.monkType == "Monk_2")
               {
                    return 120;
               }
               return _damageToNotArmour;
          }
          
          public function healSpell(param1:com.brockw.stickwar.engine.units.Unit) : Boolean
          {
               if(!this.isBusy() && this.healSpellCooldown.spellActivate(team))
               {
                    this.isHealing = true;
                    _state = S_ATTACK;
                    hasHit = false;
                    this.healTarget = param1;
                    team.game.soundManager.playSound("HealSpellFinish",px,py);
                    return true;
               }
               return false;
          }
          
          public function cureSpell(param1:com.brockw.stickwar.engine.units.Unit) : void
          {
               if(!this.isBusy() && techTeam.tech.isResearched(Tech.MONK_CURE) && this.cureSpellCooldown.spellActivate(team))
               {
                    this.cureTarget = param1;
                    this.isCuring = true;
                    _state = S_ATTACK;
                    hasHit = false;
                    team.game.soundManager.playSound("PoisonCureSpellStart",px,py);
               }
          }
          
          public function slowDartSpell(param1:int) : void
          {
               var _loc2_:com.brockw.stickwar.engine.units.Unit = null;
               if(!this.isSlowing && this.slowSpellCooldown.spellActivate(this.team))
               {
                    this.spellX = param1;
                    if(int(param1) in team.game.units)
                    {
                         _loc2_ = team.game.units[param1];
                         forceFaceDirection(_loc2_.px - this.px);
                         this.isSlowing = true;
                         hasHit = false;
                         _state = S_ATTACK;
                    }
               }
          }
          
          public function healCooldown() : Number
          {
               return this.healSpellCooldown.cooldown();
          }
          
          public function cureCooldown() : Number
          {
               return this.cureSpellCooldown.cooldown();
          }
          
          public function slowDartCooldown() : Number
          {
               return this.slowSpellCooldown.cooldown();
          }
          
          override public function mayAttack(param1:com.brockw.stickwar.engine.units.Unit) : Boolean
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
                    if(Math.abs(px - param1.px) < WEAPON_REACH && Math.abs(py - param1.py) < 40 && this.getDirection() == Util.sgn(param1.px - px))
                    {
                         return true;
                    }
               }
               return false;
          }
          
          override public function stateFixForCutToWalk() : void
          {
               if(!this.isCuring && !this.isHealing)
               {
                    super.stateFixForCutToWalk();
               }
          }
          
          public function get isCureToggled() : Boolean
          {
               return this._isCureToggled;
          }
          
          public function set isCureToggled(param1:Boolean) : void
          {
               this._isCureToggled = param1;
          }
          
          public function get isHealToggled() : Boolean
          {
               return this._isHealToggled;
          }
          
          public function set isHealToggled(param1:Boolean) : void
          {
               this._isHealToggled = param1;
          }
          
          public function get healAmount() : Number
          {
               return this._healAmount;
          }
          
          public function set healAmount(param1:Number) : void
          {
               this._healAmount = param1;
          }
          
          public function get healDuration() : Number
          {
               return this._healDuration;
          }
          
          public function set healDuration(param1:Number) : void
          {
               this._healDuration = param1;
          }
     }
}
