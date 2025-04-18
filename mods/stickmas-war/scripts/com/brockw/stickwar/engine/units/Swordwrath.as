package com.brockw.stickwar.engine.units
{
     import com.brockw.game.*;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.*;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.*;
     import com.brockw.stickwar.market.*;
     import flash.display.*;
     import flash.filters.*;
     
     public class Swordwrath extends Unit
     {
          
          private static var WEAPON_REACH:int;
          
          private static var RAGE_COOLDOWN:int;
          
          private static var RAGE_EFFECT:int;
           
          
          private var healthLoss:int;
          
          private var damageIncrease:Number;
          
          private var rageSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var rageSpellGlow:GlowFilter;
          
          private var rageSpellGlow2:GlowFilter;
          
          private var normalMaxVelocity:Number;
          
          private var rageMaxVelocity:Number;
          
          private var lastWasStanding:Boolean;
          
          public function Swordwrath(param1:StickWar)
          {
               super(param1);
               _mc = new _swordwrath();
               this.init(param1);
               addChild(_mc);
               ai = new SwordwrathAi(this);
               initSync();
               firstInit();
               this.rageSpellGlow = new GlowFilter();
               this.rageSpellGlow2 = new GlowFilter();
               this.rageSpellGlow.color = 16711680;
               this.rageSpellGlow.blurX = 10;
               this.rageSpellGlow.blurY = 10;
               this.rageSpellGlow2.color = 65280;
               this.rageSpellGlow2.blurX = 10;
               this.rageSpellGlow2.blurY = 10;
               this.lastWasStanding = false;
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_swordwrath;
               if((_loc5_ = _swordwrath(param1)).mc.sword)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.sword.gotoAndStop(param2);
                    }
               }
               if(_loc5_.mc.head)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.head.gotoAndStop(param3);
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
               WEAPON_REACH = param1.xml.xml.Order.Units.swordwrath.weaponReach;
               population = param1.xml.xml.Order.Units.swordwrath.population;
               RAGE_COOLDOWN = param1.xml.xml.Order.Units.swordwrath.rage.cooldown;
               RAGE_EFFECT = param1.xml.xml.Order.Units.swordwrath.rage.effect;
               this.healthLoss = param1.xml.xml.Order.Units.swordwrath.rage.healthLoss;
               this.damageIncrease = param1.xml.xml.Order.Units.swordwrath.rage.damageIncrease;
               _mass = param1.xml.xml.Order.Units.swordwrath.mass;
               _maxForce = param1.xml.xml.Order.Units.swordwrath.maxForce;
               _dragForce = param1.xml.xml.Order.Units.swordwrath.dragForce;
               _scale = param1.xml.xml.Order.Units.swordwrath.scale;
               _maxVelocity = param1.xml.xml.Order.Units.swordwrath.maxVelocity;
               damageToDeal = param1.xml.xml.Order.Units.swordwrath.baseDamage;
               this.createTime = param1.xml.xml.Order.Units.swordwrath.cooldown;
               maxHealth = health = param1.xml.xml.Order.Units.swordwrath.health;
               loadDamage(param1.xml.xml.Order.Units.swordwrath);
               type = Unit.U_SWORDWRATH;
               this.normalMaxVelocity = _maxVelocity;
               this.rageMaxVelocity = param1.xml.xml.Order.Units.swordwrath.rage.rageMaxVelocity;
               this.rageSpell = new com.brockw.stickwar.engine.units.SpellCooldown(RAGE_EFFECT,RAGE_COOLDOWN,param1.xml.xml.Order.Units.swordwrath.rage.mana);
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
          
          override public function getDamageToDeal() : Number
          {
               if(this.rageSpell.inEffect())
               {
                    return 2 * damageToDeal;
               }
               return damageToDeal;
          }
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:String = null;
               this.rageSpell.update();
               updateCommon(param1);
               if(this.rageSpell.inEffect())
               {
                    this.rageSpellGlow.blurX = 9 + 6 * Util.sin(20 * Math.PI * this.rageSpell.timeRunning() / RAGE_EFFECT);
                    this.rageSpellGlow.blurY = 10;
                    this.rageSpellGlow2.blurX = 9 + 6 * Util.sin(10 * Math.PI * this.rageSpell.timeRunning() / RAGE_EFFECT);
                    this.rageSpellGlow2.blurY = 10;
                    this.mc.filters = [this.rageSpellGlow,this.rageSpellGlow2];
                    _maxVelocity = this.rageMaxVelocity;
               }
               else
               {
                    this.mc.filters = [];
                    _maxVelocity = this.normalMaxVelocity;
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
                              _loc2_ = _mc.currentFrameLabel;
                              if(!(_loc2_ == "stand" || _loc2_ == "stand_breath"))
                              {
                                   if(param1.random.nextNumber() < 0.1)
                                   {
                                        _mc.gotoAndStop("stand");
                                   }
                                   else
                                   {
                                        _mc.gotoAndStop("stand_breath");
                                   }
                              }
                         }
                    }
                    else if(_state == S_ATTACK)
                    {
                         if(mc.mc.swing != null)
                         {
                              team.game.soundManager.playSound("swordwrathSwing1",px,py);
                         }
                         if(!hasHit)
                         {
                              hasHit = this.checkForHit();
                         }
                         if(this.rageSpell.inEffect())
                         {
                              MovieClip(_mc.mc).nextFrame();
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
                         _mc.gotoAndStop(this.getDeathLabel(param1));
                         this.team.removeUnit(this,param1);
                         isDead = true;
                    }
               }
               if(isDead || _isDualing)
               {
                    Util.animateMovieClip(_mc,0);
               }
               else
               {
                    if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                    {
                         MovieClip(_mc.mc).gotoAndStop(1);
                    }
                    MovieClip(_mc.mc).nextFrame();
               }
               Swordwrath.setItem(_swordwrath(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),"","");
          }
          
          override protected function getDeathLabel(param1:StickWar) : String
          {
               if(arrowDeath)
               {
                    return "arrow_death";
               }
               if(isOnFire)
               {
                    return "fireDeath";
               }
               if(stoned)
               {
                    return "stone";
               }
               var _loc2_:int = team.game.random.nextInt() % this._deathLabels.length;
               return "death_" + this._deathLabels[_loc2_];
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.rageSpell.inEffect())
               {
                    return _damageToArmour + this.damageIncrease;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.rageSpell.inEffect())
               {
                    return _damageToNotArmour + this.damageIncrease;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(techTeam.tech.isResearched(Tech.SWORDWRATH_RAGE))
               {
                    param1.setAction(0,0,UnitCommand.SWORDWRATH_RAGE);
               }
          }
          
          public function rageCooldown() : Number
          {
               return this.rageSpell.cooldown();
          }
          
          public function rage() : void
          {
               if(health > 10 && techTeam.tech.isResearched(Tech.SWORDWRATH_RAGE))
               {
                    if(this.rageSpell.spellActivate(team))
                    {
                         health -= this.healthLoss;
                         heal(this.healthLoss,4);
                         team.game.soundManager.playSoundRandom("Rage",3,px,py);
                         this.attackStartFrame = 0;
                    }
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
                    if(this.rageSpell.inEffect())
                    {
                         framesInAttack = MovieClip(_mc.mc).totalFrames / 2;
                    }
                    else
                    {
                         framesInAttack = MovieClip(_mc.mc).totalFrames;
                    }
               }
          }
          
          override public function mayAttack(param1:Unit) : Boolean
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
     }
}
