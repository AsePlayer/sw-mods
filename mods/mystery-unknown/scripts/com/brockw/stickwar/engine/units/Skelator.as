package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.SkelatorAi;
     import com.brockw.stickwar.engine.Ai.command.StandCommand;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.filters.GlowFilter;
     
     public class Skelator extends com.brockw.stickwar.engine.units.Unit
     {
           
          
          private var WEAPON_REACH:Number;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var fistAttackSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var reaperSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var isFistAttacking:Boolean;
          
          private var isReaperSpell:Boolean;
          
          public var skelatorType:String;
          
          private var setupComplete:Boolean;
          
          private var spellX:Number;
          
          private var spellY:Number;
          
          private var target:com.brockw.stickwar.engine.units.Unit;
          
          private var _fistDamage:Number;
          
          private var Toxic:com.brockw.stickwar.engine.units.Dead;
          
          private var DeadBoss:com.brockw.stickwar.engine.units.Dead;
          
          private var bomber:com.brockw.stickwar.engine.units.Bomber;
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var castSpellGlow:GlowFilter;
          
          private var Undead_2:com.brockw.stickwar.engine.units.Spearton;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Cat;
          
          public function Skelator(param1:StickWar)
          {
               super(param1);
               _mc = new _skelator();
               this.init(param1);
               addChild(_mc);
               ai = new SkelatorAi(this);
               initSync();
               firstInit();
               this.castSpellGlow = new GlowFilter();
               this.castSpellGlow.color = 16711680;
               this.castSpellGlow.blurX = 10;
               this.castSpellGlow.blurY = 10;
               this.skelatorType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_skelator = null;
               if((_loc5_ = _skelator(param1)).mc.skullhead)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.skullhead.gotoAndStop(param3);
                    }
               }
               if(_loc5_.mc.skullstaff)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.skullstaff.gotoAndStop(param2);
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return this.WEAPON_REACH;
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               this.WEAPON_REACH = param1.xml.xml.Chaos.Units.skelator.weaponReach;
               population = param1.xml.xml.Chaos.Units.skelator.population;
               _mass = param1.xml.xml.Chaos.Units.skelator.mass;
               _maxForce = param1.xml.xml.Chaos.Units.skelator.maxForce;
               _dragForce = param1.xml.xml.Chaos.Units.skelator.dragForce;
               _scale = param1.xml.xml.Chaos.Units.skelator.scale;
               _maxVelocity = param1.xml.xml.Chaos.Units.skelator.maxVelocity;
               damageToDeal = param1.xml.xml.Chaos.Units.skelator.baseDamage;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               this.createTime = param1.xml.xml.Chaos.Units.skelator.cooldown;
               this.radiantDamage = param1.xml.xml.Elemental.Units.lavaElement.radiant.damage;
               this.radiantRange = param1.xml.xml.Elemental.Units.lavaElement.radiant.range;
               this.radiantFrames = param1.xml.xml.Elemental.Units.lavaElement.radiant.frames;
               maxHealth = health = param1.xml.xml.Chaos.Units.skelator.health;
               this.fistDamage = param1.xml.xml.Chaos.Units.skelator.fist.damage;
               loadDamage(param1.xml.xml.Chaos.Units.skelator);
               type = com.brockw.stickwar.engine.units.Unit.U_SKELATOR;
               this.isFistAttacking = false;
               this.isReaperSpell = false;
               this.spellX = this.spellY = 0;
               this.fistAttackSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.skelator.fist.effect,param1.xml.xml.Chaos.Units.skelator.fist.cooldown,param1.xml.xml.Chaos.Units.skelator.fist.mana);
               this.reaperSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.skelator.reaper.effect,param1.xml.xml.Chaos.Units.skelator.reaper.cooldown,param1.xml.xml.Chaos.Units.skelator.reaper.mana);
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.healthBar.y = -mc.mc.height * 1.1;
               this.target = null;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["UndeadBuilding"];
          }
          
          override public function canAttackAir() : Boolean
          {
               return true;
          }
          
          private function burnInArea(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team)
               {
                    if(this.skelatorType == "")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                         }
                    }
                    else if(this.skelatorType == "CrystalMarrow")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(this.isFistAttacking)
                              {
                                   param1.freeze(30 * 8);
                              }
                         }
                    }
                    else if(this.skelatorType == "VoltMarrow")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(this.isFistAttacking == true)
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
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:int = 0;
               this.fistAttackSpell.update();
               this.reaperSpell.update();
               updateCommon(param1);
               if(!isUC)
               {
                    _maxVelocity = param1.xml.xml.Chaos.Units.skelator.maxVelocity;
               }
               if(isUC)
               {
                    this.fistDamage = param1.xml.xml.Chaos.Units.skelator.fist.damage * 2;
                    _maxVelocity = param1.xml.xml.Chaos.Units.skelator.maxVelocity * 1.2;
                    _damageToNotArmour = (Number(param1.xml.xml.Chaos.Units.skelator.damage) + Number(param1.xml.xml.Chaos.Units.skelator.toNotArmour)) * 5;
                    _damageToArmour = (Number(param1.xml.xml.Chaos.Units.skelator.damage) + Number(param1.xml.xml.Chaos.Units.skelator.toArmour)) * 5;
                    _mass = Number(param1.xml.xml.Chaos.Units.skelator.mass) / 2;
               }
               else if(!team.isEnemy)
               {
                    this.fistDamage = param1.xml.xml.Chaos.Units.skelator.fist.damage;
                    _maxVelocity = param1.xml.xml.Chaos.Units.skelator.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Chaos.Units.skelator.damage) + Number(param1.xml.xml.Chaos.Units.skelator.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Chaos.Units.skelator.damage) + Number(param1.xml.xml.Chaos.Units.skelator.toArmour);
                    _mass = param1.xml.xml.Chaos.Units.skelator.mass;
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    this._fistDamage *= 1;
                    health *= 1;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.01 - 0.01;
                    enemyBuffed = true;
               }
               if(this.skelatorType == "CrystalMarrow" || this.skelatorType == "VoltMarrow")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               if(this.skelatorType == "Bone_1" && !this.setupComplete)
               {
                    Skelator.setItem(_mc,"Scythe","Horns","Default");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.5;
                    this.setupComplete = true;
               }
               if(this.skelatorType == "GoldMarrow" && !this.setupComplete)
               {
                    Skelator.setItem(_mc,"Gold Staff","Gold Head","Default");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.5;
                    this.setupComplete = true;
               }
               if(this.skelatorType == "Kai" && !this.setupComplete)
               {
                    Skelator.setItem(_mc,"Bone Staff","Demon Head","Default");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.5;
                    this.setupComplete = true;
               }
               if(this.skelatorType == "Kai_2" && !this.setupComplete)
               {
                    Skelator.setItem(_mc,"Bone Staff 2","Demon Head","Default");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.5;
                    this.setupComplete = true;
               }
               if(this.skelatorType == "MegaMarrow" && !this.setupComplete)
               {
                    Skelator.setItem(_mc,"Bone Scythe","Green Helmet","Default");
                    nonTeleportable = true;
                    maxHealth = 25000;
                    health = 25000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    _maxVelocity = 1.9;
                    this.setupComplete = true;
               }
               if(this.skelatorType == "CrystalMarrow" && !this.setupComplete)
               {
                    frozenUnit = true;
                    slowRegen = true;
                    Skelator.setItem(_mc,"Crystal Staff","Crystal Head","Default");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.3;
                    this.castSpellGlow.color = 65535;
                    this.castSpellGlow.blurX = 5;
                    this.castSpellGlow.blurY = 5;
                    this.mc.filters = [this.castSpellGlow];
                    this.shieldwallDamageReduction = 0.85;
                    this.setupComplete = true;
               }
               if(this.skelatorType == "VoltMarrow" && !this.setupComplete)
               {
                    isVoltaic = true;
                    maxHealthIncrease = true;
                    Skelator.setItem(_mc,"Volt Staff","Volt Head","Default");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.3;
                    this.radiantRange = 350;
                    this.fistAttackSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.skelator.fist.effect,650,param1.xml.xml.Chaos.Units.skelator.fist.mana);
                    this.reaperSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.skelator.reaper.effect,350,param1.xml.xml.Chaos.Units.skelator.reaper.mana);
                    this.setupComplete = true;
               }
               if(this.skelatorType != "")
               {
                    isCustomUnit = true;
               }
               if(isCustomUnit = true)
               {
                    if(this.skelatorType == "Bone_1")
                    {
                         this.fistDamage = 125;
                    }
                    else if(isUC)
                    {
                         _maxVelocity = param1.xml.xml.Chaos.Units.skelator.maxVelocity * 1.2;
                    }
                    else if(this.skelatorType == "MegaMarrow")
                    {
                         this.fistDamage = 925;
                    }
                    else if(this.skelatorType == "GoldMarrow")
                    {
                         this.fistDamage = 115;
                    }
                    else if(this.skelatorType == "CrystalMarrow")
                    {
                         this.radiantRange = 430;
                    }
                    else
                    {
                         this.fistDamage = param1.xml.xml.Chaos.Units.skelator.fist.damage;
                    }
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
                    else if(this.isFistAttacking)
                    {
                         _mc.gotoAndStop("fistAttack");
                         _loc2_ = (_mc.mc.currentFrame - 27) / 5;
                         if(_mc.mc.currentFrame >= 27 && (_mc.mc.currentFrame - 27) % 5 == 0 && _loc2_ < 6)
                         {
                              if(this.skelatorType == "GoldMarrow")
                              {
                                   this.protect(300);
                              }
                              else if(this.skelatorType == "Kai")
                              {
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_CAT);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.catType = "AlphaCat";
                                   this.clusterLad.ai.setCommand(team.game,new StandCommand(team.game));
                              }
                              else if(this.skelatorType == "Kai_2")
                              {
                                   this.Undead_2 = Spearton(param1.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON));
                                   team.spawn(this.Undead_2,param1);
                                   this.Undead_2.px = this.target.px;
                                   this.Undead_2.py = this.target.py;
                                   this.Undead_2.speartonType = "Undead_2";
                                   this.Undead_2.ai.setCommand(team.game,new StandCommand(team.game));
                              }
                              param1.projectileManager.initFistAttack(this.spellX,this.spellY,this,_loc2_);
                         }
                         if(_mc.mc.currentFrame == _mc.mc.totalFrames)
                         {
                              if(this.isFistAttacking == false)
                              {
                                   this.mc.filters = [];
                              }
                              _state = S_RUN;
                              this.isFistAttacking = false;
                         }
                    }
                    else if(this.isReaperSpell)
                    {
                         _mc.gotoAndStop("reaperAttack");
                         if(_mc.mc.currentFrame == 42)
                         {
                              if(this.skelatorType == "GoldMarrow")
                              {
                                   this.protect(300);
                              }
                              else if(this.skelatorType == "Kai")
                              {
                                   this.Toxic = Dead(param1.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_DEAD));
                                   team.spawn(this.Toxic,param1);
                                   this.Toxic.px = this.target.px;
                                   this.Toxic.py = this.target.py;
                                   this.Toxic.deadType = "Toxic";
                                   this.Toxic.ai.setCommand(team.game,new StandCommand(team.game));
                                   this.Toxic = Dead(param1.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_DEAD));
                                   team.spawn(this.Toxic,param1);
                                   this.Toxic.px = this.target.px;
                                   this.Toxic.py = this.target.py;
                                   this.Toxic.deadType = "Toxic";
                                   this.Toxic.ai.setCommand(team.game,new StandCommand(team.game));
                              }
                              else if(this.skelatorType == "Kai_2")
                              {
                                   this.DeadBoss = Dead(param1.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_DEAD));
                                   team.spawn(this.DeadBoss,param1);
                                   this.DeadBoss.px = this.target.px;
                                   this.DeadBoss.py = this.target.py;
                                   this.DeadBoss.deadType = "DeadBoss";
                                   this.DeadBoss.ai.setCommand(team.game,new StandCommand(team.game));
                              }
                              else if(this.skelatorType == "VoltMarrow")
                              {
                                   param1.projectileManager.initLightning(this,this.target,this);
                                   param1.projectileManager.initLightning(this,this.target,this);
                                   param1.projectileManager.initLightning(this,this.target,this);
                                   param1.projectileManager.initLightning(this,this.target,this);
                              }
                              param1.projectileManager.initReaper(this,this.target);
                         }
                         if(_mc.mc.currentFrame == _mc.mc.totalFrames)
                         {
                              if(this.isReaperSpell == false)
                              {
                                   this.mc.filters = [];
                              }
                              _state = S_RUN;
                              this.isReaperSpell = false;
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
               Util.animateMovieClip(mc);
               if(this.skelatorType == "Bone_1")
               {
                    Skelator.setItem(_mc,"Scythe","Horns","Default");
               }
               else if(this.skelatorType == "MegaMarrow")
               {
                    Skelator.setItem(_mc,"Bone Scythe","Green Helmet","Default");
               }
               else if(this.skelatorType == "GoldMarrow")
               {
                    Skelator.setItem(_mc,"Gold Staff","Gold Head","Default");
               }
               else if(this.skelatorType == "Kai")
               {
                    Skelator.setItem(_mc,"Bone Staff","Demon Head","Default");
               }
               else if(this.skelatorType == "Kai_2")
               {
                    Skelator.setItem(_mc,"Bone Staff 2","Demon Head","Default");
               }
               else if(this.skelatorType == "CrystalMarrow")
               {
                    Skelator.setItem(_mc,"Crystal Staff","Crystal Head","Default");
               }
               else if(this.skelatorType == "VoltMarrow")
               {
                    Skelator.setItem(_mc,"Volt Staff","Volt Head","Default");
               }
               else
               {
                    Skelator.setItem(_mc,"","","Default");
               }
          }
          
          override public function stateFixForCutToWalk() : void
          {
               if(!this.isFistAttacking && !this.isReaperSpell)
               {
                    super.stateFixForCutToWalk();
                    this.isFistAttacking = false;
                    this.isReaperSpell = false;
               }
          }
          
          public function fistAttackCooldown() : Number
          {
               return this.fistAttackSpell.cooldown();
          }
          
          public function reaperCooldown() : Number
          {
               return this.reaperSpell.cooldown();
          }
          
          override public function isBusy() : Boolean
          {
               return !this.notInSpell() || isBusyForSpell;
          }
          
          private function notInSpell() : Boolean
          {
               return !this.isFistAttacking && !this.isReaperSpell;
          }
          
          public function fistAttack(param1:Number, param2:Number) : void
          {
               if(!techTeam.tech.isResearched(Tech.SKELETON_FIST_ATTACK))
               {
                    return;
               }
               if(this.notInSpell() && this.fistAttackSpell.spellActivate(this.team))
               {
                    this.spellX = param1;
                    this.spellY = param2;
                    forceFaceDirection(this.spellX - this.px);
                    this.isFistAttacking = true;
                    hasHit = false;
                    _state = S_ATTACK;
                    team.game.soundManager.playSound("skeltalFistsSound",px,py);
               }
          }
          
          public function reaperAttack(param1:com.brockw.stickwar.engine.units.Unit) : void
          {
               if(param1 != null && param1.isAlive())
               {
                    if(this.notInSpell() && this.reaperSpell.spellActivate(this.team))
                    {
                         this.target = param1;
                         forceFaceDirection(this.target.px - px);
                         this.isReaperSpell = true;
                         hasHit = false;
                         _state = S_ATTACK;
                         team.game.soundManager.playSound("skeletalReaperSound",px,py);
                    }
               }
          }
          
          override public function get damageToArmour() : Number
          {
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               param1.setAction(0,0,UnitCommand.REAPER);
               if(techTeam.tech.isResearched(Tech.SKELETON_FIST_ATTACK))
               {
                    param1.setAction(1,0,UnitCommand.FIST_ATTACK);
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
               }
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.skelatorType == "CrystalMarrow")
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
               }
          }
          
          override public function mayAttack(param1:com.brockw.stickwar.engine.units.Unit) : Boolean
          {
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
          
          public function get fistDamage() : Number
          {
               return this._fistDamage;
          }
          
          public function set fistDamage(param1:Number) : void
          {
               this._fistDamage = param1;
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
