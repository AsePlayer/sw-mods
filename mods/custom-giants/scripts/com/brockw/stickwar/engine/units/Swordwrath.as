package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.SwordwrathAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     import flash.filters.GlowFilter;
     import flash.geom.ColorTransform;
     
     public class Swordwrath extends Unit
     {
          
          private static var WEAPON_REACH:int;
          
          private static var RAGE_COOLDOWN:int;
          
          private static var RAGE_EFFECT:int;
           
          
          private var healthLoss:int;
          
          private var damageIncrease:Number;
          
          private var rageSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var rageSpellGlow:GlowFilter;
          
          public var swordwrathType:String;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Swordwrath;
          
          private var setupComplete:Boolean;
          
          private var normalMaxVelocity:Number;
          
          private var rageMaxVelocity:Number;
          
          private var lastWasStanding:Boolean;
          
          public function Swordwrath(param1:StickWar)
          {
               super(param1);
               _mc = new _swordwrath();
               this.init(param1);
               addChild(_mc);
               ai = new SwordwrathAi(this);
               initSync();
               firstInit();
               this.rageSpellGlow = new GlowFilter();
               this.rageSpellGlow.color = 16711680;
               this.rageSpellGlow.blurX = 10;
               this.rageSpellGlow.blurY = 10;
               this.lastWasStanding = false;
               this.swordwrathType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_swordwrath = _swordwrath(param1);
               if(_loc5_.mc.sword)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.sword.gotoAndStop(param2);
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
               WEAPON_REACH = param1.xml.xml.Order.Units.swordwrath.weaponReach;
               population = param1.xml.xml.Order.Units.swordwrath.population;
               RAGE_COOLDOWN = param1.xml.xml.Order.Units.swordwrath.rage.cooldown;
               RAGE_EFFECT = param1.xml.xml.Order.Units.swordwrath.rage.effect;
               this.healthLoss = param1.xml.xml.Order.Units.swordwrath.rage.healthLoss;
               this.damageIncrease = param1.xml.xml.Order.Units.swordwrath.rage.damageIncrease;
               _mass = param1.xml.xml.Order.Units.swordwrath.mass;
               _maxForce = param1.xml.xml.Order.Units.swordwrath.maxForce;
               _dragForce = param1.xml.xml.Order.Units.swordwrath.dragForce;
               _scale = param1.xml.xml.Order.Units.swordwrath.scale;
               _maxVelocity = param1.xml.xml.Order.Units.swordwrath.maxVelocity;
               damageToDeal = param1.xml.xml.Order.Units.swordwrath.baseDamage;
               this.createTime = param1.xml.xml.Order.Units.swordwrath.cooldown;
               maxHealth = health = param1.xml.xml.Order.Units.swordwrath.health;
               loadDamage(param1.xml.xml.Order.Units.swordwrath);
               type = Unit.U_SWORDWRATH;
               this.normalMaxVelocity = _maxVelocity;
               this.rageMaxVelocity = param1.xml.xml.Order.Units.swordwrath.rage.rageMaxVelocity;
               this.rageSpell = new com.brockw.stickwar.engine.units.SpellCooldown(RAGE_EFFECT,RAGE_COOLDOWN,param1.xml.xml.Order.Units.swordwrath.rage.mana);
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
          
          override public function getDamageToDeal() : Number
          {
               if(this.rageSpell.inEffect())
               {
                    return 2 * damageToDeal;
               }
               if(this.swordwrathType == "Silver")
               {
                    return 18000 * damageToDeal;
               }
               if(this.swordwrathType == "Xiphos")
               {
                    return 18000 * damageToDeal;
               }
               return damageToDeal;
          }
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:String = null;
               var _loc69_:ColorTransform = this.mc.transform.colorTransform;
               this.rageSpell.update();
               updateCommon(param1);
               if(this.rageSpell.inEffect())
               {
                    _loc69_ = this.mc.transform.colorTransform;
                    this.rageSpellGlow.blurX = 9 + 6 * Util.sin(20 * Math.PI * this.rageSpell.timeRunning() / RAGE_EFFECT);
                    this.rageSpellGlow.blurY = 10;
                    this.mc.filters = [this.rageSpellGlow];
                    _loc69_.redOffset = 255;
                    _maxVelocity = this.rageMaxVelocity;
                    if(this.swordwrathType == "Xiphos")
                    {
                         poisonRegen = true;
                         isVampUnit = true;
                    }
               }
               else
               {
                    isVampUnit = false;
                    this.mc.filters = [];
                    _maxVelocity = this.normalMaxVelocity;
               }
               if(this.swordwrathType == "Sword_1" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"OG Sword Two","","");
                    maxHealth = 200;
                    health = 200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 3;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Xiphos" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xiphos Sword","","");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.3;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Sword_3" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Copper Sword","","");
                    maxHealth = 170;
                    health = 170;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5.5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Clubwrath" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"OG Sword One","","");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.4;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Silver" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Elvish Sword","","");
                    maxHealth = 300;
                    health = 300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Sword_4" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Steel Sword","","");
                    maxHealth = 1330;
                    health = 1330;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Minion" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Minion Pitchfork","","");
                    maxHealth = 150;
                    health = 150;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Xenophon" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xeno Sword","","");
                    maxHealth = 1706.25;
                    health = 1706.25;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Blood_Blade" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Blue Blade","","");
                    maxHealth = 6000;
                    health = 6000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "IceSword" && !this.setupComplete)
               {
                    freezeUnit = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Ice Sword","","");
                    maxHealth = 170;
                    health = 170;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.setupComplete = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.swordwrathType == "Sword_1")
                    {
                         _maxVelocity = 4.8;
                    }
                    else if(this.swordwrathType == "Xiphos")
                    {
                         _maxVelocity = 5;
                    }
                    else if(this.swordwrathType == "Sword_3")
                    {
                         stunTimeLeft = 0;
                         _maxVelocity = 5.4;
                    }
                    else if(this.swordwrathType == "Clubwrath")
                    {
                         stunTimeLeft = 0;
                         _maxVelocity = 3.8;
                    }
                    else if(this.swordwrathType == "Silver")
                    {
                         this.cure();
                         stunTimeLeft = 0;
                         _maxVelocity = 5;
                    }
                    else if(this.swordwrathType == "Sword_4")
                    {
                         _maxVelocity = 4.8;
                    }
                    else if(this.swordwrathType == "Minion")
                    {
                         _maxVelocity = 4;
                    }
                    else if(this.swordwrathType == "Xenophon")
                    {
                         _maxVelocity = 9.3;
                    }
                    else
                    {
                         _maxVelocity = param1.xml.xml.Order.Units.swordwrath.maxVelocity;
                    }
               }
               if(this.swordwrathType != "")
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
                              _loc2_ = _mc.currentFrameLabel;
                              if(!(_loc2_ == "stand" || _loc2_ == "stand_breath"))
                              {
                                   if(param1.random.nextNumber() < 0.1)
                                   {
                                        _mc.gotoAndStop("stand");
                                   }
                                   else
                                   {
                                        _mc.gotoAndStop("stand_breath");
                                   }
                              }
                         }
                    }
                    else if(_state == S_ATTACK)
                    {
                         if(mc.mc.swing != null)
                         {
                              team.game.soundManager.playSound("swordwrathSwing1",px,py);
                         }
                         if(!hasHit)
                         {
                              hasHit = this.checkForHit();
                         }
                         if(this.rageSpell.inEffect())
                         {
                              MovieClip(_mc.mc).nextFrame();
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
                    if(this.swordwrathType == "Blood_Blade")
                    {
                         team.game.projectileManager.initNuke(px,py,this,0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "Xenophon";
                         this.clusterLad.stun(45);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "Xenophon";
                         this.clusterLad.stun(45);
                         isDead = true;
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
                         _mc.gotoAndStop(this.getDeathLabel(param1));
                         this.team.removeUnit(this,param1);
                         isDead = true;
                    }
               }
               if(isDead || _isDualing)
               {
                    Util.animateMovieClip(_mc,0);
               }
               else
               {
                    if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                    {
                         MovieClip(_mc.mc).gotoAndStop(1);
                    }
                    MovieClip(_mc.mc).nextFrame();
               }
               if(this.swordwrathType == "Sword_1")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"OG Sword Two","Default","Default");
               }
               else if(this.swordwrathType == "Xiphos")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xiphos Sword","Default","Default");
               }
               else if(this.swordwrathType == "Sword_3")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Copper Sword","","");
               }
               else if(this.swordwrathType == "Clubwrath")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"OG Sword One","","");
               }
               else if(this.swordwrathType == "Silver")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Elvish Sword","","");
               }
               else if(this.swordwrathType == "Sword_4")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Steel Sword","","");
               }
               else if(this.swordwrathType == "Minion")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Minion Pitchfork","","");
               }
               else if(this.swordwrathType == "Xenophon")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xeno Sword","","");
               }
               else if(this.swordwrathType == "Blood_Blade")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Blue Blade","","");
               }
               else if(this.swordwrathType == "IceSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Ice Sword","","");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_swordwrath(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),"","");
               }
          }
          
          override protected function getDeathLabel(param1:StickWar) : String
          {
               if(arrowDeath)
               {
                    return "arrow_death";
               }
               if(isOnFire)
               {
                    return "fireDeath";
               }
               if(stoned)
               {
                    return "stone";
               }
               var _loc2_:int = team.game.random.nextInt() % this._deathLabels.length;
               return "death_" + this._deathLabels[_loc2_];
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.rageSpell.inEffect())
               {
                    return _damageToArmour + this.damageIncrease;
               }
               if(this.swordwrathType == "IceSword")
               {
                    return 40;
               }
               if(this.swordwrathType == "Silver")
               {
                    return 20;
               }
               if(this.swordwrathType == "Sword_3")
               {
                    return 10;
               }
               if(this.swordwrathType == "Xenophon")
               {
                    return 225;
               }
               if(this.swordwrathType == "Blood_Blade")
               {
                    return 165;
               }
               if(this.swordwrathType == "Xiphos")
               {
                    return 55;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.rageSpell.inEffect())
               {
                    return _damageToNotArmour + this.damageIncrease;
               }
               if(this.swordwrathType == "IceSword")
               {
                    return 40;
               }
               if(this.swordwrathType == "Xenophon")
               {
                    return 85;
               }
               if(this.swordwrathType == "Clubwrath")
               {
                    return 170;
               }
               if(this.swordwrathType == "Sword_3")
               {
                    return 5;
               }
               if(this.swordwrathType == "Silver")
               {
                    return 25;
               }
               if(this.swordwrathType == "Blood_Blade")
               {
                    return 105;
               }
               if(this.swordwrathType == "Xiphos")
               {
                    return 25;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(team.tech.isResearched(Tech.SWORDWRATH_RAGE) || this.swordwrathType == "Xiphos")
               {
                    param1.setAction(0,0,UnitCommand.SWORDWRATH_RAGE);
               }
          }
          
          public function rageCooldown() : Number
          {
               return this.rageSpell.cooldown();
          }
          
          public function rage() : void
          {
               if(health > 10 && team.tech.isResearched(Tech.SWORDWRATH_RAGE))
               {
                    if(this.rageSpell.spellActivate(team))
                    {
                         health -= this.healthLoss;
                         team.game.soundManager.playSoundRandom("Rage",3,px,py);
                    }
               }
               else if(health > 50 && this.swordwrathType == "Xiphos")
               {
                    if(this.rageSpell.spellActivate(team))
                    {
                         health += this.healthLoss;
                         team.game.soundManager.playSoundRandom("Rage",3,px,py);
                    }
               }
          }
          
          override public function attack() : void
          {
               var _loc1_:int = 0;
               if(_state != S_ATTACK)
               {
                    _loc1_ = team.game.random.nextInt() % this._attackLabels.length;
                    _mc.gotoAndStop("attack_" + "2");
                    MovieClip(_mc.mc).gotoAndStop(1);
                    _state = S_ATTACK;
                    hasHit = false;
                    attackStartFrame = team.game.frame;
                    if(this.rageSpell.inEffect())
                    {
                         framesInAttack = MovieClip(_mc.mc).totalFrames / 500;
                    }
                    else
                    {
                         framesInAttack = MovieClip(_mc.mc).totalFrames;
                    }
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
     }
}
