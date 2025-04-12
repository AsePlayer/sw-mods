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
          
          private var clusterLad:com.brockw.stickwar.engine.units.Knight;
          
          public var knightType:String;
          
          private var setupComplete:Boolean;
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
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
               var _loc5_:MovieClip = _knight(param1).mc;
               if(_loc5_.knighthelm)
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
               maxHealth = health = param1.xml.xml.Chaos.Units.knight.health;
               this.chargeStunArea = param1.xml.xml.Chaos.Units.knight.charge.stunArea;
               this.stunDamage = param1.xml.xml.Chaos.Units.knight.charge.damage;
               this.stunEffect = param1.xml.xml.Chaos.Units.knight.charge.stun;
               this.chargeVelocity = param1.xml.xml.Chaos.Units.knight.charge.velocity;
               this.maxTargetsToHit = param1.xml.xml.Chaos.Units.giant.maxTargetsToHit + 2;
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
               if(!team.tech.isResearched(Tech.KNIGHT_CHARGE))
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
          
          private function knightHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(this.targetsHit < this.maxTargetsToHit && param1.team != this.team)
               {
                    if(param1.px * mc.scaleX > px * mc.scaleX)
                    {
                         if(param1 is Wall || param1 is Statue)
                         {
                              ++this.targetsHit;
                              param1.damage(0,this.damageToDeal,this);
                              param1.stun(this.stunEffect);
                              this.heal(10,1);
                              this.cure();
                         }
                         else if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(5 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                         {
                              ++this.targetsHit;
                              param1.stun(this.stunEffect);
                              param1.damage(0,this.damageToDeal,this);
                              param1.damage(0,this.damageToDeal,this);
                              param1.poison(60);
                         }
                    }
               }
          }
          
          override public function update(param1:StickWar) : void
          {
               this.chargeSpell.update();
               updateCommon(param1);
               if(this.knightType == "BuffKnight" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Predator Axe","Skull Helmet","Skull Shield");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.heal(2,1);
                    this.setupComplete = true;
               }
               if(this.knightType == "Mega_2" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Silver Axe","Silver Helmet","Silver Shield");
                    maxHealth = 850;
                    health = 850;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 19;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.knightType == "Mega_3" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Fireman Axe","Fireman","Fireman Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 6;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.knightType == "Mega_4" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Gas Mask","Thor Shield");
                    maxHealth = 3850;
                    health = 3850;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 4;
                    _scale = 1.4;
                    this.setupComplete = true;
               }
               if(this.knightType == "Mega_5" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Axe","Football Helmet","Pig Shield");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 4.5;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.knightType == "Mega_6" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Viking Axe","Shard Helmet","Solid Shield");
                    maxHealth = 5000;
                    health = 5000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 4.5;
                    _scale = 1.2;
                    this.setupComplete = true;
               }
               if(this.knightType == "LavaKnight" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Lava Axe","Lava Jug Helmet","Lava Jug Shield");
                    maxHealth = 12000;
                    health = 12000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.setupComplete = true;
               }
               if(this.knightType == "BuffKnight")
               {
                    if(!hasHit && _mc.mc.currentFrame == 23)
                    {
                         this.heal(30,1);
                         this.cure();
                    }
                    stunTimeLeft = 0;
               }
               if(isCustomUnit == true)
               {
                    if(this.knightType == "LavaKnight")
                    {
                         _maxVelocity = 3.2;
                    }
                    else
                    {
                         _maxVelocity = this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity;
                    }
               }
               if(this.knightType == "Mega_4")
               {
                    stunTimeLeft = 0;
               }
               if(this.knightType == "LavaKnight")
               {
                    stunTimeLeft = 0;
               }
               if(this.knightType == "Mega_6")
               {
                    stunTimeLeft = 0;
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
                         if(this.knightType == "BuffKnight")
                         {
                              if(this.targetsHit < this.maxTargetsToHit && !hasHit)
                              {
                                   if(_mc.mc.currentFrame == 23)
                                   {
                                        team.game.spatialHash.mapInArea(px - 300,py - 300,px + 25,py + 25,this.knightHit);
                                   }
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
                    if(this.knightType == "BuffSpear")
                    {
                         team.game.projectileManager.initNuke(px,py,this,0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Mega_2";
                         this.clusterLad.stun(45);
                    }
                    if(this.knightType == "BuffSpear")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Mega_3";
                         this.clusterLad.stun(45);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Mega_3";
                         this.clusterLad.stun(45);
                    }
                    if(this.knightType == "Mega_3")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Mega_5";
                         this.clusterLad.stun(45);
                    }
                    if(this.knightType == "Mega_5")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Mega_6";
                         this.clusterLad.stun(45);
                    }
                    if(this.knightType == "Mega_6")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Mega_4";
                         this.clusterLad.stun(45);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "LavaKnight";
                         this.clusterLad.stun(45);
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
               if(this.knightType == "BuffKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Predator Axe","Skull Helmet","Skull Shield");
               }
               else if(this.knightType == "Mega_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Silver Axe","Silver Helmet","Silver Shield");
               }
               else if(this.knightType == "Mega_3")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Fireman Axe","Fireman","Fireman Shield");
               }
               else if(this.knightType == "Mega_4")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Gas Mask","Thor Shield");
               }
               else if(this.knightType == "Mega_5")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Axe","Football Helmet","Pig Shield");
               }
               else if(this.knightType == "Mega_6")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Viking Axe","Shard Helmet","Solid Shield");
               }
               else if(this.knightType == "LavaKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Lava Axe","Lava Jug Helmet","Lava Jug Shield");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_knight(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.knightType == "BuffKnight")
               {
                    return 60;
               }
               if(this.knightType == "Mega_4")
               {
                    return 40;
               }
               if(this.knightType == "LavaKnight")
               {
                    return 70;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.knightType == "BuffKnight")
               {
                    return 110;
               }
               if(this.knightType == "Mega_4")
               {
                    return 40;
               }
               if(this.knightType == "LavaKnight")
               {
                    return 70;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(team.tech.isResearched(Tech.KNIGHT_CHARGE))
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
