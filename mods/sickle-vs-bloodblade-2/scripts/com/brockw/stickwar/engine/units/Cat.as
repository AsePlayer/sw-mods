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
           
          
          public var catType:String;
          
          private var setupComplete:Boolean;
          
          private var hitsOnTarget:int;
          
          private var lastHitFrame:Number;
          
          private var packStacks:int;
          
          private var packDamagePerUnit:int;
          
          private var target:com.brockw.stickwar.engine.units.Unit;
          
          private var normalMaxVelocity:Number;
          
          private var upgradedMaxVelocity:Number;
          
          public function Cat(param1:StickWar)
          {
               super(param1);
               _mc = new _cat();
               this.init(param1);
               addChild(_mc);
               ai = new CatAi(this);
               initSync();
               firstInit();
               this.target = null;
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_cat = null;
               if((_loc5_ = _cat(param1)).mc.crawlerHead)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.crawlerHead.gotoAndStop(param2);
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
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               WEAPON_REACH = param1.xml.xml.Chaos.Units.cat.weaponReach;
               population = param1.xml.xml.Chaos.Units.cat.population;
               _mass = param1.xml.xml.Chaos.Units.cat.mass;
               _maxForce = param1.xml.xml.Chaos.Units.cat.maxForce;
               _dragForce = param1.xml.xml.Chaos.Units.cat.dragForce;
               _scale = param1.xml.xml.Chaos.Units.cat.scale;
               _maxVelocity = this.normalMaxVelocity = param1.xml.xml.Chaos.Units.cat.slowMaxVelocity;
               this.upgradedMaxVelocity = param1.xml.xml.Chaos.Units.cat.maxVelocity;
               damageToDeal = param1.xml.xml.Chaos.Units.cat.baseDamage;
               this.createTime = param1.xml.xml.Chaos.Units.cat.cooldown;
               maxHealth = health = param1.xml.xml.Chaos.Units.cat.health;
               loadDamage(param1.xml.xml.Chaos.Units.cat);
               this.packStacks = param1.xml.xml.Chaos.Units.cat.pack.stacks;
               this.packDamagePerUnit = param1.xml.xml.Chaos.Units.cat.pack.damagePerUnit;
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
               var _loc4_:* = undefined;
               var _loc1_:com.brockw.stickwar.engine.units.Unit = ai.getClosestTarget();
               if(_loc1_ == null)
               {
                    return false;
               }
               var _loc2_:int = Util.sgn(_loc1_.px - px);
               if(_mc.mc.tip == null)
               {
                    return false;
               }
               var _loc3_:Point = MovieClip(_mc.mc.tip).localToGlobal(new Point(0,0));
               if(_loc1_.checkForHitPoint(_loc3_,_loc1_))
               {
                    _loc4_ = Math.min(team.numberOfCats,this.packStacks);
                    if(!techTeam.tech.isResearched(Tech.CAT_PACK))
                    {
                         _loc4_ = 0;
                    }
                    _loc1_.damage(0,_loc4_ * this.packDamagePerUnit + this._damageToArmour,null);
                    _loc1_.poison(10);
                    ++this.hitsOnTarget;
                    this.lastHitFrame = team.game.frame;
                    this.target = _loc1_;
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
          
          override public function update(param1:StickWar) : void
          {
               updateCommon(param1);
               if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour = _damageToNotArmour / 3 * team.game.main.campaign.difficultyLevel + 1;
                    _damageToArmour = _damageToArmour / 3 * team.game.main.campaign.difficultyLevel + 1;
                    health = health / 5 * (team.game.main.campaign.difficultyLevel + 1);
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    enemyBuffed = true;
               }
               if(this.catType == "Cat_1" && !this.setupComplete)
               {
                    Cat.setItem(_mc,"Default","Blue Eyes","Default");
                    maxHealth = 250;
                    health = 250;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.catType == "AlphaCat" && !this.setupComplete)
               {
                    Cat.setItem(_mc,"Default","Blue Eyes","Default");
                    maxHealth = 550;
                    health = 550;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.14;
                    this.setupComplete = true;
               }
               if(this.catType == "PackLeader" && !this.setupComplete)
               {
                    Cat.setItem(_mc,"Xenomorph","","");
                    maxHealth = 800;
                    health = 800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.38;
                    this.setupComplete = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.catType == "AlphaCat")
                    {
                         this.packDamagePerUnit = 12;
                         this.packStacks = 25;
                         this.upgradedMaxVelocity = 11.6;
                         this.normalMaxVelocity = 6.6;
                    }
                    else if(this.catType == "Cat_1")
                    {
                         this.upgradedMaxVelocity = 10.6;
                         this.normalMaxVelocity = 7.6;
                    }
                    else if(this.catType == "PackLeader")
                    {
                         this.packDamagePerUnit = 20;
                         this.packStacks = 30;
                         this.upgradedMaxVelocity = 16.6;
                         this.normalMaxVelocity = 8.6;
                         stunTimeLeft = 0;
                    }
                    else
                    {
                         this.normalMaxVelocity = param1.xml.xml.Chaos.Units.cat.slowMaxVelocity;
                         this.packStacks = param1.xml.xml.Chaos.Units.cat.pack.stacks;
                         this.packDamagePerUnit = param1.xml.xml.Chaos.Units.cat.pack.damagePerUnit;
                         this.upgradedMaxVelocity = param1.xml.xml.Chaos.Units.cat.maxVelocity;
                    }
               }
               if(this.catType != "")
               {
                    isCustomUnit = true;
               }
               if(!techTeam.tech.isResearched(Tech.CAT_SPEED))
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
                                   param1.soundManager.playSound("sword1",px,py);
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
               Util.animateMovieClip(_mc);
               if(this.catType == "Cat_1")
               {
                    Cat.setItem(_mc,"Evil Crawler","","");
               }
               else if(this.catType == "AlphaCat")
               {
                    Cat.setItem(_mc,"Blue Eyes","","");
               }
               else if(this.catType == "PackLeader")
               {
                    Cat.setItem(_mc,"Xenomorph","","");
               }
               else
               {
                    Cat.setItem(_cat(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),"","");
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.catType == "PackLeader")
               {
                    return 20;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.catType == "PackLeader")
               {
                    return 35;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(techTeam.tech.isResearched(Tech.CAT_PACK))
               {
                    param1.setAction(0,0,UnitCommand.CAT_PACK);
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
                    attackStartFrame = team.game.frame;
                    framesInAttack = MovieClip(_mc.mc).totalFrames;
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
     }
}
