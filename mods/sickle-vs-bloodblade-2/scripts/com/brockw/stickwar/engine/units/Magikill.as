package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.MagikillAi;
     import com.brockw.stickwar.engine.Ai.command.StandCommand;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.filters.GlowFilter;
     
     public class Magikill extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var convertedUnit:com.brockw.stickwar.engine.units.Unit;
          
          private var currentTarget:com.brockw.stickwar.engine.units.Unit;
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var target:com.brockw.stickwar.engine.units.Unit;
          
          private var stunSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var nukeSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var poisonDartSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
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
          
          private var stunForce:Number;
          
          private var stunTime:int;
          
          private var stunned:com.brockw.stickwar.engine.units.Unit;
          
          private var protectTime:int;
          
          private var isHurricane:Boolean;
          
          private var targetX:Number;
          
          private var targetY:Number;
          
          private var firestormFireFrames:int;
          
          private var firebreathFireFrames:int;
          
          private var firestormFireDamage:Number;
          
          private var firebreathFireDamage:Number;
          
          private var firebreathDamage:Number;
          
          private var firestormDamage:Number;
          
          private var firestormStunForce:Number;
          
          private var firebreathArea:Number;
          
          private var breathNumber:int;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var towerConstructing:com.brockw.stickwar.engine.units.ChaosTower;
          
          private var castSpellGlow:GlowFilter;
          
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
               this.castSpellGlow = new GlowFilter();
               this.castSpellGlow.color = 16711680;
               this.castSpellGlow.blurX = 10;
               this.castSpellGlow.blurY = 10;
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
               this.convertedUnit = null;
               this.currentTarget = null;
               WEAPON_REACH = param1.xml.xml.Order.Units.magikill.weaponReach;
               population = param1.xml.xml.Order.Units.magikill.population;
               _mass = param1.xml.xml.Order.Units.magikill.mass;
               _maxForce = param1.xml.xml.Order.Units.magikill.maxForce;
               _dragForce = param1.xml.xml.Order.Units.magikill.dragForce;
               _scale = param1.xml.xml.Order.Units.magikill.scale;
               _maxVelocity = param1.xml.xml.Order.Units.magikill.maxVelocity;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               this.explosionDamage = param1.xml.xml.Order.Units.magikill.nuke.damage;
               this.createTime = param1.xml.xml.Order.Units.magikill.cooldown;
               this.fireDamage = param1.xml.xml.Order.Units.magikill.nuke.fireDamage;
               this.fireFrames = param1.xml.xml.Order.Units.magikill.nuke.fireFrames;
               this.stunTime = param1.xml.xml.Elemental.Units.hurricaneElement.shieldBash.stunTime;
               this.stunForce = param1.xml.xml.Elemental.Units.hurricaneElement.shieldBash.stunForce;
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
               this.isNuking = false;
               this.isStunning = false;
               this.isPoisonDarting = false;
          }
          
          override public function setBuilding() : void
          {
               if(this.team.type == Team.T_GOOD)
               {
                    building = team.buildings["MagicGuildBuilding"];
               }
               else
               {
                    building = team.buildings["MedusaBuilding"];
               }
          }
          
          override public function canAttackAir() : Boolean
          {
               return true;
          }
          
          override public function getDamageToDeal() : Number
          {
               return damageToDeal;
          }
          
          private function burnInArea(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team)
               {
                    if(this.magikillType == "SW1Mage")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE && param1.type != com.brockw.stickwar.engine.units.Unit.U_WALL && param1.type != com.brockw.stickwar.engine.units.Unit.U_GIANT)
                              {
                                   if(this.isNuking == true)
                                   {
                                        this.convertedUnit = param1;
                                        team.enemyTeam.switchTeams(param1);
                                        _state = S_ATTACK;
                                   }
                                   else if(this.isStunning == true)
                                   {
                                        this.convertedUnit = param1;
                                        team.enemyTeam.switchTeams(param1);
                                        _state = S_ATTACK;
                                   }
                                   else if(this.isPoisonDarting == true)
                                   {
                                        this.convertedUnit = param1;
                                        team.enemyTeam.switchTeams(param1);
                                        _state = S_ATTACK;
                                   }
                              }
                         }
                    }
                    else if(this.magikillType == "IceMage")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   if(this.isNuking == true)
                                   {
                                        param1.slow(30 * 45);
                                   }
                                   else if(this.isStunning == true)
                                   {
                                        param1.slow(30 * 50);
                                   }
                                   else if(this.isPoisonDarting == true)
                                   {
                                        param1.slow(30 * 75);
                                   }
                              }
                         }
                    }
                    else if(this.magikillType == "CrystalMage")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   if(this.isNuking == true)
                                   {
                                        param1.freezeCount = 30 * 8;
                                   }
                                   else if(this.isStunning == true)
                                   {
                                        param1.freezeCount = 30 * 8;
                                   }
                                   else if(this.isPoisonDarting == true)
                                   {
                                        param1.freezeCount = 30 * 8;
                                   }
                              }
                         }
                    }
                    else if(this.magikillType == "SavageMage")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   if(this.isNuking == true)
                                   {
                                        param1.stun(100);
                                   }
                                   else if(this.isStunning == true)
                                   {
                                        param1.stun(190);
                                   }
                                   else if(this.isPoisonDarting == true)
                                   {
                                        param1.stun(300);
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
               noStone = true;
               if(this.magikillType == "IceMage" || this.magikillType == "CrystalMage" || this.magikillType == "SW1Mage" || this.magikillType == "SavageMage")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               if(!team.isEnemy)
               {
                    _maxVelocity = param1.xml.xml.Order.Units.magikill.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Order.Units.magikill.damage) + Number(param1.xml.xml.Order.Units.magikill.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Order.Units.magikill.damage) + Number(param1.xml.xml.Order.Units.magikill.toArmour);
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    this.explosionDamage *= 1;
                    health = Number(param1.xml.xml.Order.Units.magikill.health) / 3;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    enemyBuffed = true;
               }
               if(this.magikillType == "FireMage" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    Magikill.setItem(_mc,"Dragon Staff","Lava Hat","Grey Beard");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.magikillType == "VampMage" && !this.setupComplete)
               {
                    isVampUnit = true;
                    LightVampRegen = true;
                    LightVampCure = true;
                    Magikill.setItem(_mc,"Vamp Staff","Vamp Hat","");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.magikillType == "IceMage" && !this.setupComplete)
               {
                    freezeUnit = true;
                    Magikill.setItem(_mc,"Ice Staff 2","Ice Hat","Ice Beard");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.magikillType == "SavageMage" && !this.setupComplete)
               {
                    stunUnit = true;
                    Magikill.setItem(_mc,"Savage Staff","Savage Hat","");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.magikillType == "Zarek" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    Magikill.setItem(_mc,"Zarek Staff","Zarek Crown","Blank");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.setupComplete = true;
               }
               if(this.magikillType == "Zarek_2" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    Magikill.setItem(_mc,"Zarek Staff","Zarek Crown","Blank");
                    maxHealth = 90000;
                    health = 90000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.5;
                    this.setupComplete = true;
               }
               if(this.magikillType == "SW1Mage" && !this.setupComplete)
               {
                    enemyColor = true;
                    nonTeleportable = true;
                    Magikill.setItem(_mc,"Default","Summoner Hat","Blank");
                    maxHealth = 9000;
                    health = 9000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 4;
                    this.castSpellGlow.color = 255;
                    this.castSpellGlow.blurX = 5;
                    this.castSpellGlow.blurY = 5;
                    this.mc.filters = [this.castSpellGlow];
                    this.setupComplete = true;
               }
               if(this.magikillType == "SW3Mage" && !this.setupComplete)
               {
                    Magikill.setItem(_mc,"Gold Staff","Gold Hat","Grey Beard");
                    maxHealth = 200;
                    health = 200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 4;
                    this.setupComplete = true;
               }
               if(this.magikillType == "LeafMage" && !this.setupComplete)
               {
                    Magikill.setItem(_mc,"Leaf Wizard Staff","Leaf Hat","Grey Beard");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.magikillType == "GoldMage" && !this.setupComplete)
               {
                    Magikill.setItem(_mc,"Gold Staff 2","Golden Hat","");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.setupComplete = true;
               }
               if(this.magikillType == "CrystalMage" && !this.setupComplete)
               {
                    frozenUnit = true;
                    slowRegen = true;
                    Magikill.setItem(_mc,"Crystal Staff 2","Crystal Hat","");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.castSpellGlow.color = 65535;
                    this.castSpellGlow.blurX = 5;
                    this.castSpellGlow.blurY = 5;
                    this.mc.filters = [this.castSpellGlow];
                    this.setupComplete = true;
               }
               if(this.magikillType != "")
               {
                    isCustomUnit = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.magikillType == "Zarek")
                    {
                         this.explosionDamage = 80;
                         this.fireDamage = 1;
                         this.fireFrames = 250;
                         stunTimeLeft = 0;
                    }
                    else if(this.magikillType == "Zarek_2")
                    {
                         this.explosionDamage = 350;
                         this.fireDamage = 25;
                         this.fireFrames = 1000;
                         stunTimeLeft = 0;
                    }
                    else if(this.magikillType == "GoldMage")
                    {
                         this.explosionDamage = 100;
                         this.fireDamage = 4;
                         this.fireFrames = 150;
                         stunTimeLeft = 0;
                    }
                    else if(this.magikillType == "SavageMage")
                    {
                         _maxVelocity = 6.5;
                         stunTimeLeft = 0;
                    }
                    else if(this.magikillType == "LeafMage")
                    {
                         _maxVelocity = 6.5;
                    }
                    else
                    {
                         this.explosionDamage = param1.xml.xml.Order.Units.magikill.nuke.damage;
                         this.fireDamage = param1.xml.xml.Order.Units.magikill.nuke.fireDamage;
                         this.fireFrames = param1.xml.xml.Order.Units.magikill.nuke.fireFrames;
                         _maxVelocity = param1.xml.xml.Order.Units.magikill.maxVelocity;
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
                    else if(this.isNuking == true)
                    {
                         _mc.gotoAndStop("attack_1");
                         if(MovieClip(_mc.mc).currentFrame == 36 && !hasHit)
                         {
                              if(this.magikillType == "Default" || this.magikillType == "SW1Mage" || this.magikillType == "SW3Mage")
                              {
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "CrystalMage")
                              {
                                   this.protect(1500);
                                   this.radiantRange = 340;
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "IceMage")
                              {
                                   this.radiantRange = 400;
                                   this.castSpellGlow.color = 20660;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "LeafMage")
                              {
                                   this.castSpellGlow.color = 65280;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "SavageMage")
                              {
                                   this.radiantRange = 600;
                                   this.castSpellGlow.color = 16776960;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "VampMage")
                              {
                                   this.heal(35,2);
                                   this.cure();
                                   this.castSpellGlow.color = 16711935;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "FireMage")
                              {
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initFirestorm(this.spellX,this.spellY,0,team,getDirection(),70,1,200,5);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.castSpellGlow.color = 16711680;
                                   this.mc.filters = [this.castSpellGlow];
                                   hasHit = true;
                              }
                              else if(this.magikillType == "GoldMage")
                              {
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   this.protect(550);
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "GoldSword";
                                   this.clusterLad.stun(0);
                                   this.clusterLad.ai.setCommand(team.game,new StandCommand(team.game));
                                   hasHit = true;
                              }
                              else if(this.magikillType == "Zarek")
                              {
                                   this.protect(1050);
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initFirestorm(this.spellX,this.spellY,0,team,getDirection(),70,1,200,5);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "Zarek_2")
                              {
                                   param1.soundManager.playSoundRandom("mediumExplosion",3,this.spellX,this.spellY);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initFirestorm(this.spellX,this.spellY,0,team,getDirection(),140,2,300,12);
                                   param1.projectileManager.initFirestorm(this.spellX,this.spellY,0,team,getDirection(),140,2,300,12);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   hasHit = true;
                              }
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isNuking = false;
                              if(this.isNuking == false)
                              {
                                   this.radiantRange = 0;
                                   this.mc.filters = [];
                                   if(this.magikillType == "SW1Mage")
                                   {
                                        this.mc.filters = [this.castSpellGlow];
                                   }
                              }
                              _state = S_RUN;
                         }
                    }
                    else if(this.isStunning == true)
                    {
                         _mc.gotoAndStop("electricAttack");
                         if(MovieClip(_mc.mc).currentFrame == 47 && !hasHit)
                         {
                              if(this.magikillType == "Default")
                              {
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "CrystalMage")
                              {
                                   this.radiantRange = 500;
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "IceMage")
                              {
                                   this.castSpellGlow.color = 20660;
                                   this.mc.filters = [this.castSpellGlow];
                                   this.radiantRange = 600;
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "LeafMage")
                              {
                                   this.castSpellGlow.color = 65280;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "VampMage")
                              {
                                   this.castSpellGlow.color = 16711935;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   this.heal(30,2);
                                   this.cure();
                                   hasHit = true;
                              }
                              else if(this.magikillType == "SavageMage")
                              {
                                   this.castSpellGlow.color = 16776960;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   this.radiantRange = 800;
                                   hasHit = true;
                              }
                              else if(this.magikillType == "GoldMage")
                              {
                                   param1.soundManager.playSound("electricWall",this.spellX,this.spellY);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   this.protect(550);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "SW1Mage")
                              {
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "MegaSword";
                                   this.clusterLad.stun(0);
                                   this.radiantRange = 500;
                                   this.clusterLad.ai.setCommand(team.game,new StandCommand(team.game));
                                   hasHit = true;
                              }
                              else if(this.magikillType == "SW3Mage")
                              {
                                   param1.projectileManager.initTowerSpawn(this.spellX,this.spellY,param1.team,0.6);
                                   this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SWORDWRATH);
                                   team.spawn(this.clusterLad,team.game);
                                   this.clusterLad.px = this.spellX;
                                   this.clusterLad.py = this.spellY;
                                   this.clusterLad.swordwrathType = "Minion";
                                   this.clusterLad.stun(0);
                                   this.clusterLad.ai.setCommand(team.game,new StandCommand(team.game));
                                   hasHit = true;
                              }
                              else if(this.magikillType == "FireMage")
                              {
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.initFireBreathLine(this.breathNumber++);
                                   this.castSpellGlow.color = 16711680;
                                   this.mc.filters = [this.castSpellGlow];
                                   hasHit = true;
                              }
                              else if(this.magikillType == "Zarek")
                              {
                                   this.protect(1050);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "Zarek_2")
                              {
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.projectileManager.initStun(this.spellX,this.spellY,param1.xml.xml.Order.Units.magikill.electricWallDamage,this);
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   hasHit = true;
                              }
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isStunning = false;
                              if(this.isStunning == false)
                              {
                                   this.radiantRange = 0;
                                   this.mc.filters = [];
                                   if(this.magikillType == "SW1Mage")
                                   {
                                        this.mc.filters = [this.castSpellGlow];
                                   }
                              }
                              _state = S_RUN;
                         }
                    }
                    else if(this.isPoisonDarting == true)
                    {
                         _mc.gotoAndStop("poisonAttack");
                         if(MovieClip(_mc.mc).currentFrame == 44 && !hasHit)
                         {
                              if(this.magikillType == "Default")
                              {
                                   this.cure();
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "CrystalMage")
                              {
                                   this.cure();
                                   this.radiantRange = 700;
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "IceMage")
                              {
                                   this.cure();
                                   this.radiantRange = 1100;
                                   this.castSpellGlow.color = 20660;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "LeafMage")
                              {
                                   this.cure();
                                   this.castSpellGlow.color = 65280;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.projectileManager.initHurricane(this.spellX,this.spellY,this,0);
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "SW1Mage")
                              {
                                   this.radiantRange = 600;
                              }
                              else if(this.magikillType == "SavageMage")
                              {
                                   this.radiantRange = 1400;
                                   this.castSpellGlow.color = 16776960;
                                   this.mc.filters = [this.castSpellGlow];
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "GoldMage")
                              {
                                   this.cure();
                                   this.protect(550);
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "VampMage")
                              {
                                   this.castSpellGlow.color = 16711935;
                                   this.mc.filters = [this.castSpellGlow];
                                   this.cure();
                                   this.heal(50,2);
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "FireMage")
                              {
                                   this.cure();
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initFirestorm(this.spellX,this.spellY,0,team,getDirection(),70,1,200,5);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   this.castSpellGlow.color = 16711680;
                                   this.mc.filters = [this.castSpellGlow];
                                   hasHit = true;
                              }
                              else if(this.magikillType == "Zarek")
                              {
                                   this.cure();
                                   this.heal(150,2);
                                   this.protect(1050);
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonPool(this.px,this.py,this,0);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                              else if(this.magikillType == "Zarek_2")
                              {
                                   this.cure();
                                   this.heal(500,2);
                                   param1.soundManager.playSound("AcidSpraySound",px,py);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   param1.projectileManager.initFirestorm(this.spellX,this.spellY,0,team,getDirection(),140,2,300,12);
                                   param1.projectileManager.initPoisonPool(this.px,this.py,this,0);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   param1.projectileManager.initNuke(this.spellX,this.spellY,this,this.explosionDamage,this.fireDamage,this.fireFrames);
                                   param1.projectileManager.initFirestorm(this.spellX,this.spellY,0,team,getDirection(),140,2,300,12);
                                   param1.projectileManager.initPoisonSpray(this.spellX,this.spellY,this,this.poisonSprayRange);
                                   hasHit = true;
                              }
                         }
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              this.isPoisonDarting = false;
                              if(this.isPoisonDarting == false)
                              {
                                   this.mc.filters = [];
                                   if(this.magikillType == "SW1Mage")
                                   {
                                        this.mc.filters = [this.castSpellGlow];
                                   }
                              }
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
                    if(this.magikillType == "FireMage")
                    {
                         param1.projectileManager.initNuke(px,py,this,40,0.8,1000);
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
               if(this.magikillType == "FireMage")
               {
                    Magikill.setItem(_mc,"Dragon Staff","Lava Hat","Grey Beard");
               }
               else if(this.magikillType == "IceMage")
               {
                    Magikill.setItem(_mc,"Ice Staff 2","Ice Hat","Ice Beard");
               }
               else if(this.magikillType == "VampMage")
               {
                    Magikill.setItem(_mc,"Vamp Staff","Vamp Hat","");
               }
               else if(this.magikillType == "SW1Mage")
               {
                    Magikill.setItem(_mc,"Default","Summoner Hat","Blank");
               }
               else if(this.magikillType == "LeafMage")
               {
                    Magikill.setItem(_mc,"Leaf Wizard Staff","Leaf Hat","Grey Beard");
               }
               else if(this.magikillType == "Zarek")
               {
                    Magikill.setItem(_mc,"Zarek Staff","Zarek Crown","Blank");
               }
               else if(this.magikillType == "Zarek_2")
               {
                    Magikill.setItem(_mc,"Zarek Staff","Zarek Crown","Blank");
               }
               else if(this.magikillType == "SW3Mage")
               {
                    Magikill.setItem(_mc,"Gold Staff","Gold Hat","Grey Beard");
               }
               else if(this.magikillType == "GoldMage")
               {
                    Magikill.setItem(_mc,"Gold Staff 2","Golden Hat","");
               }
               else if(this.magikillType == "SavageMage")
               {
                    Magikill.setItem(_mc,"Savage Staff","Savage Hat","");
               }
               else if(this.magikillType == "CrystalMage")
               {
                    Magikill.setItem(_mc,"Crystal Staff 2","Crystal Hat","");
               }
               else
               {
                    Magikill.setItem(_mc,"","","");
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
          
          private function shieldHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(this.stunned == null && param1.team != this.team && param1.pz == 0)
               {
                    if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(5 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                    {
                         this.stunned = param1;
                         param1.damage(0,this.damageToDeal,this);
                         param1.stun(this.stunTime);
                         param1.applyVelocity(this.stunForce * Util.sgn(mc.scaleX));
                    }
               }
          }
          
          protected function checkForBlockHit() : Boolean
          {
               this.stunned = null;
               team.game.spatialHash.mapInArea(px,py,px + 30,py + 30,this.shieldHit);
               return true;
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
          
          override public function get damageToArmour() : Number
          {
               if(this.magikillType == "Zarek")
               {
                    return 450;
               }
               if(this.magikillType == "Zarek_2")
               {
                    return 2500;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.magikillType == "Zarek")
               {
                    return 450;
               }
               if(this.magikillType == "Zarek_2")
               {
                    return 2500;
               }
               return _damageToNotArmour;
          }
          
          override public function isBusy() : Boolean
          {
               return !this.notInSpell() || isBusyForSpell;
          }
          
          private function notInSpell() : Boolean
          {
               return !this.isPoisonDarting && !this.isStunning && !this.isNuking;
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
               if(this.magikillType == "Zarek")
               {
                    this.isBlocking = true;
                    this.inBlock = true;
               }
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
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.magikillType == "Zarek")
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
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
