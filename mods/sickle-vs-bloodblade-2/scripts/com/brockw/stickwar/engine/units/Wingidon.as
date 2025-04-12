package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.WingidonAi;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     import flash.filters.GlowFilter;
     import flash.geom.Point;
     
     public class Wingidon extends RangedUnit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var wingidonSpeedSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var normalVelocity:Number;
          
          public var wingidonType:String;
          
          private var setupComplete:Boolean;
          
          private var windStrength:Number;
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var wingidonGlow:GlowFilter;
          
          private var shieldwallDamageReduction:Number;
          
          public function Wingidon(param1:StickWar)
          {
               super(param1);
               _mc = new _wingidon();
               this.init(param1);
               addChild(_mc);
               ai = new WingidonAi(this);
               initSync();
               firstInit();
               this.wingidonGlow = new GlowFilter();
               this.wingidonGlow.color = 16711680;
               this.wingidonGlow.blurX = 0;
               this.wingidonGlow.blurY = 0;
               this.wingidonType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_wingidon = null;
               if((_loc5_ = _wingidon(param1)).mc.body)
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
                         if(param4 != "")
                         {
                              _loc5_.mc.body.quiver.gotoAndStop(param4);
                         }
                    }
               }
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               this.projectileVelocity = param1.xml.xml.Chaos.Units.wingidon.arrowVelocity;
               population = param1.xml.xml.Chaos.Units.wingidon.population;
               _mass = param1.xml.xml.Chaos.Units.wingidon.mass;
               _maxForce = param1.xml.xml.Chaos.Units.wingidon.maxForce;
               _dragForce = param1.xml.xml.Chaos.Units.wingidon.dragForce;
               _scale = param1.xml.xml.Chaos.Units.wingidon.scale;
               this.createTime = param1.xml.xml.Chaos.Units.wingidon.cooldown;
               this.windStrength = param1.xml.xml.Chaos.Units.wingidon.win.sStrength;
               this.normalVelocity = _maxVelocity = param1.xml.xml.Chaos.Units.wingidon.maxVelocity;
               _maximumRange = param1.xml.xml.Chaos.Units.wingidon.maximumRange;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               maxHealth = health = param1.xml.xml.Chaos.Units.wingidon.health;
               type = Unit.U_WINGIDON;
               flyingHeight = 250 * 1;
               this.wingidonSpeedSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.wingidon.wind.effect,param1.xml.xml.Chaos.Units.wingidon.wind.cooldown,param1.xml.xml.Chaos.Units.wingidon.wind.mana);
               loadDamage(param1.xml.xml.Chaos.Units.wingidon);
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
                    MovieClip(mc.mc.body.wings1).gotoAndPlay(Math.floor(MovieClip(mc.mc.body.wings1).totalFrames * param1.random.nextNumber()));
                    MovieClip(mc.mc.body.wings2).gotoAndPlay(MovieClip(mc.mc.body.wings1).currentFrame);
               }
               drawShadow();
               this.healthBar.y = -mc.mc.height * 0.9;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["ArcheryBuilding"];
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
          }
          
          public function speedSpell() : void
          {
               if(this.wingidonSpeedSpell.spellActivate(team))
               {
               }
          }
          
          public function speedSpellCooldown() : Number
          {
               return this.wingidonSpeedSpell.cooldown();
          }
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:MovieClip = null;
               this.wingidonSpeedSpell.update();
               super.update(param1);
               updateCommon(param1);
               if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour = _damageToNotArmour / 2.7 * team.game.main.campaign.difficultyLevel + 1;
                    _damageToArmour = _damageToArmour / 2.9 * team.game.main.campaign.difficultyLevel + 1;
                    this.normalVelocity = _maxVelocity / 2.5 * (team.game.main.campaign.difficultyLevel + 1);
                    health = health / 3.2 * (team.game.main.campaign.difficultyLevel + 1);
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.05 - 0.05;
                    enemyBuffed = true;
               }
               if(this.wingidonType == "SuperWing_1" && !this.setupComplete)
               {
                    slowRegen = true;
                    Wingidon.setItem(mc,"","Crystal Helmet","Crystal Quiver");
                    maxHealth = 7000;
                    health = 7000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.4;
                    _maxVelocity = 6.9;
                    this.wingidonGlow.color = 65535;
                    this.wingidonGlow.blurX = 5;
                    this.wingidonGlow.blurY = 5;
                    this.mc.filters = [this.wingidonGlow];
                    this.setupComplete = true;
               }
               if(this.wingidonType == "SuperWing_2" && !this.setupComplete)
               {
                    Wingidon.setItem(mc,"","","");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.4;
                    _maxVelocity = 7.2;
                    this.setupComplete = true;
               }
               if(this.wingidonType == "SuperWing_3" && !this.setupComplete)
               {
                    Wingidon.setItem(mc,"","","");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.4;
                    _maxVelocity = 7;
                    this.setupComplete = true;
               }
               if(this.wingidonType == "SuperWing_4" && !this.setupComplete)
               {
                    Wingidon.setItem(mc,"","Crystal Helmet","Crystal Quiver");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 7;
                    this.setupComplete = true;
               }
               if(this.wingidonType != "")
               {
                    isCustomUnit = true;
               }
               if(isCustomUnit = true)
               {
                    if(this.wingidonType == "SuperWing_1")
                    {
                         this.projectileVelocity = 65;
                         _maximumRange = 1500;
                    }
                    else if(this.wingidonType == "SuperWing_4")
                    {
                         _maximumRange = 850;
                    }
                    else
                    {
                         _maximumRange = param1.xml.xml.Chaos.Units.wingidon.maximumRange;
                         this.projectileVelocity = param1.xml.xml.Chaos.Units.wingidon.arrowVelocity;
                    }
               }
               if(!isDieing)
               {
                    if(_mc.mc.body.legs != null)
                    {
                         _mc.mc.body.legs.rotation = getDirection() * _dx / _maxVelocity * param1.xml.xml.Chaos.Units.wingidon.legRotateAngleWhenFlying;
                         MovieClip(mc.mc.body.legs).nextFrame();
                         if(MovieClip(mc.mc.body.legs).currentFrame == MovieClip(mc.mc.body.legs).totalFrames)
                         {
                              MovieClip(mc.mc.body.legs).gotoAndStop(1);
                         }
                    }
                    if(mc.mc.body.wings1 != null)
                    {
                         if(this.wingidonSpeedSpell.inEffect())
                         {
                              MovieClip(mc.mc.body.wings1).nextFrame();
                              MovieClip(mc.mc.body.wings2).nextFrame();
                              param1.projectileManager.airEffects.push([px + team.direction * 100,py,team.direction * this.windStrength,team]);
                         }
                         MovieClip(mc.mc.body.wings1).nextFrame();
                         MovieClip(mc.mc.body.wings2).nextFrame();
                         if(MovieClip(mc.mc.body.wings1).currentFrame == MovieClip(mc.mc.body.wings1).totalFrames)
                         {
                              MovieClip(mc.mc.body.wings1).gotoAndStop(1);
                         }
                         if(MovieClip(mc.mc.body.wings2).currentFrame == MovieClip(mc.mc.body.wings2).totalFrames)
                         {
                              MovieClip(mc.mc.body.wings2).gotoAndStop(1);
                         }
                    }
                    updateMotion(param1);
                    _loc2_ = _mc.mc.body.arms;
                    if(_loc2_ != null)
                    {
                         if(_loc2_.currentFrame != 1)
                         {
                              _loc2_.nextFrame();
                              if(_loc2_.currentFrame == _loc2_.totalFrames)
                              {
                                   _loc2_.gotoAndStop(1);
                              }
                         }
                         _loc2_.rotation = bowAngle;
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
                         if(Math.abs(_dx) + Math.abs(_dy) > 0.1)
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
               if(!isDead && _mc.mc != null)
               {
                    MovieClip(_mc.mc).nextFrame();
                    if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                    {
                         MovieClip(_mc.mc).gotoAndStop(1);
                    }
               }
               if(!isDead && _mc.mc.wings1 != null)
               {
                    MovieClip(_mc.mc).gotoAndStop(_mc.mc.wings1.currentFrame);
               }
               if(isDead)
               {
                    Util.animateMovieClip(_mc,3);
                    if(_mc.mc.body != null && _mc.mc.body.quiver != null)
                    {
                         MovieClip(_mc.mc.body.quiver).gotoAndStop(1);
                    }
                    else if(_mc.mc.quiver != null)
                    {
                         MovieClip(_mc.mc.quiver).gotoAndStop(1);
                    }
               }
               if(this.wingidonType == "SuperWing_4")
               {
                    Wingidon.setItem(mc,"","Crystal Helmet","Crystal Quiver");
               }
               else if(this.wingidonType == "SuperWing_1")
               {
                    Wingidon.setItem(mc,"","Crystal Helmet","Crystal Quiver");
               }
               else
               {
                    Wingidon.setItem(mc,team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.wingidonType == "SuperWing_2")
               {
                    return 115;
               }
               if(this.wingidonType == "SuperWing_4")
               {
                    return 135;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.wingidonType == "SuperWing_2")
               {
                    return 135;
               }
               if(this.wingidonType == "SuperWing_4")
               {
                    return 120;
               }
               return _damageToNotArmour;
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
               if(this.wingidonType == "")
               {
                    this.isBlocking = true;
                    this.inBlock = true;
               }
          }
          
          override public function mayAttack(param1:Unit) : Boolean
          {
               if(isIncapacitated())
               {
                    return false;
               }
               if(this.wingidonSpeedSpell.inEffect())
               {
                    return false;
               }
               return super.mayAttack(param1);
          }
          
          override public function shoot(param1:StickWar, param2:Unit) : void
          {
               var _loc3_:MovieClip = null;
               var _loc4_:Point = null;
               if(_state != S_ATTACK)
               {
                    _loc3_ = _mc.mc.body.arms;
                    if(_loc3_.currentFrame != 1)
                    {
                         return;
                    }
                    param1.soundManager.playSoundRandom("launchArrow",4,px,py);
                    _loc3_.nextFrame();
                    _loc4_ = _loc3_.localToGlobal(new Point(0,0));
                    _loc4_ = param1.battlefield.globalToLocal(_loc4_);
                    if(mc.scaleX < 0)
                    {
                         param1.projectileManager.initBolt(_loc4_.x,_loc4_.y,180 - _loc3_.rotation,projectileVelocity,param2.py,angleToTargetW(param2,projectileVelocity,angleToTarget(param2)),this,20,30 * 4,false,param2,0,0);
                    }
                    else
                    {
                         param1.projectileManager.initBolt(_loc4_.x,_loc4_.y,_loc3_.rotation,projectileVelocity,param2.py,angleToTargetW(param2,projectileVelocity,angleToTarget(param2)),this,20,30 * 4,false,param2,0,0);
                    }
               }
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.wingidonType == "SuperWing_2")
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
               }
          }
          
          override public function walk(param1:Number, param2:Number, param3:int) : void
          {
               if(isAbleToWalk() && !this.wingidonSpeedSpell.inEffect())
               {
                    baseWalk(param1,param2,param3);
               }
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
