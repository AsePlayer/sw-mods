package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.MagikillAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     
     public class Magikill extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var stunSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var nukeSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var poisonDartSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var isShieldBashing:Boolean;
          
          private var isStunning:Boolean;
          
          private var isNuking:Boolean;
          
          private var isPoisonDarting:Boolean;
          
          private var spellX:Number;
          
          private var spellY:Number;
          
          public var magikillType:String;
          
          private var setupComplete:Boolean;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Swordwrath;
          
          private var explosionDamage:Number;
          
          private var poisonSprayRange:Number;
          
          private var fireDamage:Number;
          
          private var fireFrames:int;
          
          private var hurricaneSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var counter:int;
          
          private var stunForce:Number;
          
          private var stunTime:int;
          
          private var stunned:com.brockw.stickwar.engine.units.Unit;
          
          private var isHurricane:Boolean;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var targetX:Number;
          
          private var targetY:Number;
          
          private var towerConstructing:com.brockw.stickwar.engine.units.ChaosTower;
          
          private var isDone:Boolean;
          
          public var teleportDistance:int;
          
          public var teleportEnemy:Boolean = false;
          
          public var nonTeleportable:Boolean = false;
          
          private var hasTeleportedOut:Boolean;
          
          private var hasTeleportedIn:Boolean;
          
          private var teleportX:Number;
          
          private var teleportY:Number;
          
          private var teleportFrames:int;
          
          private var teleportDirection:int;
          
          private var firestormSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var firebreathSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var firestormFireFrames:int;
          
          private var firebreathFireFrames:int;
          
          private var firestormFireDamage:Number;
          
          private var firebreathFireDamage:Number;
          
          private var firebreathDamage:Number;
          
          private var firestormDamage:Number;
          
          private var firestormStunForce:Number;
          
          private var firebreathArea:Number;
          
          private var protectTime:int;
          
          private var protectTarget:com.brockw.stickwar.engine.units.Unit;
          
          private var isProtect:Boolean = false;
          
          public function Magikill(param1:StickWar)
          {
               super(param1);
               _mc = new _magikill();
               this.init(param1);
               addChild(_mc);
               ai = new MagikillAi(this);
               initSync();
               firstInit();
               healthBar.y = -pheight * 1;
               this.magikillType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_magikill = null;
               if((_loc5_ = _magikill(param1)).mc.wizhat)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.wizhat.gotoAndStop(param3);
                    }
               }
               if(_loc5_.mc.wizstaff)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.wizstaff.gotoAndStop(param2);
                    }
               }
               if(_loc5_.mc.wizbeard)
               {
                    if(param4 != "")
                    {
                         _loc5_.mc.wizbeard.gotoAndStop(param4);
                    }
               }
          }
          
          override public function weaponReach() : Number
          {
               return WEAPON_REACH;
          }
          
          override public function playDeathSound() : void
          {
               team.game.soundManager.playSound("MagikillDeath",px,py);
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               WEAPON_REACH = param1.xml.xml.Order.Units.magikill.weaponReach;
               population = param1.xml.xml.Order.Units.magikill.population;
               _mass = param1.xml.xml.Order.Units.magikill.mass;
               _maxForce = param1.xml.xml.Order.Units.magikill.maxForce;
               _dragForce = param1.xml.xml.Order.Units.magikill.dragForce;
               _scale = param1.xml.xml.Order.Units.magikill.scale;
               _maxVelocity = param1.xml.xml.Order.Units.magikill.maxVelocity;
               this.stunTime = param1.xml.xml.Elemental.Units.hurricaneElement.shieldBash.stunTime;
               this.stunForce = param1.xml.xml.Elemental.Units.hurricaneElement.shieldBash.stunForce;
               this.explosionDamage = param1.xml.xml.Order.Units.magikill.nuke.damage;
               this.createTime = param1.xml.xml.Order.Units.magikill.cooldown;
               this.fireDamage = param1.xml.xml.Order.Units.magikill.nuke.fireDamage;
               this.fireFrames = param1.xml.xml.Order.Units.magikill.nuke.fireFrames;
               this.teleportDirection = -1;
               this.firestormStunForce = param1.xml.xml.Elemental.Units.firestormElement.firestorm.stunForce;
               this.firestormFireFrames = param1.xml.xml.Elemental.Units.firestormElement.firestorm.fireFrames;
               this.firebreathFireFrames = param1.xml.xml.Elemental.Units.firestormElement.firebreath.fireFrames;
               this.firestormDamage = param1.xml.xml.Elemental.Units.firestormElement.firestorm.damage;
               this.firestormFireDamage = param1.xml.xml.Elemental.Units.firestormElement.firestorm.fireDamage;
               this.firebreathFireDamage = param1.xml.xml.Elemental.Units.firestormElement.firebreath.fireDamage;
               this.firebreathDamage = param1.xml.xml.Elemental.Units.firestormElement.firebreath.damage;
               this.firebreathArea = param1.xml.xml.Elemental.Units.firestormElement.firebreath.area;
               this.radiantDamage = param1.xml.xml.Elemental.Units.lavaElement.radiant.damage;
               this.radiantRange = param1.xml.xml.Elemental.Units.lavaElement.radiant.range;
               this.radiantFrames = param1.xml.xml.Elemental.Units.lavaElement.radiant.frames;
               maxHealth = health = param1.xml.xml.Order.Units.magikill.health;
               loadDamage(param1.xml.xml.Order.Units.magikill);
               type = com.brockw.stickwar.engine.units.Unit.U_MAGIKILL;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.poisonSprayRange = param1.xml.xml.Order.Units.magikill.poisonSpray.range;
               this.stunSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.electricWall.effect,param1.xml.xml.Order.Units.magikill.electricWall.cooldown,param1.xml.xml.Order.Units.magikill.electricWall.mana);
               this.nukeSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.nuke.effect,param1.xml.xml.Order.Units.magikill.nuke.cooldown,param1.xml.xml.Order.Units.magikill.nuke.mana);
               this.poisonDartSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Order.Units.magikill.poisonSpray.effect,param1.xml.xml.Order.Units.magikill.poisonSpray.cooldown,param1.xml.xml.Order.Units.magikill.poisonSpray.mana);
               this.hurricaneSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(0,param1.xml.xml.Elemental.Units.hurricaneElement.hurricane.cooldown,param1.xml.xml.Elemental.Units.hurricaneElement.hurricane.mana);
               this.isNuking = false;
               this.isStunning = false;
               this.isPoisonDarting = false;
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["MagicGuildBuilding"];
          }
          
          override public function getDamageToDeal() : Number
          {
               return damageToDeal;
          }
          
          private function burnInArea(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team)
               {
                    if(this.magikillType == "TheMagikill2")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   if(this.isStunning == true)
                                   {
                                        param1.stun(75);
                                   }
                                   else if(this.isPoisonDarting == true)
                                   {
                                        param1.setFire(30 * 5,0.2);
                                   }
                              }
                         }
                    }
                    else if(this.magikillType == "TheMagikill3")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   if(this.isNuking == true)
                                   {
                                        param1.freeze(30 * 6);
                                   }
                              }
                         }
                    }
               }
          }
          
          override public function update(param1:StickWar) : void
          {
               this.stunSpellCooldown.update();
               this.nukeSpellCooldown.update();
               this.poisonDartSpellCooldown.update();
               updateCommon(param1);
               if(this.magikillType == "TheMagikill2" || this.magikillType == "TheMagikill3")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               if(this.magikillType == "TheMagikill" && !this.setupComplete)
               {
                    WEAPON_REACH = 60;
                    population = 0;
                    maxHealth = 2000;
                    health = 2000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    _maxVelocity = 3;
                    this.explosionDamage = 400;
                    this.fireDamage = 2;
                    this.fireFrames = 500;
                    this.poisonSprayRange = 1100;
                    this.setupComplete = true;
               }
               if(this.magikillType == "TheMagikill2" && !this.setupComplete)
               {
                    WEAPON_REACH = 60;
                    population = 0;
                    maxHealth = 2000;
                    health = 2000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    _maxVelocity = 3;
                    this.explosionDamage = 400;
                    this.fireDamage = 2;
                    this.fireFrames = 500;
                    this.poisonSprayRange = 1100;
                    this.setupComplete = true;
               }
               if(this.magikillType == "TheMagikill3" && !this.setupComplete)
               {
                    WEAPON_REACH = 60;
                    population = 0;
                    maxHealth = 2000;
                    health = 2000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    _maxVelocity = 3;
                    this.explosionDamage = 400;
                    this.fireDamage = 2;
                    this.fireFrames = 450;
                    this.poisonSprayRange = 1100;
                    this.setupComplete = true;
               }
               if(this.magikillType == "Zilaros" && !this.setupComplete)
               {
                    WEAPON_REACH = 30;
                    population = 0;
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 4;
                    this.explosionDamage = 300;
                    this.fireDamage = 1.2;
                    this.fireFrames = 350;
                    this.poisonSprayRange = 900;
                    this.setupComplete = true;
               }
               if(this.magikillType != "")
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
                    else if(this.isNuking == true)
                    {
                         _mc.gotoAndStop("attack_1");
                         if(MovieClip(_mc.mc).currentFrame == 36 && !hasHit)
                         {
                              if(this.magikillType == "Default" || this.magikillType == "Zilaros")
                              {
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "TheMagikill")
                              {
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initNuke(this.px - 200,this.py + 50,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initNuke(this.px - 200,this.py - 50,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initNuke(this.px,this.py,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "TheMagikill2")
                              {
                                   param1.projectileManager.initFirestorm(this.px,this.spellY,0,team,getDirection(),250,2,250,this.firestormStunForce);
                                   team.game.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   team.game.projectileManager.initHurricane(this.px - 50,this.py - 50,this,0);
                                   team.game.projectileManager.initHurricane(this.px - 50,this.py + 50,this,0);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "TheMagikill3")
                              {
                                   this.radiantRange = 400;
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.px,this.py,this,0,0,0);
                                   hasHit = true;
                                   this.px += -700;
                              }
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isNuking = false;
                              _state = S_RUN;
                         }
                    }
                    else if(this.isStunning == true)
                    {
                         _mc.gotoAndStop("electricAttack");
                         if(MovieClip(_mc.mc).currentFrame == 47 && !hasHit)
                         {
                              if(this.magikillType == "Default" || this.magikillType == "TheMagikill" || this.magikillType == "Zilaros")
                              {
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "TheMagikill")
                              {
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "TheMagikill2")
                              {
                                   this.radiantRange = 700;
                                   hasHit = true;
                                   this.px += 700;
                              }
                              else if(this.magikillType == "TheMagikill3")
                              {
                                   param1.projectileManager.initFirestorm(this.px,this.spellY,0,team,getDirection(),250,2,250,this.firestormStunForce);
                                   param1.projectileManager.initFirestorm(this.px - 200,this.py + 50,0,team,getDirection(),250,2,250,this.firestormStunForce);
                                   param1.projectileManager.initFirestorm(this.px - 200,this.py - 50,0,team,getDirection(),250,2,250,this.firestormStunForce);
                                   param1.projectileManager.initNuke(this.px,this.py,this,0,0,0);
                                   hasHit = true;
                                   this.px += 1400;
                              }
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isStunning = false;
                              _state = S_RUN;
                         }
                    }
                    else if(this.isPoisonDarting == true)
                    {
                         _mc.gotoAndStop("poisonAttack");
                         if(MovieClip(_mc.mc).currentFrame == 44 && !hasHit)
                         {
                              if(this.magikillType == "Default" || this.magikillType == "TheMagikill" || this.magikillType == "Zilaros")
                              {
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "TheMagikill2")
                              {
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "EnchantedRebelSword";
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "EnchantedRebelSword";
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "EnchantedRebelSword";
                                   hasHit = true;
                              }
                              else if(this.magikillType == "TheMagikill3")
                              {
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "EnchantedRebelSword";
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "EnchantedRebelSword";
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "EnchantedRebelSword";
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "EnchantedRebelSword";
                                   hasHit = true;
                              }
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isPoisonDarting = false;
                              _state = S_RUN;
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
                    if(this.magikillType == "TheMagikill")
                    {
                         param1.projectileManager.initNuke(px,py,this,0,0,0);
                    }
                    else if(this.magikillType == "TheMagikill2")
                    {
                         param1.projectileManager.initNuke(px,py,this,0,0,0);
                    }
                    else if(this.magikillType == "TheMagikill3")
                    {
                         param1.projectileManager.initNuke(px,py,this,0,0,0);
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
               if(!isDead && MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
               {
                    MovieClip(_mc.mc).gotoAndStop(1);
               }
               Util.animateMovieClip(_mc,0);
               if(mc.mc.wizhat != null)
               {
                    mc.mc.wizhat.gotoAndStop(1);
               }
               if(this.magikillType == "TheMagikill")
               {
                    Magikill.setItem(_magikill(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
               else if(this.magikillType == "TheMagikill2")
               {
                    Magikill.setItem(_magikill(mc),"Metal Staff","Gold Hat","");
               }
               else if(this.magikillType == "TheMagikill3")
               {
                    Magikill.setItem(_magikill(mc),"Gold Staff","Leaf Hat","Ice Beard");
               }
               else if(this.magikillType == "Zilaros")
               {
                    Magikill.setItem(_magikill(mc),"Purple Staff","Belt Hat","Grey Beard");
               }
               else
               {
                    Magikill.setItem(_magikill(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               param1.setAction(0,0,UnitCommand.NUKE);
               if(techTeam.tech.isResearched(Tech.MAGIKILL_POISON))
               {
                    param1.setAction(1,0,UnitCommand.POISON_DART);
               }
               if(techTeam.tech.isResearched(Tech.MAGIKILL_WALL))
               {
                    param1.setAction(2,0,UnitCommand.STUN);
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
          
          override public function isBusy() : Boolean
          {
               return !this.notInSpell() || isBusyForSpell;
          }
          
          private function notInSpell() : Boolean
          {
               return !this.isPoisonDarting && !this.isStunning && !this.isNuking;
          }
          
          public function poisonDartSpell(param1:Number, param2:Number) : void
          {
               if(!techTeam.tech.isResearched(Tech.MAGIKILL_POISON))
               {
                    return;
               }
               if(this.notInSpell() && this.poisonDartSpellCooldown.spellActivate(this.team))
               {
                    this.spellX = param1;
                    this.spellY = param2;
                    forceFaceDirection(this.spellX - this.px);
                    this.isPoisonDarting = true;
                    hasHit = false;
                    _state = S_ATTACK;
                    team.game.soundManager.playSound("wizardPoisonSound",px,py);
               }
          }
          
          public function nukeSpell(param1:Number, param2:Number) : void
          {
               if(this.notInSpell() && this.nukeSpellCooldown.spellActivate(this.team))
               {
                    this.spellX = param1;
                    forceFaceDirection(this.spellX - this.px);
                    this.spellY = param2;
                    this.isNuking = true;
                    hasHit = false;
                    _state = S_ATTACK;
                    _mc.gotoAndStop("attack_1");
                    MovieClip(_mc.mc).gotoAndStop(1);
                    team.game.soundManager.playSound("fulminateSound",px,py);
               }
          }
          
          public function stunSpell(param1:Number, param2:Number) : void
          {
               if(!techTeam.tech.isResearched(Tech.MAGIKILL_WALL))
               {
                    return;
               }
               if(this.notInSpell() && this.stunSpellCooldown.spellActivate(this.team))
               {
                    this.spellX = param1;
                    forceFaceDirection(this.spellX - this.px);
                    this.spellY = param2;
                    this.isStunning = true;
                    hasHit = false;
                    _state = S_ATTACK;
                    team.game.soundManager.playSound("electricWallSound",px,py);
               }
          }
          
          private function initFireBreathLine(param1:int) : void
          {
               var _loc3_:Number = NaN;
               var _loc2_:int = 0;
               while(_loc2_ < 4)
               {
                    _loc3_ = this.spellX + (team.game.random.nextNumber() * this.firebreathArea - this.firebreathArea / 4) * this.getDirection();
                    if(techTeam.tech.isResearched(Tech.MAGIKILL_WALL) && _loc2_ == 0 && param1 % 2 == 0)
                    {
                         team.game.projectileManager.initLavaComet(_loc3_,team.game.random.nextNumber() * team.game.map.height,this,this.firebreathDamage,this.firebreathFireDamage,this.firebreathFireFrames);
                    }
                    else
                    {
                         team.game.projectileManager.initLavaRain(_loc3_,team.game.random.nextNumber() * team.game.map.height,this,this.firebreathDamage,this.firebreathFireDamage,this.firebreathFireFrames);
                    }
                    _loc2_++;
               }
          }
          
          private function firebreathHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team && !(param1.id in this.fireBreathHasHit))
               {
                    param1.damage(com.brockw.stickwar.engine.units.Unit.D_FIRE,this.firebreathDamage,null);
                    param1.setFire(this.firebreathFireFrames,this.firebreathFireDamage);
                    this.fireBreathHasHit[param1.id] = 1;
               }
          }
          
          public function hurricaneSpell(param1:Number, param2:Number) : void
          {
               if(this.hurricaneSpellCooldown.spellActivate(team) && this.techTeam.tech.isResearched(Tech.TORNADO))
               {
                    _state = S_ATTACK;
                    this.isHurricane = true;
                    this.targetX = param1;
                    this.targetY = param2;
               }
          }
          
          public function teleportSpell(param1:Number, param2:Number) : void
          {
               if(this._teleportSpellTimer.spellActivate(team))
               {
                    this.teleportX = param1;
                    this.teleportY = param2;
                    this.teleportDirection = Util.sgn(this.teleportX - px);
                    team.game.projectileManager.initTeleportEffect(px,py,0,team,this.teleportDirection);
                    this.px = this.teleportX;
                    this.py = this.teleportY;
                    this.teleportFrames = 0;
                    this.hasTeleportedOut = true;
                    this.hasTeleportedIn = false;
               }
          }
          
          public function stunCooldown() : Number
          {
               return this.stunSpellCooldown.cooldown();
          }
          
          public function nukeCooldown() : Number
          {
               return this.nukeSpellCooldown.cooldown();
          }
          
          public function poisonDartCooldown() : Number
          {
               return this.poisonDartSpellCooldown.cooldown();
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
                    if(Math.abs(px - param1.px) < WEAPON_REACH && Math.abs(py - param1.py) < 40 && this.getDirection() == Util.sgn(param1.px - px))
                    {
                         return true;
                    }
               }
               return false;
          }
          
          override public function stateFixForCutToWalk() : void
          {
               if(!this.isStunning && !this.isNuking && !this.isPoisonDarting)
               {
                    super.stateFixForCutToWalk();
                    this.isStunning = false;
                    this.isNuking = false;
                    this.isPoisonDarting = false;
               }
          }
     }
}
