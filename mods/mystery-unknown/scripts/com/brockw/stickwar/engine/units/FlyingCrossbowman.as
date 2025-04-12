package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.Ai.FlyingCrossbowmanAi;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.filters.DropShadowFilter;
     import flash.geom.Point;
     
     public class FlyingCrossbowman extends RangedUnit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var bowFrame:int;
          
          private var invisAlbowGlow:DropShadowFilter;
          
          private var fireDamage:Number;
          
          private var fireFrames:int;
          
          private var setupComplete:Boolean;
          
          public var flyingCrossbowmanType:String;
          
          private var _isCastleArcher:Boolean;
          
          private var areaDamage:Number;
          
          private var area:Number;
          
          private var normalRange:Number;
          
          public function FlyingCrossbowman(param1:StickWar)
          {
               super(param1);
               _mc = new _flyingcrossbowmanMc();
               this.init(param1);
               addChild(_mc);
               ai = new FlyingCrossbowmanAi(this);
               initSync();
               firstInit();
               this.bowFrame = 1;
               this.flyingCrossbowmanType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_flyingcrossbowmanMc = null;
               if((_loc5_ = _flyingcrossbowmanMc(param1)).mc.body)
               {
                    if(_loc5_.mc.body.head)
                    {
                         if(param3 != "")
                         {
                              _loc5_.mc.body.head.gotoAndStop(param3);
                         }
                    }
                    if(_loc5_.mc.body.quiver)
                    {
                         if(param2 != "")
                         {
                              _loc5_.mc.body.quiver.gotoAndStop(param2);
                         }
                    }
               }
               if(_loc5_.mc.head)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.head.gotoAndStop(param3);
                    }
               }
               if(_loc5_.mc.wings)
               {
                    if(param4 != "")
                    {
                         _loc5_.mc.wings.avadonwing.gotoAndStop(param4);
                         _loc5_.mc.wings.avadonebackwing.gotoAndStop(param4);
                    }
               }
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               this.projectileVelocity = param1.xml.xml.Order.Units.flyingCrossbowman.arrowVelocity;
               population = param1.xml.xml.Order.Units.flyingCrossbowman.population;
               _mass = param1.xml.xml.Order.Units.flyingCrossbowman.mass;
               _maxForce = param1.xml.xml.Order.Units.flyingCrossbowman.maxForce;
               _dragForce = param1.xml.xml.Order.Units.flyingCrossbowman.dragForce;
               _scale = param1.xml.xml.Order.Units.flyingCrossbowman.scale;
               this.createTime = param1.xml.xml.Order.Units.flyingCrossbowman.cooldown;
               _maxVelocity = param1.xml.xml.Order.Units.flyingCrossbowman.maxVelocity;
               _maximumRange = this.normalRange = param1.xml.xml.Order.Units.flyingCrossbowman.maximumRange;
               maxHealth = health = param1.xml.xml.Order.Units.flyingCrossbowman.health;
               this.fireDamage = param1.xml.xml.Order.Units.flyingCrossbowman.fireDamage;
               this.fireFrames = param1.xml.xml.Order.Units.flyingCrossbowman.fireFrames;
               this.invisAlbowGlow = new DropShadowFilter();
               this.invisAlbowGlow.knockout = true;
               this.invisAlbowGlow.angle = 0;
               this.invisAlbowGlow.distance = 0;
               this.invisAlbowGlow.color = 0;
               type = Unit.U_FLYING_CROSSBOWMAN;
               flyingHeight = 250 * 1;
               this.areaDamage = 0;
               this.area = 0;
               if(this.isCastleArcher)
               {
                    this._maximumRange = this.normalRange = param1.xml.xml.Order.Units.flyingCrossbowman.castleRange;
                    _scale *= 1.1;
                    this.area = param1.xml.xml.Order.Units.archer.castleArea;
                    this.areaDamage = param1.xml.xml.Order.Units.archer.castleAreaDamage;
               }
               this.loadDamage(param1.xml.xml.Order.Units.flyingCrossbowman);
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _hitBoxWidth = 25;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               py = 0;
               pz = -flyingHeight * (param1.backScale + py / param1.map.height * (param1.frontScale - param1.backScale));
               y = -100;
               if(param1 != null)
               {
                    MovieClip(mc.mc.wings).gotoAndPlay(Math.floor(MovieClip(mc.mc.wings).totalFrames * param1.random.nextNumber()));
               }
               drawShadow();
               this.healthBar.y = -mc.mc.height * 1.1;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["ArcheryBuilding"];
          }
          
          override protected function loadDamage(param1:XMLList) : void
          {
               var _loc2_:Number = NaN;
               this.isArmoured = param1.armoured == 1 ? true : false;
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
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:MovieClip = null;
               super.update(param1);
               enemyColor4 = true;
               if(!isUC)
               {
                    _maxVelocity = param1.xml.xml.Order.Units.flyingCrossbowman.maxVelocity;
               }
               if(isUC)
               {
                    _maxVelocity = param1.xml.xml.Order.Units.flyingCrossbowman.maxVelocity * 1.2;
                    _damageToNotArmour = (Number(param1.xml.xml.Order.Units.flyingCrossbowman.damage) + Number(param1.xml.xml.Order.Units.flyingCrossbowman.toNotArmour)) * 2.8;
                    _damageToArmour = (Number(param1.xml.xml.Order.Units.flyingCrossbowman.damage) + Number(param1.xml.xml.Order.Units.flyingCrossbowman.toArmour)) * 5;
                    _mass = Number(param1.xml.xml.Order.Units.flyingCrossbowman.mass) / 2;
               }
               else if(!team.isEnemy)
               {
                    _maxVelocity = param1.xml.xml.Order.Units.flyingCrossbowman.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Order.Units.flyingCrossbowman.damage) + Number(param1.xml.xml.Order.Units.flyingCrossbowman.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Order.Units.flyingCrossbowman.damage) + Number(param1.xml.xml.Order.Units.flyingCrossbowman.toArmour);
                    _maximumRange = Number(param1.xml.xml.Order.Units.flyingCrossbowman.maximumRange);
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    health = Number(param1.xml.xml.Order.Units.flyingCrossbowman.health) * 1.2;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.01 - 0.01;
                    enemyBuffed = true;
               }
               if(this.flyingCrossbowmanType == "Icaron" && !this.setupComplete)
               {
                    fireRegen = true;
                    FlyingCrossbowman.setItem(mc,"Icaron Quiver","Icaron","Blue Wing");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    this.setupComplete = true;
               }
               if(this.flyingCrossbowmanType == "Blazing" && !this.setupComplete)
               {
                    fireRegen = true;
                    this.isReflective = true;
                    weakToIce = true;
                    removeIce = true;
                    FlyingCrossbowman.setItem(mc,"Lava Sleeve","Lava Helmet","Lava Wing");
                    maxHealth = 300;
                    health = 300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    this.setupComplete = true;
               }
               if(this.flyingCrossbowmanType == "LeafAblow" && !this.setupComplete)
               {
                    FlyingCrossbowman.setItem(mc,"Leaf Quiver","Leaf Helmet","Leaf Wings");
                    maxHealth = 200;
                    health = 200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    this.setupComplete = true;
               }
               if(this.flyingCrossbowmanType == "Elite" && !this.setupComplete)
               {
                    FlyingCrossbowman.setItem(mc,"Gold Quiver 2","Gold Helmet 2","Metal Wing");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.5;
                    _scale = 1.4;
                    _mass = 30;
                    this.setupComplete = true;
               }
               if(this.flyingCrossbowmanType == "SuperAlbow" && !this.setupComplete)
               {
                    FlyingCrossbowman.setItem(mc,"","","");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.4;
                    this.setupComplete = true;
               }
               if(this.flyingCrossbowmanType == "FrostBow" && !this.setupComplete)
               {
                    slowRegen = true;
                    selfFreeze = true;
                    weakToFire = true;
                    FlyingCrossbowman.setItem(mc,"Ice Quiver","Ice Helmet","Ice Wing");
                    maxHealth = 300;
                    health = 300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    this.setupComplete = true;
               }
               if(this.flyingCrossbowmanType != "")
               {
                    isCustomUnit = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.flyingCrossbowmanType == "Blazing")
                    {
                         this.fireDamage = 0.4;
                         this.fireFrames = 200;
                    }
                    else if(isUC)
                    {
                         _maxVelocity = param1.xml.xml.Order.Units.flyingCrossbowman.maxVelocity * 1.2;
                    }
                    else if(this.flyingCrossbowmanType == "Elite")
                    {
                         _mass = 30;
                         _maxVelocity = 6.5;
                         _maximumRange = 850;
                    }
                    else if(this.flyingCrossbowmanType == "SuperAlbow")
                    {
                         _mass = 30;
                         _maxVelocity = 7.5;
                         _maximumRange = 950;
                         this.fireDamage = 0.65;
                         this.fireFrames = 200;
                    }
                    else if(this.isCastleArcher)
                    {
                         redColor = true;
                         this.fireDamage = 0.85;
                         this.fireFrames = 300;
                         _maximumRange = 1550;
                    }
                    else
                    {
                         this.projectileVelocity = param1.xml.xml.Order.Units.flyingCrossbowman.arrowVelocity;
                         _mass = param1.xml.xml.Order.Units.flyingCrossbowman.mass;
                         _maximumRange = param1.xml.xml.Order.Units.flyingCrossbowman.maximumRange;
                         this.fireDamage = param1.xml.xml.Order.Units.flyingCrossbowman.fireDamage;
                         this.fireFrames = param1.xml.xml.Order.Units.flyingCrossbowman.fireFrames;
                    }
               }
               if(_mc.mc.bow != null)
               {
                    _mc.mc.bow.rotation = bowAngle + 12;
               }
               else if(_mc.mc.body != null && _mc.mc.body.arms)
               {
                    _mc.mc.body.arms.rotation = bowAngle + 12;
               }
               updateCommon(param1);
               if(_mc.mc.body != null && _mc.mc.body.legs != null)
               {
                    _mc.mc.body.legs.rotation = getDirection() * _dx / _maxVelocity * param1.xml.xml.Order.Units.flyingCrossbowman.legRotateAngleWhenFlying;
                    MovieClip(mc.mc.body.legs).nextFrame();
                    if(MovieClip(mc.mc.body.legs).currentFrame == MovieClip(mc.mc.body.legs).totalFrames)
                    {
                         MovieClip(mc.mc.body.legs).gotoAndStop(1);
                    }
               }
               if(mc.mc.wings != null)
               {
                    MovieClip(mc.mc.wings).nextFrame();
                    if(MovieClip(mc.mc.wings).currentFrame == MovieClip(mc.mc.wings).totalFrames)
                    {
                         MovieClip(mc.mc.wings).gotoAndStop(1);
                    }
               }
               if(!isDieing)
               {
                    updateMotion(param1);
                    _loc2_ = _mc.mc.body.arms;
                    if(_loc2_ != null)
                    {
                         _loc2_.gotoAndStop(this.bowFrame);
                         if(this.bowFrame != _loc2_.totalFrames)
                         {
                              _loc2_.nextFrame();
                              ++this.bowFrame;
                         }
                    }
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
                    if(this.flyingCrossbowmanType == "Blazing")
                    {
                         param1.projectileManager.initNuke(px,py,this,60,0.5,850);
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
               if(!isDead && _mc.mc.wings != null)
               {
                    MovieClip(_mc.mc).gotoAndStop(_mc.mc.wings.currentFrame);
               }
               if(isDead)
               {
                    Util.animateMovieClip(_mc,3);
                    MovieClip(_mc.mc.wings).gotoAndStop(1);
                    if(_mc.mc.body != null && _mc.mc.body.quiver != null)
                    {
                         MovieClip(_mc.mc.body.quiver).gotoAndStop(1);
                    }
                    else if(_mc.mc.quiver != null)
                    {
                         MovieClip(_mc.mc.quiver).gotoAndStop(1);
                    }
                    if(_mc.mc.arms != null)
                    {
                         _mc.mc.arms.gotoAndStop(1);
                    }
               }
               if(this.isCastleArcher)
               {
                    FlyingCrossbowman.setItem(mc,"Default","Basic Helmet","");
               }
               else if(this.flyingCrossbowmanType == "Blazing")
               {
                    FlyingCrossbowman.setItem(mc,"Lava Sleeve","Lava Helmet","Lava Wing");
               }
               else if(this.flyingCrossbowmanType == "Elite")
               {
                    FlyingCrossbowman.setItem(mc,"Gold Quiver 2","Gold Helmet 2","Metal Wing");
               }
               else if(this.flyingCrossbowmanType == "FrostBow")
               {
                    FlyingCrossbowman.setItem(mc,"Ice Quiver","Ice Helmet","Ice Wing");
               }
               else if(this.flyingCrossbowmanType == "LeafAlbow")
               {
                    FlyingCrossbowman.setItem(mc,"Leaf Quiver","Leaf Helmet","Leaf Wings");
               }
               else if(this.flyingCrossbowmanType == "SuperAlbow")
               {
                    FlyingCrossbowman.setItem(mc,"","","");
               }
               else if(this.flyingCrossbowmanType == "Icaron")
               {
                    FlyingCrossbowman.setItem(mc,"Icaron Quiver","Icaron","Blue Wing");
               }
               else
               {
                    FlyingCrossbowman.setItem(mc,"","","");
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(team.tech.isResearchedMap[Tech.CROSSBOW_FIRE])
               {
                    return _damageToArmour + int(team.game.xml.xml.Order.Units.flyingCrossbowman.fireDamageToArmour);
               }
               if(this.isCastleArcher)
               {
                    return 45 + int(team.game.xml.xml.Order.Units.flyingCrossbowman.fireDamageToArmour);
               }
               if(this.flyingCrossbowmanType == "Elite")
               {
                    return 145;
               }
               if(this.flyingCrossbowmanType == "SuperAlbow")
               {
                    return 145;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(team.tech.isResearchedMap[Tech.CROSSBOW_FIRE])
               {
                    return _damageToArmour + int(team.game.xml.xml.Order.Units.flyingCrossbowman.fireDamageToNotArmour);
               }
               if(this.isCastleArcher)
               {
                    return 45 + int(team.game.xml.xml.Order.Units.flyingCrossbowman.fireDamageToArmour);
               }
               if(this.flyingCrossbowmanType == "Elite")
               {
                    return 100;
               }
               if(this.flyingCrossbowmanType == "SuperAlbow")
               {
                    return 90;
               }
               return _damageToNotArmour;
          }
          
          override public function shoot(param1:StickWar, param2:Unit) : void
          {
               var _loc3_:MovieClip = null;
               var _loc4_:Point = null;
               if(_state != S_ATTACK)
               {
                    _loc3_ = _mc.mc.body.arms;
                    if(_loc3_.currentFrame != _loc3_.totalFrames)
                    {
                         return;
                    }
                    _loc3_.gotoAndStop(1);
                    this.bowFrame = 1;
                    _loc4_ = _loc3_.localToGlobal(new Point(0,0));
                    _loc4_ = param1.battlefield.globalToLocal(_loc4_);
                    param1.soundManager.playSoundRandom("launchArrow",4,px,py);
                    if(mc.scaleX < 0)
                    {
                         param1.projectileManager.initBolt(_loc4_.x,_loc4_.y,180 - bowAngle,projectileVelocity,param2.py,angleToTargetW(param2,projectileVelocity,angleToTarget(param2)),this,20,30 * 4,techTeam.tech.isResearched(Tech.CROSSBOW_FIRE),param2,this.fireDamage,this.fireFrames);
                    }
                    else
                    {
                         param1.projectileManager.initBolt(_loc4_.x,_loc4_.y,bowAngle,projectileVelocity,param2.py,angleToTargetW(param2,projectileVelocity,angleToTarget(param2)),this,20,30 * 4,techTeam.tech.isResearched(Tech.CROSSBOW_FIRE),param2,this.fireDamage,this.fireFrames);
                    }
               }
          }
          
          override public function mayAttack(param1:Unit) : Boolean
          {
               if(!this.isCastleArcher && team.direction * px < team.direction * (this.team.homeX + team.direction * 200))
               {
                    return false;
               }
               if(aimedAtUnit(param1,angleToTarget(param1)) && this.inRange(param1))
               {
                    return true;
               }
               return false;
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
                    isStationary = true;
               }
               this._isCastleArcher = param1;
          }
     }
}
