package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.SwordwrathAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.filters.GlowFilter;
     
     public class Swordwrath extends Unit
     {
          
          private static var WEAPON_REACH:int;
          
          private static var RAGE_COOLDOWN:int;
          
          private static var RAGE_EFFECT:int;
           
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var healthLoss:int;
          
          private var damageIncrease:Number;
          
          private var rageSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var rageSpellGlow:GlowFilter;
          
          private var normalMaxVelocity:Number;
          
          private var rageMaxVelocity:Number;
          
          public var swordwrathType:String;
          
          private var setupComplete:Boolean;
          
          private var lastWasStanding:Boolean;
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Swordwrath;
          
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
               this.rageSpellGlow.blurX = 0;
               this.rageSpellGlow.blurY = 0;
               this.lastWasStanding = false;
               this.swordwrathType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_swordwrath = null;
               if((_loc5_ = _swordwrath(param1)).mc.sword)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.sword.gotoAndStop(param2);
                    }
               }
               if(_loc5_.mc.head)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.head.gotoAndStop(param3);
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
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
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
               this.maxTargetsToHit = param1.xml.xml.Chaos.Units.giant.maxTargetsToHit;
               this.radiantDamage = param1.xml.xml.Elemental.Units.lavaElement.radiant.damage;
               this.radiantRange = param1.xml.xml.Elemental.Units.lavaElement.radiant.range;
               this.radiantFrames = param1.xml.xml.Elemental.Units.lavaElement.radiant.frames;
               this.maxTargetsToHit = param1.xml.xml.Chaos.Units.giant.maxTargetsToHit;
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
               return damageToDeal;
          }
          
          private function burnInArea(param1:Unit) : *
          {
               if(param1.team != this.team)
               {
                    if(this.swordwrathType == "Wrathnar")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              param1.setFire(150,0.8);
                         }
                    }
                    else if(param1.team != this.team && this.swordwrathType == "Wrathnar_2")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              param1.setFire(150,0.8);
                         }
                    }
                    else if(this.swordwrathType == "Crystalsickle" || this.swordwrathType == "Sicklewrath")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(!hasHit && _mc.mc.currentFrame == 12)
                              {
                                   param1.damage(0,8,this);
                              }
                         }
                    }
                    else if(this.swordwrathType == "Voltsickle")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(!hasHit && _mc.mc.currentFrame == 12)
                              {
                                   param1.damage(0,8,this);
                              }
                         }
                    }
                    else if(this.swordwrathType == "SickleLeader")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(!hasHit && _mc.mc.currentFrame == 12)
                              {
                                   param1.damage(0,this.damageToDeal,this);
                              }
                         }
                    }
                    else if(this.swordwrathType == "Sicklebear")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(!hasHit && _mc.mc.currentFrame == 12)
                              {
                                   param1.damage(0,this.damageToDeal,this);
                              }
                         }
                    }
               }
               else if(param1.team == this.team)
               {
                    if(this.swordwrathType == "Just_K")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(this.rageSpell.inEffect())
                              {
                                   param1.isArmoured = true;
                                   param1.protect(90);
                              }
                         }
                    }
               }
          }
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:String = null;
               this.rageSpell.update();
               updateCommon(param1);
               maxHealthIncrease = true;
               if(isUC)
               {
                    this.normalMaxVelocity = param1.xml.xml.Order.Units.swordwrath.maxVelocity * 1.2;
                    this.rageMaxVelocity = param1.xml.xml.Order.Units.swordwrath.rage.rageMaxVelocity * 1.2;
                    _damageToNotArmour = (Number(param1.xml.xml.Order.Units.swordwrath.damage) + Number(param1.xml.xml.Order.Units.swordwrath.toNotArmour)) * 2.5;
                    _damageToArmour = (Number(param1.xml.xml.Order.Units.swordwrath.damage) + Number(param1.xml.xml.Order.Units.swordwrath.toArmour)) * 4;
               }
               else if(!team.isEnemy)
               {
                    this.normalMaxVelocity = param1.xml.xml.Order.Units.swordwrath.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Order.Units.swordwrath.damage) + Number(param1.xml.xml.Order.Units.swordwrath.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Order.Units.swordwrath.damage) + Number(param1.xml.xml.Order.Units.swordwrath.toArmour);
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    health *= 1;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    enemyBuffed = true;
               }
               if(this.swordwrathType == "Wrathnar" || this.swordwrathType == "Just_K" || this.swordwrathType == "Sicklebear" || this.swordwrathType == "SickleLeader" || this.swordwrathType == "Voltsickle" || this.swordwrathType == "Wrathnar_2" || this.swordwrathType == "Crystalsickle" || this.swordwrathType == "Sicklewrath" || this.swordwrathType == "")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               if(this.swordwrathType == "Xenophon" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    noStone = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    this.ABoss = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xenophon","Stone","");
                    maxHealth = 3000;
                    health = 3000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "XenoClone" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xenophon","","");
                    maxHealth = 200;
                    health = 200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "VoltSword" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    isVoltaic = true;
                    this.isASuperUnit = true;
                    maxHealthIncrease = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Voltaic Sword 1","Voltaic Helmet 1","");
                    maxHealth = 120;
                    health = 120;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "VoltSword_2" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    GeneralIsVoltaic = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    maxHealthIncrease = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Voltaic Sword 2","Voltaic Helmet 2","");
                    maxHealth = 450;
                    health = 450;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.enableHealNum = true;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "NativeXeno" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    this.isABoss = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Native Xeno Sword","Native Xeno Helmet","");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Just_K" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    this.isASuperUnit = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Just K Sword","Just K Helmet","");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.shieldwallDamageReduction = 0.48;
                    this.radiantRange = 400;
                    this.rageSpell = new com.brockw.stickwar.engine.units.SpellCooldown(300,900,param1.xml.xml.Order.Units.swordwrath.rage.mana);
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "NativeXenoClone" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Native Xeno Sword","","");
                    maxHealth = 200;
                    health = 200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "SpikeSword" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Spike Club","","");
                    maxHealth = 135;
                    health = 135;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Clubwrath" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Club","","");
                    maxHealth = 165;
                    health = 165;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Sword_1" && !this.setupComplete)
               {
                    blueColor = true;
                    unitRegen = true;
                    LightVampRegen = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"","","");
                    maxHealth = 105;
                    health = 105;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Sword_2" && !this.setupComplete)
               {
                    redColor = true;
                    unitRegen = true;
                    LightVampRegen = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"","","");
                    maxHealth = 105;
                    health = 105;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Minion" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Pitchfork","","");
                    maxHealth = 90;
                    health = 90;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Minion_2" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Minion Sword","Minion Helmet","");
                    maxHealth = 90;
                    health = 90;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "MinionBomber" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Dynamite","","");
                    maxHealth = 49000;
                    health = 49000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.7;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Xiphos" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xiphos Sword","","");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.isReflective = true;
                    this.shieldwallDamageReduction = 0.62;
                    this.rageSpell = new com.brockw.stickwar.engine.units.SpellCooldown(300,900,param1.xml.xml.Order.Units.swordwrath.rage.mana);
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Xiphos_2" && !this.setupComplete)
               {
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xiphos Sword 2","","");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.isReflective = true;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Wrathnar" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Wrathnar Sword","","");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.isReflective = true;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Wrathnar_2" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Wrathnar Sword","","");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.isReflective = true;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "BloodBlade" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Blood Blade","","");
                    unitRegen = true;
                    maxHealth = 120;
                    health = 120;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "CorruptBloodBlade" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Baron Blade 2","Corrupt Blood Mask","");
                    maxHealth = 120;
                    health = 30;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "IceSword" && !this.setupComplete)
               {
                    freezeUnit = true;
                    weakToFire = true;
                    slowRegen = true;
                    selfFreeze = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Ice Sword","Ice","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "IceSword_2" && !this.setupComplete)
               {
                    freezeUnit = true;
                    weakToFire = true;
                    slowRegen = true;
                    selfFreeze = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Ice Sword 2","Ice Helmet 2","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "CrystalSword" && !this.setupComplete)
               {
                    frozenUnit = true;
                    slowRegen = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Crystal Sword","Crystal Helmet","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.rageSpellGlow.color = 65535;
                    this.rageSpellGlow.blurX = 10;
                    this.rageSpellGlow.blurY = 10;
                    this.mc.filters = [this.rageSpellGlow];
                    this.shieldwallDamageReduction = 0.85;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Crystalsickle" && !this.setupComplete)
               {
                    frozenUnit = true;
                    slowRegen = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Crystal Sickle","","");
                    maxHealth = 80;
                    health = 80;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.shieldwallDamageReduction = 0.85;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "FireSword" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    this.isReflective = true;
                    weakToIce = true;
                    removeIce = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Flame Sword","Lava 2","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "MoltenSword" && !this.setupComplete)
               {
                    meltUnit = true;
                    fireRegen = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Molten Sword","","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "MoltenSword_2" && !this.setupComplete)
               {
                    meltUnit = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Molten Sword 2","","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "SavageSword" && !this.setupComplete)
               {
                    stunUnit = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Savage Sword","Savage Helmet","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Prince_1" && !this.setupComplete)
               {
                    this.isASuperUnit = true;
                    this.shieldwallDamageReduction = 0.48;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Golden Sword 2","Prince 1","");
                    maxHealth = 2530;
                    health = 2530;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.rageSpell = new com.brockw.stickwar.engine.units.SpellCooldown(300,900,param1.xml.xml.Order.Units.swordwrath.rage.mana);
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "SavageSwordPrince" && !this.setupComplete)
               {
                    stunUnit = true;
                    this.isABoss = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Savage Sword","Savage Helmet","");
                    maxHealth = 2230;
                    health = 2230;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.6;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "LeafSwordPrince" && !this.setupComplete)
               {
                    this.isABoss = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Leaf Sword","Leaf","");
                    maxHealth = 2230;
                    health = 2230;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.6;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "LeafSword" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Leaf Sword","Leaf","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "LeafSword_2" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Leaf Sword 2","Leaf 2","");
                    maxHealth = 110;
                    health = 110;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Baron" && !this.setupComplete)
               {
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Blood Blade","Lava","");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5.1;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "CorruptBaron" && !this.setupComplete)
               {
                    generalRegen = true;
                    generalRegen2 = true;
                    FullHealthRegen = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Baron Blade","Corrupt Baron","");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5.1;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Sicklewrath" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Sickle","","");
                    maxHealth = 50;
                    health = 50;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "SickleGeneral" && !this.setupComplete)
               {
                    stunUnit = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Sickle","","");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.5;
                    _maxVelocity = 3.5;
                    this.maxTargetsToHit = 6;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Sicklebear" && !this.setupComplete)
               {
                    stunUnit = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Sicklebear Sickle","Sicklebear","");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 6.5;
                    this.maxTargetsToHit = 6;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "SickleLeader" && !this.setupComplete)
               {
                    stunUnit = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Sickle","Sicklehat","");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.maxTargetsToHit = 6;
                    this.shieldwallDamageReduction = 0.48;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "ChaosSickle" && !this.setupComplete)
               {
                    stunUnit = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Chaos Sickle","Chaos Helmet","");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Leafsickle" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Leaf Sickle","","");
                    maxHealth = 90;
                    health = 90;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 8.3;
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Icesickle" && !this.setupComplete)
               {
                    frozenUnit = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Ice Sickle","","");
                    maxHealth = 90;
                    health = 90;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.1;
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Savagesickle" && !this.setupComplete)
               {
                    stunUnit = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Savage Sickle","","");
                    maxHealth = 90;
                    health = 90;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 8.3;
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Lavasickle" && !this.setupComplete)
               {
                    fireRegen = true;
                    burnUnit = true;
                    this.ai.archerTargeter = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Lava Sickle","","");
                    maxHealth = 90;
                    health = 90;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5.1;
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Voltsickle" && !this.setupComplete)
               {
                    isVoltaic = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Voltaic Sickle","","");
                    maxHealth = 50;
                    health = 50;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.1;
                    this.maxTargetsToHit = 6;
                    this.radiantRange = 200;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "Vampsickle" && !this.setupComplete)
               {
                    poisonRegen = true;
                    LightVampRegen = true;
                    LightVampCure = true;
                    isVampUnit = true;
                    lifeSteal = true;
                    lifeStealAmount = 10;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Vamp Sickle","","");
                    maxHealth = 130;
                    health = 130;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.1;
                    this.maxTargetsToHit = 6;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "VampSword" && !this.setupComplete)
               {
                    isVampUnit = true;
                    LightVampRegen = true;
                    LightVampCure = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Vamp Sword","Vamp Helmet","");
                    maxHealth = 125;
                    health = 125;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.1;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "GoldSword" && !this.setupComplete)
               {
                    this.isAGoldenUnit = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Golden Sword","Golden Helmet","");
                    nonTeleportable = true;
                    maxHealth = 550;
                    health = 550;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "GoldSword_2" && !this.setupComplete)
               {
                    this.isAGoldenUnit = true;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Golden Sword 2","","");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "SW1_Sword1" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"SW Sword 1","","");
                    maxHealth = 275;
                    health = 275;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "MegaSword" && !this.setupComplete)
               {
                    slowAttack = true;
                    this.healthBar.visible = false;
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Pitchfork","","");
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.4;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType == "SW1_Sword2" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"SW Sword 2","","");
                    maxHealth = 390;
                    health = 390;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.swordwrathType != "")
               {
                    isCustomUnit = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.swordwrathType == "Wrathnar")
                    {
                         this.radiantRange = 230;
                         this.normalMaxVelocity = 5.9;
                    }
                    else if(isUC)
                    {
                         this.normalMaxVelocity *= 1.5;
                    }
                    else if(this.swordwrathType == "Wrathnar_2")
                    {
                         this.radiantRange = 230;
                         this.normalMaxVelocity = 6.1;
                    }
                    else if(this.swordwrathType == "Crystalsickle" || this.swordwrathType == "Sicklewrath")
                    {
                         stunTimeLeft = 0;
                         this.radiantRange = 230;
                    }
                    else if(this.swordwrathType == "SickleLeader" || this.swordwrathType == "Sicklebear")
                    {
                         this.radiantRange = 170;
                         stunTimeLeft = 0;
                    }
                    else if(this.swordwrathType == "Baron" || this.swordwrathType == "CorruptBaron" || this.swordwrathType == "Sicklebear" || this.swordwrathType == "SickleLeader" || this.swordwrathType == "BloodBlade" || this.swordwrathType == "CorruptBloodBlade")
                    {
                         this.normalMaxVelocity = 5.6;
                    }
                    else if(this.swordwrathType == "Savagesickle" || this.swordwrathType == "SavageSword")
                    {
                         stunTimeLeft = 0;
                         this.normalMaxVelocity = 8.3;
                    }
                    else if(this.swordwrathType == "SavageSwordPrince" || this.swordwrathType == "LeafSwordPrince")
                    {
                         stunTimeLeft = 0;
                         this.normalMaxVelocity = 4;
                    }
                    else if(this.swordwrathType == "Leafsickle" || this.swordwrathType == "LeafSword" || this.swordwrathType == "LeafSword_2")
                    {
                         this.normalMaxVelocity = 8.3;
                    }
                    else if(this.swordwrathType == "Xenophon")
                    {
                         this.normalMaxVelocity = 6.2;
                    }
                    else if(this.swordwrathType == "NativeXeno")
                    {
                         this.normalMaxVelocity = 6.2;
                    }
                    else if(this.swordwrathType == "Minion")
                    {
                         this.normalMaxVelocity = 6.5;
                    }
                    else if(this.swordwrathType == "SW1_Sword1")
                    {
                         this.normalMaxVelocity = 6.1;
                    }
                    else if(this.swordwrathType == "SW1_Sword2")
                    {
                         this.normalMaxVelocity = 8.1;
                    }
                    else if(this.swordwrathType == "MinionBomber")
                    {
                         this.normalMaxVelocity = 8.1;
                    }
                    else if(this.swordwrathType == "Just_K")
                    {
                         this.rageMaxVelocity = 15;
                         this.normalMaxVelocity = 8;
                         this.damageIncrease = 325;
                    }
                    else if(this.swordwrathType == "Prince_1")
                    {
                         this.rageMaxVelocity = 25;
                         this.damageIncrease = 250;
                    }
                    else if(this.swordwrathType == "Xiphos")
                    {
                         this.damageIncrease = 315;
                    }
                    else if(this.swordwrathType == "GoldSword")
                    {
                         this.rageMaxVelocity = 9;
                         this.normalMaxVelocity = 6;
                         this.damageIncrease = 175;
                    }
                    else
                    {
                         this.rageMaxVelocity = param1.xml.xml.Order.Units.swordwrath.rage.rageMaxVelocity;
                         this.damageIncrease = param1.xml.xml.Order.Units.swordwrath.rage.damageIncrease;
                         _maxVelocity = this.normalMaxVelocity;
                    }
               }
               if(this.swordwrathType == "NativeXeno" || this.swordwrathType == "Just_K" || this.swordwrathType == "GoldSword" || this.swordwrathType == "Xiphos_2" || this.swordwrathType == "Wrathnar_2" || this.swordwrathType == "Xenophon" || this.swordwrathType == "Xiphos" || this.swordwrathType == "Wrathnar" || this.swordwrathType == "SickleGeneral" || this.swordwrathType == "Baron")
               {
                    slowFramesRemaining = 0;
                    stunTimeLeft = 0;
               }
               if(this.swordwrathType == "Baron")
               {
                    slowFramesRemaining = 0;
               }
               if(this.rageSpell.inEffect())
               {
                    this.rageSpellGlow.blurX = 9 + 6 * Util.sin(20 * Math.PI * this.rageSpell.timeRunning() / RAGE_EFFECT);
                    this.rageSpellGlow.blurY = 10;
                    this.mc.filters = [this.rageSpellGlow];
                    _maxVelocity = this.rageMaxVelocity;
                    if(this.swordwrathType == "GoldSword")
                    {
                         goldenColor = true;
                         this.protect(275);
                    }
                    else if(this.swordwrathType == "Just_K")
                    {
                         goldenColor = true;
                         this.isArmoured = true;
                         this.rageSpellGlow.color = 16776960;
                         this.rageSpellGlow.blurX = 10;
                         this.rageSpellGlow.blurY = 10;
                         this.mc.filters = [this.rageSpellGlow];
                    }
                    else if(this.swordwrathType == "Wrathnar")
                    {
                         this.radiantRange = 900;
                         this.rageSpellGlow.color = 16711680;
                         this.rageSpellGlow.blurX = 10;
                         this.rageSpellGlow.blurY = 10;
                         this.mc.filters = [this.rageSpellGlow];
                    }
               }
               else if(this.swordwrathType == "CrystalSword" || this.swordwrathType == "Crystalsickle")
               {
                    this.rageSpellGlow.color = 65535;
                    this.rageSpellGlow.blurX = 10;
                    this.rageSpellGlow.blurY = 10;
                    this.mc.filters = [this.rageSpellGlow];
               }
               else
               {
                    if(this.swordwrathType == "Wrathnar")
                    {
                         this.radiantRange = 230;
                    }
                    this.isArmoured = false;
                    goldenColor = false;
                    this.mc.filters = [];
                    _maxVelocity = this.normalMaxVelocity;
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
                         if(team.isEnemy)
                         {
                              if(!this.rageSpell.inEffect() && team.tech.isResearched(Tech.SWORDWRATH_RAGE) && this.rageCooldown() <= 0 && this.health <= this.maxHealth / 2)
                              {
                                   this.rageSpell.spellActivate(team);
                                   team.game.soundManager.playSoundRandom("Rage",3,px,py);
                              }
                         }
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
                         if(this.swordwrathType == "MinionBomber")
                         {
                              this.damage(0,1000,null);
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
                         if(this.swordwrathType == "Savagesickle" || this.swordwrathType == "SavageSword")
                         {
                              MovieClip(_mc.mc).nextFrame();
                         }
                    }
                    updateMotion(param1);
               }
               else if(isDead == false)
               {
                    if(this.swordwrathType == "Xenophon")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "XenoClone";
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "XenoClone";
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "XenoClone";
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "XenoClone";
                    }
                    if(this.swordwrathType == "NativeXeno")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "XenoClone";
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "NativeXenoClone";
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "NativeXenoClone";
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_SWORDWRATH);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.swordwrathType = "NativeXenoClone";
                    }
                    if(this.swordwrathType == "")
                    {
                         param1.projectileManager.initNuke(px,py,this,10,0.2,200);
                    }
                    if(this.swordwrathType == "Wrathnar")
                    {
                         param1.projectileManager.initNuke(px,py,this,50,0.8,100);
                         team.gold += 50;
                    }
                    if(this.swordwrathType == "VoltSword" || this.swordwrathType == "VoltSword_2")
                    {
                         param1.projectileManager.initStun(this.px,py,35,this);
                    }
                    if(this.swordwrathType == "Xiphos")
                    {
                         team.gold += 300;
                    }
                    if(this.swordwrathType == "MinionBomber")
                    {
                         param1.soundManager.playSoundRandom("mediumExplosion",3,px,py);
                         param1.projectileManager.initNuke(px,py,this,15000,50,250);
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
               if(this.swordwrathType == "Xenophon")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xenophon","Lava","");
               }
               else if(this.swordwrathType == "NativeXeno")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Native Xeno Sword","Native Xeno Helmet","");
               }
               else if(this.swordwrathType == "XenoClone")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xenophon","","");
               }
               else if(this.swordwrathType == "NativeXenoClone")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Native Xeno Sword","","");
               }
               else if(this.swordwrathType == "BloodBlade")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Blood Blade","","");
               }
               else if(this.swordwrathType == "CorruptBloodBlade")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Baron Blade 2","Corrupt Blood Mask","");
               }
               else if(this.swordwrathType == "Baron")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Blood Blade","Lava","");
               }
               else if(this.swordwrathType == "CorruptBaron")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Baron Blade","Corrupt Baron","");
               }
               else if(this.swordwrathType == "Sicklewrath")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Sickle","","");
               }
               else if(this.swordwrathType == "SickleGeneral")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Sickle","","");
               }
               else if(this.swordwrathType == "SickleLeader")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Sickle","Sicklehat","");
               }
               else if(this.swordwrathType == "Sicklebear")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Sicklebear Sickle","Sicklebear","");
               }
               if(this.swordwrathType == "ChaosSickle")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Chaos Sickle","Chaos Helmet","");
               }
               else if(this.swordwrathType == "Leafsickle")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Leaf Sickle","","");
               }
               else if(this.swordwrathType == "Icesickle")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Ice Sickle","","");
               }
               else if(this.swordwrathType == "Savagesickle")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Savage Sickle","","");
               }
               else if(this.swordwrathType == "Lavasickle")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Lava Sickle","","");
               }
               else if(this.swordwrathType == "Voltsickle")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Voltaic Sickle","","");
               }
               else if(this.swordwrathType == "Vampsickle")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Vamp Sickle","","");
               }
               else if(this.swordwrathType == "GoldSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Golden Sword","Golden Helmet","");
               }
               else if(this.swordwrathType == "VampSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Vamp Sword","Vamp Helmet","");
               }
               else if(this.swordwrathType == "GoldSword_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Golden Sword 2","","");
               }
               else if(this.swordwrathType == "Xiphos")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xiphos Sword","","");
               }
               else if(this.swordwrathType == "Xiphos_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Xiphos Sword 2","","");
               }
               else if(this.swordwrathType == "Just_K")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Just K Sword","Just K Helmet","");
               }
               else if(this.swordwrathType == "Wrathnar")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Wrathnar Sword","","");
               }
               else if(this.swordwrathType == "Wrathnar_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Wrathnar Sword","","");
               }
               else if(this.swordwrathType == "IceSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Ice Sword","Ice","");
               }
               else if(this.swordwrathType == "IceSword_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Ice Sword 2","Ice Helmet 2","");
               }
               else if(this.swordwrathType == "FireSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Flame Sword","Lava 2","");
               }
               else if(this.swordwrathType == "MoltenSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Molten Sword","","");
               }
               else if(this.swordwrathType == "MoltenSword_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Molten Sword 2","","");
               }
               else if(this.swordwrathType == "Clone")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Pirate Sword","","");
               }
               else if(this.swordwrathType == "SpikeSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Spike Club","","");
               }
               else if(this.swordwrathType == "Clubwrath")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Club","","");
               }
               else if(this.swordwrathType == "Minion")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Pitchfork","","");
               }
               else if(this.swordwrathType == "Minion_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Minion Sword","Minion Helmet","");
               }
               else if(this.swordwrathType == "MinionBomber")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Dynamite","","");
               }
               else if(this.swordwrathType == "SW1_Sword1")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"SW Sword 1","","");
               }
               else if(this.swordwrathType == "MegaSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Pitchfork","","");
               }
               else if(this.swordwrathType == "SW1_Sword2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"SW Sword 2","","");
               }
               else if(this.swordwrathType == "LeafSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Leaf Sword","Leaf","");
               }
               else if(this.swordwrathType == "LeafSword_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Leaf Sword 2","Leaf 2","");
               }
               else if(this.swordwrathType == "SavageSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Savage Sword","Savage Helmet","");
               }
               else if(this.swordwrathType == "SavageSwordPrince")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Savage Sword","Savage Helmet","");
               }
               else if(this.swordwrathType == "LeafSwordPrince")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Leaf Sword","Leaf","");
               }
               else if(this.swordwrathType == "Prince_1")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Golden Sword 2","Prince 1","");
               }
               else if(this.swordwrathType == "CrystalSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Crystal Sword","Crystal Helmet","");
               }
               else if(this.swordwrathType == "Crystalsickle")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Crystal Sickle","","");
               }
               else if(this.swordwrathType == "VoltSword")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Voltaic Sword 1","Voltaic Helmet 1","");
               }
               else if(this.swordwrathType == "VoltSword_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"Voltaic Sword 2","Voltaic Helmet 2","");
               }
               else if(this.swordwrathType == "Sword_1")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"","","");
               }
               else if(this.swordwrathType == "Sword_2")
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"","","");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Swordwrath.setItem(_mc,"","","");
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
               if(this.swordwrathType == "Sword_1")
               {
                    return 1;
               }
               if(this.swordwrathType == "Sword_2")
               {
                    return 44;
               }
               if(this.swordwrathType == "MoltenSword" || this.swordwrathType == "MoltenSword_2")
               {
                    return 0;
               }
               if(this.swordwrathType == "Sicklewrath")
               {
                    return 8;
               }
               if(this.swordwrathType == "Xiphos")
               {
                    return 180;
               }
               if(this.swordwrathType == "VoltSword_2")
               {
                    return 60;
               }
               if(this.swordwrathType == "MegaSword")
               {
                    return 120;
               }
               if(this.swordwrathType == "GoldSword")
               {
                    return 150;
               }
               if(this.swordwrathType == "GoldSword_2")
               {
                    return 100;
               }
               if(this.swordwrathType == "Prince_1")
               {
                    return 200;
               }
               if(this.swordwrathType == "SavageSwordPrince")
               {
                    return 250;
               }
               if(this.swordwrathType == "LeafSwordPrince")
               {
                    return 250;
               }
               if(this.swordwrathType == "Minion")
               {
                    return 10;
               }
               if(this.swordwrathType == "Minion_2")
               {
                    return 10;
               }
               if(this.swordwrathType == "Xenophon")
               {
                    return 500;
               }
               if(this.swordwrathType == "NativeXeno")
               {
                    return 250;
               }
               if(this.swordwrathType == "XenoClone")
               {
                    return 65;
               }
               if(this.swordwrathType == "NativeXenoClone")
               {
                    return 75;
               }
               if(this.swordwrathType == "Just_K")
               {
                    return 200;
               }
               if(this.swordwrathType == "Xiphos_2")
               {
                    return 260;
               }
               if(this.swordwrathType == "Wrathnar")
               {
                    return 140;
               }
               if(this.swordwrathType == "Wrathnar_2")
               {
                    return 210;
               }
               if(this.swordwrathType == "Baron")
               {
                    return 160;
               }
               if(this.swordwrathType == "BloodBlade")
               {
                    return 65;
               }
               if(this.swordwrathType == "SickleGeneral")
               {
                    return 65;
               }
               if(this.swordwrathType == "SickleLeader")
               {
                    return 80;
               }
               if(this.swordwrathType == "Sicklebear")
               {
                    return 35;
               }
               if(this.swordwrathType == "SpikeSword")
               {
                    return 10;
               }
               if(this.swordwrathType == "Clubwrath")
               {
                    return 45;
               }
               if(this.swordwrathType == "SW1_Sword1")
               {
                    return 45;
               }
               if(this.swordwrathType == "SW1_Sword2")
               {
                    return 45;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.rageSpell.inEffect())
               {
                    return _damageToNotArmour + this.damageIncrease;
               }
               if(this.swordwrathType == "Sword_1")
               {
                    return 58;
               }
               if(this.swordwrathType == "Sword_2")
               {
                    return 1;
               }
               if(this.swordwrathType == "MoltenSword" || this.swordwrathType == "MoltenSword_2")
               {
                    return 0;
               }
               if(this.swordwrathType == "Prince_1")
               {
                    return 145;
               }
               if(this.swordwrathType == "SavageSwordPrince")
               {
                    return 100;
               }
               if(this.swordwrathType == "LeafSwordPrince")
               {
                    return 100;
               }
               if(this.swordwrathType == "MegaSword")
               {
                    return 75;
               }
               if(this.swordwrathType == "SW1_Sword1")
               {
                    return 45;
               }
               if(this.swordwrathType == "SW1_Sword2")
               {
                    return 45;
               }
               if(this.swordwrathType == "SpikeSword")
               {
                    return 10;
               }
               if(this.swordwrathType == "Clubwrath")
               {
                    return 85;
               }
               if(this.swordwrathType == "GoldSword")
               {
                    return 90;
               }
               if(this.swordwrathType == "GoldSword_2")
               {
                    return 80;
               }
               if(this.swordwrathType == "Minion")
               {
                    return 10;
               }
               if(this.swordwrathType == "Minion_2")
               {
                    return 10;
               }
               if(this.swordwrathType == "Xenophon")
               {
                    return 200;
               }
               if(this.swordwrathType == "NativeXeno")
               {
                    return 220;
               }
               if(this.swordwrathType == "XenoClone")
               {
                    return 50;
               }
               if(this.swordwrathType == "NativeXenoClone")
               {
                    return 60;
               }
               if(this.swordwrathType == "Clone")
               {
                    return 40;
               }
               if(this.swordwrathType == "Just_K")
               {
                    return 160;
               }
               if(this.swordwrathType == "Xiphos")
               {
                    return 85;
               }
               if(this.swordwrathType == "VoltSword_2")
               {
                    return 20;
               }
               if(this.swordwrathType == "Xiphos_2")
               {
                    return 200;
               }
               if(this.swordwrathType == "Wrathnar")
               {
                    return 85;
               }
               if(this.swordwrathType == "Wrathnar_2")
               {
                    return 210;
               }
               if(this.swordwrathType == "Baron")
               {
                    return 95;
               }
               if(this.swordwrathType == "BloodBlade")
               {
                    return 30;
               }
               if(this.swordwrathType == "SickleGeneral")
               {
                    return 55;
               }
               if(this.swordwrathType == "SickleLeader")
               {
                    return 55;
               }
               if(this.swordwrathType == "Sicklebear")
               {
                    return 40;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(team.tech.isResearched(Tech.SWORDWRATH_RAGE))
               {
                    param1.setAction(0,0,UnitCommand.SWORDWRATH_RAGE);
               }
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
               if(this.swordwrathType == "GoldSword_2")
               {
                    this.isBlocking = true;
                    this.inBlock = true;
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
                         this.heal(1,this.healthLoss);
                         team.game.soundManager.playSoundRandom("Rage",3,px,py);
                    }
               }
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.swordwrathType == "Sicklebear" || this.swordwrathType == "SickleLeader" || this.swordwrathType == "Crystalsickle" || this.swordwrathType == "CrystalSword" || this.swordwrathType == "SickleGeneral" || this.swordwrathType == "Baron" || this.swordwrathType == "SickleLeader" || this.swordwrathType == "Xenophon" || this.swordwrathType == "Wrathnar_2" || this.swordwrathType == "Wrathnar" || this.swordwrathType == "Xiphos_2" || this.swordwrathType == "Xiphos" || this.swordwrathType == "SavageSwordPrince" || this.swordwrathType == "LeafSwordPrince")
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
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
                    if(this.rageSpell.inEffect())
                    {
                         framesInAttack = MovieClip(_mc.mc).totalFrames / 2;
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
