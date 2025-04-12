package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.KnightAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     
     public class Knight extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var chargeVelocity:Number;
          
          private var normalVelocity:Number;
          
          private var chargeSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var isChargeSet:Boolean;
          
          private var chargeForce:Number;
          
          private var normalForce:Number;
          
          private var chargeStunArea:Number;
          
          private var hasCharged:Boolean;
          
          private var stunned:com.brockw.stickwar.engine.units.Unit;
          
          private var stunDamage:Number;
          
          private var stunEffect:Number;
          
          private var stunForce:Number;
          
          public var knightType:String;
          
          private var setupComplete:Boolean;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var explosionDamage:Number;
          
          private var fireDamage:Number;
          
          private var fireFrames:int;
          
          public function Knight(param1:StickWar)
          {
               super(param1);
               _mc = new _knight();
               this.init(param1);
               addChild(_mc);
               ai = new KnightAi(this);
               initSync();
               firstInit();
               this.isChargeSet = false;
               this.chargeForce = 0;
               this.hasCharged = false;
               this.stunned = null;
               this.knightType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:MovieClip = null;
               if((_loc5_ = _knight(param1).mc).knighthelm)
               {
                    if(param3 != "")
                    {
                         _loc5_.knighthelm.gotoAndStop(param3);
                    }
               }
               if(_loc5_.knightweapon)
               {
                    if(param2 != "")
                    {
                         _loc5_.knightweapon.gotoAndStop(param2);
                    }
               }
               if(_loc5_.knightshield)
               {
                    if(param4 != "")
                    {
                         _loc5_.knightshield.gotoAndStop(param4);
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
               WEAPON_REACH = param1.xml.xml.Chaos.Units.knight.weaponReach;
               population = param1.xml.xml.Chaos.Units.knight.population;
               _mass = param1.xml.xml.Chaos.Units.knight.mass;
               _maxForce = this.normalForce = param1.xml.xml.Chaos.Units.knight.maxForce;
               this.chargeForce = param1.xml.xml.Chaos.Units.knight.charge.force;
               this.stunForce = param1.xml.xml.Chaos.Units.knight.charge.stunForce;
               _dragForce = param1.xml.xml.Chaos.Units.knight.dragForce;
               _scale = param1.xml.xml.Chaos.Units.knight.scale;
               _maxVelocity = this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity;
               damageToDeal = param1.xml.xml.Chaos.Units.knight.baseDamage;
               this.createTime = param1.xml.xml.Chaos.Units.knight.cooldown;
               this.radiantDamage = param1.xml.xml.Elemental.Units.lavaElement.radiant.damage;
               this.radiantRange = param1.xml.xml.Elemental.Units.lavaElement.radiant.range;
               this.radiantFrames = param1.xml.xml.Elemental.Units.lavaElement.radiant.frames;
               maxHealth = health = param1.xml.xml.Chaos.Units.knight.health;
               this.chargeStunArea = param1.xml.xml.Chaos.Units.knight.charge.stunArea;
               this.stunDamage = param1.xml.xml.Chaos.Units.knight.charge.damage;
               this.stunEffect = param1.xml.xml.Chaos.Units.knight.charge.stun;
               this.chargeVelocity = param1.xml.xml.Chaos.Units.knight.charge.velocity;
               this.explosionDamage = param1.xml.xml.Order.Units.magikill.nuke.damage;
               this.fireDamage = param1.xml.xml.Order.Units.magikill.nuke.fireDamage;
               this.fireFrames = param1.xml.xml.Order.Units.magikill.nuke.fireFrames;
               loadDamage(param1.xml.xml.Chaos.Units.knight);
               type = com.brockw.stickwar.engine.units.Unit.U_KNIGHT;
               this.chargeSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.knight.charge.effect,param1.xml.xml.Chaos.Units.knight.charge.cooldown,param1.xml.xml.Chaos.Units.knight.charge.mana);
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
               return damageToDeal;
          }
          
          public function getChargeCooldown() : Number
          {
               return this.chargeSpell.cooldown();
          }
          
          public function charge() : void
          {
               if(!techTeam.tech.isResearched(Tech.KNIGHT_CHARGE))
               {
                    return;
               }
               if(this.chargeSpell.spellActivate(team))
               {
                    team.game.soundManager.playSound("deathKnightChargeSound",px,py);
                    this.hasCharged = false;
               }
          }
          
          private function getStunnedUnit(param1:com.brockw.stickwar.engine.units.Unit) : void
          {
               if(this.stunned == null && param1.team != this.team && param1.pz == 0)
               {
                    if(param1.type == com.brockw.stickwar.engine.units.Unit.U_WALL && Math.abs(param1.px - px) < 20)
                    {
                         this.stunned = param1;
                    }
                    else if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(3 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                    {
                         this.stunned = param1;
                    }
               }
          }
          
          private function burnInArea(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team)
               {
                    if(this.knightType == "BullKnight")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(!hasHit && _mc.mc.currentFrame == 1)
                              {
                                   param1.slow(30 * 5);
                              }
                         }
                    }
               }
          }
          
          override public function update(param1:StickWar) : void
          {
               this.chargeSpell.update();
               updateCommon(param1);
               if(this.knightType == "BullKnight" && !this.setupComplete)
               {
                    this.lazyUnit = true;
                    maxHealth = 2500;
                    health = 2500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.4;
                    this.chargeStunArea = 700;
                    this.chargeForce = 700;
                    this.stunDamage = 125;
                    this.normalVelocity = 8;
                    this.setupComplete = true;
               }
               if(this.knightType == "GateKnight" && !this.setupComplete)
               {
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    this.setupComplete = true;
               }
               if(this.knightType == "Ilovefuckingswordwraths" && !this.setupComplete)
               {
                    this.ai.swordTargeter = true;
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    this.setupComplete = true;
               }
               if(this.knightType == "Archeraboooose" && !this.setupComplete)
               {
                    this.ai.archerTargeter = true;
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    this.setupComplete = true;
               }
               if(this.knightType != "")
               {
                    isCustomUnit = true;
               }
               if(mc.mc.sword != null)
               {
                    mc.mc.sword.gotoAndStop(team.loadout.getItem(this.type,MarketItem.T_WEAPON));
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
                    else if(this.chargeSpell.inEffect() && this.hasCharged == false)
                    {
                         if(!this.hasCharged)
                         {
                              this.stunned = null;
                              param1.spatialHash.mapInArea(this.px - this.chargeStunArea,this.py - this.chargeStunArea,this.px + this.chargeStunArea,this.py + this.chargeStunArea,this.getStunnedUnit);
                              if(this.stunned != null)
                              {
                                   this.hasCharged = true;
                                   this.stunned.stun(this.stunEffect);
                                   this.stunned.damage(0,this.stunDamage,null);
                                   this.stunned.applyVelocity(this.stunForce * Util.sgn(mc.scaleX));
                                   if(this.knightType == "BullKnight")
                                   {
                                        param1.projectileManager.initNuke(this.px,this.py,this,125,this.fireDamage,this.fireFrames);
                                        param1.projectileManager.initNuke(this.px - 200,this.py,this,125,this.fireDamage,this.fireFrames);
                                   }
                              }
                         }
                         _mc.gotoAndStop("charge");
                         this._maxVelocity = this.chargeVelocity;
                         this._maxForce = this.chargeForce;
                         this.isChargeSet = true;
                         this.walk(team.direction,0,team.direction);
                         this.isChargeSet = false;
                    }
                    else if(_state == S_RUN)
                    {
                         this._maxVelocity = this.normalVelocity;
                         this._maxForce = this.normalForce;
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
                              if(hasHit)
                              {
                                   param1.soundManager.playSound("sword1",px,py);
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
               if(_mc.mc.dust)
               {
                    Util.animateMovieClipBasic(_mc.mc.dust);
               }
               if(this.knightType == "BullKnight")
               {
                    Knight.setItem(_knight(mc),"Spikey Axe","Knight Helmet","Solid Shield");
               }
               else if(this.knightType == "GateKnight")
               {
                    Knight.setItem(_knight(mc),"Chain Axe","Shard Helmet","Skull Shield");
               }
               else if(this.knightType == "Ilovefuckingswordwraths")
               {
                    Knight.setItem(_knight(mc),"Chain Axe","Shard Helmet","Wooden Shield");
               }
               else if(this.knightType == "Archeraboooose")
               {
                    Knight.setItem(_knight(mc),"Boot Axe","Skull Helmet","Skull Shield");
               }
               else
               {
                    Knight.setItem(_knight(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.knightType == "BullKnight")
               {
                    return 80;
               }
               if(this.knightType == "GateKnight")
               {
                    return 75;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.knightType == "BullKnight")
               {
                    return 100;
               }
               if(this.knightType == "GateKnight")
               {
                    return 50;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(techTeam.tech.isResearched(Tech.KNIGHT_CHARGE))
               {
                    param1.setAction(0,0,UnitCommand.KNIGHT_CHARGE);
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
                    framesInAttack = MovieClip(_mc.mc).totalFrames;
                    attackStartFrame = team.game.frame;
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
          
          override protected function isAbleToWalk() : Boolean
          {
               return this._state == S_RUN && (!this.chargeSpell.inEffect() || this.isChargeSet);
          }
     }
}
