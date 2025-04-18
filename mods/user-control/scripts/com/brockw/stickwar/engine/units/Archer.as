package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.ArcherAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import flash.display.MovieClip;
     import flash.geom.Point;
     
     public class Archer extends RangedUnit
     {
           
          
          private var _isCastleArcher:Boolean;
          
          private var isFire:Boolean;
          
          private var archerFireSpellCooldown:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var arrowDamage:Number;
          
          private var bowFrame:int;
          
          private var normalRange:Number;
          
          private var fireArrowRange:Number;
          
          private var areaDamage:Number;
          
          private var area:Number;
          
          public function Archer(game:StickWar)
          {
               super(game);
               _mc = new _archer();
               this.init(game);
               addChild(_mc);
               ai = new ArcherAi(this);
               initSync();
               firstInit();
               this.archerFireSpellCooldown = new com.brockw.stickwar.engine.units.SpellCooldown(0,game.xml.xml.Order.Units.archer.fire.cooldown,game.xml.xml.Order.Units.archer.fire.mana);
          }
          
          public static function setItem(mc:MovieClip, weapon:String, armor:String, misc:String) : void
          {
               var m:_archer = _archer(mc);
               if(m.mc.archerBag)
               {
                    if(misc != "")
                    {
                         m.mc.archerBag.gotoAndStop(misc);
                    }
               }
               if(m.mc.head)
               {
                    if(armor != "")
                    {
                         m.mc.head.gotoAndStop(armor);
                    }
               }
          }
          
          override public function setActionInterface(a:ActionInterface) : void
          {
               super.setActionInterface(a);
               if(team.tech.isResearched(Tech.ARCHIDON_FIRE))
               {
                    a.setAction(0,0,UnitCommand.ARCHER_FIRE);
               }
          }
          
          public function getFireCoolDown() : Number
          {
               return this.archerFireSpellCooldown.cooldown();
          }
          
          override public function init(game:StickWar) : void
          {
               initBase();
               _maximumRange = this.normalRange = game.xml.xml.Order.Units.archer.maximumRange;
               this.fireArrowRange = game.xml.xml.Order.Units.archer.fire.range;
               maxHealth = health = game.xml.xml.Order.Units.archer.health;
               this.createTime = game.xml.xml.Order.Units.archer.cooldown;
               this.projectileVelocity = game.xml.xml.Order.Units.archer.arrowVelocity;
               this.arrowDamage = game.xml.xml.Order.Units.archer.damage;
               population = game.xml.xml.Order.Units.archer.population;
               _mass = game.xml.xml.Order.Units.archer.mass;
               _maxForce = game.xml.xml.Order.Units.archer.maxForce;
               _dragForce = game.xml.xml.Order.Units.archer.dragForce;
               _scale = game.xml.xml.Order.Units.archer.scale;
               _maxVelocity = game.xml.xml.Order.Units.archer.maxVelocity;
               this.loadDamage(game.xml.xml.Order.Units.archer);
               this.areaDamage = 0;
               this.area = 0;
               if(this.isCastleArcher)
               {
                    this._maximumRange = this.normalRange = game.xml.xml.Order.Units.archer.castleRange;
                    _scale *= 1.1;
                    this.area = game.xml.xml.Order.Units.archer.castleArea;
                    this.areaDamage = game.xml.xml.Order.Units.archer.castleAreaDamage;
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
               this.isArmoured = param1.armoured == 1 ? Boolean(true) : Boolean(false);
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
               if(this.archerFireSpellCooldown.spellActivate(team) && team.tech.isResearched(Tech.ARCHIDON_FIRE))
               {
                    this.isFire = true;
                    takeBottomTrajectory = false;
                    _maximumRange = this.fireArrowRange;
               }
          }
          
          override public function update(game:StickWar) : void
          {
               super.update(game);
               if(isUC)
               {
                    _maxVelocity = game.xml.xml.Order.Units.archer.maxVelocity * 1.25;
                    _damageToNotArmour = (Number(game.xml.xml.Order.Units.archer.damage) + Number(game.xml.xml.Order.Units.archer.toNotArmour)) * 1.15 * Number(team.game.main.campaign.difficultyLevel);
                    _damageToArmour = (Number(game.xml.xml.Order.Units.archer.damage) + Number(game.xml.xml.Order.Units.archer.toArmour)) * 1.15 * Number(team.game.main.campaign.difficultyLevel);
               }
               else if(!team.isEnemy)
               {
                    _maxVelocity = game.xml.xml.Order.Units.archer.maxVelocity;
                    _damageToNotArmour = Number(game.xml.xml.Order.Units.archer.damage) + Number(game.xml.xml.Order.Units.archer.toNotArmour);
                    _damageToArmour = Number(game.xml.xml.Order.Units.archer.damage) + Number(game.xml.xml.Order.Units.archer.toArmour);
               }
               else if(team.isEnemy && !enemyBuffed && !this.isCastleArcher)
               {
                    _damageToNotArmour = _damageToNotArmour / 2.5 * team.game.main.campaign.difficultyLevel + 1;
                    _damageToArmour = _damageToArmour / 2.5 * team.game.main.campaign.difficultyLevel + 1;
                    health = Number(game.xml.xml.Order.Units.archer.health) / 2.5 * (team.game.main.campaign.difficultyLevel + 1);
                    maxHealth = health;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    _scale = _scale + Number(team.game.main.campaign.difficultyLevel) * 0.05 - 0.05;
                    enemyBuffed = true;
               }
               this.archerFireSpellCooldown.update();
               updateCommon(game);
               if(!isDieing)
               {
                    updateMotion(game);
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
                         if(MovieClip(_mc.mc).currentFrame > MovieClip(_mc.mc).totalFrames / 2 && !hasHit)
                         {
                              hasHit = this.checkForHit();
                         }
                         if(MovieClip(_mc.mc).totalFrames == MovieClip(_mc.mc).currentFrame)
                         {
                              _state = S_RUN;
                         }
                    }
               }
               else if(isDead == false)
               {
                    isDead = true;
                    if(_isDualing)
                    {
                         _mc.gotoAndStop(_currentDual.defendLabel);
                    }
                    else
                    {
                         _mc.gotoAndStop(getDeathLabel(game));
                    }
                    this.team.removeUnit(this,game);
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
               var bow:MovieClip = _mc.mc.bow;
               if(bow != null)
               {
                    bow.gotoAndStop(this.bowFrame);
                    if(this.bowFrame != 1)
                    {
                         if(this.bowFrame == 46)
                         {
                              game.soundManager.playSound("BowReady",px,py);
                         }
                         bow.nextFrame();
                         ++this.bowFrame;
                         if(bow.currentFrame == bow.totalFrames)
                         {
                              bow.gotoAndStop(1);
                              this.bowFrame = 1;
                         }
                    }
               }
               if(this.isCastleArcher)
               {
                    Archer.setItem(mc,"Default","Basic Helmet","Default");
               }
               else if(team.isEnemy)
               {
                    if(team.game.main.campaign.difficultyLevel == 3)
                    {
                         Archer.setItem(mc,"","Robin Hood Hat","Robin Hood Quiver");
                    }
                    else if(team.game.main.campaign.difficultyLevel == 2)
                    {
                         Archer.setItem(mc,"","","Silver Archidon");
                    }
                    else if(team.game.main.campaign.difficultyLevel == 1)
                    {
                         Archer.setItem(mc,"","","");
                    }
               }
               else
               {
                    Archer.setItem(mc,"","","");
               }
               if(_mc.mc.bow != null)
               {
                    _mc.mc.bow.rotation = bowAngle;
               }
          }
          
          override public function isLoaded() : Boolean
          {
               var bow:MovieClip = _mc.mc.bow;
               return this.bowFrame < 35;
          }
          
          override public function shoot(game:StickWar, target:Unit) : void
          {
               var bow:MovieClip = null;
               var p:Point = null;
               var v:int = 0;
               var damage:int = 0;
               var poison:Number = NaN;
               var fireDamage:Number = NaN;
               if(_state != S_ATTACK)
               {
                    bow = _mc.mc.bow;
                    if(this.bowFrame != 1)
                    {
                         return;
                    }
                    ++this.bowFrame;
                    bow.nextFrame();
                    p = bow.localToGlobal(new Point(0,0));
                    p = game.battlefield.globalToLocal(p);
                    v = projectileVelocity;
                    damage = this.arrowDamage;
                    poison = 0;
                    fireDamage = 0;
                    if(this.isFire)
                    {
                         fireDamage = Number(game.xml.xml.Order.Units.archer.fire.damage);
                    }
                    game.soundManager.playSoundRandom("launchArrow",5,px,py);
                    if(mc.scaleX < 0)
                    {
                         game.projectileManager.initArrow(p.x,p.y,180 - bowAngle,v,target.y,angleToTargetW(target,v,angleToTarget(target)),this,damage,poison,this.isFire,this.area,this.areaDamage);
                    }
                    else
                    {
                         game.projectileManager.initArrow(p.x,p.y,bowAngle,v,target.y,angleToTargetW(target,v,angleToTarget(target)),this,damage,poison,this.isFire,this.area,this.areaDamage);
                    }
                    this.isFire = false;
                    _maximumRange = this.normalRange;
                    takeBottomTrajectory = true;
               }
          }
          
          override public function aim(target:Unit) : void
          {
               var a:Number = angleToTarget(target);
               if(Math.abs(normalise(angleToBowSpace(a) - bowAngle)) < 10)
               {
                    bowAngle += normalise(angleToBowSpace(a) - bowAngle) * 0.8;
               }
               else
               {
                    bowAngle += normalise(angleToBowSpace(a) - bowAngle) * 0.1;
               }
          }
          
          override public function mayAttack(target:Unit) : Boolean
          {
               var CASTLE_WIDTH:int = 200;
               if(!this.isCastleArcher && team.direction * px < team.direction * (this.team.homeX + team.direction * CASTLE_WIDTH))
               {
                    return false;
               }
               if(isIncapacitated())
               {
                    return false;
               }
               if(target == null)
               {
                    return false;
               }
               if(this.isDualing == true)
               {
                    return false;
               }
               if(aimedAtUnit(target,angleToTarget(target)) && this.inRange(target))
               {
                    return true;
               }
               return false;
          }
          
          override public function walk(x:Number, y:Number, intendedX:int) : void
          {
               if(isAbleToWalk())
               {
                    baseWalk(x,y,intendedX);
               }
          }
          
          public function get isCastleArcher() : Boolean
          {
               return this._isCastleArcher;
          }
          
          public function set isCastleArcher(value:Boolean) : void
          {
               if(value)
               {
                    this._maximumRange = 500;
                    this.healthBar.visible = false;
                    isStationary = true;
               }
               this._isCastleArcher = value;
          }
     }
}
