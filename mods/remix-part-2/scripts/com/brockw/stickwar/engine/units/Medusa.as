package com.brockw.stickwar.engine.units
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.Ai.MedusaAi;
     import com.brockw.stickwar.engine.Ai.command.UnitCommand;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.market.MarketItem;
     import flash.display.DisplayObject;
     import flash.display.MovieClip;
     import flash.utils.Dictionary;
     
     public class Medusa extends com.brockw.stickwar.engine.units.Unit
     {
           
          
          private var WEAPON_REACH:int;
          
          private var snakeFrames:Dictionary;
          
          private var poisonSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var stoneSpell:com.brockw.stickwar.engine.units.SpellCooldown;
          
          private var inPoisonSpell:Boolean;
          
          private var inStoneSpell:Boolean;
          
          private var targetUnit:com.brockw.stickwar.engine.units.Unit;
          
          public var medusaType:String;
          
          private var setupComplete:Boolean;
          
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
               this.medusaType = "Default";
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
               if(this.medusaType == "GAG" && !this.setupComplete)
               {
                    maxHealth = 600;
                    health = 600;
                    maxHealth = maxHealth;
                    healthBar.totalHealth = maxHealth;
                    this.setupComplete = true;
               }
               if(this.medusaType != "")
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
                                        this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToArmour / 2);
                                   }
                                   else if(this.targetUnit.isArmoured)
                                   {
                                        this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToArmour);
                                   }
                                   else
                                   {
                                        this.targetUnit.stoneAttack(param1.xml.xml.Chaos.Units.medusa.stone.damageToNotArmour);
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
               if(this.medusaType == "GAG")
               {
                    Medusa.setItem(_medusaMc(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
               }
               else
               {
                    Medusa.setItem(_medusaMc(mc),team.loadout.getItem(this.type,MarketItem.T_WEAPON),team.loadout.getItem(this.type,MarketItem.T_ARMOR),team.loadout.getItem(this.type,MarketItem.T_MISC));
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
               this.maxHealth = 12000;
               this.health = 12000;
               this.scale = 3;
               _damageToArmour = 75;
               _damageToNotArmour = 75;
               this.stoneSpell = new com.brockw.stickwar.engine.units.SpellCooldown(team.game.xml.xml.Chaos.Units.medusa.stone.effect,team.game.xml.xml.Chaos.Units.medusa.stone.superCooldown,team.game.xml.xml.Chaos.Units.medusa.stone.mana);
               maxHealth = this.maxHealth;
               healthBar.totalHealth = maxHealth;
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
