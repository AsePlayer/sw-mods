package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.KnightAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.MovieClip;
     import flash.filters.GlowFilter;
     
     public class Knight extends com.brockw.stickwar.engine.units.Unit
     {
          
          private static var WEAPON_REACH:int;
           
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var convertedUnit:com.brockw.stickwar.engine.units.Unit;
          
          private var currentTarget:com.brockw.stickwar.engine.units.Unit;
          
          private var chargeVelocity:Number;
          
          private var normalVelocity:Number;
          
          private var chargeSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var isChargeSet:Boolean;
          
          private var chargeForce:Number;
          
          private var normalForce:Number;
          
          private var chargeStunArea:Number;
          
          private var hasCharged:Boolean;
          
          private var stunned:com.brockw.stickwar.engine.units.Unit;
          
          private var stunDamage:Number;
          
          private var stunEffect:Number;
          
          private var stunForce:Number;
          
          public var knightType:String;
          
          private var setupComplete:Boolean;
          
          private var maxTargetsToHit:int;
          
          private var targetsHit:int;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Knight;
          
          private var frames:int;
          
          private var knightGlow:GlowFilter;
          
          private var radiantRange:Number;
          
          private var radiantDamage:Number;
          
          private var radiantFrames:int;
          
          private var divider:String;
          
          private var comment:String;
          
          public function Knight(param1:StickWar)
          {
               super(param1);
               _mc = new _knight();
               this.init(param1);
               addChild(_mc);
               ai = new KnightAi(this);
               initSync();
               firstInit();
               this.isChargeSet = false;
               this.chargeForce = 0;
               this.hasCharged = false;
               this.stunned = null;
               this.knightGlow = new GlowFilter();
               this.knightGlow.color = 16711680;
               this.knightGlow.blurX = 0;
               this.knightGlow.blurY = 0;
               this.knightType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:MovieClip = null;
               if((_loc5_ = _knight(param1).mc).knighthelm)
               {
                    if(param3 != "")
                    {
                         _loc5_.knighthelm.gotoAndStop(param3);
                    }
               }
               if(_loc5_.knightweapon)
               {
                    if(param2 != "")
                    {
                         _loc5_.knightweapon.gotoAndStop(param2);
                    }
               }
               if(_loc5_.knightshield)
               {
                    if(param4 != "")
                    {
                         _loc5_.knightshield.gotoAndStop(param4);
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
               this.inBlock = false;
               this.isBlocking = false;
               this.convertedUnit = null;
               this.currentTarget = null;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               WEAPON_REACH = param1.xml.xml.Chaos.Units.knight.weaponReach;
               population = param1.xml.xml.Chaos.Units.knight.population;
               _mass = param1.xml.xml.Chaos.Units.knight.mass;
               _maxForce = this.normalForce = param1.xml.xml.Chaos.Units.knight.maxForce;
               this.chargeForce = param1.xml.xml.Chaos.Units.knight.charge.force;
               this.stunForce = param1.xml.xml.Chaos.Units.knight.charge.stunForce;
               _dragForce = param1.xml.xml.Chaos.Units.knight.dragForce;
               _scale = param1.xml.xml.Chaos.Units.knight.scale;
               _maxVelocity = this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity;
               damageToDeal = param1.xml.xml.Chaos.Units.knight.baseDamage;
               this.createTime = param1.xml.xml.Chaos.Units.knight.cooldown;
               maxHealth = health = param1.xml.xml.Chaos.Units.knight.health;
               this.radiantDamage = param1.xml.xml.Elemental.Units.lavaElement.radiant.damage;
               this.radiantRange = param1.xml.xml.Elemental.Units.lavaElement.radiant.range;
               this.radiantFrames = param1.xml.xml.Elemental.Units.lavaElement.radiant.frames;
               this.chargeStunArea = param1.xml.xml.Chaos.Units.knight.charge.stunArea;
               this.stunDamage = param1.xml.xml.Chaos.Units.knight.charge.damage;
               this.stunEffect = param1.xml.xml.Chaos.Units.knight.charge.stun;
               this.chargeVelocity = param1.xml.xml.Chaos.Units.knight.charge.velocity;
               this.maxTargetsToHit = param1.xml.xml.Chaos.Units.giant.maxTargetsToHit + 2;
               loadDamage(param1.xml.xml.Chaos.Units.knight);
               type = com.brockw.stickwar.engine.units.Unit.U_KNIGHT;
               this.chargeSpell = new com.brockw.stickwar.engine.units.SpellCooldown(param1.xml.xml.Chaos.Units.knight.charge.effect,param1.xml.xml.Chaos.Units.knight.charge.cooldown,param1.xml.xml.Chaos.Units.knight.charge.mana);
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
               return damageToDeal;
          }
          
          public function getChargeCooldown() : Number
          {
               return this.chargeSpell.cooldown();
          }
          
          public function charge() : void
          {
               if(!techTeam.tech.isResearched(Tech.KNIGHT_CHARGE))
               {
                    return;
               }
               if(this.chargeSpell.spellActivate(team))
               {
                    team.game.soundManager.playSound("deathKnightChargeSound",px,py);
                    this.hasCharged = false;
               }
          }
          
          private function getStunnedUnit(param1:com.brockw.stickwar.engine.units.Unit) : void
          {
               if(this.stunned == null && param1.team != this.team && param1.pz == 0)
               {
                    if(param1.type == com.brockw.stickwar.engine.units.Unit.U_WALL && Math.abs(param1.px - px) < 20)
                    {
                         this.stunned = param1;
                    }
                    else if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(3 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                    {
                         if(this.knightType == "Leader" && param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE && param1.type != com.brockw.stickwar.engine.units.Unit.U_WALL)
                         {
                              this.convertedUnit = param1;
                              team.enemyTeam.switchTeams(param1);
                              _state = S_ATTACK;
                         }
                         else if(this.knightType == "Leader_2" && param1.type != com.brockw.stickwar.engine.units.Unit.U_STATUE && param1.type != com.brockw.stickwar.engine.units.Unit.U_WALL && param1.type != com.brockw.stickwar.engine.units.Unit.U_GIANT && param1.type != com.brockw.stickwar.engine.units.Unit.U_KNIGHT)
                         {
                              this.convertedUnit = param1;
                              team.enemyTeam.switchTeams(param1);
                              _state = S_ATTACK;
                         }
                         this.stunned = param1;
                    }
               }
          }
          
          private function knightHit(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(this.targetsHit < this.maxTargetsToHit && param1.team != this.team)
               {
                    if(param1.px * mc.scaleX > px * mc.scaleX)
                    {
                         if(param1 is Wall || param1 is Statue)
                         {
                              ++this.targetsHit;
                              param1.damage(0,this.damageToDeal,this);
                         }
                         else if(Math.pow(param1.px + param1.dx - dx - px,2) + Math.pow(param1.py + param1.dy - dy - py,2) < Math.pow(5 * param1.hitBoxWidth * (this.perspectiveScale + param1.perspectiveScale) / 2,2))
                         {
                              ++this.targetsHit;
                              param1.damage(0,this.damageToDeal,this);
                              param1.damage(0,this.damageToDeal,this);
                         }
                    }
               }
          }
          
          private function burnInArea(param1:com.brockw.stickwar.engine.units.Unit) : *
          {
               if(param1.team != this.team)
               {
                    if(this.knightType == "BuffKnight")
                    {
                         if(Math.pow(param1.px - px,2) + Math.pow(param1.py - py,2) < this.radiantRange * this.radiantRange)
                         {
                              if(!hasHit && _mc.mc.currentFrame == 12)
                              {
                                   param1.poison(35);
                                   param1.damage(0,this.damageToDeal,this);
                                   param1.stun(10);
                              }
                         }
                    }
               }
          }
          
          override public function update(param1:StickWar) : void
          {
               this.chargeSpell.update();
               updateCommon(param1);
               if(this.knightType == "BuffKnight")
               {
                    team.game.spatialHash.mapInArea(px - this.radiantRange,py - this.radiantRange,px + this.radiantRange,py + this.radiantRange,this.burnInArea);
               }
               if(!isUC)
               {
                    this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity;
                    this.chargeVelocity = param1.xml.xml.Chaos.Units.knight.charge.velocity;
               }
               if(isUC)
               {
                    this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity * 1.5;
                    _damageToNotArmour = (Number(param1.xml.xml.Chaos.Units.knight.damage) + Number(param1.xml.xml.Chaos.Units.knight.toNotArmour)) * 6.7;
                    _damageToArmour = (Number(param1.xml.xml.Chaos.Units.knight.damage) + Number(param1.xml.xml.Chaos.Units.knight.toArmour)) * 4.4;
                    _mass = Number(param1.xml.xml.Chaos.Units.knight.mass) / 2;
                    this.stunDamage = param1.xml.xml.Chaos.Units.knight.charge.damage * 3;
               }
               else if(!team.isEnemy)
               {
                    this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Chaos.Units.knight.damage) + Number(param1.xml.xml.Chaos.Units.knight.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Chaos.Units.knight.damage) + Number(param1.xml.xml.Chaos.Units.knight.toArmour);
                    _mass = param1.xml.xml.Chaos.Units.knight.mass;
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
               if(this.knightType == "BuffKnight" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    fireRegen = true;
                    poisonRegen = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Skull Helmet","Skull Shield");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Predator" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Predator Axe","Predator Helmet","Bone Shield");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Wild" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"","","");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.07;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Rusted" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Rusted Axe","Rust Helmet","Rusted Shield");
                    maxHealth = 1450;
                    health = 1450;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Fireman" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Fireman Axe","Fireman","Fireman Shield");
                    maxHealth = 2150;
                    health = 2150;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Red" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Red Knight Axe","Red Knight Helmet","Red Knight Shield");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Chef" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Cleaver","Chef Hat","Pig Shield");
                    maxHealth = 1800;
                    health = 1800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Viking" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Orc Weapon","Viking Helmet","Viking Shield");
                    maxHealth = 2500;
                    health = 2500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.5;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Gold" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Axe","Gold Helmet","Gold Shield");
                    maxHealth = 2500;
                    health = 2500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.5;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Toppat" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Top Hat","Pig Shield");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.07;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Thor" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Thor Hammer","Thor Helmet","Thor Shield");
                    maxHealth = 4800;
                    health = 4800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "SuperKnight" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Spikey Axe","Knight Helmet","Solid Shield");
                    maxHealth = 7800;
                    health = 7800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "GigaKnight" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Boot Axe","Shard Helmet","Wooden Shield");
                    maxHealth = 35800;
                    health = 35800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 2;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               this.divider = "---------------------------------------------------------------------------";
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "";
               if(this.knightType == "Leader" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Leader Axe","Leader Helmet 3","Leader Shield");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.07;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Leader_2" && !this.setupComplete)
               {
                    noStone = true;
                    poisonUnit = true;
                    fireRegen = true;
                    poisonRegen = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Leader Axe","Leader Helmet","Leader Shield");
                    maxHealth = 10500;
                    health = 10500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "SecondCommand" && !this.setupComplete)
               {
                    noStone = true;
                    stunUnit = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Commander Helmet","Leader Shield");
                    maxHealth = 550;
                    health = 550;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.04;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "SecondCommand_2" && !this.setupComplete)
               {
                    noStone = true;
                    stunUnit = true;
                    nonTeleportable = true;
                    generalRegen = true;
                    generalRegen2 = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Second Helmet","Slotted Shield");
                    maxHealth = 8000;
                    health = 8000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "LeGoldKnight" && !this.setupComplete)
               {
                    noStone = true;
                    generalRegen = true;
                    LeGoldRegen = true;
                    RefuseToDie = true;
                    this.isReflective = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"LeSword","LeHelmet","LeShield");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.knightGlow.color = 16776960;
                    this.knightGlow.blurX = 10;
                    this.knightGlow.blurY = 10;
                    this.mc.filters = [this.knightGlow];
                    this.setupComplete = true;
               }
               if(this.knightType == "FireKnight" && !this.setupComplete)
               {
                    noStone = true;
                    burnUnit = true;
                    fireRegen = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Flame Axe","Flame Helmet","Flame Shield");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.08;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "DemonKnight" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Demon Sword 1","Demon Helmet","Demon Shield");
                    maxHealth = 1400;
                    health = 1400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.knightGlow.color = 0;
                    this.knightGlow.blurX = 10;
                    this.knightGlow.blurY = 10;
                    this.mc.filters = [this.knightGlow];
                    this.setupComplete = true;
               }
               if(this.knightType == "DemonKnight_2" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Demon Sword 2","Demon Helmet","Demon Shield");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.knightGlow.color = 0;
                    this.knightGlow.blurX = 10;
                    this.knightGlow.blurY = 10;
                    this.mc.filters = [this.knightGlow];
                    this.setupComplete = true;
               }
               if(this.knightType == "CrystalKnight" && !this.setupComplete)
               {
                    frozenUnit = true;
                    slowRegen = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Crystal Axe","Crystal Helmet","Crystal Shield");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.knightGlow.color = 65535;
                    this.knightGlow.blurX = 20;
                    this.knightGlow.blurY = 20;
                    this.mc.filters = [this.knightGlow];
                    this.shieldwallDamageReduction = 0.85;
                    this.setupComplete = true;
               }
               if(this.knightType == "VampKnight" && !this.setupComplete)
               {
                    noStone = true;
                    HeavyVampRegen = true;
                    HeavyVampCure = true;
                    isVampUnit = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Vamp Axe","Vamp Helmet 2","Vamp Shield 2");
                    maxHealth = 1000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.08;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "IceKnight" && !this.setupComplete)
               {
                    noStone = true;
                    freezeUnit = true;
                    this.ai.flyingCrossbowmanTargeter = true;
                    flyingHeight = 250 * 1;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Ice Axe","Vamp Helmet 2","Ice Shield");
                    maxHealth = 1300;
                    health = 1300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.08;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "EliteKnight" && !this.setupComplete)
               {
                    noStone = true;
                    criticalDamage = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Elite Axe","Elite Helmet","Elite Shield");
                    maxHealth = 800;
                    health = 800;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "SilverKnight" && !this.setupComplete)
               {
                    noStone = true;
                    BlockChance = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Silver Axe","Silver Helmet","Silver Shield");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "Knight_1" && !this.setupComplete)
               {
                    noStone = true;
                    reapUnit = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"New Axe 2","New Helmet 2","New Shield 2");
                    maxHealth = 10000;
                    health = 1000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "GoldKnight" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Jug Axe","Gold Jug Helmet","Gold Jug Shield");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.08;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "GoldKnight_2" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Axe 2","Gold Jug Helmet 2","Gold Jug Shield 2");
                    maxHealth = 1200;
                    health = 1200;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "MegaKnight" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    slowAttack = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Gas Mask","Riot Shield");
                    maxHealth = 9500;
                    health = 9500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "MegaKnight_2" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Gas Mask","Thor Shield");
                    maxHealth = 7500;
                    health = 7500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.2;
                    _maxVelocity = 4.8;
                    this.setupComplete = true;
               }
               if(this.knightType == "MegaKnight_3" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Viking Axe","Shard Helmet","Solid Shield");
                    maxHealth = 11000;
                    health = 11000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 4.8;
                    _scale = 1.2;
                    this.setupComplete = true;
               }
               if(this.knightType == "DemonClone" && !this.setupComplete)
               {
                    noStone = true;
                    enemyColor4 = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Demon Sword 1","Demon Helmet","Demon Shield");
                    maxHealth = 300;
                    health = 300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "DemonClone_2" && !this.setupComplete)
               {
                    noStone = true;
                    enemyColor4 = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Demon Sword 2","Demon Helmet","Demon Shield");
                    maxHealth = 300;
                    health = 300;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "VoltKnight" && !this.setupComplete)
               {
                    noStone = true;
                    GeneralIsVoltaic = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Voltaic Axe 1","Voltaic Helmet 1","Voltaic Shield 1");
                    maxHealth = 1400;
                    health = 1400;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "VoltKnight_2" && !this.setupComplete)
               {
                    noStone = true;
                    isVoltaic = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Voltaic Axe 2","Voltaic Helmet 2","Voltaic Shield 2");
                    maxHealth = 1170;
                    health = 1170;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType == "RGB_Knight" && !this.setupComplete)
               {
                    isRGB = true;
                    burnUnit = true;
                    freezeUnit = true;
                    frozenUnit = true;
                    poisonUnit = true;
                    stunUnit = true;
                    isVoltaic = true;
                    reapUnit = true;
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"RGB Axe","RGB Helmet","RGB Shield");
                    maxHealth = 4000;
                    health = 4000;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    _maxVelocity = 6.5;
                    this.setupComplete = true;
               }
               if(this.knightType != "")
               {
                    isCustomUnit = true;
               }
               if(this.knightType == "Leader" || this.knightType == "LeGoldKnight" || this.knightType == "MegaKnight_2" || this.knightType == "MegaKnight_3" || this.knightType == "DemonKnight" || this.knightType == "DemonKnight_2" || this.knightType == "GoldKnight" || this.knightType == "GoldKnight_2" || this.knightType == "SecondCommand" || this.knightType == "SecondCommand_2")
               {
                    slowFramesRemaining = 0;
                    stunTimeLeft = 0;
               }
               if(isCustomUnit = true)
               {
                    if(this.knightType == "SecondCommand")
                    {
                         this.normalVelocity = 6.4;
                         this.chargeStunArea = 250;
                         this.chargeVelocity = 15;
                         this.chargeForce = 300;
                    }
                    else if(this.knightType == "DemonClone" || this.knightType == "DemonClone_2")
                    {
                         this.normalVelocity = 7.4;
                    }
                    else if(this.knightType == "Leader_2")
                    {
                         stunTimeLeft = 0;
                    }
                    else if(isUC)
                    {
                         this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity * 1.5;
                    }
                    else if(this.knightType == "SecondCommand_2")
                    {
                         this.normalVelocity = 8.4;
                         this.chargeStunArea = 350;
                         this.chargeVelocity = 27;
                         this.chargeForce = 500;
                    }
                    else if(this.knightType == "MegaKnight")
                    {
                         this.chargeStunArea = 550;
                         this.chargeVelocity = 47;
                         this.chargeForce = 700;
                         this.normalVelocity = 4.6;
                    }
                    else if(this.knightType == "LeGoldKnight")
                    {
                         this.chargeStunArea = 350;
                         this.chargeVelocity = 25;
                         this.chargeForce = 400;
                         this.normalVelocity = 7.5;
                    }
                    else if(this.knightType == "EliteKnight")
                    {
                         this.chargeStunArea = 150;
                         this.chargeVelocity = 12;
                         this.chargeForce = 200;
                         this.normalVelocity = 5.6;
                    }
                    else if(this.knightType == "MegaKnight_2" || this.knightType == "MegaKnight_3")
                    {
                         this.normalVelocity = 4.8;
                    }
                    else if(this.knightType == "GigaKnight")
                    {
                         this.normalVelocity = 4.4;
                    }
                    else if(this.knightType == "Toppat")
                    {
                         this.normalVelocity = 4.9;
                    }
                    else if(this.knightType == "Fireman")
                    {
                         this.normalVelocity = 27.9;
                    }
                    else if(this.knightType == "MegaKnight")
                    {
                         this.convertedUnit = param1;
                         team.enemyTeam.switchTeams(param1);
                         _state = S_ATTACK;
                    }
                    else
                    {
                         this.normalVelocity = param1.xml.xml.Chaos.Units.knight.maxVelocity;
                         this.chargeStunArea = param1.xml.xml.Chaos.Units.knight.charge.stunArea;
                         this.chargeVelocity = param1.xml.xml.Chaos.Units.knight.charge.velocity;
                         this.chargeForce = param1.xml.xml.Chaos.Units.knight.charge.force;
                    }
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
                    else if(this.chargeSpell.inEffect() && this.hasCharged == false)
                    {
                         if(!this.hasCharged)
                         {
                              this.stunned = null;
                              param1.spatialHash.mapInArea(this.px - this.chargeStunArea,this.py - this.chargeStunArea,this.px + this.chargeStunArea,this.py + this.chargeStunArea,this.getStunnedUnit);
                              if(this.stunned != null)
                              {
                                   this.hasCharged = true;
                                   this.stunned.stun(this.stunEffect);
                                   this.stunned.damage(0,this.stunDamage,null);
                                   this.stunned.applyVelocity(this.stunForce * Util.sgn(mc.scaleX));
                                   if(this.knightType == "SecondCommand")
                                   {
                                        this.stunned.poison(70);
                                        param1.projectileManager.initNuke(px,py,this,20,0.2,600);
                                   }
                                   if(this.knightType == "IceKnight")
                                   {
                                        this.stunned.slow(30 * 100);
                                        this.stunned.freeze(30 * 25);
                                   }
                                   if(this.knightType == "MegaKnight")
                                   {
                                        this.stunned.poison(100);
                                   }
                                   if(this.knightType == "GoldKnight" || this.knightType == "GoldKnight_2")
                                   {
                                        this.protect(190);
                                   }
                                   if(this.knightType == "SecondCommand_2")
                                   {
                                        this.stunned.poison(160);
                                        this.stunned.slow(30 * 200);
                                        this.stunned.freeze(30 * 60);
                                        param1.projectileManager.initNuke(px,py,this,80,0.6,600);
                                   }
                                   if(this.knightType == "CrystalKnight")
                                   {
                                        this.stunned.freeze(30 * 5);
                                   }
                                   if(this.knightType == "FireKnight")
                                   {
                                        this.stunned.setFire(1230,1.2);
                                   }
                                   if(this.knightType == "VampKnight")
                                   {
                                        this.heal(75,5);
                                   }
                              }
                         }
                         _mc.gotoAndStop("charge");
                         this._maxVelocity = this.chargeVelocity;
                         this._maxForce = this.chargeForce;
                         this.isChargeSet = true;
                         this.walk(team.direction,0,team.direction);
                         this.isChargeSet = false;
                    }
                    else if(_state == S_RUN)
                    {
                         this._maxVelocity = this.normalVelocity;
                         this._maxForce = this.normalForce;
                         if(isFeetMoving())
                         {
                              if(this.knightType == "")
                              {
                                   this.heal(0.5,1);
                              }
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
                         if(this.knightType == "")
                         {
                              if(this.targetsHit < this.maxTargetsToHit && !hasHit)
                              {
                                   if(_mc.mc.currentFrame == 23)
                                   {
                                        team.game.spatialHash.mapInArea(px - 300,py - 300,px + 25,py + 25,this.knightHit);
                                   }
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
                    if(this.knightType == "DemonKnight")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "DemonClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "DemonClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "DemonClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "DemonClone";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "DemonKnight_2")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "DemonClone_2";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "DemonClone_2";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "DemonClone_2";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "DemonClone_2";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "SecondCommand_2")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Default";
                         this.clusterLad.stun(40);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Default";
                         this.clusterLad.stun(40);
                    }
                    if(this.knightType == "LeGoldKnight")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "GoldKnight";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "GoldKnight_2";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "FireKnight";
                         this.clusterLad.stun(140);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "FireKnight";
                         this.clusterLad.stun(140);
                    }
                    if(this.knightType == "BuffKnight")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Predator";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "Predator")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Wild";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "Wild")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Rusted";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "Rusted")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Fireman";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "Fireman")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Chef";
                         this.clusterLad.stun(0);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Red";
                         this.clusterLad.stun(0);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Toppat";
                         this.clusterLad.stun(0);
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Toppat";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "Red")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Viking";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "Chef")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Gold";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "Gold")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "Thor";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "Thor")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "SuperKnight";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "SuperKnight")
                    {
                         param1.projectileManager.initTowerSpawn(px,py,param1.team,0.6);
                         this.clusterLad = team.game.unitFactory.getUnit(com.brockw.stickwar.engine.units.Unit.U_KNIGHT);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px;
                         this.clusterLad.py = py;
                         this.clusterLad.knightType = "GigaKnight";
                         this.clusterLad.stun(0);
                    }
                    if(this.knightType == "FireKnight")
                    {
                         param1.projectileManager.initNuke(px,py,this,40,0.4,300);
                    }
                    if(this.knightType == "VoltKnight" || this.knightType == "VoltKnight_2")
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
               if(_mc.mc.dust)
               {
                    Util.animateMovieClipBasic(_mc.mc.dust);
               }
               if(this.knightType == "Leader")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Leader Axe","Leader Helmet","Leader Shield");
               }
               else if(this.knightType == "Leader_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Leader Axe","Leader Helmet 3","Slotted Shield");
               }
               else if(this.knightType == "BuffKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Skull Helmet","Skull Shield");
               }
               else if(this.knightType == "Predator")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Predator Axe","Predator Helmet","Bone Shield");
               }
               else if(this.knightType == "Wild")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Claw Hammer","Lion Head","Fur Shield");
               }
               else if(this.knightType == "Rusted")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Rusted Axe","Rust Helmet","Rusted Shield");
               }
               else if(this.knightType == "Fireman")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Fireman Axe","Fireman","Fireman Shield");
               }
               else if(this.knightType == "Red")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Red Knight Axe","Red Knight Helmet","Red Knight Shield");
               }
               else if(this.knightType == "Chef")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Cleaver","Chef Hat","Pig Shield");
               }
               else if(this.knightType == "Viking")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Orc Weapon","Viking Helmet","Viking Shield");
               }
               else if(this.knightType == "Gold")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Axe","Gold Helmet","Gold Shield");
               }
               else if(this.knightType == "GoldKnight_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Axe 2","Gold Jug Helmet 2","Gold Jug Shield 2");
               }
               else if(this.knightType == "Toppat")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Top Hat","Pig Shield");
               }
               else if(this.knightType == "Thor")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Thor Hammer","Thor Helmet","Thor Shield");
               }
               else if(this.knightType == "SuperKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Spikey Axe","Knight Helmet","Solid Shield");
               }
               else if(this.knightType == "GigaKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Boot Axe","Shard Helmet","Wooden Shield");
               }
               else if(this.knightType == "FireKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Flame Axe","Flame Helmet","Flame Shield");
               }
               else if(this.knightType == "VampKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Vamp Axe","Vamp Helmet 2","Vamp Shield 2");
               }
               else if(this.knightType == "SecondCommand")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Commander Helmet","Leader Shield");
               }
               else if(this.knightType == "SecondCommand_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe","Second Helmet","Slotted Shield");
               }
               else if(this.knightType == "GoldKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Gold Jug Axe","Gold Jug Helmet","Gold Jug Shield");
               }
               else if(this.knightType == "IceKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Ice Axe","New Default Helmet","Ice Shield");
               }
               else if(this.knightType == "MegaKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Gas Mask","Riot Shield");
               }
               else if(this.knightType == "MegaKnight_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Chain Axe","Gas Mask","Thor Shield");
               }
               else if(this.knightType == "MegaKnight_3")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Viking Axe","Shard Helmet","Solid Shield");
               }
               else if(this.knightType == "DemonKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Demon Sword 1","Demon Helmet","Demon Shield");
               }
               else if(this.knightType == "DemonKnight_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Demon Sword 2","Demon Helmet","Demon Shield");
               }
               else if(this.knightType == "DemonClone")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Demon Sword 1","Demon Helmet","Demon Shield");
               }
               else if(this.knightType == "DemonClone_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Demon Sword 2","Demon Helmet","Demon Shield");
               }
               else if(this.knightType == "CrystalKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Crystal Axe","Crystal Helmet","Crystal Shield");
               }
               else if(this.knightType == "VoltKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Voltaic Axe 1","Voltaic Helmet 1","Voltaic Shield 1");
               }
               else if(this.knightType == "VoltKnight_2")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Voltaic Axe 2","Voltaic Helmet 2","Voltaic Shield 2");
               }
               else if(this.knightType == "EliteKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Elite Axe","Elite Helmet","Elite Shield");
               }
               else if(this.knightType == "SilverKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Silver Axe","Silver Helmet","Silver Shield");
               }
               else if(this.knightType == "LeGoldKnight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"LeSword","LeHelmet","LeShield");
               }
               else if(this.knightType == "RGB_Knight")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"RGB Axe","RGB Helmet","RGB Shield");
               }
               else if(this.knightType == "Knight_1")
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"New Axe 2","New Helmet 2","New Shield 2");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Knight.setItem(_mc,"Double Axe 2","New Helmet 3","Slotted Shield 2");
               }
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.knightType == "LeGoldKnight")
               {
                    return 820;
               }
               if(this.knightType == "DemonKnight_2")
               {
                    return 125;
               }
               if(this.knightType == "DemonKnight")
               {
                    return 165;
               }
               if(this.knightType == "EliteKnight")
               {
                    return 70;
               }
               if(this.knightType == "SilverKnight")
               {
                    return 43;
               }
               if(this.knightType == "GoldKnight")
               {
                    return 145;
               }
               if(this.knightType == "GoldKnight_2")
               {
                    return 165;
               }
               if(this.knightType == "DemonClone")
               {
                    return 40;
               }
               if(this.knightType == "DemonClone_2")
               {
                    return 40;
               }
               if(this.knightType == "Leader")
               {
                    return 23;
               }
               if(this.knightType == "Leader_2")
               {
                    return 230;
               }
               if(this.knightType == "SecondCommand")
               {
                    return 20;
               }
               if(this.knightType == "SecondCommand_2")
               {
                    return 263;
               }
               if(this.knightType == "FireKnight")
               {
                    return 15;
               }
               if(this.knightType == "VampKnight")
               {
                    return 15;
               }
               if(this.knightType == "MegaKnight_2")
               {
                    return 100;
               }
               if(this.knightType == "MegaKnight_3")
               {
                    return 130;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.knightType == "BuffKnight")
               {
                    return 140;
               }
               if(this.knightType == "Toppat")
               {
                    return 40;
               }
               if(this.knightType == "Viking")
               {
                    return 80;
               }
               if(this.knightType == "Thor")
               {
                    return 170;
               }
               if(this.knightType == "SuperKnight")
               {
                    return 230;
               }
               if(this.knightType == "GigaKnight")
               {
                    return 2350;
               }
               this.divider = "---------------------------------------------------------------------------";
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.knightType == "SilverKnight")
               {
                    return 73;
               }
               if(this.knightType == "MegaKnight_2")
               {
                    return 65;
               }
               if(this.knightType == "MegaKnight_3")
               {
                    return 110;
               }
               if(this.knightType == "DemonKnight_2")
               {
                    return 180;
               }
               if(this.knightType == "DemonKnight")
               {
                    return 200;
               }
               if(this.knightType == "DemonClone")
               {
                    return 60;
               }
               if(this.knightType == "DemonClone_2")
               {
                    return 60;
               }
               if(this.knightType == "Leader")
               {
                    return 23;
               }
               if(this.knightType == "Leader_2")
               {
                    return 300;
               }
               if(this.knightType == "LeGoldKnight")
               {
                    return 520;
               }
               if(this.knightType == "SecondCommand")
               {
                    return 21;
               }
               if(this.knightType == "SecondCommand_2")
               {
                    return 410;
               }
               if(this.knightType == "FireKnight")
               {
                    return 15;
               }
               if(this.knightType == "GoldKnight")
               {
                    return 215;
               }
               if(this.knightType == "GoldKnight_2")
               {
                    return 265;
               }
               if(this.knightType == "VampKnight")
               {
                    return 15;
               }
               this.divider = "---------------------------------------------------------------------------";
               if(this.knightType == "BuffKnight")
               {
                    return 200;
               }
               if(this.knightType == "Toppat")
               {
                    return 60;
               }
               if(this.knightType == "Viking")
               {
                    return 90;
               }
               if(this.knightType == "Thor")
               {
                    return 290;
               }
               if(this.knightType == "SuperKnight")
               {
                    return 430;
               }
               if(this.knightType == "GigaKnight")
               {
                    return 2750;
               }
               this.divider = "---------------------------------------------------------------------------";
               return _damageToNotArmour;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(techTeam.tech.isResearched(Tech.KNIGHT_CHARGE || this.knightType == "Leader"))
               {
                    param1.setAction(0,0,UnitCommand.KNIGHT_CHARGE);
               }
          }
          
          public function stopBlocking() : void
          {
               this.isBlocking = false;
          }
          
          public function startBlocking() : void
          {
               if(this.knightType == "")
               {
                    this.isBlocking = true;
                    this.inBlock = true;
               }
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.knightType == "CrystalKnight")
               {
                    trace(this.shieldwallDamageReduction);
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
                    framesInAttack = MovieClip(_mc.mc).totalFrames;
                    attackStartFrame = team.game.frame;
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
          
          override protected function isAbleToWalk() : Boolean
          {
               return this._state == S_RUN && (!this.chargeSpell.inEffect() || this.isChargeSet);
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
