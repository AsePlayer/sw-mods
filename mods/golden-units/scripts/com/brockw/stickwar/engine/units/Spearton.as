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
     import flash.filters.GlowFilter;
     
     public class Spearton extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
          
          private static var RAGE_COOLDOWN:int;
          
          private static var RAGE_EFFECT:int;
           
          
          private var clusterLad:com.brockw.stickwar.engine.units.Spearton;
          
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
          
          private var stunTime:int;
          
          private var stunned:com.brockw.stickwar.engine.units.Unit;
          
          private var shieldRange:Number;
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
          private var frames:int;
          
          private var speartonGlow:GlowFilter;
          
          private var divider:String;
          
          private var comment:String;
          
          public function Spearton(param1:StickWar)
          {
               super(param1);
               _mc = new _speartonMc();
               this.init(param1);
               addChild(_mc);
               ai = new SpeartonAi(this);
               initSync();
               firstInit();
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
               this.maxTargetsToHit = 0;
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
                    if(this.speartonType == "")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   this.convertedUnit = param1;
                                   team.enemyTeam.switchTeams(param1);
                                   _state = S_ATTACK;
                              }
                         }
                    }
                    else if(this.speartonType == "Spearos")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   param1.slow(30 * 5);
                              }
                         }
                    }
                    else if(this.speartonType == "Spearos_2")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   param1.slow(30 * 10);
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
                    else if(this.speartonType == "BuffSpear_3")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE)
                              {
                                   param1.setFire(3275,2);
                                   param1.poison(85);
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
               if(!team.isEnemy)
               {
                    _maxVelocity = param1.xml.xml.Order.Units.spearton.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Order.Units.spearton.damage) + Number(param1.xml.xml.Order.Units.spearton.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Order.Units.spearton.damage) + Number(param1.xml.xml.Order.Units.spearton.toArmour);
                    _mass = param1.xml.xml.Order.Units.spearton.mass;
               }
               else if(team.isEnemy && !enemyBuffed)
               {
                    _damageToNotArmour = _damageToNotArmour / 2.2 * team.game.main.campaign.difficultyLevel;
                    _damageToArmour = _damageToArmour / 3.5 * team.game.main.campaign.difficultyLevel;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.03 - 0.03;
                    enemyBuffed = true;
               }
               if(this.speartonType == "Barin" || this.speartonType == "Spearos_2" || this.speartonType == "Spearos" || this.speartonType == "Lava")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               this.comment = "Spearton Generals";
               if(this.speartonType == "BuffSpear" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Gladiator Helmet","Roman Shield");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "BuffSpear_2" && !this.setupComplete)
               {
                    noStone = true;
                    this.healthBar.visible = false;
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
                    noStone = true;
                    poisonUnit = true;
                    poisonRegen = true;
                    fireRegen = true;
                    burnUnit = true;
                    freezeUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"s07 Spear","s07 Helmet","s07 Shield");
                    maxHealth = 3000;
                    health = 3000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 6.3;
                    this.speartonGlow.color = 16711680;
                    this.speartonGlow.blurX = 10;
                    this.speartonGlow.blurY = 10;
                    this.mc.filters = [this.speartonGlow];
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
                    stunUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Elite","Greek Shield");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.07;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Atreyos_2" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Elite","Greek Shield");
                    maxHealth = 1600;
                    health = 1600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "SWLAtreyos" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","SWL Atreyos Helmet","Elite Shield 2");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 7.5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "OldSpearos" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Old Spearos Spear","Old Spearos Helmet","Old Spearos Shield");
                    maxHealth = 800;
                    health = 800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.3;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Spearos" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    frozenUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Spearos","Ice Shield 2");
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.07;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Spearos_2" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    frozenUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Spearos","Ice Shield 2");
                    maxHealth = 980;
                    health = 980;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.3;
                    this.speartonGlow = new GlowFilter();
                    this.speartonGlow.color = 3137765;
                    this.speartonGlow.blurX = 10;
                    this.speartonGlow.blurY = 10;
                    this.mc.filters = [this.speartonGlow];
                    this.setupComplete = true;
               }
               if(this.speartonType == "Barin" && !this.setupComplete)
               {
                    noStone = true;
                    burnUnit = true;
                    fireRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Barin Spear","Barin Helmet","Barin Shield");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "Golden and Elite Speartons";
               if(this.speartonType == "GoldenSpear" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Spear","Golden Helmet","Golden Shield");
                    maxHealth = 2160;
                    health = 2160;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "GoldenSpear_2" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Spear","Golden Helmet 2","Golden Shield 2");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "DarkSpear" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Spear","Dark Helmet","Dark Shield");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "DarkClone" && !this.setupComplete)
               {
                    enemyColor = true;
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Dark Spear","Dark Helmet","Dark Shield");
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    _maxVelocity = 12.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "DarkClone_2" && !this.setupComplete)
               {
                    enemyColor = true;
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
               if(this.speartonType == "Elite_1" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Golden Helmet 3","Greek Shield");
                    maxHealth = 775;
                    health = 775;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.8;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Elite_2" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","British Helmet","Roman Shield");
                    maxHealth = 1600;
                    health = 1600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.3;
                    _maxVelocity = 3.5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Elite_3" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Medieval Helmet","Medieval Shield");
                    maxHealth = 3800;
                    health = 3800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    _maxVelocity = 2;
                    this.setupComplete = true;
               }
               if(this.speartonType == "EliteSpear" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Jaged","Elite","Elite Shield 2");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 7;
                    this.heal(5,1);
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "Super Speartons";
               if(this.speartonType == "Ultra" && !this.setupComplete)
               {
                    noStone = true;
                    damageUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Native Spearton","Default");
                    maxHealth = 4200;
                    health = 4200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Super" && !this.setupComplete)
               {
                    noStone = true;
                    damageUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","HedgeHog Helmet","Spider Shield");
                    maxHealth = 7000;
                    health = 7000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Giga" && !this.setupComplete)
               {
                    noStone = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Trident","Marine Helmet","Goat Shield");
                    maxHealth = 65000;
                    health = 65000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2.5;
                    _maxVelocity = 3.5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Stone" && !this.setupComplete)
               {
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
               if(this.speartonType == "Leaf" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Leaf Spear","Leaf Helmet","Leaf Shield");
                    damageUnit = true;
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "MillionHP" && !this.setupComplete)
               {
                    freezeUnit = true;
                    frozenUnit = true;
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
                    freezeUnit = true;
                    frozenUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 8000;
                    health = 8000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Boss_2" && !this.setupComplete)
               {
                    freezeUnit = true;
                    frozenUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","","");
                    maxHealth = 12000;
                    health = 12000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.24;
                    _maxVelocity = 5;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "Other";
               if(this.speartonType == "Speedy" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Gladius","Default","Default");
                    maxHealth = 1600;
                    health = 1600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 25;
                    this.setupComplete = true;
               }
               if(this.speartonType == "HeavySpear" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Default","");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.15;
                    _maxVelocity = 6.1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Master" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Hockey Stick","Red Goalie","Goal Pads Shield");
                    maxHealth = 1050;
                    health = 1050;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Mega" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Gold Helmet","Medieval Shield");
                    damageUnit = true;
                    maxHealth = 2750;
                    health = 2750;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 13;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Dark" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Camo Spear","Samurai Mask","Dark Wood Shield");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Light" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Samurai","Gold Wood Shield");
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Lava" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Lava Helmet","Lava Shield");
                    maxHealth = 900;
                    health = 900;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Hybrid" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    poisonUnit = true;
                    poisonRegen = true;
                    freezeUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Ice Helmet","Undead Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Undead" && !this.setupComplete)
               {
                    noStone = true;
                    poisonUnit = true;
                    poisonRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"","Undead Helmet","Undead Shield");
                    maxHealth = 860;
                    health = 860;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.2;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Undead_2" && !this.setupComplete)
               {
                    noStone = true;
                    poisonRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Undead Spear","Undead Helmet 2","Undead Shield 2");
                    maxHealth = 1360;
                    health = 1360;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.2;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Savage" && !this.setupComplete)
               {
                    noStone = true;
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
                    noStone = true;
                    poisonRegen = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Vamp Spear","Vamp Helmet","Vamp Shield");
                    maxHealth = 200;
                    health = 100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "Ice" && !this.setupComplete)
               {
                    slowRegen = true;
                    freezeUnit = true;
                    damageUnit = true;
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Ice Spear 2","Ice Helmet","Ice Shield");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.speartonType == "NativeSpear" && !this.setupComplete)
               {
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
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"LeGold Spear","LeGold Helmet","LeGold Shield");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 5.9;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.speartonType != "")
               {
                    isCustomUnit = true;
               }
               if(this.speartonType == "GoldenSpear" || this.speartonType == "Elite_1" || this.speartonType == "Barin" || this.speartonType == "OldSpearos" || this.speartonType == "Spearos_2" || this.speartonType == "Adicai" || this.speartonType == "GoldenSpear_2" || this.speartonType == "Spearos" || this.speartonType == "Boss_2" || this.speartonType == "Boss_1" || this.speartonType == "MillionHP" || this.speartonType == "Atreyos" || this.speartonType == "Atreyos_2" || this.speartonType == "BuffSpear" || this.speartonType == "Ultra" || this.speartonType == "Super" || this.speartonType == "Giga" || this.speartonType == "BuffSpear_2" || this.speartonType == "DarkSpear")
               {
                    slowFramesRemaining = 0;
                    stunTimeLeft = 0;
               }
               if(this.speartonType == "Barin")
               {
                    this.radiantRange = 250;
               }
               if(this.speartonType == "BuffSpear")
               {
                    this.radiantRange = 350;
               }
               if(this.speartonType == "BuffSpear_2")
               {
                    this.radiantRange = 300;
               }
               if(this.speartonType == "Spearos")
               {
                    this.radiantRange = 250;
               }
               if(this.speartonType == "Spearos_2")
               {
                    this.radiantRange = 450;
               }
               if(isCustomUnit = true)
               {
                    if(this.speartonType == "SWLAtreyos")
                    {
                         _maxVelocity = 7.5;
                    }
                    else if(this.speartonType == "Mega")
                    {
                         _maxVelocity = 19.5;
                    }
                    else if(this.speartonType == "DarkClone")
                    {
                         _maxVelocity = 7;
                    }
                    else if(this.speartonType == "HeavySpear")
                    {
                         _maxVelocity = 4.2;
                    }
                    else if(this.speartonType == "Dark")
                    {
                         _maxVelocity = 4.6;
                    }
                    else if(this.speartonType == "Light")
                    {
                         _maxVelocity = 6.6;
                    }
                    else if(this.speartonType == "Leaf")
                    {
                         _maxVelocity = 6.8;
                    }
                    else if(this.speartonType == "Ice")
                    {
                         _maxVelocity = 5.8;
                    }
                    else if(this.speartonType == "Lava")
                    {
                         _maxVelocity = 5.8;
                    }
                    else
                    {
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
                         if(this.speartonType == "")
                         {
                              if(!hasHit && _mc.mc.currentFrame == 12)
                              {
                                   team.game.spatialHash.mapInArea(px - 300,py - 300,px + 25,py + 25,this.speartonHit);
                              }
                         }
                         if(!hasHit)
                         {
                              if(this.speartonType == "Vamp")
                              {
                                   isVampUnit = true;
                              }
                              hasHit = this.checkForHit();
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
                         if(this.speartonType == "SWLAtreyos" || this.speartonType == "GoldenSpear")
                         {
                              MovieClip(_mc.mc).nextFrame();
                         }
                    }
               }
               else if(isDead == false)
               {
                    if(this.speartonType == "Lava" || this.speartonType == "Barin")
                    {
                         param1.projectileManager.initNuke(px,py,this,50,0.6,600);
                    }
                    if(this.speartonType == "Atreyos_2")
                    {
                         param1.projectileManager.initNuke(px,py,this,50,0.6,600);
                         param1.projectileManager.initStun(this.px,py,35,this);
                         param1.projectileManager.initPoisonPool(this.px,this.py,this,0);
                    }
                    if(this.speartonType == "SWLAtreyos")
                    {
                         param1.projectileManager.initNuke(px,py,this,150,0.6,600);
                    }
                    if(this.speartonType == "EliteSpear")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Elite";
                    }
                    if(this.speartonType == "Elite")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Elite_2";
                    }
                    if(this.speartonType == "Adicai")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Elite_2";
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Elite_2";
                    }
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
                         this.clusterLad.speartonType = "DarkClone_2";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Undead_2")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Undead";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Undead";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Undead";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 200;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Undead";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Dark")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 200;
                         this.clusterLad.py = py - 50;
                         this.clusterLad.speartonType = "Light";
                         this.clusterLad.stun(0);
                         this.clusterLad.ai.setCommand(param1,new HoldCommand(param1));
                    }
                    if(this.speartonType == "Dark")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Light";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "Ultra")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "Super";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_SPEARTON);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.speartonType = "";
                         this.clusterLad.stun(0);
                    }
                    if(this.speartonType == "BuffSpear_2")
                    {
                         param1.projectileManager.initNuke(px,py,this,1000,500,10000);
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
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"s07 Spear","s07 Helmet","s07 Shield");
               }
               else if(this.speartonType == "Lava")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Lava Helmet","Lava Shield");
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
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","SWL Atreyos Helmet","Elite Shield 2");
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
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Default","Default","");
               }
               else if(this.speartonType == "Master")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Hockey Stick","Red Goalie","Goal Pads Shield");
               }
               else if(this.speartonType == "Mega")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Gold Helmet","Medieval Shield");
               }
               else if(this.speartonType == "Dark")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Camo Spear","Samurai Mask","Dark Wood Shield");
               }
               else if(this.speartonType == "Light")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Bronze Jaged","Samurai","Gold Wood Shield");
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
               else if(this.speartonType == "Elite_1")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Golden Jaged","Golden Helmet 3","Greek Shield");
               }
               else if(this.speartonType == "Elite_2")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","British Helmet","Roman Shield");
               }
               else if(this.speartonType == "Elite_3")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"British Spear","Medieval Helmet","Medieval Shield");
               }
               else if(this.speartonType == "EliteSpear")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Jaged","Elite","Elite Shield 2");
               }
               else if(this.speartonType == "Stone")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Stone Spear","Stone Helmet","Stone Shield");
               }
               else if(this.speartonType == "Leaf")
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
               else if(this.speartonType == "Hybrid")
               {
                    com.brockw.stickwar.engine.units.Spearton.setItem(_mc,"Lava Spear","Ice Helmet","Undead Shield");
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
                              param1.damage(0,this.damageToDeal,this);
                              param1.damage(0,this.damageToDeal,this);
                              param1.damage(0,this.damageToDeal,this);
                              param1.setFire(400,25);
                         }
                         if(this.speartonType == "GoldenSpear_2")
                         {
                              this.protect(350);
                              param1.damage(0,this.damageToDeal,this);
                              param1.damage(0,this.damageToDeal,this);
                         }
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
               if(this.speartonType == "NativeSpear_2")
               {
                    return 40;
               }
               if(this.speartonType == "NativeSpear")
               {
                    return 50;
               }
               if(this.speartonType == "Spearos")
               {
                    return 20;
               }
               if(this.speartonType == "Spearos_2")
               {
                    return 125;
               }
               if(this.speartonType == "OldSpearos")
               {
                    return 125;
               }
               if(this.speartonType == "SWLAtreyos")
               {
                    return 230;
               }
               if(this.speartonType == "Stone")
               {
                    return 65;
               }
               if(this.speartonType == "Lava")
               {
                    return 65;
               }
               if(this.speartonType == "s07")
               {
                    return 500;
               }
               if(this.speartonType == "DarkSpear")
               {
                    return 180;
               }
               if(this.speartonType == "EliteSpear")
               {
                    return 80;
               }
               if(this.speartonType == "DarkClone")
               {
                    return 50;
               }
               if(this.speartonType == "DarkClone_2")
               {
                    return 10;
               }
               if(this.speartonType == "Adicai")
               {
                    return 100;
               }
               if(this.speartonType == "GoldenSpear")
               {
                    return 160;
               }
               if(this.speartonType == "GoldenSpear_2")
               {
                    return 340;
               }
               if(this.speartonType == "Elite_2")
               {
                    return 80;
               }
               if(this.speartonType == "Elite_3")
               {
                    return 70;
               }
               if(this.speartonType == "Atreyos")
               {
                    return 30;
               }
               if(this.speartonType == "Atreyos_2")
               {
                    return 350;
               }
               if(this.speartonType == "Ultra")
               {
                    return 50;
               }
               if(this.speartonType == "Super")
               {
                    return 100;
               }
               if(this.speartonType == "Giga")
               {
                    return 2000;
               }
               if(this.speartonType == "BuffSpear")
               {
                    return 150;
               }
               if(this.speartonType == "BuffSpear_2")
               {
                    return 70;
               }
               if(this.speartonType == "BuffSpear_3")
               {
                    return 120;
               }
               if(this.speartonType == "MillionHP")
               {
                    return 200;
               }
               if(this.speartonType == "Boss_1")
               {
                    return 900;
               }
               if(this.speartonType == "Boss_2")
               {
                    return 118;
               }
               if(this.speartonType == "HeavySpear")
               {
                    return 88;
               }
               if(this.speartonType == "Dark")
               {
                    return 75;
               }
               if(this.speartonType == "Light")
               {
                    return 165;
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
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.speartonType == "Barin")
               {
                    return 120;
               }
               if(this.speartonType == "NativeSpear_2")
               {
                    return 55;
               }
               if(this.speartonType == "NativeSpear")
               {
                    return 35;
               }
               if(this.speartonType == "SWLAtreyos")
               {
                    return 230;
               }
               if(this.speartonType == "Stone")
               {
                    return 115;
               }
               if(this.speartonType == "Lava")
               {
                    return 115;
               }
               if(this.speartonType == "s07")
               {
                    return 700;
               }
               if(this.speartonType == "Adicai")
               {
                    return 125;
               }
               if(this.speartonType == "Elite_2")
               {
                    return 70;
               }
               if(this.speartonType == "EliteSpear")
               {
                    return 80;
               }
               if(this.speartonType == "Spearos_2")
               {
                    return 210;
               }
               if(this.speartonType == "Spearos")
               {
                    return 25;
               }
               if(this.speartonType == "OldSpearos")
               {
                    return 125;
               }
               if(this.speartonType == "GoldenSpear")
               {
                    return 160;
               }
               if(this.speartonType == "GoldenSpear_2")
               {
                    return 380;
               }
               if(this.speartonType == "DarkSpear")
               {
                    return 180;
               }
               if(this.speartonType == "DarkClone")
               {
                    return 50;
               }
               if(this.speartonType == "DarkClone_2")
               {
                    return 10;
               }
               if(this.speartonType == "Elite_1")
               {
                    return 245;
               }
               if(this.speartonType == "Hybrid")
               {
                    return 20;
               }
               if(this.speartonType == "Atreyos")
               {
                    return 35;
               }
               if(this.speartonType == "Atreyos_2")
               {
                    return 295;
               }
               if(this.speartonType == "Ultra")
               {
                    return 50;
               }
               if(this.speartonType == "Super")
               {
                    return 290;
               }
               if(this.speartonType == "Giga")
               {
                    return 2000;
               }
               if(this.speartonType == "BuffSpear")
               {
                    return 200;
               }
               if(this.speartonType == "BuffSpear_2")
               {
                    return 5000;
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
               if(this.speartonType == "BuffSpear_2")
               {
                    return 120;
               }
               if(this.speartonType == "BuffSpear_3")
               {
                    return 200;
               }
               if(this.speartonType == "HeavySpear")
               {
                    return 75;
               }
               if(this.speartonType == "Dark")
               {
                    return 95;
               }
               if(this.speartonType == "Light")
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
               if(this.inBlock || this.speartonType == "Elite_1" || this.speartonType == "SWLAtreyos" || this.speartonType == "Barin" || this.speartonType == "Spearos_2" || this.speartonType == "Spearos" || this.speartonType == "s07" || this.speartonType == "DarkSpear" || this.speartonType == "Adicai" || this.speartonType == "GoldenSpear_2" || this.speartonType == "GoldenSpear" || this.speartonType == "Atreyos" || this.speartonType == "Atreyos_2")
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
