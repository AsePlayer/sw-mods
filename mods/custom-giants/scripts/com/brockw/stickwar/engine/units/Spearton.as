package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.SpeartonAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     
     public class Spearton extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
          
          private static var RAGE_COOLDOWN:int;
          
          private static var RAGE_EFFECT:int;
           
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var shieldBashSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var isShieldBashing:Boolean;
          
          private var stunForce:Number;
          
          private var stunTime:int;
          
          private var stunned:com.brockw.stickwar.engine.units.Unit;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Spearton;
          
          public var speartonType:String;
          
          private var isReflective:Boolean;
          
          private var setupComplete:Boolean;
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
          public function Spearton(param1:StickWar)
          {
               super(param1);
               _mc = new _speartonMc();
               this.init(param1);
               addChild(_mc);
               ai = new SpeartonAi(this);
               initSync();
               firstInit();
               this.speartonType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_speartonMc = _speartonMc(param1);
               if(_loc5_.mc.helm)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.helm.gotoAndStop(param3);
                    }
               }
               if(_loc5_.mc.spear)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.spear.gotoAndStop(param2);
                    }
               }
               if(_loc5_.mc.shield)
               {
                    if(param4 != "")
                    {
                         _loc5_.mc.shield.gotoAndStop(param4);
                    }
               }
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               this.inBlock = false;
               this.isBlocking = false;
               WEAPON_REACH = param1.xml.xml.Order.Units.spearton.weaponReach;
               this.stunTime = param1.xml.xml.Order.Units.spearton.shieldBash.stunTime;
               this.stunForce = param1.xml.xml.Order.Units.spearton.shieldBash.stunForce;
               population = param1.xml.xml.Order.Units.spearton.population;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               _mass = param1.xml.xml.Order.Units.spearton.mass;
               _maxForce = param1.xml.xml.Order.Units.spearton.maxForce;
               _dragForce = param1.xml.xml.Order.Units.spearton.dragForce;
               _scale = param1.xml.xml.Order.Units.spearton.scale;
               _maxVelocity = param1.xml.xml.Order.Units.spearton.maxVelocity;
               damageToDeal = param1.xml.xml.Order.Units.spearton.baseDamage;
               this.createTime = param1.xml.xml.Order.Units.spearton.cooldown;
               maxHealth = health = param1.xml.xml.Order.Units.spearton.health;
               this.maxTargetsToHit = param1.xml.xml.Chaos.Units.giant.maxTargetsToHit;
               type = com.brockw.stickwar.engine.units.Unit.U_SPEARTON;
               loadDamage(param1.xml.xml.Order.Units.spearton);
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               this.isShieldBashing = false;
               this.shieldBashSpell = new com.brockw.stickwar.engine.units.SpellCooldown(0,param1.xml.xml.Order.Units.spearton.shieldBash.cooldown,param1.xml.xml.Order.Units.spearton.shieldBash.mana);
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
          }
          
          override public function weaponReach() : Number
          {
               return WEAPON_REACH;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["BarracksBuilding"];
          }
          
          override public function getDamageToDeal() : Number
          {
               return this.damageToDeal;
          }
          
          private function speartonHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(this.targetsHit < this.maxTargetsToHit && param1.team != this.team)
               {
                    if(param1.px * mc.scaleX > px * mc.scaleX)
                    {
                         if(param1 is Wall || param1 is Statue)
                         {
                              ++this.targetsHit;
                              param1.damage(0,this.damageToDeal,this);
                              param1.stun(this.stunTime);
                              this.heal(5,1);
                              this.cure();
                         }
                         else if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(5 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                         {
                              ++this.targetsHit;
                              param1.stun(this.stunTime);
                              param1.damage(0,this.damageToDeal,this);
                              param1.poison(6);
                              this.heal(5,1);
                              this.cure();
                         }
                    }
               }
          }
          
          public function shieldBash() : void
          {
               if(this.shieldBashSpell.spellActivate(team) && this._isBlocking)
               {
                    this.isShieldBashing = true;
               }
          }
          
          public function shieldBashCooldown() : Number
          {
               return this.shieldBashSpell.cooldown();
          }
          
          override public function update(param1:StickWar) : void
          {
               this.customSpeartonSetUp(param1);
               if(this.speartonType != "")
               {
                    isCustomUnit = true;
               }
               var _loc3_:Boolean = false;
               this.shieldBashSpell.update();
               updateCommon(param1);
               if(!isDieing)
               {
                    updateMotion(param1);
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.attackLabel);
                         moveDualPartner(_dualPartner,_currentDual.xDiff);
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              _isDualing = false;
                              _state = S_RUN;
                              px += Util.sgn(mc.scaleX) * team.game.getPerspectiveScale(py) * _currentDual.finalXOffset;
                              x = px;
                              dx = 0;
                              dy = 0;
                         }
                    }
                    else if(this.isShieldBashing)
                    {
                         if(MovieClip(mc.mc).currentFrameLabel == "swing")
                         {
                              team.game.soundManager.playSound("swordwrathSwing1",px,py);
                         }
                         _mc.gotoAndStop("shieldBash");
                         _mc.mc.nextFrame();
                         if(_mc.mc.currentFrame == 12)
                         {
                              _loc3_ = this.checkForBlockHit();
                         }
                         if(_mc.mc.currentFrame == _mc.mc.totalFrames)
                         {
                              this.isShieldBashing = false;
                         }
                    }
                    else if(this.inBlock)
                    {
                         if(_mc.currentLabel == "shieldBash")
                         {
                              _mc.gotoAndStop("block");
                              _mc.mc.gotoAndStop(15);
                         }
                         else
                         {
                              _mc.gotoAndStop("block");
                         }
                         if(this.isBlocking)
                         {
                              if(_mc.mc.currentFrame < 15)
                              {
                                   _mc.mc.nextFrame();
                              }
                         }
                         else
                         {
                              _mc.mc.nextFrame();
                              if(_mc.mc.currentFrame == _mc.mc.totalFrames)
                              {
                                   this.inBlock = false;
                              }
                         }
                    }
                    else if(_state == S_RUN)
                    {
                         if(isFeetMoving())
                         {
                              if(this.speartonType == "Vamp")
                              {
                                   this.heal(1,1);
                                   this.cure();
                              }
                              _mc.gotoAndStop("run");
                         }
                         else
                         {
                              if(this.speartonType == "Vamp")
                              {
                                   this.heal(1,1);
                                   this.cure();
                              }
                              _mc.gotoAndStop("stand");
                         }
                    }
                    else if(_state == S_ATTACK)
                    {
                         if(MovieClip(mc.mc).currentFrameLabel == "swing")
                         {
                              team.game.soundManager.playSound("swordwrathSwing1",px,py);
                         }
                         if(this.speartonType == "BuffSpear")
                         {
                              if(this.targetsHit < this.maxTargetsToHit && !hasHit && _mc.mc.currentFrame == 12)
                              {
                                   team.game.spatialHash.mapInArea(px - 300,py - 300,px + 25,py + 25,this.speartonHit);
                              }
                         }
                         MovieClip(_mc.mc).nextFrame();
                         if(!hasHit)
                         {
                              hasHit = this.checkForHit();
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
                    }
               }
               else if(isDead == false)
               {
                    if(this.speartonType == "Ultra")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Super";
                         this.clusterLad.stun(45);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Undead";
                         this.clusterLad.stun(45);
                    }
                    if(this.speartonType == "Dark")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Light";
                         this.clusterLad.stun(45);
                    }
                    if(this.speartonType == "Undead")
                    {
                         team.game.projectileManager.initPoisonPool(this.px,this.py,this,0);
                    }
                    if(this.speartonType == "Light")
                    {
                         team.game.projectileManager.initStun(px,py,30,this);
                    }
                    isDead = true;
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.defendLabel);
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              isDualing = false;
                              mc.filters = [];
                         }
                    }
                    else
                    {
                         _mc.gotoAndStop(getDeathLabel(param1));
                    }
                    this.team.removeUnit(this,param1);
               }
               if(!isDead && MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
               {
                    MovieClip(_mc.mc).gotoAndStop(1);
               }
               if(_isDualing || !this.inBlock || isDead)
               {
                    Util.animateMovieClip(_mc);
               }
               this.skinSetUp(param1);
          }
          
          private function shieldHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(this.stunned == null && param1.team != this.team && param1.pz == 0)
               {
                    if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(5 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                    {
                         this.stunned = param1;
                         param1.damage(0,this.damageToDeal,this);
                         param1.stun(this.stunTime);
                         param1.applyVelocity(this.stunForce * Util.sgn(mc.scaleX));
                    }
               }
          }
          
          protected function checkForBlockHit() : Boolean
          {
               this.stunned = null;
               team.game.spatialHash.mapInArea(px,py,px + 30,py + 30,this.shieldHit);
               return true;
          }
          
          public function stopBlocking() : void
          {
               this.isBlocking = false;
          }
          
          public function startBlocking() : void
          {
               if(team.tech.isResearched(Tech.BLOCK) || this.speartonType == "BuffSpear")
               {
                    if(this.speartonType == "BuffSpear")
                    {
                         this.heal(1,1);
                    }
                    this.isBlocking = true;
                    this.inBlock = true;
                    team.game.soundManager.playSound("speartonHoghSound",px,py);
               }
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(team.tech.isResearched(Tech.BLOCK) || this.speartonType == "BuffSpear")
               {
                    param1.setAction(0,0,UnitCommand.SPEARTON_BLOCK);
               }
               if(team.tech.isResearched(Tech.SHIELD_BASH) || this.speartonType == "BuffSpear")
               {
                    param1.setAction(1,0,UnitCommand.SHIELD_BASH);
               }
          }
          
          public function skinSetUp(param1:StickWar) : void
          {
               if(this.speartonType == "BuffSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
               }
               else if(this.speartonType == "Master")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Hockey Stick","Red Goalie","Goal Pads Shield");
               }
               else if(this.speartonType == "HeavySpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Silver Helmet One","Dark Shield");
               }
               else if(this.speartonType == "Ultra")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","British Helmet","British Shield");
               }
               else if(this.speartonType == "Speedy")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Diamond","Default","Default");
               }
               else if(this.speartonType == "Super")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","HedgeHog Helmet","Spider Shield");
               }
               else if(this.speartonType == "Mega")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Gold Helmet","Medieval Shield");
               }
               else if(this.speartonType == "Giga")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Pitchfork","Samurai","Goat Shield");
               }
               else if(this.speartonType == "Dark")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Samurai Spear","Samurai Mask","Dark Wood Shield");
               }
               else if(this.speartonType == "Light")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Samurai","Gold Wood Shield");
               }
               else if(this.speartonType == "Vamp")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Vamp Spear","Vamp Helmet","Vamp Shield");
               }
               else if(this.speartonType == "Lava")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Lava Helmet","Lava Shield");
               }
               else if(this.speartonType == "Undead")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Dead Helmet","Dead Shield");
               }
               else if(this.speartonType == "Stone")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Stone Spear","Stone Helmet","Stone Shield");
               }
               else if(this.speartonType == "Leaf")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear","Leaf Helmet","Leaf Shield");
               }
               else if(this.speartonType == "Ice")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear","Ice Helmet","Ice Shield");
               }
               else if(this.speartonType == "Ice_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Ice Helmet 2","Ice Shield 2");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_speartonMc(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
          }
          
          public function customSpeartonSetUp(param1:StickWar) : void
          {
               if(this.speartonType == "BuffSpear" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Gold Helmet","Medieval Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.6;
                    this.heal(5,1);
                    this.setupComplete = true;
               }
               if(this.speartonType == "BuffSpear" || this.speartonType == "Lava" || this.speartonType == "Leaf" || this.speartonType == "Stone" || this.speartonType == "Ultra" || this.speartonType == "Super" || this.speartonType == "HeavySpear" || this.speartonType == "Giga")
               {
                    stunTimeLeft = 0;
               }
               if(this.speartonType == "Vamp" && !hasHit)
               {
                    isVampUnit = true;
               }
               if(this.speartonType == "Mega" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
                    maxHealth = 1550;
                    health = 1550;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 13;
                    this.heal(5,1);
                    this.setupComplete = true;
               }
               if(this.speartonType == "HeavySpear" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Silver Helmet One","Dark Shield");
                    maxHealth = 750;
                    health = 750;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    population = 10;
                    _maxVelocity = 6.1;
                    this.heal(5,1);
                    this.setupComplete = true;
               }
               if(this.speartonType == "Ultra" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","British Helmet","British Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    population = 10;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Speedy" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Diamond","Default","Default");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    population = 10;
                    _maxVelocity = 15.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Master" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Hockey Stick","Red Goalie","Goal Pads Shield");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    population = 10;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Super" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","HedgeHog Helmet","Spider Shield");
                    maxHealth = 3800;
                    health = 3800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    population = 10;
                    _maxVelocity = 4;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Giga" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","Marine Helmet","Goat Shield");
                    maxHealth = 15000;
                    health = 15000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.3;
                    population = 50;
                    _maxVelocity = 7.5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Dark" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Samurai Spear","Samurai Mask","Dark Wood Shield");
                    maxHealth = 1400;
                    health = 1400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    population = 20;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Light" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Samurai","Gold Wood Shield");
                    maxHealth = 1400;
                    health = 1400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    population = 20;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Vamp" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Vamp Spear","Vamp Helmet","Vamp Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Lava")
               {
                    this.isReflective = true;
                    if(!this.setupComplete)
                    {
                         com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Lava Helmet","Lava Shield");
                         maxHealth = 15875;
                         health = 15875;
                         maxHealth = maxHealth;
                         healthBar.totalHealth = maxHealth;
                         _scale = 1.3;
                         _maxVelocity = 4.2;
                         this.setupComplete = true;
                    }
               }
               if(this.speartonType == "Stone" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Stone Spear","Stone Helmet","Stone Shield");
                    maxHealth = 14800;
                    health = 14800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.7;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Leaf" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear","Leaf Helmet","Leaf Shield");
                    maxHealth = 17450;
                    health = 17450;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.2;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Ice")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear","Ice Helmet","Ice Shield");
                    freezeUnit = true;
                    if(!this.setupComplete)
                    {
                         maxHealth = 800;
                         health = 800;
                         maxHealth = maxHealth;
                         healthBar.totalHealth = maxHealth;
                         _scale = 1;
                         _maxVelocity = 5.8;
                         this.setupComplete = true;
                    }
               }
               if(this.speartonType == "Ice_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Ice Helmet 2","Ice Shield 2");
                    freezeUnit = true;
                    if(!this.setupComplete)
                    {
                         maxHealth = 800;
                         health = 800;
                         maxHealth = maxHealth;
                         healthBar.totalHealth = maxHealth;
                         _scale = 1;
                         _maxVelocity = 5.8;
                         this.setupComplete = true;
                    }
               }
               if(this.speartonType == "Undead")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Dead Helmet","Dead Shield");
                    poisonUnit = true;
                    poisonRegen = true;
                    if(!this.setupComplete)
                    {
                         maxHealth = 350;
                         health = 350;
                         maxHealth = maxHealth;
                         healthBar.totalHealth = maxHealth;
                         _scale = 0.9;
                         _maxVelocity = 4;
                         this.setupComplete = true;
                    }
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.speartonType == "Ultra")
               {
                    return 15;
               }
               if(this.speartonType == "BuffSpear")
               {
                    return 60;
               }
               if(this.speartonType == "Leaf")
               {
                    return 126;
               }
               if(this.speartonType == "Lava")
               {
                    return 200;
               }
               if(this.speartonType == "Stone")
               {
                    return 80;
               }
               if(this.speartonType == "Undead")
               {
                    return 5;
               }
               if(this.speartonType == "Vamp")
               {
                    return 20;
               }
               if(this.speartonType == "Light")
               {
                    return 30;
               }
               if(this.speartonType == "Dark")
               {
                    return 30;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.speartonType == "Ultra")
               {
                    return 25;
               }
               if(this.speartonType == "Super")
               {
                    return 100;
               }
               if(this.speartonType == "Undead")
               {
                    return 5;
               }
               if(this.speartonType == "Speedy")
               {
                    return 31;
               }
               if(this.speartonType == "Leaf")
               {
                    return 126;
               }
               if(this.speartonType == "BuffSpear")
               {
                    return 120;
               }
               if(this.speartonType == "Vamp")
               {
                    return 40;
               }
               if(this.speartonType == "Lava")
               {
                    return 80;
               }
               if(this.speartonType == "Stone")
               {
                    return 180;
               }
               if(this.speartonType == "Light")
               {
                    return 30;
               }
               if(this.speartonType == "Dark")
               {
                    return 30;
               }
               if(this.speartonType == "Giga")
               {
                    return 100;
               }
               return _damageToNotArmour;
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
                    this.targetsHit = 0;
                    attackStartFrame = team.game.frame;
                    framesInAttack = MovieClip(_mc.mc).totalFrames;
               }
          }
          
          override public function damage(param1:int, param2:int, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock)
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
               }
          }
          
          override public function mayAttack(param1:com.brockw.stickwar.engine.units.Unit) : Boolean
          {
               if(framesInAttack > team.game.frame - attackStartFrame)
               {
                    return false;
               }
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
          
          public function get isBlocking() : Boolean
          {
               return this._isBlocking;
          }
          
          public function set isBlocking(param1:Boolean) : void
          {
               this._isBlocking = param1;
          }
          
          public function get inBlock() : Boolean
          {
               return this._inBlock;
          }
          
          public function set inBlock(param1:Boolean) : void
          {
               this._inBlock = param1;
          }
     }
}
