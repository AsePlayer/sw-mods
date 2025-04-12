package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.GiantAi;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     
     public class Giant extends Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var scaleI:Number;
          
          private var scaleII:Number;
          
          public var giantType:String;
          
          private var setupComplete:Boolean;
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
          private var stunTime:int;
          
          private var hasGrowled:Boolean;
          
          public function Giant(game:StickWar)
          {
               super(game);
               _mc = new _giant();
               this.init(game);
               addChild(_mc);
               ai = new GiantAi(this);
               initSync();
               firstInit();
               this.giantType = "Default";
          }
          
          public static function setItem(mc:MovieClip, weapon:String, armor:String, misc:String) : void
          {
               var m:_giant = _giant(mc);
               if(m.mc.giantclub)
               {
                    if(weapon != "")
                    {
                         m.mc.giantclub.gotoAndStop(weapon);
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return WEAPON_REACH;
          }
          
          override public function init(game:StickWar) : void
          {
               initBase();
               WEAPON_REACH = game.xml.xml.Chaos.Units.giant.weaponReach;
               this.hasGrowled = false;
               population = game.xml.xml.Chaos.Units.giant.population;
               _mass = game.xml.xml.Chaos.Units.giant.mass;
               _maxForce = game.xml.xml.Chaos.Units.giant.maxForce;
               _dragForce = game.xml.xml.Chaos.Units.giant.dragForce;
               _scale = game.xml.xml.Chaos.Units.giant.scale;
               _maxVelocity = game.xml.xml.Chaos.Units.giant.maxVelocity;
               damageToDeal = game.xml.xml.Chaos.Units.giant.baseDamage;
               this.createTime = game.xml.xml.Chaos.Units.giant.cooldown;
               maxHealth = health = game.xml.xml.Chaos.Units.giant.health;
               this.maxTargetsToHit = game.xml.xml.Chaos.Units.giant.maxTargetsToHit;
               this.stunTime = game.xml.xml.Chaos.Units.giant.stunTime;
               this.scaleI = game.xml.xml.Chaos.Units.giant.growthIScale;
               this.scaleII = game.xml.xml.Chaos.Units.giant.growthIIScale;
               loadDamage(game.xml.xml.Chaos.Units.giant);
               type = Unit.U_GIANT;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.healthBar.y = -mc.mc.height * 1.1;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["GiantBuilding"];
          }
          
          override public function getDamageToDeal() : Number
          {
               return damageToDeal;
          }
          
          private function giantHit(unit:Unit) : *
          {
               if(this.targetsHit < this.maxTargetsToHit && unit.team != this.team)
               {
                    if(unit.px * mc.scaleX > px * mc.scaleX)
                    {
                         if(unit is Wall)
                         {
                              ++this.targetsHit;
                              unit.damage(0,this.damageToDeal,this);
                              unit.stun(this.stunTime);
                              unit.dx = 10 * Util.sgn(mc.scaleX);
                         }
                         else if(Math.pow(unit.px + unit.dx - dx - px,2) + Math.pow(unit.py + unit.dy - dy - py,2) < Math.pow(5 * unit.hitBoxWidth * (this.perspectiveScale + unit.perspectiveScale) / 2,2))
                         {
                              if(this.giantType == "IceGiant")
                              {
                                   unit.slow(30 * 3);
                              }
                              ++this.targetsHit;
                              unit.damage(0,this.damageToDeal,this);
                              unit.stun(this.stunTime);
                              unit.applyVelocity(7 * Util.sgn(mc.scaleX));
                         }
                    }
               }
          }
          
          override public function applyVelocity(xf:Number, yf:Number = 0, zf:Number = 0) : void
          {
          }
          
          override public function update(game:StickWar) : void
          {
               if(!this.hasGrowled)
               {
                    this.hasGrowled = true;
                    team.game.soundManager.playSoundRandom("GiantGrowl",6,px,py);
               }
               stunTimeLeft = 0;
               _dz = 0;
               if(team.tech.isResearched(Tech.CHAOS_GIANT_GROWTH_II))
               {
                    if(_scale != this.scaleII)
                    {
                         health = game.xml.xml.Chaos.Units.giant.healthI - (maxHealth - health);
                         maxHealth = game.xml.xml.Chaos.Units.giant.healthI;
                         healthBar.totalHealth = maxHealth;
                    }
                    _scale = this.scaleII;
               }
               else if(team.tech.isResearched(Tech.CHAOS_GIANT_GROWTH_I))
               {
                    if(_scale != this.scaleI)
                    {
                         health = game.xml.xml.Chaos.Units.giant.healthI - (maxHealth - health);
                         maxHealth = game.xml.xml.Chaos.Units.giant.healthI;
                         healthBar.totalHealth = maxHealth;
                    }
                    _scale = this.scaleI;
               }
               updateCommon(game);
               if(mc.mc.sword != null)
               {
                    mc.mc.sword.gotoAndStop(team.loadout.getItem(this.type,MarketItem.T_WEAPON));
               }
               if(this.giantType == "Griffin" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Mace","","");
                    maxHealth = 72050;
                    health = 72050;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 2;
                    _scale = 3.8;
                    this.maxTargetsToHit = 25;
                    this.setupComplete = true;
               }
               if(this.giantType == "FinalBoss" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Spike Club","","");
                    maxHealth = 74350;
                    health = 74350;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 3.8;
                    _maxVelocity = 2;
                    this.maxTargetsToHit = 30;
                    this.setupComplete = true;
               }
               if(this.giantType == "Boss_1" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Wood Club","","");
                    maxHealth = 1950;
                    health = 1950;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.7;
                    _maxVelocity = 2.3;
                    this.setupComplete = true;
               }
               if(this.giantType == "Boss_2" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Bone Club","","");
                    maxHealth = 5450;
                    health = 5450;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.7;
                    _maxVelocity = 2.3;
                    this.maxTargetsToHit = 4;
                    this.setupComplete = true;
               }
               if(this.giantType == "Boss_3" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Leaf Club","","");
                    maxHealth = 850;
                    health = 850;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.1;
                    _maxVelocity = 4.1;
                    this.maxTargetsToHit = 4;
                    this.setupComplete = true;
               }
               if(this.giantType == "Boss_4" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Vamp Club","","");
                    maxHealth = 4900;
                    health = 4900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.7;
                    _maxVelocity = 3;
                    this.maxTargetsToHit = 4;
                    this.setupComplete = true;
               }
               if(this.giantType == "Boss_5" && !this.setupComplete)
               {
                    Giant.setItem(_mc,"Lava Club","","");
                    maxHealth = 1050;
                    health = 1050;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.7;
                    _maxVelocity = 5;
                    this.heal(5,1);
                    this.setupComplete = true;
               }
               if(this.giantType == "IceGiant" && !this.setupComplete)
               {
                    freezeUnit = true;
                    Giant.setItem(_mc,"Ice Club","","");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.1;
                    _maxVelocity = 3.4;
                    this.maxTargetsToHit = 2;
                    this.setupComplete = true;
               }
               if(this.giantType != "")
               {
                    isCustomUnit = true;
               }
               if(this.giantType == "IceGiant")
               {
                    freezeUnit = true;
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
                         if(this.giantType == "Boss_3")
                         {
                              MovieClip(_mc.mc).nextFrame();
                         }
                    }
                    updateMotion(game);
               }
               else if(isDead == false)
               {
                    team.game.soundManager.playSoundRandom("GiantDeath",3,px,py);
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
               MovieClip(_mc.mc).nextFrame();
               _mc.mc.stop();
               if(this.giantType == "Griffin")
               {
                    Giant.setItem(_mc,"Mace","","");
               }
               else if(this.giantType == "FinalBoss")
               {
                    Giant.setItem(_mc,"Spike Club","","");
               }
               else if(this.giantType == "Boss_1")
               {
                    Giant.setItem(_mc,"Wood Club","","");
               }
               else if(this.giantType == "Boss_2")
               {
                    Giant.setItem(_mc,"Bone Club","","");
               }
               else if(this.giantType == "Boss_3")
               {
                    Giant.setItem(_mc,"Leaf Club","","");
               }
               else if(this.giantType == "Boss_4")
               {
                    Giant.setItem(_mc,"Vamp Club","","");
               }
               else if(this.giantType == "Boss_5")
               {
                    Giant.setItem(_mc,"Lava Club","","");
               }
               else if(this.giantType == "IceGiant")
               {
                    Giant.setItem(_mc,"Ice Club","","");
               }
               else
               {
                    Giant.setItem(_giant(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),"","");
               }
          }
          
          override public function canAttackAir() : Boolean
          {
               return true;
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.giantType == "Griffin")
               {
                    return 1200;
               }
               if(this.giantType == "FinalBoss")
               {
                    return 1200;
               }
               if(this.giantType == "Boss_1")
               {
                    return 10;
               }
               if(this.giantType == "Boss_2")
               {
                    return 90;
               }
               if(this.giantType == "Boss_3")
               {
                    return 175;
               }
               if(this.giantType == "Boss_4")
               {
                    return 75;
               }
               if(this.giantType == "Boss_5")
               {
                    return 10;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.giantType == "Griffin")
               {
                    return 950;
               }
               if(this.giantType == "FinalBoss")
               {
                    return 950;
               }
               if(this.giantType == "Boss_1")
               {
                    return 10;
               }
               if(this.giantType == "Boss_2")
               {
                    return 130;
               }
               if(this.giantType == "Boss_3")
               {
                    return 150;
               }
               if(this.giantType == "Boss_4")
               {
                    return 110;
               }
               if(this.giantType == "Boss_5")
               {
                    return 10;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(a:ActionInterface) : void
          {
               super.setActionInterface(a);
          }
          
          override public function faceDirection(dir:int) : void
          {
               if(_state != S_ATTACK)
               {
                    super.faceDirection(dir);
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
                    this.targetsHit = 0;
                    framesInAttack = MovieClip(_mc.mc).totalFrames;
                    attackStartFrame = team.game.frame;
               }
          }
          
          override public function mayAttack(target:Unit) : Boolean
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
