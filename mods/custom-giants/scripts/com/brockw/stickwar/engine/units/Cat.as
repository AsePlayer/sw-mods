package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.CatAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     import flash.geom.Point;
     
     public class Cat extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var hitsOnTarget:int;
          
          private var lastHitFrame:Number;
          
          private var packStacks:int;
          
          private var packDamagePerUnit:int;
          
          public var catType:String;
          
          private var setupComplete:Boolean;
          
          private var target:com.brockw.stickwar.engine.units.Unit;
          
          private var normalMaxVelocity:Number;
          
          private var upgradedMaxVelocity:Number;
          
          public function Cat(game:StickWar)
          {
               super(game);
               _mc = new _cat();
               this.init(game);
               addChild(_mc);
               ai = new CatAi(this);
               initSync();
               firstInit();
               this.target = null;
               this.catType = "Default";
          }
          
          public static function setItem(mc:MovieClip, weapon:String, armor:String, misc:String) : void
          {
               var m:_cat = _cat(mc);
               if(m.mc.crawlerHead)
               {
                    if(weapon != "")
                    {
                         m.mc.crawlerHead.gotoAndStop(weapon);
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return WEAPON_REACH;
          }
          
          override public function playDeathSound() : void
          {
               team.game.soundManager.playSoundRandom("CrawlerDeath",3,px,py);
          }
          
          override public function init(game:StickWar) : void
          {
               initBase();
               WEAPON_REACH = game.xml.xml.Chaos.Units.cat.weaponReach;
               population = game.xml.xml.Chaos.Units.cat.population;
               _mass = game.xml.xml.Chaos.Units.cat.mass;
               _maxForce = game.xml.xml.Chaos.Units.cat.maxForce;
               _dragForce = game.xml.xml.Chaos.Units.cat.dragForce;
               _scale = game.xml.xml.Chaos.Units.cat.scale;
               _maxVelocity = this.normalMaxVelocity = game.xml.xml.Chaos.Units.cat.slowMaxVelocity;
               this.upgradedMaxVelocity = game.xml.xml.Chaos.Units.cat.maxVelocity;
               damageToDeal = game.xml.xml.Chaos.Units.cat.baseDamage;
               this.createTime = game.xml.xml.Chaos.Units.cat.cooldown;
               maxHealth = health = game.xml.xml.Chaos.Units.cat.health;
               loadDamage(game.xml.xml.Chaos.Units.cat);
               this.packStacks = game.xml.xml.Chaos.Units.cat.pack.stacks;
               this.packDamagePerUnit = game.xml.xml.Chaos.Units.cat.pack.damagePerUnit;
               type = com.brockw.stickwar.engine.units.Unit.U_CAT;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               pheight = 150;
          }
          
          override protected function checkForHit() : Boolean
          {
               var packBonus:* = undefined;
               var target:com.brockw.stickwar.engine.units.Unit = ai.getClosestTarget();
               if(target == null)
               {
                    return false;
               }
               var dir:int = Util.sgn(target.px - px);
               if(_mc.mc.tip == null)
               {
                    return false;
               }
               var p2:Point = MovieClip(_mc.mc.tip).localToGlobal(new Point(0,0));
               if(target.checkForHitPoint(p2,target))
               {
                    packBonus = Math.min(team.numberOfCats,this.packStacks);
                    if(!team.tech.isResearched(Tech.CAT_PACK))
                    {
                         packBonus = 0;
                    }
                    target.damage(0,packBonus * this.packDamagePerUnit + this._damageToArmour,null);
                    ++this.hitsOnTarget;
                    this.lastHitFrame = team.game.frame;
                    this.target = target;
                    return true;
               }
               return false;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["BarracksBuilding"];
          }
          
          override public function getDamageToDeal() : Number
          {
               return damageToDeal;
          }
          
          override public function update(game:StickWar) : void
          {
               updateCommon(game);
               if(!team.tech.isResearched(Tech.CAT_SPEED))
               {
                    _maxVelocity = this.normalMaxVelocity;
               }
               else
               {
                    _maxVelocity = this.upgradedMaxVelocity;
               }
               if(mc.mc.sword != null)
               {
                    mc.mc.sword.gotoAndStop(team.loadout.getItem(this.type,MarketItem.T_WEAPON));
               }
               if(this.catType == "Cat_1" && !this.setupComplete)
               {
                    Cat.setItem(_mc,"Default","Evil Crawler","Default");
                    maxHealth = 150;
                    health = 150;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    _maxVelocity = 3.7;
                    this.setupComplete = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.catType == "Cat_1")
                    {
                         _maxVelocity = 4;
                    }
                    else
                    {
                         _maxVelocity = this.normalMaxVelocity = game.xml.xml.Chaos.Units.cat.slowMaxVelocity;
                    }
               }
               if(this.catType != "")
               {
                    isCustomUnit = true;
               }
               if(!isDieing)
               {
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.attackLabel);
                         _dualPartner.px += (this.px + _currentDual.xDiff * this.scaleX * this._scale * _worldScaleX * this.perspectiveScale * -Util.sgn(this.px - _dualPartner.px) - _dualPartner.px) * 0.1;
                         _dualPartner.py += (py - _dualPartner.py) * 0.2;
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
                         if(!hasHit)
                         {
                              hasHit = this.checkForHit();
                              if(hasHit)
                              {
                                   game.soundManager.playSound("sword1",px,py);
                              }
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
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
                         _mc.gotoAndStop(getDeathLabel(game));
                         this.team.removeUnit(this,game);
                         isDead = true;
                    }
               }
               if(!isDead && MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
               {
                    MovieClip(_mc.mc).gotoAndStop(1);
               }
               Util.animateMovieClip(_mc);
               if(this.catType == "Cat_1")
               {
                    Cat.setItem(_mc,"Default","Evil Crawler","Default");
               }
               else
               {
                    Cat.setItem(_cat(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),"","");
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.catType == "Cat_1")
               {
                    return _damageToArmour + 585;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.catType == "Cat_1")
               {
                    return _damageToNotArmour + 145;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(a:ActionInterface) : void
          {
               super.setActionInterface(a);
               if(team.tech.isResearched(Tech.CAT_PACK))
               {
                    a.setAction(0,0,UnitCommand.CAT_PACK);
               }
          }
          
          override public function attack() : void
          {
               var id:int = 0;
               if(_state != S_ATTACK)
               {
                    id = team.game.random.nextInt() % this._attackLabels.length;
                    _mc.gotoAndStop("attack_" + this._attackLabels[id]);
                    MovieClip(_mc.mc).gotoAndStop(1);
                    _state = S_ATTACK;
                    hasHit = false;
                    attackStartFrame = team.game.frame;
                    framesInAttack = MovieClip(_mc.mc).totalFrames;
               }
          }
          
          override public function mayAttack(target:com.brockw.stickwar.engine.units.Unit) : Boolean
          {
               if(framesInAttack > team.game.frame - attackStartFrame)
               {
                    return false;
               }
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
                    if(Math.abs(px - target.px) < WEAPON_REACH && Math.abs(py - target.py) < 40 && this.getDirection() == Util.sgn(target.px - px))
                    {
                         return true;
                    }
               }
               return false;
          }
     }
}
