package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.ArcherAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.geom.Point;
     
     public class Archer extends RangedUnit
     {
           
          
          private var _isCastleArcher:Boolean;
          
          private var isFire:Boolean;
          
          private var archerFireSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var arrowDamage:Number;
          
          private var bowFrame:int;
          
          public var archerType:String;
          
          private var scaleOffset:Number;
          
          private var setupComplete:Boolean;
          
          private var normalRange:Number;
          
          private var fireArrowRange:Number;
          
          private var damageIncrease:Number;
          
          private var areaDamage:Number;
          
          private var area:Number;
          
          private var comment:String;
          
          public function Archer(param1:StickWar)
          {
               super(param1);
               _mc = new _archer();
               this.init(param1);
               addChild(_mc);
               ai = new ArcherAi(this);
               initSync();
               firstInit();
               this.archerType = "Default";
               this.archerFireSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(0,param1.xml.xml.Order.Units.archer.fire.cooldown,param1.xml.xml.Order.Units.archer.fire.mana);
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_archer = _archer(param1);
               if(_loc5_.mc.archerBag)
               {
                    if(param4 != "")
                    {
                         _loc5_.mc.archerBag.gotoAndStop(param4);
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
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(team.tech.isResearched(Tech.ARCHIDON_FIRE))
               {
                    param1.setAction(0,0,UnitCommand.ARCHER_FIRE);
               }
          }
          
          public function getFireCoolDown() : Number
          {
               return this.archerFireSpellCooldown.cooldown();
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               _maximumRange = this.normalRange = param1.xml.xml.Order.Units.archer.maximumRange;
               this.fireArrowRange = param1.xml.xml.Order.Units.archer.fire.range;
               maxHealth = health = param1.xml.xml.Order.Units.archer.health;
               this.createTime = param1.xml.xml.Order.Units.archer.cooldown;
               this.damageIncrease = param1.xml.xml.Order.Units.swordwrath.rage.damageIncrease;
               this.projectileVelocity = param1.xml.xml.Order.Units.archer.arrowVelocity;
               this.arrowDamage = param1.xml.xml.Order.Units.archer.damage;
               population = param1.xml.xml.Order.Units.archer.population;
               _mass = param1.xml.xml.Order.Units.archer.mass;
               _maxForce = param1.xml.xml.Order.Units.archer.maxForce;
               _dragForce = param1.xml.xml.Order.Units.archer.dragForce;
               _scale = param1.xml.xml.Order.Units.archer.scale;
               _maxVelocity = param1.xml.xml.Order.Units.archer.maxVelocity;
               this.loadDamage(param1.xml.xml.Order.Units.archer);
               this.areaDamage = 0;
               this.area = 0;
               if(this.isCastleArcher)
               {
                    this._maximumRange = this.normalRange = param1.xml.xml.Order.Units.archer.castleRange;
                    _scale *= 1;
                    this.area = param1.xml.xml.Order.Units.archer.castleArea;
                    this.areaDamage = param1.xml.xml.Order.Units.archer.castleAreaDamage;
               }
               if(this.archerType == "Kytchu")
               {
                    this.arrowDamage = param1.xml.xml.Order.Units.archer.damage * 11.637813333333;
               }
               type = Unit.U_ARCHER;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.isFire = false;
               this.bowFrame = 1;
          }
          
          override protected function loadDamage(param1:XMLList) : void
          {
               var _loc2_:Number = NaN;
               this.isArmoured = param1.armoured == 1 ? Boolean(true) : Boolean(false);
               if(!this._isCastleArcher)
               {
                    _loc2_ = Number(param1.damage);
                    this._damageToArmour = _loc2_ + Number(param1.toArmour);
                    this._damageToNotArmour = _loc2_ + Number(param1.toNotArmour);
               }
               else
               {
                    _loc2_ = Number(param1.castleDamage);
                    this._damageToArmour = _loc2_ + Number(param1.castleToArmour);
                    this._damageToNotArmour = _loc2_ + Number(param1.castleToNotArmour);
               }
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["ArcheryBuilding"];
          }
          
          public function archerFireArrow() : void
          {
               if(this.archerFireSpellCooldown.spellActivate(team) && team.tech.isResearched(Tech.ARCHIDON_FIRE))
               {
                    this.isFire = true;
                    takeBottomTrajectory = false;
                    _maximumRange = this.fireArrowRange;
               }
          }
          
          override public function update(param1:StickWar) : void
          {
               super.update(param1);
               this.archerFireSpellCooldown.update();
               updateCommon(param1);
               if(this.isCastleArcher && !this.setupComplete)
               {
                    poisonUnit = true;
               }
               if(this.archerType == "Kytchu" && !this.setupComplete)
               {
                    poisonRegen = true;
                    Archer.setItem(mc,"Default","Kytchu","Golden Sleeve");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maximumRange = 9400;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "Kytchu" || this.archerType == "Buff" || this.archerType == "HouseArcher")
               {
                    stunTimeLeft = 0;
               }
               if(this.archerType == "Crippled" && !this.setupComplete)
               {
                    poisonUnit = true;
                    freezeUnit = true;
                    Archer.setItem(mc,"Default","Black Hat","Spiky Quiver");
                    maxHealth = 625;
                    health = 625;
                    maxHealth = maxHealth;
                    this.areaDamage = 75;
                    this.area = 100;
                    healthBar.totalHealth = maxHealth;
                    this.arrowDamage = 250;
                    _maximumRange = 27400;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "Heavy" && !this.setupComplete)
               {
                    Archer.setItem(mc,"Default","Default","Default");
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    this.areaDamage = 5;
                    this.area = 100;
                    healthBar.totalHealth = maxHealth;
                    _maximumRange = 17300;
                    _maxVelocity = 5.5;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "Buff" && !this.setupComplete)
               {
                    Archer.setItem(mc,"Default","Default","Default");
                    this.healthBar.visible = false;
                    isStationary = true;
                    flyingHeight = 410;
                    maxHealth = 500000;
                    health = 500000;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.5;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "HouseArcher" && !this.setupComplete)
               {
                    Archer.setItem(mc,"Default","Default","Default");
                    this.healthBar.visible = false;
                    isStationary = true;
                    flyingHeight = 675;
                    maxHealth = 500000;
                    health = 500000;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.5;
                    _scale = 0.6;
                    this.setupComplete = true;
               }
               if(this.archerType == "Frost_1" && !this.setupComplete)
               {
                    freezeUnit = true;
                    Archer.setItem(mc,"Default","Ice Helmet Two","Ice Quiver Two");
                    maxHealth = 80;
                    health = 80;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maximumRange = 3600;
                    _maxVelocity = 4.6;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "Frost_2" && !this.setupComplete)
               {
                    freezeUnit = true;
                    Archer.setItem(mc,"Default","Ice Helmet","Ice Quiver");
                    maxHealth = 680;
                    health = 680;
                    maxHealth = maxHealth;
                    this.areaDamage = 7;
                    this.area = 150;
                    healthBar.totalHealth = maxHealth;
                    _maximumRange = 3600;
                    _maxVelocity = 3.2;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType != "")
               {
                    isCustomUnit = true;
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
                              if(this.archerType == "Buff")
                              {
                                   this.heal(1,1);
                              }
                              _mc.gotoAndStop("stand");
                         }
                    }
                    else if(_state == S_ATTACK)
                    {
                         if(MovieClip(_mc.mc).currentFrame > MovieClip(_mc.mc).totalFrames / 2 && !hasHit)
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
               if(isDead)
               {
                    Util.animateMovieClip(_mc);
               }
               else
               {
                    if(!isDead && MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                    {
                         MovieClip(_mc.mc).gotoAndStop(1);
                    }
                    MovieClip(_mc.mc).nextFrame();
                    _mc.mc.stop();
               }
               var _loc2_:MovieClip = _mc.mc.bow;
               if(_loc2_ != null)
               {
                    _loc2_.gotoAndStop(this.bowFrame);
                    if(this.bowFrame != 1)
                    {
                         if(this.bowFrame == 46)
                         {
                              param1.soundManager.playSound("BowReady",px,py);
                         }
                         _loc2_.nextFrame();
                         ++this.bowFrame;
                         if(_loc2_.currentFrame == _loc2_.totalFrames)
                         {
                              _loc2_.gotoAndStop(1);
                              this.bowFrame = 1;
                         }
                    }
               }
               if(this.isCastleArcher)
               {
                    Archer.setItem(mc,"Default","Basic Helmet","Default");
               }
               else if(this.archerType == "Heavy")
               {
                    Archer.setItem(mc,"Default","Basic Helmet","Default");
               }
               else if(this.archerType == "Kytchu")
               {
                    Archer.setItem(mc,"Default","Kytchu","Golden Sleeve");
               }
               else if(this.archerType == "Buff")
               {
                    Archer.setItem(mc,"Default","Basic Helmet","Default");
               }
               else if(this.archerType == "Crippled")
               {
                    Archer.setItem(mc,"Default","Black Hat","Spiky Quiver");
               }
               else if(this.archerType == "Frost_1")
               {
                    Archer.setItem(mc,"Default","Ice Helmet Two","Ice Quiver Two");
               }
               else if(this.archerType == "Frost_2")
               {
                    Archer.setItem(mc,"Default","Ice Helmet","Ice Quiver");
               }
               else if(!hasDefaultLoadout)
               {
                    Archer.setItem(mc,"Default","Basic Helmet","Silver Archidon");
               }
               if(_mc.mc.bow != null)
               {
                    _mc.mc.bow.rotation = bowAngle;
               }
          }
          
          override public function isLoaded() : Boolean
          {
               var _loc1_:MovieClip = _mc.mc.bow;
               return this.bowFrame < 35;
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.archerType == "HouseArcher")
               {
                    return 55;
               }
               if(this.archerType == "Buff")
               {
                    return 250;
               }
               if(this.archerType == "Heavy")
               {
                    return 35;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.archerType == "HouseArcher")
               {
                    return 75;
               }
               if(this.archerType == "Buff")
               {
                    return 185;
               }
               if(this.archerType == "Heavy")
               {
                    return 25;
               }
               return _damageToNotArmour;
          }
          
          override public function shoot(param1:StickWar, param2:Unit) : void
          {
               var _loc3_:MovieClip = null;
               var _loc4_:Point = null;
               var _loc5_:int = 0;
               var _loc6_:int = 0;
               var _loc7_:Number = NaN;
               var _loc8_:Number = NaN;
               if(_state != S_ATTACK)
               {
                    _loc3_ = _mc.mc.bow;
                    if(this.bowFrame != 1)
                    {
                         return;
                    }
                    ++this.bowFrame;
                    _loc3_.nextFrame();
                    _loc4_ = _loc3_.localToGlobal(new Point(0,0));
                    _loc4_ = param1.battlefield.globalToLocal(_loc4_);
                    _loc5_ = projectileVelocity;
                    if(this.archerType == "Buff")
                    {
                         this.cure();
                         this.heal(10,1);
                    }
                    if(this.archerType == "Crippled")
                    {
                         _loc6_ = 30;
                    }
                    else
                    {
                         _loc6_ = this.arrowDamage;
                    }
                    if(this.archerType == "Frost_1" || this.archerType == "Frost_2")
                    {
                         _loc7_ = 30 * 8;
                    }
                    else
                    {
                         _loc7_ = 0;
                    }
                    _loc8_ = 0;
                    if(this.isFire)
                    {
                         if(this.archerType == "Heavy")
                         {
                              this.comment = "The second number is what is getting added to the normal Fire Arrow dmg that is used by Archidon";
                              _loc8_ = param1.xml.xml.Order.Units.archer.fire.damage + 100000;
                         }
                         else
                         {
                              _loc8_ = Number(param1.xml.xml.Order.Units.archer.fire.damage);
                         }
                    }
                    param1.soundManager.playSoundRandom("launchArrow",5,px,py);
                    if(mc.scaleX < 0)
                    {
                         param1.projectileManager.initArrow(_loc4_.x,_loc4_.y,180 - bowAngle,_loc5_,param2.y,angleToTargetW(param2,_loc5_,angleToTarget(param2)),this,_loc6_,_loc7_,this.isFire,this.area,this.areaDamage);
                    }
                    else
                    {
                         param1.projectileManager.initArrow(_loc4_.x,_loc4_.y,bowAngle,_loc5_,param2.y,angleToTargetW(param2,_loc5_,angleToTarget(param2)),this,_loc6_,_loc7_,this.isFire,this.area,this.areaDamage);
                    }
                    this.isFire = false;
                    _maximumRange = this.normalRange;
                    takeBottomTrajectory = true;
               }
          }
          
          override public function aim(param1:Unit) : void
          {
               var _loc2_:Number = angleToTarget(param1);
               if(Math.abs(normalise(angleToBowSpace(_loc2_) - bowAngle)) < 10)
               {
                    bowAngle += normalise(angleToBowSpace(_loc2_) - bowAngle) * 0.8;
               }
               else
               {
                    bowAngle += normalise(angleToBowSpace(_loc2_) - bowAngle) * 0.1;
               }
          }
          
          override public function mayAttack(param1:Unit) : Boolean
          {
               if(!this.isCastleArcher && team.direction * px < team.direction * (this.team.homeX + team.direction * 200))
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
          
          override public function walk(param1:Number, param2:Number, param3:int) : void
          {
               if(isAbleToWalk())
               {
                    baseWalk(param1,param2,param3);
               }
          }
          
          public function get isCastleArcher() : Boolean
          {
               return this._isCastleArcher;
          }
          
          public function set isCastleArcher(param1:Boolean) : void
          {
               if(param1)
               {
                    this._maximumRange = 500;
                    this.healthBar.visible = false;
                    isStationary = false;
               }
               this._isCastleArcher = param1;
          }
     }
}
