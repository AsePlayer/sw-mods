package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.MagikillAi;
     import com.brockw.stickwar.engine.Ai.command.HoldCommand;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     
     public class Magikill extends Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var stunSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var nukeSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var poisonDartSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var isStunning:Boolean;
          
          private var isNuking:Boolean;
          
          public var magikillType:String;
          
          private var setupComplete:Boolean;
          
          private var isPoisonDarting:Boolean;
          
          private var spellX:Number;
          
          private var Minion:com.brockw.stickwar.engine.units.Swordwrath;
          
          private var Lava:com.brockw.stickwar.engine.units.Spearton;
          
          private var Vamp:com.brockw.stickwar.engine.units.Spearton;
          
          private var spellY:Number;
          
          private var explosionDamage:Number;
          
          public function Magikill(param1:StickWar)
          {
               super(param1);
               _mc = new _magikill();
               this.init(param1);
               addChild(_mc);
               ai = new MagikillAi(this);
               initSync();
               firstInit();
               healthBar.y = -pheight * 1;
               this.magikillType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_magikill = _magikill(param1);
               if(_loc5_.mc.wizhat)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.wizhat.gotoAndStop(param3);
                    }
               }
               if(_loc5_.mc.wizstaff)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.wizstaff.gotoAndStop(param2);
                    }
               }
               if(_loc5_.mc.wizbeard)
               {
                    if(param4 != "")
                    {
                         _loc5_.mc.wizbeard.gotoAndStop(param4);
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return WEAPON_REACH;
          }
          
          override public function playDeathSound() : void
          {
               team.game.soundManager.playSound("MagikillDeath",px,py);
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               WEAPON_REACH = param1.xml.xml.Order.Units.magikill.weaponReach;
               population = param1.xml.xml.Order.Units.magikill.population;
               _mass = param1.xml.xml.Order.Units.magikill.mass;
               _maxForce = param1.xml.xml.Order.Units.magikill.maxForce;
               _dragForce = param1.xml.xml.Order.Units.magikill.dragForce;
               _scale = param1.xml.xml.Order.Units.magikill.scale;
               _maxVelocity = param1.xml.xml.Order.Units.magikill.maxVelocity;
               this.explosionDamage = param1.xml.xml.Order.Units.magikill.nuke.damage;
               this.createTime = param1.xml.xml.Order.Units.magikill.cooldown;
               maxHealth = health = param1.xml.xml.Order.Units.magikill.health;
               loadDamage(param1.xml.xml.Order.Units.magikill);
               type = Unit.U_MAGIKILL;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.stunSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.electricWall.effect,param1.xml.xml.Order.Units.magikill.electricWall.cooldown,param1.xml.xml.Order.Units.magikill.electricWall.mana);
               this.nukeSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.nuke.effect,param1.xml.xml.Order.Units.magikill.nuke.cooldown,param1.xml.xml.Order.Units.magikill.nuke.mana);
               this.poisonDartSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.poisonSpray.effect,param1.xml.xml.Order.Units.magikill.poisonSpray.cooldown,param1.xml.xml.Order.Units.magikill.poisonSpray.mana);
               this.isNuking = false;
               this.isStunning = false;
               this.isPoisonDarting = false;
          }
          
          override public function setBuilding() : void
          {
               if(this.team.type == Team.T_GOOD)
               {
                    building = team.buildings["MagicGuildBuilding"];
               }
               else
               {
                    building = team.buildings["MedusaBuilding"];
               }
          }
          
          override public function getDamageToDeal() : Number
          {
               return damageToDeal;
          }
          
          override public function update(param1:StickWar) : void
          {
               this.stunSpellCooldown.update();
               this.nukeSpellCooldown.update();
               this.poisonDartSpellCooldown.update();
               updateCommon(param1);
               if(this.magikillType == "Speeder" && !this.setupComplete)
               {
                    Magikill.setItem(_mc,"Metal Staff","Belt Hat","Grey Beard");
                    this.healthBar.visible = false;
                    isStationary = true;
                    flyingHeight = 500;
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 3.5;
                    this.ai.setCommand(team.game,new HoldCommand(team.game));
                    this.stunSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.electricWall.effect,10 * 30,0);
                    this.nukeSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.nuke.effect,10 * 30,0);
                    this.poisonDartSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.poisonSpray.effect,10 * 30,0);
                    this.setupComplete = true;
               }
               if(this.magikillType == "CastleMage" && !this.setupComplete)
               {
                    Magikill.setItem(_mc,"Default","Default","Default");
                    this.healthBar.visible = false;
                    isStationary = true;
                    flyingHeight = 500;
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 3.5;
                    this.ai.setCommand(team.game,new HoldCommand(team.game));
                    this.stunSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.electricWall.effect,10 * 30,0);
                    this.nukeSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.nuke.effect,10 * 30,0);
                    this.poisonDartSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.poisonSpray.effect,10 * 30,0);
                    this.setupComplete = true;
               }
               if(this.magikillType != "")
               {
                    isCustomUnit = true;
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
                    else if(this.isNuking == true)
                    {
                         _mc.gotoAndStop("attack_1");
                         if(MovieClip(_mc.mc).currentFrame == 36 && !hasHit)
                         {
                              param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                              this.heal(1,2);
                              param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage);
                              hasHit = true;
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isNuking = false;
                              _state = S_RUN;
                         }
                    }
                    else if(this.isStunning == true)
                    {
                         _mc.gotoAndStop("electricAttack");
                         if(MovieClip(_mc.mc).currentFrame == 47 && !hasHit)
                         {
                              hasHit = true;
                              param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                              param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isStunning = false;
                              _state = S_RUN;
                         }
                    }
                    else if(this.isPoisonDarting == true)
                    {
                         _mc.gotoAndStop("poisonAttack");
                         if(MovieClip(_mc.mc).currentFrame == 44 && !hasHit)
                         {
                              this.cure();
                              param1.soundManager.playSound("AcidSpraySound",px,py);
                              param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this);
                              hasHit = true;
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isPoisonDarting = false;
                              _state = S_RUN;
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
                         if(!hasHit)
                         {
                              hasHit = this.checkForHit();
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
               Util.animateMovieClip(_mc,0);
               if(mc.mc.wizhat != null)
               {
                    mc.mc.wizhat.gotoAndStop(1);
               }
               if(mc.mc.wizstaff != null)
               {
                    mc.mc.wizstaff.gotoAndStop(1);
                    if(mc.mc.wizstaff.fireloopwizstaff != null)
                    {
                         mc.mc.wizstaff.fireloopwizstaff.nextFrame();
                         if(mc.mc.wizstaff.fireloopwizstaff.currentFrame == mc.mc.wizstaff.fireloopwizstaff.totalFrames)
                         {
                              mc.mc.wizstaff.fireloopwizstaff.gotoAndStop(1);
                         }
                    }
               }
               if(this.magikillType == "Speeder")
               {
                    Magikill.setItem(_mc,"Default","Summon Hat","Grey Beard");
               }
               else if(this.magikillType == "CastleMage")
               {
                    Magikill.setItem(_mc,"Default","Default","Default");
               }
               else
               {
                    Magikill.setItem(_mc,"Default","Default","Grey Beard");
               }
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               param1.setAction(0,0,UnitCommand.NUKE);
               if(team.tech.isResearched(Tech.MAGIKILL_POISON || this.magikillType == "CastleMage"))
               {
                    param1.setAction(1,0,UnitCommand.POISON_DART);
               }
               if(team.tech.isResearched(Tech.MAGIKILL_WALL || this.magikillType == "CastleMage"))
               {
                    param1.setAction(2,0,UnitCommand.STUN);
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
               }
          }
          
          override public function isBusy() : Boolean
          {
               return !this.notInSpell() || isBusyForSpell;
          }
          
          private function notInSpell() : Boolean
          {
               return !this.isPoisonDarting && !this.isStunning && !this.isNuking;
          }
          
          public function poisonDartSpell(param1:Number, param2:Number) : void
          {
               if(!team.tech.isResearched(Tech.MAGIKILL_POISON))
               {
                    return;
               }
               if(this.notInSpell() && this.poisonDartSpellCooldown.spellActivate(this.team))
               {
                    this.spellX = param1;
                    this.spellY = param2;
                    forceFaceDirection(this.spellX - this.px);
                    this.isPoisonDarting = true;
                    hasHit = false;
                    _state = S_ATTACK;
                    team.game.soundManager.playSound("wizardPoisonSound",px,py);
               }
          }
          
          public function nukeSpell(param1:Number, param2:Number) : void
          {
               if(this.notInSpell() && this.nukeSpellCooldown.spellActivate(this.team))
               {
                    this.spellX = param1;
                    forceFaceDirection(this.spellX - this.px);
                    this.spellY = param2;
                    this.isNuking = true;
                    hasHit = false;
                    _state = S_ATTACK;
                    _mc.gotoAndStop("attack_1");
                    MovieClip(_mc.mc).gotoAndStop(1);
                    team.game.soundManager.playSound("fulminateSound",px,py);
               }
          }
          
          public function stunSpell(param1:Number, param2:Number) : void
          {
               if(!team.tech.isResearched(Tech.MAGIKILL_WALL))
               {
                    return;
               }
               if(this.notInSpell() && this.stunSpellCooldown.spellActivate(this.team))
               {
                    this.spellX = param1;
                    forceFaceDirection(this.spellX - this.px);
                    this.spellY = param2;
                    this.isStunning = true;
                    hasHit = false;
                    _state = S_ATTACK;
                    team.game.soundManager.playSound("electricWallSound",px,py);
               }
          }
          
          public function stunCooldown() : Number
          {
               return this.stunSpellCooldown.cooldown();
          }
          
          public function nukeCooldown() : Number
          {
               return this.nukeSpellCooldown.cooldown();
          }
          
          public function poisonDartCooldown() : Number
          {
               return this.poisonDartSpellCooldown.cooldown();
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
                    if(Math.abs(px - param1.px) < WEAPON_REACH && Math.abs(py - param1.py) < 40 && this.getDirection() == Util.sgn(param1.px - px))
                    {
                         return true;
                    }
               }
               return false;
          }
          
          override public function stateFixForCutToWalk() : void
          {
               if(!this.isStunning && !this.isNuking && !this.isPoisonDarting)
               {
                    super.stateFixForCutToWalk();
                    this.isStunning = false;
                    this.isNuking = false;
                    this.isPoisonDarting = false;
               }
          }
     }
}
