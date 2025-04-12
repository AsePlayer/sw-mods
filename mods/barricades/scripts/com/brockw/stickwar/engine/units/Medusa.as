package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.MedusaAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.DisplayObject;
     import flash.display.MovieClip;
     import flash.utils.Dictionary;
     
     public class Medusa extends com.brockw.stickwar.engine.units.Unit
     {
           
          
          private var WEAPON_REACH:int;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var snakeFrames:Dictionary;
          
          private var poisonSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var stoneSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var inPoisonSpell:Boolean;
          
          private var inStoneSpell:Boolean;
          
          private var targetUnit:com.brockw.stickwar.engine.units.Unit;
          
          public var medusaType:String;
          
          private var knight:com.brockw.stickwar.engine.units.Knight;
          
          private var setupComplete:Boolean;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Medusa;
          
          private var spellX:Number;
          
          private var spellY:Number;
          
          public function Medusa(param1:StickWar)
          {
               super(param1);
               _mc = new _medusaMc();
               this.snakeFrames = new Dictionary();
               this.init(param1);
               addChild(_mc);
               ai = new MedusaAi(this);
               initSync();
               firstInit();
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_medusaMc = null;
               if((_loc5_ = _medusaMc(param1)).mc.medusacape)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.medusacape.gotoAndStop(param3);
                    }
               }
               if(_loc5_.mc.medusacrown)
               {
                    if(param4 != "")
                    {
                         _loc5_.mc.medusacrown.gotoAndStop(param4);
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return this.WEAPON_REACH;
          }
          
          override public function playDeathSound() : void
          {
               team.game.soundManager.playSoundRandom("Medusa",3,px,py);
          }
          
          override public function init(param1:StickWar) : void
          {
               var _loc3_:DisplayObject = null;
               initBase();
               isStoneable = false;
               this.WEAPON_REACH = param1.xml.xml.Chaos.Units.medusa.weaponReach;
               this.radiantDamage = param1.xml.xml.Elemental.Units.lavaElement.radiant.damage;
               this.radiantRange = param1.xml.xml.Elemental.Units.lavaElement.radiant.range;
               this.radiantFrames = param1.xml.xml.Elemental.Units.lavaElement.radiant.frames;
               population = param1.xml.xml.Chaos.Units.medusa.population;
               _mass = param1.xml.xml.Chaos.Units.medusa.mass;
               _maxForce = param1.xml.xml.Chaos.Units.medusa.maxForce;
               _dragForce = param1.xml.xml.Chaos.Units.medusa.dragForce;
               _scale = param1.xml.xml.Chaos.Units.medusa.scale;
               _maxVelocity = param1.xml.xml.Chaos.Units.medusa.maxVelocity;
               damageToDeal = param1.xml.xml.Chaos.Units.medusa.baseDamage;
               this.createTime = param1.xml.xml.Chaos.Units.medusa.cooldown;
               maxHealth = health = param1.xml.xml.Chaos.Units.medusa.health;
               loadDamage(param1.xml.xml.Chaos.Units.medusa);
               type = com.brockw.stickwar.engine.units.Unit.U_MEDUSA;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.inPoisonSpell = this.inStoneSpell = false;
               var _loc2_:int = 0;
               while(_loc2_ < _mc.mc.snakes.numChildren)
               {
                    _loc3_ = _mc.mc.snakes.getChildAt(_loc2_);
                    if(_loc3_ is MovieClip)
                    {
                         this.snakeFrames[_loc3_.name] = int(param1.random.nextNumber() * MovieClip(_loc3_).totalFrames);
                    }
                    _loc2_++;
               }
               this.poisonSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.medusa.poison.effect,param1.xml.xml.Chaos.Units.medusa.poison.cooldown,param1.xml.xml.Chaos.Units.medusa.poison.mana);
               this.stoneSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.medusa.stone.effect,param1.xml.xml.Chaos.Units.medusa.stone.cooldown,param1.xml.xml.Chaos.Units.medusa.stone.mana);
          }
          
          override public function canAttackAir() : Boolean
          {
               return true;
          }
          
          override public function isBusy() : Boolean
          {
               return !this.notInSpell() || isBusyForSpell;
          }
          
          private function notInSpell() : Boolean
          {
               return !this.inPoisonSpell && !this.inStoneSpell;
          }
          
          public function poisonSpray() : void
          {
               if(!techTeam.tech.isResearched(Tech.MEDUSA_POISON))
               {
                    return;
               }
               if(this.poisonSpell.spellActivate(team))
               {
                    team.game.soundManager.playSound("acidPoolSound",px,py);
                    this.inPoisonSpell = true;
                    _state = S_ATTACK;
               }
          }
          
          public function poisonPoolCooldown() : Number
          {
               return this.poisonSpell.cooldown();
          }
          
          public function stoneCooldown() : Number
          {
               return this.stoneSpell.cooldown();
          }
          
          public function stone(param1:com.brockw.stickwar.engine.units.Unit) : void
          {
               if(this.stoneSpell.spellActivate(team))
               {
                    team.game.soundManager.playSound("medusaPetrifySound",px,py);
                    this.inStoneSpell = true;
                    this.targetUnit = param1;
                    _state = S_ATTACK;
               }
          }
          
          private function burnInArea(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team)
               {
                    if(this.medusaType == "MedusaSummoner")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(this.inPoisonSpell == true)
                              {
                                   if(_mc.mc.currentFrame == 12)
                                   {
                                        this.team.game.projectileManager.initLightning(this,param1,this);
                                   }
                              }
                         }
                    }
               }
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["MedusaBuilding"];
          }
          
          override public function getDamageToDeal() : Number
          {
               return damageToDeal;
          }
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:int = 0;
               var _loc3_:DisplayObject = null;
               this.poisonSpell.update();
               this.stoneSpell.update();
               updateCommon(param1);
               poisonRegen = true;
               if(this.medusaType == "MedusaSummoner")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               if(!isUC)
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.medusa.maxVelocity;
               }
               if(isUC)
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.medusa.maxVelocity * 1.2;
                    _damageToNotArmour = (Number(param1.xml.xml.Chaos.Units.medusa.damage) + Number(param1.xml.xml.Chaos.Units.medusa.toNotArmour)) * 35;
                    _damageToArmour = (Number(param1.xml.xml.Chaos.Units.medusa.damage) + Number(param1.xml.xml.Chaos.Units.medusa.toArmour)) * 35;
                    _mass = Number(param1.xml.xml.Chaos.Units.medusa.mass) / 2;
               }
               else if(!team.isEnemy)
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.medusa.maxVelocity * 4;
                    _damageToNotArmour = Number(param1.xml.xml.Chaos.Units.medusa.damage) + Number(param1.xml.xml.Chaos.Units.medusa.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Chaos.Units.medusa.damage) + Number(param1.xml.xml.Chaos.Units.medusa.toArmour);
                    _mass = param1.xml.xml.Chaos.Units.medusa.mass;
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    health *= 1;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.01 - 0.01;
                    enemyBuffed = true;
               }
               if(this.medusaType == "MedusaClone" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Medusa.setItem(_mc,"","","");
                    maxHealth = 2800;
                    health = 2800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.9;
                    this.setupComplete = true;
               }
               if(this.medusaType == "MedusaSummoner" && !this.setupComplete)
               {
                    GeneralIsVoltaic = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    RefuseToDie = true;
                    com.brockw.stickwar.engine.units.Medusa.setItem(_mc,"","","");
                    maxHealth = 7500;
                    health = 7500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.5;
                    this.radiantRange = 1000;
                    this.setupComplete = true;
               }
               if(this.medusaType != "")
               {
                    isCustomUnit = true;
               }
               isCustomUnit = true;
               if(isUC)
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.medusa.maxVelocity * 1.2;
               }
               else
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.medusa.maxVelocity;
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
                    else if(this.inPoisonSpell)
                    {
                         _mc.gotoAndStop("poisonAttack");
                         if(MovieClip(_mc.mc).currentFrame == 3)
                         {
                              param1.projectileManager.initPoisonPool(this.px,this.py,this,0);
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                              this.inPoisonSpell = false;
                         }
                    }
                    else if(this.inStoneSpell)
                    {
                         _mc.gotoAndStop("stoneAttack");
                         if(MovieClip(_mc.mc).currentFrame == 20)
                         {
                              if(this.targetUnit)
                              {
                                   if(this.targetUnit.type == com.brockw.stickwar.engine.units.Unit.U_MEDUSA)
                                   {
                                        if(this.medusaType == "MedusaSummoner")
                                        {
                                             this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToArmour * 6);
                                        }
                                        else
                                        {
                                             this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToArmour / 25);
                                        }
                                   }
                                   else if(this.targetUnit.isArmoured)
                                   {
                                        if(this.medusaType == "MedusaSummoner")
                                        {
                                             this.team.game.projectileManager.initLightning(this,this.targetUnit,this);
                                             this.team.game.projectileManager.initLightning(this,this.targetUnit,this);
                                             this.team.game.projectileManager.initLightning(this,this.targetUnit,this);
                                             this.team.game.projectileManager.initLightning(this,this.targetUnit,this);
                                             this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToArmour * 2);
                                        }
                                        else if(isUC)
                                        {
                                             this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToArmour * 6);
                                        }
                                        else
                                        {
                                             this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToArmour);
                                        }
                                   }
                                   else
                                   {
                                        this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToArmour);
                                   }
                              }
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                              this.inStoneSpell = false;
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
                         if(MovieClip(_mc.mc).currentFrame > MovieClip(_mc.mc).totalFrames / 2 && !hasHit)
                         {
                              hasHit = this.checkForHit();
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
                    if(this.medusaType == "MedusaClone")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_MEDUSA);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 75;
                         this.clusterLad.py = py;
                         this.clusterLad.medusaType = "Default";
                         this.clusterLad.stun(5);
                    }
                    isDead = true;
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
               if(!isDead)
               {
                    _loc2_ = 0;
                    while(_loc2_ < _mc.mc.snakes.numChildren)
                    {
                         _loc3_ = _mc.mc.snakes.getChildAt(_loc2_);
                         if(_loc3_ is MovieClip)
                         {
                              this.snakeFrames[_loc3_.name] = (this.snakeFrames[_loc3_.name] + 1) % MovieClip(_loc3_).totalFrames;
                              MovieClip(_loc3_).gotoAndStop(this.snakeFrames[_loc3_.name]);
                         }
                         _loc2_++;
                    }
                    if(_mc.mc.multisnakes2 != null)
                    {
                         _mc.mc.multisnakes2.gotoAndStop((_mc.mc.multisnakes1.currentFrame + 10) % _mc.mc.multisnakes1.totalFrames);
                    }
               }
               Util.animateMovieClip(_mc);
               if(this.medusaType == "MedusaSummoner")
               {
                    com.brockw.stickwar.engine.units.Medusa.setItem(_mc,"","Volt Cape","Volt Crown");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Medusa.setItem(_mc,"","","");
               }
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               param1.setAction(0,0,UnitCommand.STONE);
               if(techTeam.tech.isResearched(Tech.MEDUSA_POISON))
               {
                    param1.setAction(1,0,UnitCommand.POISON_POOL);
               }
          }
          
          public function enableSuperMedusa() : void
          {
               this.health = this.maxHealth = team.game.xml.xml.Chaos.Units.medusa.superHealth;
               this.scale = team.game.xml.xml.Chaos.Units.medusa.superScale;
               _damageToArmour = team.game.xml.xml.Chaos.Units.medusa.superDamage;
               _damageToNotArmour = team.game.xml.xml.Chaos.Units.medusa.superDamage;
               this.stoneSpell = new com.brockw.stickwar.engine.units.SpellCooldown(team.game.xml.xml.Chaos.Units.medusa.stone.effect,team.game.xml.xml.Chaos.Units.medusa.stone.superCooldown,team.game.xml.xml.Chaos.Units.medusa.stone.mana);
               maxHealth = this.maxHealth;
               healthBar.totalHealth = maxHealth;
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.medusaType == "MedusaClone")
               {
                    return 1750;
               }
               if(this.medusaType == "MedusaSummoner")
               {
                    return 250;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.medusaType == "MedusaClone")
               {
                    return 3150;
               }
               if(this.medusaType == "MedusaSummoner")
               {
                    return 250;
               }
               return _damageToNotArmour;
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
                    if(Math.abs(px - param1.px) < this.WEAPON_REACH && Math.abs(py - param1.py) < 40 && this.getDirection() == Util.sgn(param1.px - px))
                    {
                         return true;
                    }
               }
               return false;
          }
          
          override public function stateFixForCutToWalk() : void
          {
               if(!this.inPoisonSpell && !this.inStoneSpell)
               {
                    super.stateFixForCutToWalk();
                    this.inPoisonSpell = false;
                    this.inStoneSpell = false;
               }
          }
     }
}
