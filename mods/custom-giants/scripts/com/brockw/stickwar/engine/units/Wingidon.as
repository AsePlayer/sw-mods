package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.WingidonAi;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     import flash.geom.Point;
     
     public class Wingidon extends RangedUnit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var wingidonSpeedSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          public var wingidonType:String;
          
          private var setupComplete:Boolean;
          
          private var normalVelocity:Number;
          
          private var windStrength:Number;
          
          public function Wingidon(param1:StickWar)
          {
               super(param1);
               _mc = new _wingidon();
               this.init(param1);
               addChild(_mc);
               ai = new WingidonAi(this);
               initSync();
               firstInit();
               this.wingidonType = "Default";
          }
          
          public static function setItem(mc:MovieClip, weapon:String, armor:String, misc:String) : void
          {
               var m:_wingidon = _wingidon(mc);
               if(m.mc.body)
               {
                    if(m.mc.body.head)
                    {
                         if(armor != "")
                         {
                              m.mc.body.head.gotoAndStop(armor);
                         }
                    }
                    if(m.mc.body.quiver)
                    {
                         if(misc != "")
                         {
                              m.mc.body.quiver.gotoAndStop(misc);
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
               var arms:MovieClip = null;
               this.wingidonSpeedSpell.update();
               super.update(param1);
               updateCommon(param1);
               if(this.wingidonType == "Shadowing" && !this.setupComplete)
               {
                    Wingidon.setItem(mc,"Default","Gold Hat","Vamp Quiver");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 6.2;
                    this.setupComplete = true;
               }
               if(this.wingidonType == "ShadowClone_1" && !this.setupComplete)
               {
                    Wingidon.setItem(mc,"Default","Demon Mask","Demon Quiver");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.wingidonType == "ShadowClone_2" && !this.setupComplete)
               {
                    Wingidon.setItem(mc,"Default","Metal Hat","Wood Quiver");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 6.8;
                    this.setupComplete = true;
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
                    arms = _mc.mc.body.arms;
                    if(arms != null)
                    {
                         if(arms.currentFrame != 1)
                         {
                              arms.nextFrame();
                              if(arms.currentFrame == arms.totalFrames)
                              {
                                   arms.gotoAndStop(1);
                              }
                         }
                         arms.rotation = bowAngle;
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
               if(this.wingidonType == "Shadowing")
               {
                    Wingidon.setItem(mc,"Default","Gold Hat","Vamp Quiver");
               }
               else if(this.wingidonType == "ShadowClone_1")
               {
                    Wingidon.setItem(mc,"Default","Demon Mask","Demon Quiver");
               }
               else if(this.wingidonType == "ShadowClone_2")
               {
                    Wingidon.setItem(mc,"Default","Metal Hat","Wood Quiver");
               }
               else
               {
                    Wingidon.setItem(mc,team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.wingidonType == "Shadowing")
               {
                    return 80;
               }
               if(this.wingidonType == "ShadowClone_1")
               {
                    return 40;
               }
               if(this.wingidonType == "ShadowClone_2")
               {
                    return 40;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.wingidonType == "Shadowing")
               {
                    return 98;
               }
               if(this.wingidonType == "ShadowClone_1")
               {
                    return 60;
               }
               if(this.wingidonType == "ShadowClone_2")
               {
                    return 60;
               }
               return _damageToNotArmour;
          }
          
          override public function mayAttack(target:Unit) : Boolean
          {
               if(isIncapacitated())
               {
                    return false;
               }
               if(this.wingidonSpeedSpell.inEffect())
               {
                    return false;
               }
               return super.mayAttack(target);
          }
          
          override public function shoot(param1:StickWar, target:Unit) : void
          {
               var arms:MovieClip = null;
               var p:Point = null;
               if(_state != S_ATTACK)
               {
                    arms = _mc.mc.body.arms;
                    if(arms.currentFrame != 1)
                    {
                         return;
                    }
                    param1.soundManager.playSoundRandom("launchArrow",4,px,py);
                    arms.nextFrame();
                    p = arms.localToGlobal(new Point(0,0));
                    p = param1.battlefield.globalToLocal(p);
                    if(mc.scaleX < 0)
                    {
                         param1.projectileManager.initBolt(p.x,p.y,180 - arms.rotation,projectileVelocity,target.py,angleToTargetW(target,projectileVelocity,angleToTarget(target)),this,20,30 * 4,false);
                    }
                    else
                    {
                         param1.projectileManager.initBolt(p.x,p.y,arms.rotation,projectileVelocity,target.py,angleToTargetW(target,projectileVelocity,angleToTarget(target)),this,20,30 * 4,false);
                    }
               }
          }
          
          override public function walk(x:Number, y:Number, intendedX:int) : void
          {
               if(isAbleToWalk() && !this.wingidonSpeedSpell.inEffect())
               {
                    baseWalk(x,y,intendedX);
               }
          }
     }
}
