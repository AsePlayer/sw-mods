package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.SpeartonAi;
     import com.brockw.stickwar.engine.Ai.command.HoldCommand;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.filters.DropShadowFilter;
     import flash.filters.GlowFilter;
     
     public class Spearton extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
          
          private static var RAGE_COOLDOWN:int;
          
          private static var RAGE_EFFECT:int;
           
          
          private var clusterLad:com.brockw.stickwar.engine.units.Spearton;
          
          private var invisSpearGlow:DropShadowFilter;
          
          private var convertedUnit:com.brockw.stickwar.engine.units.Unit;
          
          private var currentTarget:com.brockw.stickwar.engine.units.Unit;
          
          private var radiantSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          public var speartonType:String;
          
          private var setupComplete:Boolean;
          
          private var shieldBashSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var isShieldBashing:Boolean;
          
          private var stunForce:Number;
          
          private var stunDamage:Number;
          
          private var stunRange:Number;
          
          private var burrowDamage:Number;
          
          private var burrowStun:Number;
          
          private var stunTime:int;
          
          private var stunned:com.brockw.stickwar.engine.units.Unit;
          
          private var shieldRange:Number;
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
          private var frames:int;
          
          private var speartonGlow:GlowFilter;
          
          private var damageIncrease:Number;
          
          private var divider:String;
          
          private var comment:String;
          
          private var randomNumber:int;
          
          private var RandomSpeed:int;
          
          private var RandomHealth:int;
          
          private var RandomLightDamage:int;
          
          private var RandomHeavyDamage:int;
          
          private var RandomScale:int;
          
          internal var Scale:Array;
          
          internal var HeavyDamage:Array;
          
          internal var LightDamage:Array;
          
          internal var Speed:Array;
          
          public function Spearton(param1:StickWar)
          {
               super(param1);
               _mc = new _speartonMc();
               this.init(param1);
               addChild(_mc);
               ai = new SpeartonAi(this);
               initSync();
               firstInit();
               this.frames = 0;
               this.HeavyDamage = [3,8,10,13,25,6,2,50,18,500];
               this.LightDamage = [6,10,14,18,28,36,12,1,5,800];
               this.Scale = [0.5,0.4,0.7,1.1,1.8,2.3,3.2,1.7];
               this.Speed = [0.7,0.4,1.5,2.4,3.6,5,7,10,13];
               this.speartonGlow = new GlowFilter();
               this.speartonGlow.color = 16711680;
               this.speartonGlow.blurX = 10;
               this.speartonGlow.blurY = 10;
               this.speartonType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_speartonMc = null;
               if((_loc5_ = _speartonMc(param1)).mc.helm)
               {
                    if(param3 != "")
                    {
                         _loc5_.mc.helm.gotoAndStop(param3);
                    }
               }
               if(_loc5_.mc.spear)
               {
                    if(param2 != "")
                    {
                         _loc5_.mc.spear.gotoAndStop(param2);
                    }
               }
               if(_loc5_.mc.shield)
               {
                    if(param4 != "")
                    {
                         _loc5_.mc.shield.gotoAndStop(param4);
                    }
               }
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               this.convertedUnit = null;
               this.currentTarget = null;
               this.inBlock = false;
               this.isBlocking = false;
               WEAPON_REACH = param1.xml.xml.Order.Units.spearton.weaponReach;
               this.stunTime = param1.xml.xml.Order.Units.spearton.shieldBash.stunTime;
               this.stunForce = param1.xml.xml.Order.Units.spearton.shieldBash.stunForce;
               this.shieldRange = param1.xml.xml.Order.Units.spearton.shieldBash.range;
               this.stunDamage = param1.xml.xml.Order.Units.spearton.shieldBash.damage;
               population = param1.xml.xml.Order.Units.spearton.population;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               _mass = param1.xml.xml.Order.Units.spearton.mass;
               _maxForce = param1.xml.xml.Order.Units.spearton.maxForce;
               _dragForce = param1.xml.xml.Order.Units.spearton.dragForce;
               _scale = param1.xml.xml.Order.Units.spearton.scale;
               _maxVelocity = param1.xml.xml.Order.Units.spearton.maxVelocity;
               damageToDeal = param1.xml.xml.Order.Units.spearton.baseDamage;
               this.createTime = param1.xml.xml.Order.Units.spearton.cooldown;
               maxHealth = health = param1.xml.xml.Order.Units.spearton.health;
               this.invisSpearGlow = new DropShadowFilter();
               this.invisSpearGlow.knockout = true;
               this.invisSpearGlow.angle = 0;
               this.invisSpearGlow.distance = 0;
               this.invisSpearGlow.color = 0;
               this.maxTargetsToHit = 0;
               this.stunRange = param1.xml.xml.Elemental.Units.lavaElement.burrow.range;
               this.burrowDamage = param1.xml.xml.Elemental.Units.lavaElement.burrow.damage;
               this.burrowStun = param1.xml.xml.Elemental.Units.lavaElement.burrow.stun;
               this.radiantDamage = param1.xml.xml.Elemental.Units.lavaElement.radiant.damage;
               this.radiantRange = param1.xml.xml.Elemental.Units.lavaElement.radiant.range;
               this.radiantFrames = param1.xml.xml.Elemental.Units.lavaElement.radiant.frames;
               type = com.brockw.stickwar.engine.units.Unit.U_SPEARTON;
               loadDamage(param1.xml.xml.Order.Units.spearton);
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               this.isShieldBashing = false;
               this.shieldBashSpell = new com.brockw.stickwar.engine.units.SpellCooldown(0,param1.xml.xml.Order.Units.spearton.shieldBash.cooldown,param1.xml.xml.Order.Units.spearton.shieldBash.mana);
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
          }
          
          override public function weaponReach() : Number
          {
               return WEAPON_REACH;
          }
          
          override public function setBuilding() : void
          {
               if(this.team.type == Team.T_GOOD)
               {
                    building = team.buildings["BarracksBuilding"];
               }
               else
               {
                    building = team.buildings["UndeadBuilding"];
               }
          }
          
          private function speartonHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(this.targetsHit < this.maxTargetsToHit && param1.team != this.team)
               {
                    if(param1.px * mc.scaleX > px * mc.scaleX)
                    {
                         if(param1 is Wall || param1 is Statue)
                         {
                              ++this.targetsHit;
                              param1.damage(0,this.damageToDeal,this);
                              param1.stun(this.stunTime);
                              this.heal(5,1);
                              this.cure();
                              param1.slow(30 * 2);
                         }
                         else if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(5 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                         {
                              ++this.targetsHit;
                              param1.stun(this.stunTime);
                              param1.damage(0,this.damageToDeal,this);
                              param1.damage(0,this.damageToDeal,this);
                              param1.poison(45);
                              this.heal(5,1);
                              param1.slow(30 * 2);
                              this.cure();
                         }
                    }
               }
          }
          
          public function shieldBash() : void
          {
               if(this.shieldBashSpell.spellActivate(team) && this._isBlocking && techTeam.tech.isResearched(Tech.SHIELD_BASH))
               {
                    this.isShieldBashing = true;
               }
          }
          
          private function burnInArea(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team)
               {
                    if(this.speartonType == "s07_Crippled")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE && param1.type != com.brockw.stickwar.engine.units.Unit.U_WALL)
                              {
                                   if(!hasHit && _mc.mc.currentFrame == 12)
                                   {
                                        if(param1.isNotPossessable == false)
                                        {
                                             this.convertedUnit = param1;
                                             team.enemyTeam.switchTeams(param1);
                                             _state = S_ATTACK;
                                        }
                                   }
                              }
                         }
                    }
                    else if(this.speartonType == "s09")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   if(!hasHit && _mc.mc.currentFrame == 12)
                                   {
                                        param1.stun(80);
                                   }
                              }
                         }
                    }
                    else if(this.speartonType == "Spearos")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   param1.slow(30 * 4);
                              }
                         }
                    }
                    else if(this.speartonType == "Spearos_2")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   param1.slow(30 * 6);
                              }
                         }
                    }
                    else if(this.speartonType == "Barin")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   param1.setFire(175,0.3);
                              }
                         }
                    }
                    else if(this.speartonType == "BuffSpear")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(!hasHit && _mc.mc.currentFrame == 12)
                              {
                                   param1.poison(50);
                                   param1.damage(0,this.damageToDeal,this);
                                   param1.stun(10);
                              }
                         }
                    }
                    else if(this.speartonType == "")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   param1.slow(30 * 2);
                              }
                         }
                    }
               }
          }
          
          private function burrowHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team && param1.pz == 0)
               {
                    if(this.speartonType == "")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.stunRange * this.stunRange)
                         {
                              if(!hasHit && _mc.mc.currentFrame == 12)
                              {
                                   this.team.game.projectileManager.initLightning(this,param1,this);
                              }
                         }
                    }
               }
          }
          
          public function shieldBashCooldown() : Number
          {
               return this.shieldBashSpell.cooldown();
          }
          
          override protected function isAbleToWalk() : Boolean
          {
               return this._state == S_RUN && !this.isBlocking && !this.isShieldBashing && !this.inBlock;
          }
          
          override public function update(param1:StickWar) : void
          {
               var _loc2_:Boolean = false;
               this.shieldBashSpell.update();
               updateCommon(param1);
               this.RandomHeavyDamage = int(int(Math.floor(Math.random() * 250) + 1));
               this.RandomLightDamage = int(int(Math.floor(Math.random() * 330) + 1));
               mc.filters = [this.invisSpearGlow];
               mc.mc.alpha = 1;
               if(isUC)
               {
                    _maxVelocity = param1.xml.xml.Order.Units.spearton.maxVelocity * 1;
                    _damageToNotArmour = (Number(param1.xml.xml.Order.Units.spearton.damage) + Number(param1.xml.xml.Order.Units.spearton.toNotArmour)) * 4.3;
                    _damageToArmour = (Number(param1.xml.xml.Order.Units.spearton.damage) + Number(param1.xml.xml.Order.Units.spearton.toArmour)) * 3.2;
                    _mass = Number(param1.xml.xml.Order.Units.spearton.mass) / 2;
               }
               else if(!team.isEnemy)
               {
                    _maxVelocity = param1.xml.xml.Order.Units.spearton.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Order.Units.spearton.damage) + Number(param1.xml.xml.Order.Units.spearton.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Order.Units.spearton.damage) + Number(param1.xml.xml.Order.Units.spearton.toArmour);
                    _mass = param1.xml.xml.Order.Units.spearton.mass;
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    health *= 1.2;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.05 - 0.05;
                    enemyBuffed = true;
               }
               if(this.speartonType == "RandomSpear")
               {
                    _damageToNotArmour = this.RandomLightDamage;
                    _damageToArmour = this.RandomHeavyDamage;
               }
               if(this.speartonType == "Barin" || this.speartonType == "s07_Crippled" || this.speartonType == "s09" || this.speartonType == "BuffSpear" || this.speartonType == "Spearos_2" || this.speartonType == "Spearos")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               if(this.speartonType == "s07")
               {
                    team.game.spatialHash.mapInArea(px - this.stunRange / 2,py - this.stunRange / 2,px + this.stunRange,py + this.stunRange,this.burrowHit);
               }
               this.comment = "BuffSpear and clones";
               if(this.speartonType == "BuffSpear" && !this.setupComplete)
               {
                    this.isABoss = true;
                    this.isAGeneral = true;
                    this.isNotPossessable = true;
                    noStone = true;
                    poisonRegen = true;
                    fireRegen = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    this.isReflective = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.shieldwallDamageReduction = 0.78;
                    this.radiantRange = 300;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Speedy" && !this.setupComplete)
               {
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Gladius","Default","Default");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 25;
                    this.setupComplete = true;
               }
               if(this.speartonType == "HeavySpear" && !this.setupComplete)
               {
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Default","Brown Shield");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Master" && !this.setupComplete)
               {
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Hockey Stick","Red Goalie","Goal Pads Shield");
                    maxHealth = 1450;
                    health = 1450;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Mega" && !this.setupComplete)
               {
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Gold Helmet","Medieval Shield");
                    damageUnit = true;
                    maxHealth = 2150;
                    health = 2150;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 13;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Elite" && !this.setupComplete)
               {
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","British Helmet","British Shield");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Elite_2" && !this.setupComplete)
               {
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Marine Helmet","Captain America Shield");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Stone" && !this.setupComplete)
               {
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Stone Spear","Stone Helmet","Stone Shield");
                    damageUnit = true;
                    maxHealth = 2500;
                    health = 2500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.5;
                    _maxVelocity = 3.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "LeafPrince" && !this.setupComplete)
               {
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear","Leaf Helmet","Leaf Shield");
                    maxHealth = 2500;
                    health = 2500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Ultra" && !this.setupComplete)
               {
                    reapImmune = true;
                    noStone = true;
                    this.isNotPossessable = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Native Spearton","Default");
                    maxHealth = 6200;
                    health = 6200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Super" && !this.setupComplete)
               {
                    reapImmune = true;
                    noStone = true;
                    damageUnit = true;
                    this.isNotPossessable = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","HedgeHog Helmet","Spider Shield");
                    maxHealth = 11000;
                    health = 11000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Giga" && !this.setupComplete)
               {
                    reapImmune = true;
                    noStone = true;
                    this.isNotPossessable = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","Marine Helmet","Goat Shield");
                    maxHealth = 65000;
                    health = 65000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.5;
                    _maxVelocity = 3.5;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "Spearton Generals";
               if(this.speartonType == "BuffSpear_2" && !this.setupComplete)
               {
                    noStone = true;
                    this.healthBar.visible = false;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
                    maxHealth = 3500;
                    health = 3500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.5;
                    _maxVelocity = 6.7;
                    this.heal(25,1);
                    this.setupComplete = true;
               }
               if(this.speartonType == "BuffSpear_3" && !this.setupComplete)
               {
                    noStone = true;
                    this.healthBar.visible = false;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
                    maxHealth = 5500;
                    health = 5500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    _maxVelocity = 6.7;
                    this.setupComplete = true;
               }
               if(this.speartonType == "s07" && !this.setupComplete)
               {
                    s07 = true;
                    noStone = true;
                    poisonUnit = true;
                    fireRegen = true;
                    poisonRegen = true;
                    burnUnit = true;
                    freezeUnit = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    reapImmune = true;
                    this.isAGeneral = true;
                    this.isReflective = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"s07 Spear","s07 Helmet","s07 Shield");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.3;
                    this.shieldwallDamageReduction = 0.85;
                    this.setupComplete = true;
               }
               if(this.speartonType == "s08" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    redColor = true;
                    reapImmune = true;
                    nonTeleportable = true;
                    this.isABoss = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"s07 Spear","s07 Helmet","s07 Shield");
                    maxHealth = 5300;
                    health = 5300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.6;
                    _maxVelocity = 6.3;
                    this.setupComplete = true;
               }
               if(this.speartonType == "s09" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    redColor = true;
                    reapImmune = true;
                    this.isABoss = true;
                    FullHealthRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"s07 Spear","s07 Helmet","s07 Shield");
                    nonTeleportable = true;
                    RefuseToDie = true;
                    maxHealth = 28000;
                    health = 28000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.1;
                    _maxVelocity = 6.3;
                    this.radiantRange = 200;
                    this.setupComplete = true;
               }
               if(this.speartonType == "s07_Crippled" && !this.setupComplete)
               {
                    slowAttack = true;
                    reapImmune = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dull Spear","Damaged Helmet","Damaged Shield");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.3;
                    this.radiantRange = 100;
                    this.shieldwallDamageReduction = 0.95;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Leonidas" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    this.isAGeneral = true;
                    FullHealthRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leonidas Spear","Leonidas Helmet","Leonidas Shield");
                    maxHealth = 3500;
                    health = 3500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.3;
                    this.shieldwallDamageReduction = 0.58;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Adicai" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Adicai Spear","Adicai Helmet","Adicai Shield");
                    maxHealth = 960;
                    health = 960;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.3;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Atreyos" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    this.isAGeneral = true;
                    reapImmune = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Elite","Greek Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.07;
                    this.shieldwallDamageReduction = 0.92;
                    this.enableDamageNum = true;
                    this.enableHitNum = true;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Atreyos_2" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    this.isAGeneral = true;
                    reapImmune = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Elite","Greek Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6;
                    this.shieldwallDamageReduction = 0.92;
                    this.enableDamageNum = true;
                    this.enableHitNum = true;
                    this.setupComplete = true;
               }
               if(this.speartonType == "SW3Atreyos" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    RefuseToDie = false;
                    reapImmune = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Atreyos Spear","Atreyos Helmet","Atreyos Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.shieldwallDamageReduction = 0.62;
                    this.setupComplete = true;
               }
               if(this.speartonType == "SWLAtreyos" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    this.isAGeneral = true;
                    reapImmune = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Legacy Spear","SWL Atreyos Helmet","Elite Shield 2");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 7.5;
                    this.shieldwallDamageReduction = 0.58;
                    this.setupComplete = true;
               }
               if(this.speartonType == "OldSpearos" && !this.setupComplete)
               {
                    noStone = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Old Spearos Spear","Old Spearos Helmet","Old Spearos Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.shieldwallDamageReduction = 0.62;
                    this.setupComplete = true;
               }
               if(this.speartonType == "OldSpearos_2" && !this.setupComplete)
               {
                    noStone = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Old Spearos Spear 2","Old Spearos Helmet 2","Old Spearos Shield 2");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.shieldwallDamageReduction = 0.62;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Spearos" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    frozenUnit = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Spearos","Ice Shield 2");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.speartonGlow = new GlowFilter();
                    this.speartonGlow.color = 3137765;
                    this.speartonGlow.blurX = 10;
                    this.speartonGlow.blurY = 10;
                    this.mc.filters = [this.speartonGlow];
                    this.shieldwallDamageReduction = 0.62;
                    this.radiantRange = 250;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Spearos_2" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    frozenUnit = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    nonTeleportable = true;
                    this.isAGeneral = true;
                    reapImmune = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Spearos","Ice Shield 2");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.3;
                    this.speartonGlow = new GlowFilter();
                    this.speartonGlow.color = 3137765;
                    this.speartonGlow.blurX = 10;
                    this.speartonGlow.blurY = 10;
                    this.mc.filters = [this.speartonGlow];
                    this.shieldwallDamageReduction = 0.58;
                    this.radiantRange = 250;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Barin" && !this.setupComplete)
               {
                    noStone = true;
                    burnUnit = true;
                    fireRegen = true;
                    this.isReflective = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    this.isAGeneral = true;
                    reapImmune = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Barin Spear","Barin Helmet","Barin Shield");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.shieldwallDamageReduction = 0.58;
                    this.radiantRange = 250;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "Golden and Elite Speartons";
               if(this.speartonType == "GoldenSpear" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    this.isAGoldenUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Spear","Golden Helmet","Golden Shield");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "GoldenSpear_2" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    unitRegen = true;
                    this.isAGoldenUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Spear","Golden Helmet 2","Golden Shield 2");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "GoldenSpear_3" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    unitRegen = true;
                    this.isAGoldenUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Golden Helmet 3","Greek Shield");
                    maxHealth = 775;
                    health = 775;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.8;
                    this.setupComplete = true;
               }
               if(this.speartonType == "GoldenSpear_4" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    unitRegen = true;
                    this.isAGoldenUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Golden Helmet 4","Golden Shield 2");
                    maxHealth = 775;
                    health = 775;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.8;
                    this.setupComplete = true;
               }
               if(this.speartonType == "AncientSpear" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ancient Gold Spear","Ancient Gold Helmet","Ancient Gold Shield");
                    maxHealth = 925;
                    health = 925;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.8;
                    this.setupComplete = true;
               }
               if(this.speartonType == "EliteSpear" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Elite Spear","Elite 3","Elite Shield 3");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 7;
                    this.heal(5,1);
                    this.setupComplete = true;
               }
               if(this.speartonType == "EliteSpear_2" && !this.setupComplete)
               {
                    noStone = true;
                    this.isASuperUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Elite Spear 2","Elite 4","Elite Shield 4");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.3;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Prince_3" && !this.setupComplete)
               {
                    noStone = true;
                    this.isASuperUnit = true;
                    nonTeleportable = true;
                    unitRegen = true;
                    RefuseToDie = false;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Spear","Prince 3","British Shield");
                    maxHealth = 5700;
                    health = 5700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "DarkSpear" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Spear","Dark Helmet","Dark Shield");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.1;
                    this.speartonGlow.color = 0;
                    this.speartonGlow.blurX = 10;
                    this.speartonGlow.blurY = 10;
                    this.mc.filters = [this.speartonGlow];
                    this.setupComplete = true;
               }
               if(this.speartonType == "DarkClone" && !this.setupComplete)
               {
                    enemyColor4 = true;
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Spear","Dark Helmet","Dark Shield");
                    maxHealth = 300;
                    health = 300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    _maxVelocity = 12.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "DarkClone_2" && !this.setupComplete)
               {
                    enemyColor4 = true;
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Spear","Dark Helmet","Dark Shield");
                    maxHealth = 3600;
                    health = 3600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 4;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "Super Speartons";
               if(this.speartonType == "Super_2" && !this.setupComplete)
               {
                    noStone = true;
                    damageUnit = true;
                    nonTeleportable = true;
                    this.isABoss = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","HedgeHog Helmet","Goat Shield");
                    maxHealth = 11000;
                    health = 11000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Ultra_2" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    this.isABoss = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Diamond","Wing Helmet","Lion Shield 2");
                    maxHealth = 7500;
                    health = 7500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 4.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Super_3" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    this.isABoss = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","HedgeHog Helmet","Scorpion Shield");
                    maxHealth = 11000;
                    health = 11000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5;
                    this.enableDamageNum = true;
                    this.enableHitNum = true;
                    this.setupComplete = true;
               }
               if(this.speartonType == "MillionHP" && !this.setupComplete)
               {
                    freezeUnit = true;
                    frozenUnit = true;
                    nonTeleportable = true;
                    this.isNotPossessable = true;
                    this.isABoss = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 1000000;
                    health = 1000000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.2;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Boss_1" && !this.setupComplete)
               {
                    this.isABoss = true;
                    frozenUnit = true;
                    freezeUnit = true;
                    nonTeleportable = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 14000;
                    health = 14000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.24;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Boss_2" && !this.setupComplete)
               {
                    this.isABoss = true;
                    freezeUnit = true;
                    frozenUnit = true;
                    nonTeleportable = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 12000;
                    health = 12000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.24;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "SavagePrince" && !this.setupComplete)
               {
                    noStone = true;
                    this.isABoss = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Savage Spear","Savage Helmet","Savage Shield");
                    maxHealth = 5200;
                    health = 5200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "LavaPrince" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    removeIce = true;
                    weakToIce = true;
                    removeFire = true;
                    this.isABoss = true;
                    this.isNotPossessable = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Lava Helmet","Lava Shield 2");
                    maxHealth = 7200;
                    health = 7200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.6;
                    this.isReflective = true;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "Other";
               if(this.speartonType == "RandomSpear" && !this.setupComplete)
               {
                    this.RandomScale = int(int(Math.floor(Math.random() * 3.5) + 1));
                    this.RandomSpeed = int(int(Math.floor(Math.random() * 9) + 1));
                    this.RandomHealth = int(int(Math.floor(Math.random() * 1500) + 1));
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = this.RandomHealth;
                    health = this.RandomHealth;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = this.RandomScale;
                    this.setupComplete = true;
               }
               if(this.speartonType == "VoltSpear" && !this.setupComplete)
               {
                    isVoltaic = true;
                    maxHealthIncrease = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Voltaic Spear","Voltaic Helmet","Voltaic Shield");
                    maxHealth = 860;
                    health = 860;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "FutureSpear" && !this.setupComplete)
               {
                    isVoltaic = true;
                    this.ai.speartonTargeter = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Future Spear","Future Helmet","Future Shield");
                    maxHealth = 860;
                    health = 860;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "MoltenSpear" && !this.setupComplete)
               {
                    noStone = true;
                    meltUnit = true;
                    slowAttack = true;
                    this.healthBar.visible = false;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Molten Spear","Molten Helmet","Molten Shield");
                    maxHealth = 5620;
                    health = 5620;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.7;
                    this.setupComplete = true;
               }
               if(this.speartonType == "MoltenSpear_2" && !this.setupComplete)
               {
                    meltUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Molten Spear 2","Molten Helmet 2","Molten Shield 2");
                    maxHealth = 860;
                    health = 860;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Lava" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    removeIce = true;
                    weakToIce = true;
                    this.isReflective = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Lava Helmet","Lava Shield");
                    maxHealth = 800;
                    health = 800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Hybrid" && !this.setupComplete)
               {
                    burnUnit = true;
                    poisonUnit = true;
                    poisonRegen = true;
                    freezeUnit = true;
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 3","Ice Helmet","Undead Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Dark" && !this.setupComplete)
               {
                    unitRegen = true;
                    nonTeleportable = true;
                    teleportEnemy = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Camo Spear","Samurai Mask","Dark Shield 2");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Light" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Samurai","Gold Wood Shield");
                    maxHealth = 960;
                    health = 960;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Silver" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","Silver Helmet 1","Silver Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Spear_1" && !this.setupComplete)
               {
                    blueColor = true;
                    unitRegen = true;
                    HeavyVampRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 550;
                    health = 550;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Spear_2" && !this.setupComplete)
               {
                    redColor = true;
                    unitRegen = true;
                    HeavyVampRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 550;
                    health = 550;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.speartonGlow = new GlowFilter();
                    this.speartonGlow.color = 16711680;
                    this.speartonGlow.blurX = 10;
                    this.speartonGlow.blurY = 10;
                    this.mc.filters = [this.speartonGlow];
                    this.setupComplete = true;
               }
               if(this.speartonType == "SuperSpear" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Super Spear","Super Helmet","Super Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Undead" && !this.setupComplete)
               {
                    noStone = true;
                    poisonUnit = true;
                    poisonRegen = true;
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","Undead Helmet","Undead Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.2;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Undead_2" && !this.setupComplete)
               {
                    noStone = true;
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Undead Spear","Undead Helmet 2","Undead Shield 2");
                    maxHealth = 960;
                    health = 960;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.2;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Leaf" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear","Leaf Helmet","Leaf Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Leaf_2" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear 2","Leaf Helmet 2","Leaf Shield 2");
                    maxHealth = 1800;
                    health = 1800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Savage" && !this.setupComplete)
               {
                    unitRegen = true;
                    stunUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Savage Spear","Savage Helmet","Savage Shield");
                    maxHealth = 860;
                    health = 860;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.2;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Vamp" && !this.setupComplete)
               {
                    isVampUnit = true;
                    HeavyVampRegen = true;
                    HeavyVampCure = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Vamp Spear","Vamp Helmet","Vamp Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Ice" && !this.setupComplete)
               {
                    freezeUnit = true;
                    unitRegen = true;
                    slowRegen = true;
                    selfFreeze = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Ice Helmet","Ice Shield");
                    maxHealth = 860;
                    health = 860;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "CrystalSpear" && !this.setupComplete)
               {
                    frozenUnit = true;
                    slowRegen = true;
                    weakToFire = true;
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Crystal Spear","Crystal Helmet","Crystal Shield");
                    maxHealth = 860;
                    health = 860;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.speartonGlow = new GlowFilter();
                    this.speartonGlow.color = 65535;
                    this.speartonGlow.blurX = 10;
                    this.speartonGlow.blurY = 10;
                    this.mc.filters = [this.speartonGlow];
                    this.shieldwallDamageReduction = 0.85;
                    this.setupComplete = true;
               }
               if(this.speartonType == "SickleSpear" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Sicklespear","Native Spearton","Sickle Shield");
                    maxHealth = 760;
                    health = 760;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "SW1_Spear_1" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Sw1 Spear 2","Sw1 Helmet 1","Sw1 Shield 2");
                    maxHealth = 760;
                    health = 760;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "SW1_Spear_2" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Sw1 Spear 2","Sw1 Helmet 2","Sw1 Shield 2");
                    maxHealth = 760;
                    health = 760;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "SW1_Native" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Sw1 Spear 1","Feather","Sw1 Shield 1");
                    maxHealth = 760;
                    health = 760;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "BloodSpear" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Blood Spear","Blood Helmet","Blood Shield");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "BloodSpear_2" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Blood Spear 2","Blood Helmet 2","Blood Shield 2");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "NativeSpear" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Native Spear","Native Spearton","Native Shield");
                    maxHealth = 950;
                    health = 950;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "NativeSpear_2" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"LeGold Spear","LeGold Helmet","LeGold Shield");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Mega_2" && !this.setupComplete)
               {
                    unitRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","British Helmet","Medieval Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 13;
                    this.setupComplete = true;
               }
               if(this.speartonType == "CritSpear" && !this.setupComplete)
               {
                    criticalDamage = true;
                    BlockChance = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "BackLineTargeter" && !this.setupComplete)
               {
                    this.ai.archerTargeter = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "MagikillTargeter" && !this.setupComplete)
               {
                    this.ai.magikillTargeter = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType != "")
               {
                    isCustomUnit = true;
               }
               if(this.speartonType == "AncientSpear" || this.speartonType == "Silver" || this.speartonType == "GoldenSpear" || this.speartonType == "GoldenSpear_2" || this.speartonType == "GoldenSpear_3" || this.speartonType == "GoldenSpear_4" || this.speartonType == "Super" || this.speartonType == "Super_2" || this.speartonType == "Super_3" || this.speartonType == "Ultra" || this.speartonType == "Ultra_2" || this.speartonType == "s07" || this.speartonType == "s08" || this.speartonType == "s09" || this.speartonType == "Barin" || this.speartonType == "Spearos" || this.speartonType == "Spearos_2" || this.speartonType == "Boss_1" || this.speartonType == "" || this.speartonType == "MillionHP" || this.speartonType == "Atreyos" || this.speartonType == "Atreyos_2" || this.speartonType == "BuffSpear" || this.speartonType == "BuffSpear_2" || this.speartonType == "DarkSpear")
               {
                    slowFramesRemaining = 0;
                    stunTimeLeft = 0;
               }
               isCustomUnit = true;
               if(true)
               {
                    if(this.speartonType == "SWLAtreyos")
                    {
                         stunTimeLeft = 0;
                         _maxVelocity = 7.5;
                    }
                    else if(isUC)
                    {
                         _maxVelocity = param1.xml.xml.Order.Units.spearton.maxVelocity * 1;
                    }
                    else if(this.speartonType == "RandomSpear")
                    {
                         _maxVelocity = this.Speed[this.RandomSpeed];
                         _mass = 60;
                    }
                    else if(this.speartonType == "SW3Atreyos")
                    {
                         stunTimeLeft = 0;
                    }
                    else if(this.speartonType == "BuffSpear")
                    {
                         _maxVelocity = 7;
                         _mass = 50;
                    }
                    else if(this.speartonType == "Mega_2")
                    {
                         _maxVelocity = 25;
                         _mass = 10;
                    }
                    else if(this.speartonType == "Dark")
                    {
                         teleportDistance = -300;
                         _maxVelocity = 5.5;
                         _mass = 30;
                    }
                    else if(this.speartonType == "Speedy")
                    {
                         _maxVelocity = 17.5;
                         _mass = 50;
                    }
                    else if(this.speartonType == "DarkClone")
                    {
                         _maxVelocity = 7.4;
                    }
                    else if(this.speartonType == "EliteSpear_2")
                    {
                         if(this._health <= 250)
                         {
                              _mass = 50;
                              _maxVelocity = 7.4;
                         }
                         else
                         {
                              _mass = 50;
                              _maxVelocity = 6;
                         }
                    }
                    else if(this.speartonType == "Leonidas")
                    {
                         stunTimeLeft = 0;
                         if(this._health <= 1750)
                         {
                              _damageToNotArmour *= 6;
                              _damageToArmour *= 6;
                              _mass = 50;
                              _maxVelocity = 14;
                         }
                         else
                         {
                              _damageToNotArmour *= 1;
                              _damageToArmour *= 1;
                              _mass = 50;
                              _maxVelocity = 5.8;
                         }
                    }
                    else if(this.speartonType == "Ultra" || this.speartonType == "Ultra_2" || this.speartonType == "Super" || this.speartonType == "Super_2" || this.speartonType == "Super_3")
                    {
                         _maxVelocity = 4.8;
                    }
                    else if(this.speartonType == "Leaf" || this.speartonType == "Leaf_2")
                    {
                         _maxVelocity = 9;
                    }
                    else if(this.speartonType == "Savage")
                    {
                         stunTimeLeft = 0;
                         _maxVelocity = 9;
                    }
                    else if(this.speartonType == "s07_Crippled")
                    {
                         stunTimeLeft = 0;
                    }
                    else if(this.speartonType == "SavagePrince" || this.speartonType == "LeafPrince" || this.speartonType == "LavaPrince")
                    {
                         stunTimeLeft = 0;
                         _maxVelocity = 4;
                    }
                    else if(this.speartonType == "s08" || this.speartonType == "Giga")
                    {
                         stunTimeLeft = 0;
                         slowFramesRemaining = 0;
                         _maxVelocity = 4.4;
                    }
                    else if(this.speartonType == "s09")
                    {
                         _maxVelocity = 3.9;
                    }
                    else if(this.speartonType == "MoltenSpear")
                    {
                         _maxVelocity = 3.4;
                    }
                    else
                    {
                         _mass = param1.xml.xml.Order.Units.spearton.mass;
                         _maxVelocity = param1.xml.xml.Order.Units.spearton.maxVelocity;
                    }
               }
               if(!isDieing)
               {
                    updateMotion(param1);
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.attackLabel);
                         moveDualPartner(_dualPartner,_currentDual.xDiff);
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              _isDualing = false;
                              _state = S_RUN;
                              px += Util.sgn(mc.scaleX) * team.game.getPerspectiveScale(py) * _currentDual.finalXOffset;
                              x = px;
                              dx = 0;
                              dy = 0;
                         }
                    }
                    else if(this.isShieldBashing)
                    {
                         if(MovieClip(mc.mc).currentFrameLabel == "swing")
                         {
                              team.game.soundManager.playSound("swordwrathSwing1",px,py);
                         }
                         _mc.gotoAndStop("shieldBash");
                         _mc.mc.nextFrame();
                         if(_mc.mc.currentFrame == 12)
                         {
                              _loc2_ = this.checkForBlockHit();
                         }
                         if(_mc.mc.currentFrame == _mc.mc.totalFrames)
                         {
                              this.isShieldBashing = false;
                         }
                    }
                    else if(this.inBlock)
                    {
                         if(_mc.currentLabel == "shieldBash")
                         {
                              _mc.gotoAndStop("block");
                              _mc.mc.gotoAndStop(15);
                         }
                         else
                         {
                              _mc.gotoAndStop("block");
                         }
                         if(this.isBlocking)
                         {
                              if(_mc.mc.currentFrame < 62)
                              {
                                   _mc.mc.nextFrame();
                              }
                              else
                              {
                                   _mc.mc.gotoAndStop(16);
                              }
                         }
                         else
                         {
                              _mc.mc.nextFrame();
                              if(_mc.mc.currentFrame == _mc.mc.totalFrames)
                              {
                                   this.inBlock = false;
                              }
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
                         if(MovieClip(mc.mc).currentFrameLabel == "swing")
                         {
                              team.game.soundManager.playSound("swordwrathSwing1",px,py);
                         }
                         if(!hasHit)
                         {
                              if(this.speartonType == "")
                              {
                                   mc.filters = [this.invisSpearGlow];
                                   mc.mc.alpha = 1;
                              }
                              hasHit = this.checkForHit();
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
                         if(this.speartonType == "Savage")
                         {
                              MovieClip(_mc.mc).nextFrame();
                         }
                    }
               }
               else if(isDead == false)
               {
                    if(this.speartonType == "Spearos")
                    {
                         team.gold += 50;
                    }
                    if(this.speartonType == "SW3Atreyos")
                    {
                         team.gold += 350;
                    }
                    if(this.speartonType == "" || this.speartonType == "Barin")
                    {
                         param1.projectileManager.initNuke(px,py,this,30,0.4,600);
                    }
                    if(this.speartonType == "Atreyos")
                    {
                         param1.projectileManager.initNuke(px,py,this,75,0.7,3550);
                         param1.projectileManager.initPoisonPool(this.px,this.py,this,0);
                    }
                    if(this.speartonType == "BuffSpear")
                    {
                         param1.projectileManager.initNuke(px,py,this,100,0.4,600);
                         param1.projectileManager.initPoisonPool(this.px,this.py,this,0);
                    }
                    if(this.speartonType == "SWLAtreyos")
                    {
                         param1.projectileManager.initNuke(px,py,this,150,0.6,600);
                    }
                    if(this.speartonType == "s07")
                    {
                         param1.projectileManager.initNuke(px,py,this,100,0.4,600);
                         param1.projectileManager.initPoisonPool(this.px,this.py,this,0);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "s08";
                         this.clusterLad.protect(1300);
                    }
                    if(this.speartonType == "s08")
                    {
                         param1.projectileManager.initNuke(px,py,this,200,0.4,600);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "s09";
                    }
                    if(this.speartonType == "s09")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,300,0.6,600);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "s07_Crippled";
                         this.clusterLad.stun(20);
                    }
                    if(this.speartonType == "s07_Crippled")
                    {
                         param1.projectileManager.initNuke(px,py,this,1000,35,250);
                    }
                    this.divider = "---------------------------------------------------------------------------";
                    if(this.speartonType == "DarkSpear")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "DarkClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "DarkClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "DarkClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "DarkClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "DarkClone";
                         this.clusterLad.stun(0);
                    }
                    this.divider = "---------------------------------------------------------------------------";
                    if(this.speartonType == "Undead_2")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Undead";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Undead";
                         this.clusterLad.stun(0);
                    }
                    this.divider = "---------------------------------------------------------------------------";
                    this.divider = "---------------------------------------------------------------------------";
                    this.comment = "BuffSpear Clones";
                    if(this.speartonType == "BuffSpear")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,100,0.5,200);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Speedy";
                         this.clusterLad.stun(0);
                         this.clusterLad.ai.setCommand(param1,new HoldCommand(param1));
                    }
                    if(this.speartonType == "Speedy")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,20,0.2,100);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "HeavySpear";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "HeavySpear")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,35,0.3,150);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Master";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Master")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,40,0.4,200);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Mega";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Mega")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,50,0.48,200);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Elite";
                         this.clusterLad.stun(0);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,50,0.48,200);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Elite_2";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Elite_2")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,60,0.54,250);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Undead_2";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Elite")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,67,0.62,350);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Ultra";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Ultra")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,86,0.7,400);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Super";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Super")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,95,0.8,600);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Giga";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Giga")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,95,0.8,600);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "BuffSpear";
                         this.clusterLad.stun(0);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         param1.projectileManager.initNuke(px,py,this,95,0.8,600);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "BuffSpear";
                         this.clusterLad.stun(0);
                    }
                    this.divider = "---------------------------------------------------------------------------";
                    this.divider = "---------------------------------------------------------------------------";
                    if(this.speartonType == "BuffSpear_2")
                    {
                         param1.projectileManager.initNuke(px,py,this,1500,100,300);
                    }
                    if(this.speartonType == "VoltSpear")
                    {
                         param1.projectileManager.initStun(this.px,py,35,this);
                    }
                    isDead = true;
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.defendLabel);
                         if(MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                         {
                              isDualing = false;
                              mc.filters = [];
                         }
                    }
                    else
                    {
                         _mc.gotoAndStop(getDeathLabel(param1));
                    }
                    this.team.removeUnit(this,param1);
               }
               if(!isDead && MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
               {
                    MovieClip(_mc.mc).gotoAndStop(1);
               }
               if(_isDualing || !this.inBlock || isDead)
               {
                    Util.animateMovieClip(_mc);
               }
               if(this.speartonType == "GoldenSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Spear","Golden Helmet","Golden Shield");
               }
               else if(this.speartonType == "GoldenSpear_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Spear","Golden Helmet 2","Golden Shield 2");
               }
               else if(this.speartonType == "GoldenSpear_3")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Golden Helmet 3","Greek Shield");
               }
               else if(this.speartonType == "GoldenSpear_4")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Golden Helmet 4","Golden Shield 2");
               }
               else if(this.speartonType == "Prince_3")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Spear","Prince 3","British Shield");
               }
               else if(this.speartonType == "AncientSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ancient Gold Spear","Ancient Gold Helmet","Ancient Gold Shield");
               }
               else if(this.speartonType == "DarkSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Spear","Dark Helmet","Dark Shield");
               }
               else if(this.speartonType == "DarkClone")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Spear","Dark Helmet","Dark Shield");
               }
               else if(this.speartonType == "DarkClone_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Spear","Dark Helmet","Dark Shield");
               }
               else if(this.speartonType == "Adicai")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Adicai Spear","Adicai Helmet","Adicai Shield");
               }
               else if(this.speartonType == "s07")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"s07 Spear 2","s07 Helmet 2","s07 Shield 2");
               }
               else if(this.speartonType == "s07_Crippled")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dull Spear","Damaged Helmet","Damaged Shield");
               }
               else if(this.speartonType == "s08")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"s07 Spear","s07 Helmet","s07 Shield");
               }
               else if(this.speartonType == "s09")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"s07 Spear","s07 Helmet","s07 Shield");
               }
               else if(this.speartonType == "Leonidas")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leonidas Spear","Leonidas Helmet","Leonidas Shield");
               }
               else if(this.speartonType == "Lava")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Lava Helmet","Lava Shield");
               }
               else if(this.speartonType == "LavaPrince")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Lava Helmet","Lava Shield 2");
               }
               else if(this.speartonType == "Atreyos")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Elite","Greek Shield");
               }
               else if(this.speartonType == "Atreyos_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Elite","Greek Shield");
               }
               else if(this.speartonType == "SWLAtreyos")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Legacy Spear","SWL Atreyos Helmet","Elite Shield 2");
               }
               else if(this.speartonType == "SW3Atreyos")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Atreyos Spear","Atreyos Helmet","Atreyos Shield");
               }
               else if(this.speartonType == "Spearos")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Spearos","Ice Shield 2");
               }
               else if(this.speartonType == "Spearos_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Spearos","Ice Shield 2");
               }
               else if(this.speartonType == "OldSpearos")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Old Spearos Spear","Old Spearos Helmet","Old Spearos Shield");
               }
               else if(this.speartonType == "OldSpearos_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Old Spearos Spear 2","Old Spearos Helmet 2","Old Spearos Shield 2");
               }
               else if(this.speartonType == "Undead")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","Undead Helmet","Undead Shield");
               }
               else if(this.speartonType == "Undead_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Undead Spear","Undead Helmet 2","Undead Shield 2");
               }
               else if(this.speartonType == "Vamp")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Vamp Spear","Vamp Helmet","Vamp Shield");
               }
               else if(this.speartonType == "BuffSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
               }
               else if(this.speartonType == "BuffSpear_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
               }
               else if(this.speartonType == "BuffSpear_3")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
               }
               else if(this.speartonType == "Speedy")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Gladius","Default","Default");
               }
               else if(this.speartonType == "HeavySpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Default","Brown Shield");
               }
               else if(this.speartonType == "Master")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Hockey Stick","Red Goalie","Goal Pads Shield");
               }
               else if(this.speartonType == "Mega")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Gold Helmet","Medieval Shield");
               }
               else if(this.speartonType == "Elite")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","British Helmet","British Shield");
               }
               else if(this.speartonType == "Elite_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Marine Helmet","Captain America Shield");
               }
               else if(this.speartonType == "Ultra")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Native Spearton","Default");
               }
               else if(this.speartonType == "Super")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","HedgeHog Helmet","Spider Shield");
               }
               else if(this.speartonType == "Giga")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","Marine Helmet","Goat Shield");
               }
               else if(this.speartonType == "Ice")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Ice Helmet","Ice Shield");
               }
               else if(this.speartonType == "Super_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","HedgeHog Helmet","Goat Shield");
               }
               else if(this.speartonType == "Dark")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Camo Spear","Samurai Mask","Dark Shield 2");
               }
               else if(this.speartonType == "Light")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Samurai","Gold Wood Shield");
               }
               else if(this.speartonType == "Silver")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","Silver Helmet 1","Silver Shield");
               }
               else if(this.speartonType == "EliteSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Elite Spear","Elite 3","Elite Shield 3");
               }
               else if(this.speartonType == "EliteSpear_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Elite Spear 2","Elite 4","Elite Shield 4");
               }
               else if(this.speartonType == "Stone")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Stone Spear","Stone Helmet","Stone Shield");
               }
               else if(this.speartonType == "Leaf")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear","Leaf Helmet","Leaf Shield");
               }
               else if(this.speartonType == "Leaf_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear 2","Leaf Helmet 2","Leaf Shield 2");
               }
               else if(this.speartonType == "LeafPrince")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear","Leaf Helmet","Leaf Shield");
               }
               else if(this.speartonType == "Boss_1")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
               else if(this.speartonType == "Boss_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
               else if(this.speartonType == "RandomSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
               else if(this.speartonType == "NativeSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Native Spear","Native Spearton","Native Shield");
               }
               else if(this.speartonType == "NativeSpear_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"LeGold Spear","LeGold Helmet","LeGold Shield");
               }
               else if(this.speartonType == "Barin")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Barin Spear","Barin Helmet","Barin Shield");
               }
               else if(this.speartonType == "Savage")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Savage Spear","Savage Helmet","Savage Shield");
               }
               else if(this.speartonType == "SavagePrince")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Savage Spear","Savage Helmet","Savage Shield");
               }
               else if(this.speartonType == "Hybrid")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 3","Ice Helmet","Undead Shield");
               }
               else if(this.speartonType == "CrystalSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Crystal Spear","Crystal Helmet","Crystal Shield");
               }
               else if(this.speartonType == "Ultra_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Diamond","Wing Helmet","Lion Shield 2");
               }
               else if(this.speartonType == "Super_3")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","HedgeHog Helmet","Scorpion Shield");
               }
               else if(this.speartonType == "Mega_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","British Helmet","Medieval Shield");
               }
               else if(this.speartonType == "Spear_1")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
               else if(this.speartonType == "Spear_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
               else if(this.speartonType == "SickleSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Sicklespear","Native Spearton","Sickle Shield");
               }
               else if(this.speartonType == "SW1_Spear_1")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Sw1 Spear 2","Sw1 Helmet 1","Sw1 Shield 2");
               }
               else if(this.speartonType == "SW1_Spear_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Sw1 Spear 2","Sw1 Helmet 2","Sw1 Shield 2");
               }
               else if(this.speartonType == "SW1_Native")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Sw1 Spear 1","Feather","Sw1 Shield 1");
               }
               else if(this.speartonType == "BloodSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Blood Spear","Blood Helmet","Blood Shield");
               }
               else if(this.speartonType == "BloodSpear_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Blood Spear 2","Blood Helmet 2","Blood Shield 2");
               }
               else if(this.speartonType == "CritSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
               else if(this.speartonType == "BackLineTargeter")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
               else if(this.speartonType == "MagikillTargeter")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
               else if(this.speartonType == "VoltSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Voltaic Spear","Voltaic Helmet","Voltaic Shield");
               }
               else if(this.speartonType == "FutureSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Future Spear","Future Helmet","Future Shield");
               }
               else if(this.speartonType == "MoltenSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Molten Spear","Molten Helmet","Molten Shield");
               }
               else if(this.speartonType == "MoltenSpear_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Molten Spear 2","Molten Helmet 2","Molten Shield 2");
               }
               else if(this.speartonType == "SuperSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Super Spear","Super Helmet","Super Shield");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
               }
          }
          
          private function shieldHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(this.stunned == null && param1.team != this.team && param1.pz == 0)
               {
                    if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.shieldRange * this.shieldRange)
                    {
                         if(this.speartonType == "")
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   this.convertedUnit = param1;
                                   team.enemyTeam.switchTeams(param1);
                                   _state = S_ATTACK;
                              }
                         }
                         if(this.speartonType == "Ice")
                         {
                              param1.freeze(30 * 15);
                              param1.slow(30 * 45);
                         }
                         if(this.speartonType == "s07")
                         {
                              this.stunned.damage(0,this.stunDamage,null);
                              param1.setFire(400,25);
                              param1.freeze(30 * 35);
                              param1.slow(30 * 70);
                         }
                         if(this.speartonType == "s08")
                         {
                              this.stunned.damage(0,this.stunDamage,null);
                              param1.setFire(800,50);
                              param1.freeze(30 * 35);
                              param1.slow(30 * 70);
                         }
                         if(this.speartonType == "s09")
                         {
                              this.stunned.damage(0,this.stunDamage,null);
                              param1.setFire(1500,100);
                         }
                         if(this.speartonType == "GoldenSpear_2")
                         {
                              this.protect(350);
                              this.stunned.damage(0,this.stunDamage,null);
                         }
                         this.stunned = param1;
                         this.stunned.damage(0,this.stunDamage,null);
                         param1.stun(this.stunTime);
                         param1.applyVelocity(this.stunForce * Util.sgn(mc.scaleX));
                    }
               }
          }
          
          protected function checkForBlockHit() : Boolean
          {
               this.stunned = null;
               team.game.spatialHash.mapInArea(px - this.shieldRange,py - this.shieldRange,px + this.shieldRange,py + this.shieldRange,this.shieldHit);
               return true;
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
               if(techTeam.tech.isResearched(Tech.BLOCK))
               {
                    this.isBlocking = true;
                    this.inBlock = true;
                    _state = S_RUN;
                    team.game.soundManager.playSound("speartonHoghSound",px,py);
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.speartonType == "Dark")
               {
                    return 0;
               }
               if(this.speartonType == "Spear_1")
               {
                    return 1;
               }
               if(this.speartonType == "Spear_2")
               {
                    return 100;
               }
               if(this.speartonType == "SW3Atreyos")
               {
                    return 140;
               }
               if(this.speartonType == "Prince_3")
               {
                    return 110;
               }
               if(this.speartonType == "SWLAtreyos")
               {
                    return 140;
               }
               if(this.speartonType == "SavagePrince")
               {
                    return 220;
               }
               if(this.speartonType == "LeafPrince")
               {
                    return 220;
               }
               if(this.speartonType == "LavaPrince")
               {
                    return 220;
               }
               if(this.speartonType == "Spearos")
               {
                    return 30;
               }
               if(this.speartonType == "Spearos_2")
               {
                    return 30;
               }
               if(this.speartonType == "SuperSpear")
               {
                    return 56;
               }
               if(this.speartonType == "GoldenSpear")
               {
                    return 112;
               }
               if(this.speartonType == "GoldenSpear_2")
               {
                    return 124;
               }
               if(this.speartonType == "GoldenSpear_3")
               {
                    return 138;
               }
               if(this.speartonType == "GoldenSpear_4")
               {
                    return 148;
               }
               if(this.speartonType == "Leonidas")
               {
                    if(this._health <= 1750)
                    {
                         return 415;
                    }
                    return 115;
               }
               if(this.speartonType == "AncientSpear")
               {
                    return 300;
               }
               if(this.speartonType == "EliteSpear")
               {
                    return 95;
               }
               if(this.speartonType == "EliteSpear")
               {
                    return 105;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType == "s08")
               {
                    return 450;
               }
               if(this.speartonType == "s09")
               {
                    return 2000;
               }
               if(this.speartonType == "s07")
               {
                    if(this._health <= 500)
                    {
                         return 290;
                    }
                    return 320;
               }
               if(this.speartonType == "s07_Crippled")
               {
                    return 8000;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType == "BuffSpear")
               {
                    return 200;
               }
               if(this.speartonType == "Stone")
               {
                    return 70;
               }
               if(this.speartonType == "Leaf")
               {
                    return 20;
               }
               if(this.speartonType == "Ultra")
               {
                    return 225;
               }
               if(this.speartonType == "Super")
               {
                    return 370;
               }
               if(this.speartonType == "Super_2")
               {
                    return 160;
               }
               if(this.speartonType == "Giga")
               {
                    return 1500;
               }
               if(this.speartonType == "EliteSpear")
               {
                    return 80;
               }
               if(this.speartonType == "EliteSpear_2")
               {
                    return 90;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType == "DarkSpear")
               {
                    return 145;
               }
               if(this.speartonType == "DarkClone")
               {
                    return 60;
               }
               if(this.speartonType == "DarkClone_2")
               {
                    return 10;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType == "Super_3")
               {
                    return 210;
               }
               if(this.speartonType == "Ultra_2")
               {
                    return 100;
               }
               if(this.speartonType == "Atreyos")
               {
                    return 275;
               }
               if(this.speartonType == "Atreyos_2")
               {
                    return 350;
               }
               if(this.speartonType == "MillionHP")
               {
                    return 200;
               }
               if(this.speartonType == "Boss_1")
               {
                    return 5;
               }
               if(this.speartonType == "Boss_2")
               {
                    return 278;
               }
               if(this.speartonType == "Barin")
               {
                    return 75;
               }
               if(this.speartonType == "Elite_1")
               {
                    return 200;
               }
               if(this.speartonType == "Hybrid")
               {
                    return 10;
               }
               if(this.speartonType == "SickleSpear")
               {
                    return 30;
               }
               if(this.speartonType == "BloodSpear")
               {
                    return 40;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.speartonType == "EliteSpear_2")
               {
                    return 90;
               }
               if(this.speartonType == "Spear_1")
               {
                    return 115;
               }
               if(this.speartonType == "Spear_2")
               {
                    return 1;
               }
               if(this.speartonType == "SickleSpear")
               {
                    return 35;
               }
               if(this.speartonType == "BloodSpear")
               {
                    return 50;
               }
               if(this.speartonType == "SW3Atreyos")
               {
                    return 200;
               }
               if(this.speartonType == "Prince_3")
               {
                    return 160;
               }
               if(this.speartonType == "SWLAtreyos")
               {
                    return 135;
               }
               if(this.speartonType == "SavagePrince")
               {
                    return 285;
               }
               if(this.speartonType == "LeafPrince")
               {
                    return 285;
               }
               if(this.speartonType == "LavaPrince")
               {
                    return 285;
               }
               if(this.speartonType == "Leonidas")
               {
                    if(this._health <= 1750)
                    {
                         return 500;
                    }
                    return 215;
               }
               if(this.speartonType == "AncientSpear")
               {
                    return 350;
               }
               if(this.speartonType == "EliteSpear")
               {
                    return 170;
               }
               if(this.speartonType == "EliteSpear")
               {
                    return 115;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType == "Dark")
               {
                    return 0;
               }
               if(this.speartonType == "s08")
               {
                    return 500;
               }
               if(this.speartonType == "s07")
               {
                    if(this._health <= 500)
                    {
                         return 330;
                    }
                    return 600;
               }
               if(this.speartonType == "s09")
               {
                    return 2000;
               }
               if(this.speartonType == "s07_Crippled")
               {
                    return 8000;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType == "BuffSpear")
               {
                    return 250;
               }
               if(this.speartonType == "Stone")
               {
                    return 95;
               }
               if(this.speartonType == "Leaf")
               {
                    return 35;
               }
               if(this.speartonType == "Ultra")
               {
                    return 900;
               }
               if(this.speartonType == "Super")
               {
                    return 1000;
               }
               if(this.speartonType == "Super_2")
               {
                    return 170;
               }
               if(this.speartonType == "Giga")
               {
                    return 2500;
               }
               if(this.speartonType == "Barin")
               {
                    return 120;
               }
               if(this.speartonType == "Spearos")
               {
                    return 35;
               }
               if(this.speartonType == "Spearos_2")
               {
                    return 35;
               }
               if(this.speartonType == "SuperSpear")
               {
                    return 56;
               }
               if(this.speartonType == "GoldenSpear")
               {
                    return 130;
               }
               if(this.speartonType == "GoldenSpear_2")
               {
                    return 148;
               }
               if(this.speartonType == "GoldenSpear_3")
               {
                    return 165;
               }
               if(this.speartonType == "GoldenSpear_4")
               {
                    return 180;
               }
               if(this.speartonType == "AncientSpear")
               {
                    return 600;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType == "DarkSpear")
               {
                    return 170;
               }
               if(this.speartonType == "DarkClone")
               {
                    return 60;
               }
               if(this.speartonType == "DarkClone_2")
               {
                    return 10;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType == "Super_3")
               {
                    return 270;
               }
               if(this.speartonType == "Ultra_2")
               {
                    return 80;
               }
               if(this.speartonType == "Atreyos")
               {
                    return 520;
               }
               if(this.speartonType == "BackLineTargeter")
               {
                    return 20;
               }
               if(this.speartonType == "MagikillTargeter")
               {
                    return 40;
               }
               if(this.speartonType == "Atreyos_2")
               {
                    return 295;
               }
               if(this.speartonType == "MillionHP")
               {
                    return 70;
               }
               if(this.speartonType == "Boss_1")
               {
                    return 90;
               }
               if(this.speartonType == "Boss_2")
               {
                    return 180;
               }
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(techTeam.tech.isResearched(Tech.BLOCK))
               {
                    param1.setAction(0,0,UnitCommand.SPEARTON_BLOCK);
               }
               if(techTeam.tech.isResearched(Tech.SHIELD_BASH))
               {
                    param1.setAction(1,0,UnitCommand.SHIELD_BASH);
               }
          }
          
          override public function attack() : void
          {
               var _loc1_:int = 0;
               if(_state != S_ATTACK)
               {
                    if(this.isBlocking)
                    {
                         this.shieldBash();
                    }
                    else
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
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               this.randomNumber = int(int(Math.floor(Math.random() * 5) + 1));
               if(this.inBlock || this.speartonType == "s07" || this.speartonType == "BuffSpear" || this.speartonType == "s07_Crippled" || this.speartonType == "SWLAtreyos" || this.speartonType == "SW3Atreyos" || this.speartonType == "CrystalSpear" || this.speartonType == "Barin" || this.speartonType == "s07" || this.speartonType == "Spearos_2" || this.speartonType == "Spearos" || this.speartonType == "Atreyos" || this.speartonType == "Atreyos_2")
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else if(this.speartonType == "")
               {
                    if(this.randomNumber == 1)
                    {
                         this.team.game.soundManager.playSound("Block1",px,py);
                         this.team.game.soundManager.playSound("Block2",px,py);
                         this.team.game.soundManager.playSound("Block3",px,py);
                         super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
                    }
               }
               else
               {
                    super.damage(param1,param2,param3);
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
