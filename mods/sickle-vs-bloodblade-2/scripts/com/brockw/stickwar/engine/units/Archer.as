package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.ArcherAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.Entity;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.filters.GlowFilter;
     import flash.geom.Point;
     
     public class Archer extends RangedUnit
     {
           
          
          private var _isBlocking:Boolean;
          
          private var _inBlock:Boolean;
          
          private var shieldwallDamageReduction:Number;
          
          private var _isCastleArcher:Boolean;
          
          private var isFire:Boolean;
          
          private var archerFireSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var arrowDamage:Number;
          
          public var archerType:String;
          
          private var setupComplete:Boolean;
          
          private var bowFrame:int;
          
          private var normalRange:Number;
          
          private var fireArrowRange:Number;
          
          private var areaDamage:Number;
          
          private var area:Number;
          
          private var fireDamage:Number;
          
          private var fireFrames:int;
          
          private var archerGlow:GlowFilter;
          
          private var clusterLad:com.brockw.stickwar.engine.units.Archer;
          
          public function Archer(param1:StickWar)
          {
               super(param1);
               _mc = new _archer();
               this.init(param1);
               addChild(_mc);
               ai = new ArcherAi(this);
               initSync();
               firstInit();
               this.archerFireSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(0,param1.xml.xml.Order.Units.archer.fire.cooldown,param1.xml.xml.Order.Units.archer.fire.mana);
               this.archerGlow = new GlowFilter();
               this.archerGlow.color = 16711680;
               this.archerGlow.blurX = 10;
               this.archerGlow.blurY = 10;
               this.archerType = "Default";
          }
          
          public static function setItem(param1:MovieClip, param2:String, param3:String, param4:String) : void
          {
               var _loc5_:_archer = null;
               if((_loc5_ = _archer(param1)).mc.archerBag)
               {
                    if(param4 != "")
                    {
                         _loc5_.mc.archerBag.gotoAndStop(param4);
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
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               super.setActionInterface(param1);
               if(techTeam.tech.isResearched(Tech.ARCHIDON_FIRE))
               {
                    param1.setAction(0,0,UnitCommand.ARCHER_FIRE);
               }
          }
          
          public function getFireCoolDown() : Number
          {
               return this.archerFireSpellCooldown.cooldown();
          }
          
          override public function init(param1:StickWar) : void
          {
               initBase();
               _maximumRange = this.normalRange = param1.xml.xml.Order.Units.archer.maximumRange;
               this.shieldwallDamageReduction = param1.xml.xml.Order.Units.spearton.shieldWall.damageReduction;
               this.fireArrowRange = param1.xml.xml.Order.Units.archer.fire.range;
               maxHealth = health = param1.xml.xml.Order.Units.archer.health;
               this.createTime = param1.xml.xml.Order.Units.archer.cooldown;
               this.projectileVelocity = param1.xml.xml.Order.Units.archer.arrowVelocity;
               this.arrowDamage = param1.xml.xml.Order.Units.archer.damage;
               population = param1.xml.xml.Order.Units.archer.population;
               _mass = param1.xml.xml.Order.Units.archer.mass;
               _maxForce = param1.xml.xml.Order.Units.archer.maxForce;
               _dragForce = param1.xml.xml.Order.Units.archer.dragForce;
               _scale = param1.xml.xml.Order.Units.archer.scale;
               _maxVelocity = param1.xml.xml.Order.Units.archer.maxVelocity;
               this.fireDamage = param1.xml.xml.Order.Units.archer.fire.fireDamage;
               this.fireFrames = param1.xml.xml.Order.Units.archer.fire.fireFrames;
               this.loadDamage(param1.xml.xml.Order.Units.archer);
               this.areaDamage = 0;
               this.area = 0;
               if(this.isCastleArcher)
               {
                    this._maximumRange = this.normalRange = param1.xml.xml.Order.Units.archer.castleRange;
                    _scale *= 1.1;
                    this.area = param1.xml.xml.Order.Units.archer.castleArea;
                    this.areaDamage = param1.xml.xml.Order.Units.archer.castleAreaDamage;
               }
               type = Unit.U_ARCHER;
               _mc.stop();
               _mc.width *= _scale;
               _mc.height *= _scale;
               _state = S_RUN;
               MovieClip(_mc.mc.gotoAndPlay(1));
               MovieClip(_mc.gotoAndStop(1));
               drawShadow();
               this.isFire = false;
               this.bowFrame = 1;
          }
          
          override protected function loadDamage(param1:XMLList) : void
          {
               var _loc2_:Number = NaN;
               this.isArmoured = param1.armoured == 1 ? true : false;
               if(!this._isCastleArcher)
               {
                    _loc2_ = Number(param1.damage);
                    this._damageToArmour = _loc2_ + Number(param1.toArmour);
                    this._damageToNotArmour = _loc2_ + Number(param1.toNotArmour);
               }
               else
               {
                    _loc2_ = Number(param1.castleDamage);
                    this._damageToArmour = _loc2_ + Number(param1.castleToArmour);
                    this._damageToNotArmour = _loc2_ + Number(param1.castleToNotArmour);
               }
          }
          
          override public function setBuilding() : void
          {
               building = team.buildings["ArcheryBuilding"];
          }
          
          public function archerFireArrow() : void
          {
               if(this.archerFireSpellCooldown.spellActivate(team) && techTeam.tech.isResearched(Tech.ARCHIDON_FIRE))
               {
                    this.isFire = true;
                    takeBottomTrajectory = false;
                    _maximumRange = this.fireArrowRange;
               }
          }
          
          override public function update(param1:StickWar) : void
          {
               super.update(param1);
               this.archerFireSpellCooldown.update();
               updateCommon(param1);
               if(!team.isEnemy)
               {
                    _maxVelocity = param1.xml.xml.Order.Units.archer.maxVelocity;
                    _damageToNotArmour = Number(param1.xml.xml.Order.Units.archer.damage) + Number(param1.xml.xml.Order.Units.archer.toNotArmour);
                    _damageToArmour = Number(param1.xml.xml.Order.Units.archer.damage) + Number(param1.xml.xml.Order.Units.archer.toArmour);
               }
               else if(team.isEnemy && !enemyBuffed && !this.isCastleArcher)
               {
                    _damageToNotArmour *= 1;
                    _damageToArmour *= 1;
                    health = Number(param1.xml.xml.Order.Units.archer.health) * 3;
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    enemyBuffed = true;
               }
               if(this.archerType == "")
               {
                    _damageToArmour = _damageToArmour / 0 * team.game.main.campaign.difficultyLevel + 1;
               }
               if(this.archerType == "Kytchu" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Kytchu","Gold Quiver");
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "Kytchu_2" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Kytchu","Gold Quiver");
                    maxHealth = 450;
                    health = 450;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 6.2;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "SplashKytchu" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Kytchu 2","Gold Quiver");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    this.areaDamage = 25;
                    this.area = 300;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "SplashKytchu_2" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Kytchu 2","Gold Quiver");
                    maxHealth = 1500;
                    health = 1500;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    this.areaDamage = 25;
                    this.area = 250;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "ChaosArcher" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Chaos Helmet","Chaos Quiver");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "LeafArcher" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Leaf Helmet","Leaf Quiver");
                    maxHealth = 500;
                    health = 500;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "Heavy" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Basic Helmet","Silver Quiver");
                    maxHealth = 700;
                    health = 700;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "LeafArcher_2" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Leaf Helmet","Leaf Quiver");
                    maxHealth = 80;
                    health = 80;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "Native" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Native Archer","Native Quiver");
                    maxHealth = 270;
                    health = 270;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "Native_2" && !this.setupComplete)
               {
                    noStone = true;
                    teleportEnemy = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","LeGold Helmet","LeGold Quiver");
                    maxHealth = 300;
                    health = 300;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "DarkKytchu" && !this.setupComplete)
               {
                    poisonRegen = true;
                    fireRegen = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Dark Kytchu","Dark Quiver");
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    this.areaDamage = 14;
                    this.area = 100;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 0.9;
                    this.archerGlow.color = 0;
                    this.archerGlow.blurX = 6;
                    this.archerGlow.blurY = 6;
                    this.mc.filters = [this.archerGlow];
                    this.setupComplete = true;
               }
               if(this.archerType == "GoldenArcher" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Golden Helmet","Gold Quiver");
                    maxHealth = 650;
                    health = 650;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "CrystalArcher" && !this.setupComplete)
               {
                    slowRegen = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Crystal Helmet","Crystal Quiver");
                    maxHealth = 650;
                    health = 650;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 1;
                    this.archerGlow.color = 65535;
                    this.archerGlow.blurX = 5;
                    this.archerGlow.blurY = 5;
                    this.mc.filters = [this.archerGlow];
                    this.setupComplete = true;
               }
               if(this.archerType == "VampArcher" && !this.setupComplete)
               {
                    LightVampRegen = true;
                    LightVampCure = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Vamp Helmet","Vamp Quiver");
                    maxHealth = 150;
                    health = 150;
                    maxHealth = maxHealth;
                    this.areaDamage = 2;
                    this.area = 150;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "SavageArcher" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Savage Helmet","Savage Quiver");
                    maxHealth = 120;
                    health = 120;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "SavageArcherPrince" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Savage Helmet","Savage Quiver");
                    maxHealth = 2580;
                    health = 2580;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 1.6;
                    this.setupComplete = true;
               }
               if(this.archerType == "SW3CA" && !this.setupComplete)
               {
                    isStationary = true;
                    this.healthBar.visible = false;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
                    maxHealth = 3500;
                    health = 3500;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "SW3CA_2" && !this.setupComplete)
               {
                    isStationary = true;
                    this.healthBar.visible = false;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
                    maxHealth = 3500;
                    health = 3500;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "SW3CA_3" && !this.setupComplete)
               {
                    isStationary = true;
                    this.healthBar.visible = false;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
                    maxHealth = 3500;
                    health = 3500;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "SW3CA_4" && !this.setupComplete)
               {
                    isStationary = true;
                    this.healthBar.visible = false;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
                    maxHealth = 3500;
                    health = 3500;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.2;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "StatueArcher" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Basic Helmet","Default");
                    this.healthBar.visible = false;
                    isStationary = true;
                    flyingHeight = 410;
                    maxHealth = 1500000;
                    health = 1500000;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.5;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "StatueArcher_2" && !this.setupComplete)
               {
                    noStone = true;
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","","Default");
                    this.healthBar.visible = false;
                    isStationary = true;
                    flyingHeight = 410;
                    maxHealth = 1500000;
                    health = 1500000;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _maxVelocity = 5.5;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "FireArcher" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Lava Archer Helmet","Lava Quiver");
                    maxHealth = 90;
                    health = 90;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "FireArcher_2" && !this.setupComplete)
               {
                    burnUnit = true;
                    fireRegen = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Lava Archer Helmet","Lava Quiver");
                    maxHealth = 80;
                    health = 1;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "Frost_1" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Ice Helmet","Ice Quiver 2");
                    maxHealth = 120;
                    health = 120;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "DarkArcherClone" && !this.setupComplete)
               {
                    enemyColor4 = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Dark Kytchu","Dark Quiver");
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    this.areaDamage = 16;
                    this.area = 150;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.8;
                    this.setupComplete = true;
               }
               if(this.archerType == "DarkArcherClone_2" && !this.setupComplete)
               {
                    enemyColor4 = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Dark Kytchu","Dark Quiver");
                    maxHealth = 2300;
                    health = 2300;
                    maxHealth = maxHealth;
                    this.areaDamage = 20;
                    this.area = 100;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.1;
                    this.setupComplete = true;
               }
               if(this.archerType == "StoneArcher" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Stone Helmet","Stone Quiver");
                    maxHealth = 400;
                    health = 400;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.archerType == "Clone_3" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
                    maxHealth = 50;
                    health = 50;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "Clone_4" && !this.setupComplete)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
                    maxHealth = 250;
                    health = 250;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 0.9;
                    this.setupComplete = true;
               }
               if(this.archerType == "Clone_5" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
                    maxHealth = 9000;
                    health = 9000;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1.05;
                    this.setupComplete = true;
               }
               if(this.archerType == "Clone_6" && !this.setupComplete)
               {
                    nonTeleportable = true;
                    noStone = true;
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
                    maxHealth = 1100;
                    health = 1100;
                    maxHealth = maxHealth;
                    this.areaDamage = 0;
                    this.area = 0;
                    healthBar.totalHealth = maxHealth;
                    _scale = 1;
                    this.setupComplete = true;
               }
               if(this.isCastleArcher)
               {
                    enemyColor2 = true;
               }
               if(this.archerType != "")
               {
                    isCustomUnit = true;
               }
               if(isCustomUnit == true)
               {
                    if(this.archerType == "Kytchu" || this.archerType == "DarkKytchu" || this.archerType == "Kytchu_2")
                    {
                         stunTimeLeft = 0;
                         _maximumRange = 1000;
                    }
                    else if(this.archerType == "SW3CA" || this.archerType == "SW3CA_2" || this.archerType == "SW3CA_3" || this.archerType == "SW3CA_4" || this.archerType == "SplashKytchu_2" || this.archerType == "SplashKytchu" || this.archerType == "Clone_4" || this.archerType == "Clone_5")
                    {
                         stunTimeLeft = 0;
                    }
                    else if(this.archerType == "Default")
                    {
                         this.fireArrowRange = 1500;
                    }
                    else if(this.archerType == "GoldenArcher")
                    {
                         stunTimeLeft = 0;
                         _maximumRange = 850;
                    }
                    else if(this.archerType == "StatueArcher")
                    {
                         stunTimeLeft = 0;
                         _maximumRange = 1450;
                    }
                    else if(this.archerType == "StatueArcher_2")
                    {
                         stunTimeLeft = 0;
                         _maximumRange = 1450;
                    }
                    else if(this.archerType == "Native_2")
                    {
                         teleportDistance = 450;
                    }
                    else if(this.archerType == "Clone_3")
                    {
                         _maximumRange = 450;
                    }
                    else if(this.archerType == "SW3CA")
                    {
                         this.projectileVelocity = 35;
                         _maximumRange = 1550;
                    }
                    else if(this.archerType == "SW3CA_2")
                    {
                         this.projectileVelocity = 35;
                         _maximumRange = 1550;
                    }
                    else if(this.archerType == "Clone_5")
                    {
                         this.fireArrowRange = 2500;
                         this.fireDamage = 1.5;
                    }
                    else if(this.archerType == "LeafArcher" || this.archerType == "LeafArcher_2")
                    {
                         _maxVelocity = 8;
                    }
                    else if(this.archerType == "SavageArcher")
                    {
                         stunTimeLeft = 0;
                         _maxVelocity = 8;
                    }
                    else if(this.archerType == "SavageArcherPrince")
                    {
                         stunTimeLeft = 0;
                         _maxVelocity = 4;
                    }
                    else if(this.isCastleArcher)
                    {
                         _maximumRange = 1500;
                    }
                    else
                    {
                         this.fireDamage = param1.xml.xml.Order.Units.archer.fire.fireDamage;
                         _maxVelocity = param1.xml.xml.Order.Units.archer.maxVelocity;
                         this.projectileVelocity = param1.xml.xml.Order.Units.archer.arrowVelocity;
                         this.fireArrowRange = param1.xml.xml.Order.Units.archer.fire.range;
                         _maximumRange = this.normalRange = param1.xml.xml.Order.Units.archer.maximumRange;
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
                         if(this.archerFireSpellCooldown.spellActivate(team) && techTeam.tech.isResearched(Tech.ARCHIDON_FIRE))
                         {
                              if(MovieClip(_mc.mc).currentFrame > MovieClip(_mc.mc).totalFrames / 2 && !hasHit)
                              {
                                   hasHit = this.checkForHit();
                              }
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
                    }
               }
               else if(isDead == false)
               {
                    if(this.archerType == "")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 500;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "Default";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 500;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "Default";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 500;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "Default";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 500;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "Default";
                         this.clusterLad.stun(0);
                    }
                    if(this.archerType == "Kytchu")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "SavageArcher";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "Frost_1";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "FireArcher";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "VampArcher";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "Default";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "Default";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px - 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "Default";
                         this.clusterLad.stun(0);
                    }
                    if(this.archerType == "DarkKytchu")
                    {
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "DarkArcherClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "DarkArcherClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "DarkArcherClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "DarkArcherClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "DarkArcherClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 100;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "DarkArcherClone";
                         this.clusterLad.stun(0);
                         this.clusterLad = team.game.unitFactory.getUnit(Unit.U_ARCHER);
                         team.spawn(this.clusterLad,team.game);
                         this.clusterLad.px = px + 20;
                         this.clusterLad.py = py;
                         this.clusterLad.archerType = "DarkArcherClone_2";
                         this.clusterLad.stun(0);
                    }
                    if(this.archerType == "FireArcher")
                    {
                         param1.projectileManager.initNuke(px,py,this,15,0.2,400);
                    }
                    isDead = true;
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.defendLabel);
                    }
                    else
                    {
                         _mc.gotoAndStop(getDeathLabel(param1));
                    }
                    this.team.removeUnit(this,param1);
               }
               if(isDead)
               {
                    Util.animateMovieClip(_mc);
               }
               else
               {
                    if(!isDead && MovieClip(_mc.mc).currentFrame == MovieClip(_mc.mc).totalFrames)
                    {
                         MovieClip(_mc.mc).gotoAndStop(1);
                    }
                    MovieClip(_mc.mc).nextFrame();
                    _mc.mc.stop();
               }
               var _loc2_:MovieClip = _mc.mc.bow;
               if(_loc2_ != null)
               {
                    _loc2_.gotoAndStop(this.bowFrame);
                    if(this.bowFrame != 1)
                    {
                         if(this.bowFrame == 46)
                         {
                              param1.soundManager.playSound("BowReady",px,py);
                         }
                         _loc2_.nextFrame();
                         ++this.bowFrame;
                         if(_loc2_.currentFrame == _loc2_.totalFrames)
                         {
                              _loc2_.gotoAndStop(1);
                              this.bowFrame = 1;
                         }
                    }
               }
               if(this.isCastleArcher)
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Basic Helmet","");
               }
               else if(this.archerType == "Heavy")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Basic Helmet","Silver Quiver");
               }
               else if(this.archerType == "VampArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Vamp Helmet","Vamp Quiver");
               }
               else if(this.archerType == "SW3CA")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Vamp Helmet","Vamp Quiver");
               }
               else if(this.archerType == "SW3CA_2")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Vamp Helmet","Vamp Quiver");
               }
               else if(this.archerType == "SW3CA_3")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Vamp Helmet","Vamp Quiver");
               }
               else if(this.archerType == "SW3CA_4")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Vamp Helmet","Vamp Quiver");
               }
               else if(this.archerType == "Kytchu")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Kytchu","Gold Quiver");
               }
               else if(this.archerType == "Kytchu_2")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Kytchu","Gold Quiver");
               }
               else if(this.archerType == "SplashKytchu")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Kytchu 2","Gold Quiver");
               }
               else if(this.archerType == "SplashKytchu_2")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Kytchu 2","Gold Quiver");
               }
               else if(this.archerType == "DarkKytchu")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Dark Kytchu","Dark Quiver");
               }
               else if(this.archerType == "DarkArcherClone")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Dark Kytchu","Dark Quiver");
               }
               else if(this.archerType == "DarkArcherClone_2")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Dark Kytchu","Dark Quiver");
               }
               else if(this.archerType == "GoldenArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Golden Helmet","Gold Quiver");
               }
               else if(this.archerType == "FireArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Lava Archer Helmet","Lava Quiver");
               }
               else if(this.archerType == "FireArcher_2")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Lava Archer Helmet","Lava Quiver");
               }
               else if(this.archerType == "Frost_1")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Ice Helmet","Ice Quiver 2");
               }
               else if(this.archerType == "Clone_1")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Samurai Archer","Gold Quiver 2");
               }
               else if(this.archerType == "StoneArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Stone Helmet","Stone Quiver");
               }
               else if(this.archerType == "Clone_3")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
               }
               else if(this.archerType == "Clone_4")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
               }
               else if(this.archerType == "Clone_5")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
               }
               else if(this.archerType == "Clone_6")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
               }
               else if(this.archerType == "Native")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Native Archer","Native Quiver");
               }
               else if(this.archerType == "Native_2")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","LeGold Helmet","LeGold Quiver");
               }
               else if(this.archerType == "StatueArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Basic Helmet","Default");
               }
               else if(this.archerType == "StatueArcher_2")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"Default","Basic Helmet","Default");
               }
               else if(this.archerType == "LeafArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Leaf Helmet","Leaf Quiver");
               }
               else if(this.archerType == "LeafArcher_2")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Leaf Helmet 2","Leaf Quiver 2");
               }
               else if(this.archerType == "SavageArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Savage Helmet","Savage Quiver");
               }
               else if(this.archerType == "SavageArcherPrince")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Savage Helmet","Savage Quiver");
               }
               else if(this.archerType == "CrystalArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Crystal Helmet","Crystal Quiver");
               }
               else if(this.archerType == "ChaosArcher")
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","Chaos Helmet","Chaos Quiver");
               }
               else
               {
                    com.brockw.stickwar.engine.units.Archer.setItem(mc,"","","");
               }
               if(_mc.mc.bow != null)
               {
                    _mc.mc.bow.rotation = bowAngle;
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
               if(this.archerType == "Default")
               {
                    this.isBlocking = true;
                    this.inBlock = true;
               }
          }
          
          override public function isLoaded() : Boolean
          {
               var _loc1_:MovieClip = _mc.mc.bow;
               return this.bowFrame < 35;
          }
          
          override public function get damageToArmour() : Number
          {
               if(this.isCastleArcher)
               {
                    return 55;
               }
               if(this.archerType == "Heavy")
               {
                    return _damageToArmour / 2;
               }
               if(this.archerType == "ChaosArcher")
               {
                    return 50;
               }
               if(this.archerType == "SavageArcherPrince")
               {
                    return 170;
               }
               if(this.archerType == "SW3CA")
               {
                    return 55;
               }
               if(this.archerType == "SW3CA_2")
               {
                    return 55;
               }
               if(this.archerType == "SW3CA_3")
               {
                    return 55;
               }
               if(this.archerType == "SW3CA_4")
               {
                    return 55;
               }
               if(this.archerType == "Native_2")
               {
                    return 35;
               }
               if(this.archerType == "Native")
               {
                    return 30;
               }
               if(this.archerType == "StatueArcher")
               {
                    return 140;
               }
               if(this.archerType == "StatueArcher_2")
               {
                    return 185;
               }
               if(this.archerType == "Kytchu")
               {
                    return 200;
               }
               if(this.archerType == "Kytchu_2")
               {
                    return 135;
               }
               if(this.archerType == "DarkKytchu")
               {
                    return 135;
               }
               if(this.archerType == "DarkArcherClone")
               {
                    return 25;
               }
               if(this.archerType == "DarkArcherClone_2")
               {
                    return 20;
               }
               if(this.archerType == "GoldenArcher")
               {
                    return 95;
               }
               if(this.archerType == "StoneArcher")
               {
                    return 148;
               }
               if(this.archerType == "Clone_5")
               {
                    return 115;
               }
               if(this.archerType == "Clone_6")
               {
                    return 42;
               }
               return _damageToArmour;
          }
          
          override public function get damageToNotArmour() : Number
          {
               if(this.isCastleArcher)
               {
                    return 30;
               }
               if(this.archerType == "ChaosArcher")
               {
                    return 45;
               }
               if(this.archerType == "SavageArcherPrince")
               {
                    return 150;
               }
               if(this.archerType == "SW3CA")
               {
                    return 105;
               }
               if(this.archerType == "SW3CA_2")
               {
                    return 105;
               }
               if(this.archerType == "SW3CA_3")
               {
                    return 80;
               }
               if(this.archerType == "SW3CA_4")
               {
                    return 80;
               }
               if(this.archerType == "StoneArcher")
               {
                    return 148;
               }
               if(this.archerType == "StatueArcher")
               {
                    return 95;
               }
               if(this.archerType == "StatueArcher_2")
               {
                    return 115;
               }
               if(this.archerType == "Kytchu")
               {
                    return 100;
               }
               if(this.archerType == "Kytchu_2")
               {
                    return 120;
               }
               if(this.archerType == "DarkArcherClone")
               {
                    return 15;
               }
               if(this.archerType == "DarkArcherClone_2")
               {
                    return 20;
               }
               if(this.archerType == "DarkKytchu")
               {
                    return 195;
               }
               if(this.archerType == "GoldenArcher")
               {
                    return 105;
               }
               if(this.archerType == "Clone_1")
               {
                    return 65;
               }
               if(this.archerType == "Clone_5")
               {
                    return 100;
               }
               if(this.archerType == "Clone_6")
               {
                    return 40;
               }
               if(this.archerType == "Native_2")
               {
                    return 50;
               }
               if(this.archerType == "Native")
               {
                    return 40;
               }
               return _damageToNotArmour;
          }
          
          override public function shoot(param1:StickWar, param2:Unit) : void
          {
               var _loc3_:MovieClip = null;
               var _loc4_:Point = null;
               var _loc5_:int = 0;
               var _loc6_:int = 0;
               var _loc7_:Number = NaN;
               if(_state != S_ATTACK)
               {
                    _loc3_ = _mc.mc.bow;
                    if(this.bowFrame != 1)
                    {
                         return;
                    }
                    ++this.bowFrame;
                    _loc3_.nextFrame();
                    _loc4_ = _loc3_.localToGlobal(new Point(0,0));
                    _loc4_ = param1.battlefield.globalToLocal(_loc4_);
                    _loc5_ = projectileVelocity;
                    _loc6_ = this.arrowDamage;
                    _loc7_ = 0;
                    param1.soundManager.playSoundRandom("launchArrow",5,px,py);
                    if(this.archerType == "VampArcher")
                    {
                         this.heal(3,1);
                         this.cure();
                    }
                    if(mc.scaleX < 0)
                    {
                         param1.projectileManager.initArrow(_loc4_.x,_loc4_.y,180 - bowAngle,_loc5_,param2.y,angleToTargetW(param2,_loc5_,angleToTarget(param2)),this,_loc6_,_loc7_,this.isFire,this.area,this.areaDamage,param2,this.fireDamage,this.fireFrames);
                    }
                    else
                    {
                         param1.projectileManager.initArrow(_loc4_.x,_loc4_.y,bowAngle,_loc5_,param2.y,angleToTargetW(param2,_loc5_,angleToTarget(param2)),this,_loc6_,_loc7_,this.isFire,this.area,this.areaDamage,param2,this.fireDamage,this.fireFrames);
                    }
                    this.isFire = false;
                    _maximumRange = this.normalRange;
                    takeBottomTrajectory = true;
               }
          }
          
          override public function aim(param1:Unit) : void
          {
               var _loc2_:Number = angleToTarget(param1);
               if(Math.abs(normalise(angleToBowSpace(_loc2_) - bowAngle)) < 10)
               {
                    bowAngle += normalise(angleToBowSpace(_loc2_) - bowAngle) * 0.8;
               }
               else
               {
                    bowAngle += normalise(angleToBowSpace(_loc2_) - bowAngle) * 0.1;
               }
          }
          
          override public function damage(param1:int, param2:Number, param3:Entity, param4:Number = 1) : void
          {
               if(this.inBlock || this.archerType == "FireArcher" || this.archerType == "LeafArcher" || this.archerType == "SavageArcher" || this.archerType == "Frost_1" || this.archerType == "SavageArcherPrince" || this.archerType == "Kytchu" || this.archerType == "DarkKytchu" || this.archerType == "Kytchu_2")
               {
                    super.damage(param1,param2 - param2 * this.shieldwallDamageReduction,param3,1 - this.shieldwallDamageReduction);
               }
               else
               {
                    super.damage(param1,param2,param3);
               }
          }
          
          override public function mayAttack(param1:Unit) : Boolean
          {
               var _loc2_:int = 200;
               if(!this.isCastleArcher && team.direction * px < team.direction * (this.team.homeX + team.direction * _loc2_))
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
               if(aimedAtUnit(param1,angleToTarget(param1)) && this.inRange(param1))
               {
                    return true;
               }
               return false;
          }
          
          override public function walk(param1:Number, param2:Number, param3:int) : void
          {
               if(isAbleToWalk())
               {
                    baseWalk(param1,param2,param3);
               }
          }
          
          public function get isCastleArcher() : Boolean
          {
               return this._isCastleArcher;
          }
          
          public function set isCastleArcher(param1:Boolean) : void
          {
               if(param1)
               {
                    this._maximumRange = 500;
                    this.healthBar.visible = false;
                    isStationary = true;
               }
               this._isCastleArcher = param1;
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
