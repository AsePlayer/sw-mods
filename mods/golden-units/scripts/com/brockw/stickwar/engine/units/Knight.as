package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.KnightAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     
     public class Knight extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var convertedUnit:com.brockw.stickwar.engine.units.Unit;
          
          private var currentTarget:com.brockw.stickwar.engine.units.Unit;
          
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
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Knight;
          
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
               this.inBlock = false;
               this.isBlocking = false;
               this.convertedUnit = null;
               this.currentTarget = null;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
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
                         if(this.knightType == "Leader" && param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE && param1.type != com.brockw.stickwar.engine.units.Unit.U_WALL)
                         {
                              this.convertedUnit = param1;
                              team.enemyTeam.switchTeams(param1);
                              _state = S_ATTACK;
                         }
                         else if(this.knightType == "Leader_2" && param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE && param1.type != com.brockw.stickwar.engine.units.Unit.U_WALL)
                         {
                              this.convertedUnit = param1;
                              team.enemyTeam.switchTeams(param1);
                              _state = S_ATTACK;
                         }
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
                         }
                         else if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(5 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                         {
                              ++this.targetsHit;
                              param1.damage(0,this.damageToDeal,this);
                              param1.damage(0,this.damageToDeal,this);
                         }
                    }
               }
          }
          
          override public function update(param1:StickWar) : void
          {
               this.chargeSpell.update();
               updateCommon(param1);
               if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour = _damageToNotArmour / 3 * team.game.main.campaign.difficultyLevel + 1;
                    _damageToArmour = _damageToArmour / 4.2 * team.game.main.campaign.difficultyLevel + 1;
                    health = health / 4 * (team.game.main.campaign.difficultyLevel + 1);
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.02 - 0.02;
                    enemyBuffed = true;
               }
               if(this.knightType == "Leader" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Leader Axe","Leader Helmet","Leader Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.07;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Leader_2" && !this.setupComplete)
               {
                    noStone = true;
                    poisonUnit = true;
                    fireRegen = true;
                    poisonRegen = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Leader Axe","Leader Helmet","Slotted Shield");
                    maxHealth = 10500;
                    health = 10500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "SecondCommand" && !this.setupComplete)
               {
                    noStone = true;
                    stunUnit = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Second Helmet","Slotted Shield");
                    maxHealth = 550;
                    health = 550;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.04;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "SecondCommand_2" && !this.setupComplete)
               {
                    noStone = true;
                    stunUnit = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Second Helmet","Slotted Shield");
                    maxHealth = 8000;
                    health = 8000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "FireKnight" && !this.setupComplete)
               {
                    noStone = true;
                    burnUnit = true;
                    fireRegen = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Flame Axe","Flame Helmet","Flame Shield");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.08;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "VampKnight" && !this.setupComplete)
               {
                    noStone = true;
                    isVampUnit = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Vamp Axe","Vamp Helmet 2","Vamp Shield 2");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.08;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "IceKnight" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Ice Axe","Vamp Helmet 2","Ice Shield");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.08;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "GoldKnight" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Jug Axe","Gold Jug Helmet","Gold Jug Shield");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.08;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "MegaKnight" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Gas Mask","Riot Shield");
                    maxHealth = 7000;
                    health = 7000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType != "")
               {
                    isCustomUnit = true;
               }
               if(this.knightType == "Leader" || this.knightType == "MegaKnight" || this.knightType == "GoldKnight" || this.knightType == "SecondCommand" || this.knightType == "SecondCommand_2" || this.knightType == "Leader_2")
               {
                    stunTimeLeft = 0;
               }
               if(isCustomUnit = true)
               {
                    if(this.knightType == "SecondCommand")
                    {
                         this.normalVelocity = 6.4;
                         this.chargeStunArea = 250;
                         this.chargeVelocity = 15;
                         this.chargeForce = 300;
                    }
                    else if(this.knightType == "SecondCommand_2")
                    {
                         this.normalVelocity = 8.4;
                         this.chargeStunArea = 350;
                         this.chargeVelocity = 27;
                         this.chargeForce = 500;
                    }
                    else if(this.knightType == "MegaKnight")
                    {
                         this.chargeStunArea = 550;
                         this.chargeVelocity = 47;
                         this.chargeForce = 700;
                    }
                    else
                    {
                         this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity;
                         this.chargeStunArea = param1.xml.xml.Chaos.Units.knight.charge.stunArea;
                         this.chargeVelocity = param1.xml.xml.Chaos.Units.knight.charge.velocity;
                         this.chargeForce = param1.xml.xml.Chaos.Units.knight.charge.force;
                    }
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
                                   if(this.knightType == "SecondCommand")
                                   {
                                        this.stunned.poison(70);
                                        param1.projectileManager.initNuke(px,py,this,20,0.2,600);
                                   }
                                   if(this.knightType == "IceKnight")
                                   {
                                        this.stunned.slow(30 * 100);
                                        this.stunned.freeze(30 * 25);
                                   }
                                   if(this.knightType == "FireKnight")
                                   {
                                        this.protect(145);
                                   }
                                   if(this.knightType == "MegaKnight")
                                   {
                                        this.stunned.damage(0,this.stunDamage,null);
                                        this.stunned.damage(0,this.stunDamage,null);
                                        this.stunned.damage(0,this.stunDamage,null);
                                        this.stunned.poison(360);
                                   }
                                   if(this.knightType == "GoldKnight")
                                   {
                                        this.protect(190);
                                   }
                                   if(this.knightType == "SecondCommand_2")
                                   {
                                        this.stunned.poison(160);
                                        this.stunned.slow(30 * 200);
                                        this.stunned.freeze(30 * 60);
                                        param1.projectileManager.initNuke(px,py,this,80,0.6,600);
                                   }
                                   if(this.knightType == "FireKnight")
                                   {
                                        this.stunned.setFire(1230,1.2);
                                   }
                                   if(this.knightType == "VampKnight")
                                   {
                                        this.heal(75,5);
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
                              if(this.knightType == "")
                              {
                                   this.heal(0.5,1);
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
                                   param1.soundManager.playSound("sword1",px,py);
                              }
                         }
                         if(this.knightType == "")
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
                    if(this.knightType == "")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Default";
                         this.clusterLad.stun(40);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Default";
                         this.clusterLad.stun(40);
                    }
                    if(this.knightType == "SecondCommand_2")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Default";
                         this.clusterLad.stun(40);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Default";
                         this.clusterLad.stun(40);
                    }
                    if(this.knightType == "")
                    {
                         param1.projectileManager.initStun(this.px,py,45,this);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "FireKnight";
                         this.clusterLad.stun(140);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "FireKnight";
                         this.clusterLad.stun(140);
                    }
                    if(this.knightType == "Leader_2")
                    {
                         param1.projectileManager.initStun(this.px,py,45,this);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "FireKnight";
                         this.clusterLad.stun(140);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "FireKnight";
                         this.clusterLad.stun(140);
                    }
                    if(this.knightType == "FireKnight")
                    {
                         param1.projectileManager.initNuke(px,py,this,80,0.6,600);
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
               if(this.knightType == "Leader")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Leader Axe","Leader Helmet","Leader Shield");
               }
               else if(this.knightType == "Leader_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Leader Axe","Leader Helmet","Slotted Shield");
               }
               else if(this.knightType == "FireKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Flame Axe","Flame Helmet","Flame Shield");
               }
               else if(this.knightType == "VampKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Vamp Axe","Vamp Helmet 2","Vamp Shield 2");
               }
               else if(this.knightType == "SecondCommand")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Second Helmet","Slotted Shield");
               }
               else if(this.knightType == "SecondCommand_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Second Helmet","Slotted Shield");
               }
               else if(this.knightType == "GoldKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Jug Axe","Gold Jug Helmet","Gold Jug Shield");
               }
               else if(this.knightType == "IceKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Ice Axe","New Default Helmet","Ice Shield");
               }
               else if(this.knightType == "MegaKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Gas Mask","Riot Shield");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"New Axe","New Default Helmet","New Default Shield");
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.knightType == "Leader")
               {
                    return 23;
               }
               if(this.knightType == "Leader_2")
               {
                    return 430;
               }
               if(this.knightType == "SecondCommand")
               {
                    return 20;
               }
               if(this.knightType == "SecondCommand_2")
               {
                    return 263;
               }
               if(this.knightType == "FireKnight")
               {
                    return 65;
               }
               if(this.knightType == "VampKnight")
               {
                    return 65;
               }
               if(this.knightType == "GoldKnight")
               {
                    return 230;
               }
               if(this.knightType == "MegaKnight")
               {
                    return 135;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.knightType == "MegaKnight")
               {
                    return 175;
               }
               if(this.knightType == "Leader")
               {
                    return 23;
               }
               if(this.knightType == "Leader_2")
               {
                    return 500;
               }
               if(this.knightType == "SecondCommand")
               {
                    return 21;
               }
               if(this.knightType == "SecondCommand_2")
               {
                    return 410;
               }
               if(this.knightType == "FireKnight")
               {
                    return 115;
               }
               if(this.knightType == "GoldKnight")
               {
                    return 245;
               }
               if(this.knightType == "VampKnight")
               {
                    return 115;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(techTeam.tech.isResearched(Tech.KNIGHT_CHARGE || this.knightType == "Leader"))
               {
                    param1.setAction(0,0,UnitCommand.KNIGHT_CHARGE);
               }
          }
          
          public function stopBlocking() : void
          {
               this.isBlocking = false;
          }
          
          public function startBlocking() : void
          {
               if(this.knightType == "Default")
               {
                    this.isBlocking = true;
                    this.inBlock = true;
               }
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.knightType == "GoldKnight" || this.knightType == "FireKnight")
               {
                    trace(this.shieldwallDamageReduction);
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
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
