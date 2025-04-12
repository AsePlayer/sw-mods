package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.GiantAi;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     
     public class Giant extends Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var scaleI:Number;
          
          private var scaleII:Number;
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
          private var stunTime:int;
          
          private var hasGrowled:Boolean;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Dead;
          
          public var giantType:String;
          
          private var setupComplete:Boolean;
          
          internal var Damage:Array;
          
          public function Giant(param1:StickWar)
          {
               super(param1);
               _mc = new _giant();
               this.init(param1);
               addChild(_mc);
               ai = new GiantAi(this);
               initSync();
               firstInit();
               this.Damage = [600];
               this.giantType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_giant = null;
               if((_loc5_ = _giant(param1)).mc.giantclub)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.giantclub.gotoAndStop(param2);
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
               WEAPON_REACH = param1.xml.xml.Chaos.Units.giant.weaponReach;
               this.hasGrowled = false;
               population = param1.xml.xml.Chaos.Units.giant.population;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               _mass = param1.xml.xml.Chaos.Units.giant.mass;
               _maxForce = param1.xml.xml.Chaos.Units.giant.maxForce;
               _dragForce = param1.xml.xml.Chaos.Units.giant.dragForce;
               _scale = param1.xml.xml.Chaos.Units.giant.scale;
               _maxVelocity = param1.xml.xml.Chaos.Units.giant.maxVelocity;
               damageToDeal = param1.xml.xml.Chaos.Units.giant.baseDamage;
               this.createTime = param1.xml.xml.Chaos.Units.giant.cooldown;
               maxHealth = health = param1.xml.xml.Chaos.Units.giant.health;
               this.maxTargetsToHit = param1.xml.xml.Chaos.Units.giant.maxTargetsToHit;
               this.stunTime = param1.xml.xml.Chaos.Units.giant.stunTime;
               this.scaleI = param1.xml.xml.Chaos.Units.giant.growthIScale;
               this.scaleII = param1.xml.xml.Chaos.Units.giant.growthIIScale;
               loadDamage(param1.xml.xml.Chaos.Units.giant);
               type = Unit.U_GIANT;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.healthBar.y = -mc.mc.height * 1.1;
               healthBar.totalHealth = maxHealth;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["GiantBuilding"];
          }
          
          override public function getDamageToDeal() : Number
          {
               return damageToDeal;
          }
          
          private function giantHit(param1:Unit) : *
          {
               if(this.targetsHit < this.maxTargetsToHit && param1.team != this.team)
               {
                    if(param1.px * mc.scaleX > px * mc.scaleX)
                    {
                         if(param1 is Wall)
                         {
                              ++this.targetsHit;
                              param1.damage(0,this.damageToDeal,this);
                              param1.stun(this.stunTime);
                              param1.dx = 10 * Util.sgn(mc.scaleX);
                         }
                         else if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(5 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                         {
                              ++this.targetsHit;
                              param1.damage(0,this.damageToDeal,this);
                              param1.stun(this.stunTime);
                              param1.applyVelocity(7 * Util.sgn(mc.scaleX));
                              if(this.giantType == "LavaGiant")
                              {
                                   param1.setFire(400,0.6);
                              }
                              if(this.giantType == "IceGiant")
                              {
                                   param1.slow(30 * 5);
                              }
                              if(this.giantType == "BomberGiant")
                              {
                                   this.team.game.projectileManager.initNuke(px + 50,py,this,30,0.5,100);
                              }
                              if(this.giantType == "VoltGiant")
                              {
                                   param1.setFire(3000,0.0385);
                                   this.team.game.projectileManager.initLightning(this,param1,this);
                                   this.team.game.projectileManager.initLightning(this,param1,this);
                                   this.team.game.projectileManager.initLightning(this,param1,this);
                              }
                         }
                    }
               }
          }
          
          override public function applyVelocity(param1:Number, param2:Number = 0, param3:Number = 0) : void
          {
          }
          
          override public function freeze(param1:int) : void
          {
          }
          
          override public function aquireFreezeLock(param1:Unit) : Boolean
          {
               return false;
          }
          
          override public function update(param1:StickWar) : void
          {
               nonTeleportable = true;
               this.shieldwallDamageReduction = 0.42;
               giantRegen = true;
               if(!isUC)
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.giant.maxVelocity;
               }
               if(isUC)
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.giant.maxVelocity * 1.2;
                    _damageToNotArmour = (Number(param1.xml.xml.Chaos.Units.giant.damage) + Number(param1.xml.xml.Chaos.Units.giant.toNotArmour)) * 3;
                    _damageToArmour = (Number(param1.xml.xml.Chaos.Units.giant.damage) + Number(param1.xml.xml.Chaos.Units.giant.toArmour)) * 5.2;
                    _mass = Number(param1.xml.xml.Chaos.Units.giant.mass) / 2;
               }
               else if(!team.isEnemy)
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.giant.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Chaos.Units.giant.damage) + Number(param1.xml.xml.Chaos.Units.giant.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Chaos.Units.giant.damage) + Number(param1.xml.xml.Chaos.Units.giant.toArmour);
                    _mass = param1.xml.xml.Chaos.Units.giant.mass;
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    health *= 1;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.01 - 0.01;
                    enemyBuffed = true;
               }
               if(!this.hasGrowled)
               {
                    this.hasGrowled = true;
                    team.game.soundManager.playSoundRandom("GiantGrowl",6,px,py);
               }
               stunTimeLeft = 0;
               _dz = 0;
               if(this.giantType != "UndeadGiant" && this.giantType != "Griffin")
               {
                    if(team.tech.isResearched(Tech.CHAOS_GIANT_GROWTH_II))
                    {
                         if(_scale != this.scaleII)
                         {
                              health = param1.xml.xml.Chaos.Units.giant.healthII - (maxHealth - health);
                              maxHealth = param1.xml.xml.Chaos.Units.giant.healthII;
                              healthBar.totalHealth = maxHealth;
                         }
                         _scale = this.scaleII;
                    }
                    else if(team.tech.isResearched(Tech.CHAOS_GIANT_GROWTH_I))
                    {
                         if(_scale != this.scaleI)
                         {
                              health = param1.xml.xml.Chaos.Units.giant.healthI - (maxHealth - health);
                              maxHealth = param1.xml.xml.Chaos.Units.giant.healthI;
                              healthBar.totalHealth = maxHealth;
                         }
                         _scale = this.scaleI;
                    }
               }
               updateCommon(param1);
               if(mc.mc.sword != null)
               {
                    mc.mc.sword.gotoAndStop(team.loadout.getItem(this.type,MarketItem.T_WEAPON));
               }
               if(this.giantType == "Griffin" && !this.setupComplete)
               {
                    slowAttack = true;
                    Giant.setItem(_mc,"Mace","","");
                    maxHealth = 75000;
                    health = 75000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 1.7;
                    _scale = 4;
                    this.maxTargetsToHit = 100;
                    this.setupComplete = true;
               }
               if(this.giantType == "VoltGiant" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Voltaic Club","","");
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.giantType == "UndeadGiant" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Undead Club","","");
                    maxHealth = 2200;
                    health = 2200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    this.setupComplete = true;
               }
               if(this.giantType == "LavaGiant" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Lava Club 2","","");
                    this.maxTargetsToHit = 75;
                    this.setupComplete = true;
               }
               if(this.giantType == "IceGiant" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Ice Club","","");
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.giantType == "VampGiant" && !this.setupComplete)
               {
                    GiantRegen = true;
                    GiantVamp = true;
                    Giant.setItem(_mc,"Vamp Club","","");
                    this.maxTargetsToHit = 4;
                    this.setupComplete = true;
               }
               if(this.giantType == "BomberGiant" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Dynamite","","");
                    this.maxTargetsToHit = 4;
                    this.setupComplete = true;
               }
               if(this.giantType == "SavageGiant" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Savage Club","","");
                    this.maxTargetsToHit = 3;
                    this.setupComplete = true;
               }
               if(this.giantType != "")
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
                         if(this.targetsHit < this.maxTargetsToHit && mc.mc.currentFrameLabel == "hit")
                         {
                              team.game.spatialHash.mapInArea(px - 200,py - 50,px + 200,py + 50,this.giantHit);
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
                         if(this.giantType == "BomberGiant")
                         {
                              if(this._health <= 500)
                              {
                                   this.damage(0,1000,null);
                              }
                         }
                    }
                    updateMotion(param1);
               }
               else if(isDead == false)
               {
                    team.game.soundManager.playSoundRandom("GiantDeath",3,px,py);
                    if(this.giantType == "UndeadGiant")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_DEAD);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.deadType = "DeadBoss";
                    }
                    if(this.giantType == "BomberGiant")
                    {
                         param1.projectileManager.initNuke(px,py,this,60,0.6,300);
                         param1.projectileManager.initNuke(px + 50,py,this,60,0.6,300);
                         param1.projectileManager.initNuke(px - 50,py,this,60,0.6,300);
                    }
                    if(this.giantType == "LavaGiant")
                    {
                         param1.projectileManager.initNuke(px,py,this,45,0.5,200);
                    }
                    if(this.giantType == "VoltGiant")
                    {
                         param1.projectileManager.initStun(this.px,py,35,this);
                    }
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
               MovieClip(_mc.mc).nextFrame();
               _mc.mc.stop();
               if(this.giantType == "Griffin")
               {
                    Giant.setItem(_mc,"Mace","","");
               }
               else if(this.giantType == "UndeadGiant")
               {
                    Giant.setItem(_mc,"Undead Club","","");
               }
               else if(this.giantType == "LavaGiant")
               {
                    Giant.setItem(_mc,"Lava Club 2","","");
               }
               else if(this.giantType == "IceGiant")
               {
                    Giant.setItem(_mc,"Ice Club","","");
               }
               else if(this.giantType == "SavageGiant")
               {
                    Giant.setItem(_mc,"Savage Club","","");
               }
               else if(this.giantType == "VampGiant")
               {
                    Giant.setItem(_mc,"Vamp Club","","");
               }
               else if(this.giantType == "VoltGiant")
               {
                    Giant.setItem(_mc,"Voltaic Club","","");
               }
               else if(this.giantType == "BomberGiant")
               {
                    Giant.setItem(_mc,"Dynamite","","");
               }
               else
               {
                    Giant.setItem(_mc,"","","");
               }
          }
          
          override public function canAttackAir() : Boolean
          {
               return true;
          }
          
          public function stopBlocking() : void
          {
               if(this.isBlocking)
               {
                    _mc.mc.gotoAndStop(62);
               }
               this.isBlocking = false;
          }
          
          public function startBlocking() : void
          {
               if(this.giantType == "Default")
               {
                    this.isBlocking = true;
                    this.inBlock = true;
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.giantType == "Griffin")
               {
                    return 1000;
               }
               if(this.giantType == "UndeadGiant")
               {
                    return 200;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.giantType == "Griffin")
               {
                    return 835;
               }
               if(this.giantType == "UndeadGiant")
               {
                    return 200;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
          }
          
          override public function faceDirection(param1:int) : void
          {
               if(_state != S_ATTACK)
               {
                    super.faceDirection(param1);
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
                    this.targetsHit = 0;
                    framesInAttack = MovieClip(_mc.mc).totalFrames;
                    attackStartFrame = team.game.frame;
               }
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.giantType == "Default")
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
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
