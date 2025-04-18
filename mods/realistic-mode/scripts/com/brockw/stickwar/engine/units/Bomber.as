package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.BomberAi;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     
     public class Bomber extends Unit
     {
           
          
          private var WEAPON_REACH:Number;
          
          private var explosionDamage:Number;
          
          public function Bomber(game:StickWar)
          {
               super(game);
               _mc = new _bomber();
               this.init(game);
               addChild(_mc);
               ai = new BomberAi(this);
               initSync();
               firstInit();
          }
          
          public static function setItem(mc:MovieClip, weapon:String, armor:String, misc:String) : void
          {
               var m:_bomber = _bomber(mc);
               if(Boolean(m.mc.dynamite2))
               {
                    if(weapon != "")
                    {
                         m.mc.dynamite2.gotoAndStop(weapon);
                         Util.animateMovieClipBasic(m.mc.dynamite2.mc);
                    }
               }
               if(Boolean(m.mc.dynamite))
               {
                    if(weapon != "")
                    {
                         m.mc.dynamite.gotoAndStop(weapon);
                         Util.animateMovieClipBasic(m.mc.dynamite.mc);
                    }
               }
               if(Boolean(m.mc.inner))
               {
                    if(Boolean(m.mc.inner.dynamite))
                    {
                         if(weapon != "")
                         {
                              m.mc.inner.dynamite.gotoAndStop(weapon);
                              Util.animateMovieClipBasic(m.mc.inner.dynamite.mc);
                         }
                    }
               }
               if(Boolean(m.mc.head))
               {
                    if(armor != "")
                    {
                         m.mc.head.gotoAndStop(armor);
                    }
               }
               if(Boolean(m.mc.top))
               {
                    if(Boolean(m.mc.top.head))
                    {
                         if(armor != "")
                         {
                              m.mc.top.head.gotoAndStop(armor);
                         }
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return 0;
          }
          
          override public function init(game:StickWar) : void
          {
               initBase();
               this.WEAPON_REACH = game.xml.xml.Chaos.Units.bomber.weaponReach;
               population = game.xml.xml.Chaos.Units.bomber.population;
               _mass = game.xml.xml.Chaos.Units.bomber.mass;
               _maxForce = game.xml.xml.Chaos.Units.bomber.maxForce;
               _dragForce = game.xml.xml.Chaos.Units.bomber.dragForce;
               _scale = game.xml.xml.Chaos.Units.bomber.scale;
               _maxVelocity = game.xml.xml.Chaos.Units.bomber.maxVelocity;
               damageToDeal = game.xml.xml.Chaos.Units.bomber.baseDamage;
               this.explosionDamage = game.xml.xml.Chaos.Units.bomber.explosionDamage;
               this.createTime = game.xml.xml.Chaos.Units.bomber.cooldown;
               maxHealth = health = game.xml.xml.Chaos.Units.bomber.health;
               loadDamage(game.xml.xml.Chaos.Units.bomber);
               type = Unit.U_BOMBER;
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
          
          override public function update(game:StickWar) : void
          {
               updateCommon(game);
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
                         damage(0,1000,null);
                    }
                    updateMotion(game);
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
                              this.team.removeUnit(this,game);
                              isDead = true;
                         }
                    }
                    else
                    {
                         this.detonate();
                         _mc.gotoAndStop(getDeathLabel(game));
                         this.team.removeUnit(this,game);
                         isDead = true;
                    }
               }
               Util.animateMovieClipBasic(mc.mc);
               if(isDead)
               {
                    _mc.gotoAndStop(getDeathLabel(game));
                    _mc.mc.alpha = 0;
               }
               if(!hasDefaultLoadout)
               {
                    Bomber.setItem(_bomber(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
          }
          
          public function detonate() : void
          {
               team.game.soundManager.playSoundRandom("mediumExplosion",3,px,py);
               this.damage(0,this.maxHealth,null);
               team.game.projectileManager.initNuke(px,py,this,this.explosionDamage);
          }
          
          override public function get damageToArmour() : Number
          {
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(a:ActionInterface) : void
          {
               super.setActionInterface(a);
               a.setAction(0,0,UnitCommand.BOMBER_DETONATE);
          }
          
          override public function attack() : void
          {
               if(_state != S_ATTACK)
               {
                    _state = S_ATTACK;
                    hasHit = false;
               }
          }
          
          override public function mayAttack(target:Unit) : Boolean
          {
               if(isIncapacitated())
               {
                    return false;
               }
               if(target == null)
               {
                    return false;
               }
               if(this.isDualing == true)
               {
                    return false;
               }
               if(_state == S_RUN)
               {
                    if(Math.abs(px - target.px) < this.WEAPON_REACH && Math.abs(py - target.py) < 40 && this.getDirection() == Util.sgn(target.px - px))
                    {
                         return true;
                    }
               }
               return false;
          }
     }
}
