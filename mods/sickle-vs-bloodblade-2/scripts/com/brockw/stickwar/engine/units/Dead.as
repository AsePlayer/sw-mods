package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.DeadAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.geom.Point;
     
     public class Dead extends RangedUnit
     {
           
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var _isCastleArcher:Boolean;
          
          private var isPoison:Boolean;
          
          private var isFire:Boolean;
          
          private var arrowDamage:Number;
          
          private var bowFrame:int;
          
          private var target:com.brockw.stickwar.engine.units.Unit;
          
          private var _isPoisonedToggled:Boolean;
          
          private var _poisonMana:Number;
          
          public var deadType:String;
          
          private var setupComplete:Boolean;
          
          private var poisonDamageAmount:Number;
          
          private var lastShotFrame:int;
          
          public function Dead(param1:StickWar)
          {
               super(param1);
               _mc = new _dead();
               this.init(param1);
               addChild(_mc);
               ai = new DeadAi(this);
               initSync();
               firstInit();
               this.isPoisonedToggled = false;
               this.lastShotFrame = 0;
               this.deadType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_dead = null;
               if((_loc5_ = _dead(param1)).mc.head)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.head.gotoAndStop(param3);
                    }
               }
          }
          
          public function get poisonMana() : Number
          {
               return this._poisonMana;
          }
          
          public function set poisonMana(param1:Number) : void
          {
               this._poisonMana = param1;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(techTeam.tech.isResearched(Tech.DEAD_POISON))
               {
                    param1.setAction(0,0,UnitCommand.DEAD_POISON);
               }
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               _maximumRange = param1.xml.xml.Chaos.Units.dead.maximumRange;
               population = param1.xml.xml.Chaos.Units.dead.population;
               maxHealth = health = param1.xml.xml.Chaos.Units.dead.health;
               this.createTime = param1.xml.xml.Chaos.Units.dead.cooldown;
               this.projectileVelocity = param1.xml.xml.Chaos.Units.dead.arrowVelocity;
               this.arrowDamage = param1.xml.xml.Chaos.Units.dead.damage;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               _mass = param1.xml.xml.Chaos.Units.dead.mass;
               _maxForce = param1.xml.xml.Chaos.Units.dead.maxForce;
               _dragForce = param1.xml.xml.Chaos.Units.dead.dragForce;
               _scale = param1.xml.xml.Chaos.Units.dead.scale;
               _maxVelocity = param1.xml.xml.Chaos.Units.dead.maxVelocity;
               this.poisonMana = param1.xml.xml.Chaos.Units.dead.poison.mana;
               this.poisonDamageAmount = param1.xml.xml.Chaos.Units.dead.poison.damage;
               loadDamage(param1.xml.xml.Chaos.Units.dead);
               type = com.brockw.stickwar.engine.units.Unit.U_DEAD;
               if(this.isCastleArcher)
               {
                    this._maximumRange = param1.xml.xml.Chaos.Units.dead.castleRange;
                    this.poisonDamageAmount = param1.xml.xml.Chaos.Units.dead.castlePoison;
                    projectileVelocity += 10;
               }
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.isPoison = false;
               this.isFire = false;
               this.bowFrame = 1;
               this.isPoisonedToggled = true;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["ArcheryBuilding"];
          }
          
          public function togglePoison() : void
          {
               this.isPoisonedToggled = !this.isPoisonedToggled;
          }
          
          override public function mayAttack(param1:com.brockw.stickwar.engine.units.Unit) : Boolean
          {
               var _loc2_:int = 200;
               if(!this.isCastleArcher && team.direction * px < team.direction * (this.team.homeX + team.direction * _loc2_))
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
               if(aimedAtUnit(param1,angleToTarget(param1)) && this.inRange(param1))
               {
                    return true;
               }
               return false;
          }
          
          public function set isCastleArcher(param1:Boolean) : void
          {
               if(param1)
               {
                    this._maximumRange = 500;
                    this.healthBar.visible = false;
                    isStationary = true;
               }
               this._isCastleArcher = param1;
          }
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:Point = null;
               var _loc3_:int = 0;
               var _loc4_:int = 0;
               var _loc5_:* = NaN;
               var _loc6_:Boolean = false;
               super.update(param1);
               updateCommon(param1);
               if(team.isEnemy && !enemyBuffed && !this.isCastleArcher)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    health *= 1;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.05 - 0.05;
                    enemyBuffed = true;
               }
               if(this.deadType == "Toxic" && !this.setupComplete)
               {
                    enemyColor6 = true;
                    poisonRegen = true;
                    Dead.setItem(mc,"","","");
                    maxHealth = 200;
                    health = 200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.deadType == "DeadBoss" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    poisonRegen = true;
                    Dead.setItem(mc,"","","");
                    maxHealth = 2800;
                    health = 2800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.7;
                    this.setupComplete = true;
               }
               if(this.deadType == "SpearDeadBoss" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    noStone = true;
                    poisonRegen = true;
                    Dead.setItem(mc,"","Dead Spearton Head","");
                    maxHealth = 4500;
                    health = 4500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.7;
                    this.setupComplete = true;
               }
               if(this.deadType == "SpeedDead" && !this.setupComplete)
               {
                    poisonRegen = true;
                    Dead.setItem(mc,"","","");
                    maxHealth = 150;
                    health = 150;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.deadType == "StatueDead" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    noStone = true;
                    Dead.setItem(mc,"","Bone 1","");
                    this.healthBar.visible = false;
                    isStationary = true;
                    flyingHeight = 410;
                    maxHealth = 5000000;
                    health = 5000000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.deadType != "")
               {
                    isCustomUnit = true;
               }
               if(this.deadType == "SpearDeadBoss" || this.deadType == "StatueDead")
               {
                    stunTimeLeft = 0;
               }
               if(isCustomUnit == true)
               {
                    if(this.deadType == "DeadBoss")
                    {
                         slowFramesRemaining = 0;
                         stunTimeLeft = 0;
                         this.poisonDamageAmount = 45;
                    }
                    else if(this.deadType == "SpearDeadBoss")
                    {
                         slowFramesRemaining = 0;
                         this.poisonDamageAmount = 40;
                    }
                    else if(this.deadType == "StatueDead")
                    {
                         this.poisonDamageAmount = 100;
                         this.projectileVelocity = 30;
                         _maximumRange = 1000;
                    }
                    else if(this.deadType == "SpeedDead")
                    {
                         this.poisonDamageAmount = 25;
                         _mass = 25;
                         _maxVelocity = 5.9;
                    }
                    else if(this.deadType == "Toxic")
                    {
                         this.poisonDamageAmount = 350;
                    }
                    else if(this.isCastleArcher)
                    {
                         this.poisonDamageAmount = 80;
                    }
                    else
                    {
                         _mass = param1.xml.xml.Chaos.Units.dead.mass;
                         _maxVelocity = param1.xml.xml.Chaos.Units.dead.maxVelocity;
                         this.projectileVelocity = param1.xml.xml.Chaos.Units.dead.arrowVelocity;
                         this.poisonDamageAmount = param1.xml.xml.Chaos.Units.dead.poison.damage;
                         _maximumRange = param1.xml.xml.Chaos.Units.dead.maximumRange;
                    }
               }
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
                         if(MovieClip(_mc.mc).currentFrame == 31 && !hasHit)
                         {
                              _loc2_ = mc.mc.localToGlobal(new Point(0,0));
                              _loc2_ = param1.battlefield.globalToLocal(_loc2_);
                              _loc3_ = projectileVelocity;
                              _loc4_ = this.arrowDamage;
                              if(this.target != null)
                              {
                                   _loc5_ = 0;
                                   _loc6_ = this.isPoisonedToggled;
                                   if(!techTeam.tech.isResearched(Tech.DEAD_POISON))
                                   {
                                        _loc6_ = false;
                                   }
                                   if(_loc6_ && team.mana > this.poisonMana || this._isCastleArcher)
                                   {
                                        _loc5_ = this.poisonDamageAmount;
                                   }
                                   if(mc.scaleX < 0)
                                   {
                                        param1.projectileManager.initGuts(_loc2_.x,_loc2_.y,180 - bowAngle,_loc3_,this.target.y,angleToTargetW(this.target,_loc3_,angleToTarget(this.target)),_loc5_,this,this.target);
                                   }
                                   else
                                   {
                                        param1.projectileManager.initGuts(_loc2_.x,_loc2_.y,bowAngle,_loc3_,this.target.y,angleToTargetW(this.target,_loc3_,angleToTarget(this.target)),_loc5_,this,this.target);
                                   }
                                   hasHit = true;
                              }
                              else
                              {
                                   if(mc.scaleX < 0)
                                   {
                                        param1.projectileManager.initGuts(_loc2_.x,_loc2_.y,180 - bowAngle,_loc3_,this.target.y,0,_loc5_,this);
                                   }
                                   else
                                   {
                                        param1.projectileManager.initGuts(_loc2_.x,_loc2_.y,bowAngle,_loc3_,this.target.y,0,_loc5_,this);
                                   }
                                   hasHit = true;
                              }
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
                    }
               }
               else if(isDead == false)
               {
                    if(this.deadType == "Deadboss" || this.deadType == "SpearDeadBoss")
                    {
                         param1.projectileManager.initPoisonPool(this.px,this.py,this,0);
                    }
                    isDead = true;
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.defendLabel);
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
               Util.animateMovieClip(_mc,0);
               if(this.isCastleArcher)
               {
                    Dead.setItem(mc,"Default","Wrapped Helmet","Default");
               }
               else if(this.deadType == "DeadBoss")
               {
                    Dead.setItem(mc,"","","");
               }
               else if(this.deadType == "StatueDead")
               {
                    Dead.setItem(mc,"","Bone 1","");
               }
               else if(this.deadType == "SpearDeadBoss")
               {
                    Dead.setItem(mc,"","Dead Spearton Head","");
               }
               else if(this.deadType == "SpeedDead")
               {
                    Dead.setItem(mc,"","","");
               }
               else if(this.deadType == "Toxic")
               {
                    Dead.setItem(mc,"","","");
               }
               else
               {
                    Dead.setItem(mc,"","","");
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.deadType == "DeadBoss")
               {
                    return 55;
               }
               if(this.deadType == "SpearDeadBoss")
               {
                    return 150;
               }
               if(this.deadType == "StatueDead")
               {
                    return 160;
               }
               if(this.isCastleArcher)
               {
                    return 65;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.isCastleArcher)
               {
                    return 65;
               }
               if(this.deadType == "DeadBoss")
               {
                    return 45;
               }
               if(this.deadType == "SpearDeadBoss")
               {
                    return 65;
               }
               if(this.deadType == "StatueDead")
               {
                    return 100;
               }
               return _damageToNotArmour;
          }
          
          override public function shoot(param1:StickWar, param2:com.brockw.stickwar.engine.units.Unit) : void
          {
               if(_state != S_ATTACK && param1.frame - this.lastShotFrame > 45)
               {
                    _state = S_ATTACK;
                    mc.gotoAndStop("attack_1");
                    this.target = param2;
                    hasHit = false;
                    this.lastShotFrame = param1.frame;
               }
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
               if(this.deadType == "Default")
               {
                    this.isBlocking = true;
                    this.inBlock = true;
               }
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.deadType == "SpearDeadBoss")
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
               }
          }
          
          public function get isPoisonedToggled() : Boolean
          {
               return this._isPoisonedToggled;
          }
          
          public function set isPoisonedToggled(param1:Boolean) : void
          {
               this._isPoisonedToggled = param1;
          }
          
          public function get isCastleArcher() : Boolean
          {
               return this._isCastleArcher;
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
