class Wizard extends Man
{
     var type = 5;
     var MAX_VELOCITY = 1.2;
     var MAX_ACCELERATION = 0.2;
     var WIZARD_RANGE = 180;
     var MIN_SWING_TIME = 3000;
     var MIN_WAIT_TIME = 100;
     var MAX_HEALTH = 100;
     var MIN_HIT_TIME = 1100;
     var HIT_WIDTH = 25;
     var MASS = 500;
     var POWER = 100;
     var MAX_MINION = 3;
     function Wizard(x, y, squad, simUnits, game)
     {
          super();
          this.x = x;
          this.y = y;
          this.dy = this.dx = 0;
          this.healthLostnum = 0;
          this.squad = squad;
          this.game = game;
          this.simUnits = simUnits;
          this.minions = [];
          this.lastSwordSwing = 0;
          this.isSwinging = false;
          this.hasDamaged = false;
          this.unitType = "wizard";
          this.initMovieClip("wizard_main");
          this.damageDirectionTime = 2500;
          this.isBlocking = false;
          this.yOffset = 0;
          this.MAX_HEALTH = squad.getTechnology().getWizardHealth();
          this.MAX_MINION = squad.getTechnology().getWizardHealing();
          this.health = this.MAX_HEALTH;
          this.isGlacialWizard = false;
          this.isGrandWizard = false;
          this.isSavageWizard = false;
          this.isVampWizard = false;
          this.isLavaWizard = false;
     }
     function update()
     {
          super.update();
          this.clip.health.bar._xscale = this.health / this.MAX_HEALTH * 100;
          if(this.isGlacialWizard)
          {
               this.clip.wand = 4;
               this.clip.hat = 6;
          }
          else if(this.isGrandWizard)
          {
               this.clip.wand = 3;
               this.clip.hat = 5;
          }
          else if(this.isSavageWizard)
          {
               this.clip.wand = 5;
               this.clip.hat = 7;
          }
          else if(this.isVampWizard)
          {
               this.clip.wand = 6;
               this.clip.hat = 8;
          }
          else if(this.isLavaWizard)
          {
               this.clip.wand = 7;
               this.clip.hat = 9;
          }
          else
          {
               this.clip.wand = this.squad.getTechnology().getWizardAttack();
               this.clip.hat = this.squad.getTechnology().getWizardHealing();
          }
          if(!this.isAlive)
          {
               this.clip.gotoAndStop("die");
               this.clip.health._visible = false;
          }
          else if(this.clip.block._currentframe < 30 && !this.isBlocking)
          {
               this.clip.block.play();
          }
          else if(this.isBlocking)
          {
               if(this.clip.block._currentframe == 20)
               {
                    this.clip.block.stop();
               }
          }
          else if(this.isSwinging)
          {
               if(this.spellType == "summon")
               {
                    this.clip.gotoAndStop("swing2");
                    if(this.isHitPeriod() && this.hasDamaged == false)
                    {
                         this.hasDamaged = true;
                         if(this.canAddMinion())
                         {
                              this.game.getSoundManager().playSound("magesummon",this.x);
                         }
                         else
                         {
                              this.game.getSoundManager().playSound("magespellfail",this.x);
                         }
                         var _loc3_ = 0;
                         while(_loc3_ < 1 && this.canAddMinion())
                         {
                              if(this.isGlacialWizard)
                              {
                                   var _loc4_ = this.squad.addSwordMan();
                                   _loc4_.setX(this.x + 10 * this.squad.getTeamDirection());
                                   _loc4_.setY(this.y);
                                   this.minions.push(_loc4_);
                                   var _loc5_ = SwordMan(_loc4_);
                                   _loc5_.setAsGlacialSword();
                                   _loc3_ += 1;
                              }
                              else if(this.isLavaWizard)
                              {
                                   _loc4_ = this.squad.addSwordMan();
                                   _loc4_.setX(this.x + 10 * this.squad.getTeamDirection());
                                   _loc4_.setY(this.y);
                                   this.minions.push(_loc4_);
                                   _loc5_ = SwordMan(_loc4_);
                                   _loc5_.setAsLavaSword();
                                   _loc3_ += 1;
                              }
                              else
                              {
                                   _loc4_ = this.squad.addSwordMan();
                                   _loc4_.setX(this.x + 10 * this.squad.getTeamDirection());
                                   _loc4_.setY(this.y);
                                   this.minions.push(_loc4_);
                                   _loc5_ = SwordMan(_loc4_);
                                   _loc5_.setAsMinion();
                                   _loc3_ += 1;
                              }
                         }
                    }
               }
               else
               {
                    this.clip.gotoAndStop("swing");
                    if(this.clip.swing._currentframe == 20)
                    {
                         this.game.getSoundManager().playSound("magicSound",this.x);
                    }
                    if(this.isHitPeriod())
                    {
                         if(!this.hasDamaged)
                         {
                              var _loc6_ = undefined;
                              for(_loc3_ in this.near)
                              {
                                   if(Math.abs(this.near[_loc3_].getClip()._y - this.y) < this.HIT_WIDTH && this.near[_loc3_].getIsAlive())
                                   {
                                        if(this.near[_loc3_].getSquad() != this.getSquad() && this.swordHasHit(this.near[_loc3_]))
                                        {
                                             this.near[_loc3_].damage(this.controlMultiply() * this.squad.getTechnology().getWizardAttackPower(),this.currentDirection,"wizard");
                                             this.near.splice(_loc3_,1);
                                             this.hasDamaged = true;
                                        }
                                   }
                              }
                         }
                         if(this.clip.hitTest(this.squad.getEnemyTeam().getCastleHitArea()))
                         {
                              this.squad.getEnemyTeam().damageCastle(this.controlMultiply() * this.squad.getTechnology().getWizardAttackPower());
                              this.hasDamaged = true;
                         }
                    }
               }
          }
          else if(this.dx != 0 || this.dy != 0)
          {
               this.clip.gotoAndStop("run");
          }
          else
          {
               this.clip.gotoAndStop("stand");
          }
          if(this.isSwinging)
          {
               if(this.spellType == "summon" && this.clip.swing._currentframe >= 85)
               {
                    this.isSwinging = false;
               }
               else if(this.clip.swing._currentframe >= 89)
               {
                    this.isSwinging = false;
               }
          }
          this.isBlocking = false;
     }
     function keyInterface()
     {
          if(!this.isSwinging)
          {
               if(!this.isBlocking && this.clip.block == undefined)
               {
                    if(Key.isDown(this.game.getKey("LEFT")) || Key.isDown(this.game.getKey("ARROW_LEFT")))
                    {
                         this.walk(- this.MAX_ACCELERATION,0);
                    }
                    if(Key.isDown(this.game.getKey("RIGHT")) || Key.isDown(this.game.getKey("ARROW_RIGHT")))
                    {
                         this.walk(this.MAX_ACCELERATION,0);
                    }
                    if(Key.isDown(this.game.getKey("UP")) || Key.isDown(this.game.getKey("ARROW_UP")))
                    {
                         this.walk(0,- this.MAX_ACCELERATION);
                    }
                    if(Key.isDown(this.game.getKey("DOWN")) || Key.isDown(this.game.getKey("ARROW_DOWN")))
                    {
                         this.walk(0,this.MAX_ACCELERATION);
                    }
                    if(Key.isDown(32))
                    {
                         this.swordSwing("shock");
                    }
                    if(Key.isDown(this.game.getKey("THROW")))
                    {
                         this.swordSwing("summon");
                    }
               }
               if(Key.isDown(this.game.getKey("BLOCK")))
               {
                    this.isBlocking = true;
               }
          }
     }
     function block()
     {
          this.isBlocking = true;
     }
     function clearStatus()
     {
     }
     function isHitPeriod()
     {
          return this.game.getGameTime() - this.lastSwordSwing <= this.MIN_HIT_TIME + 100 && this.game.getGameTime() - this.lastSwordSwing >= this.MIN_HIT_TIME && !this.hasDamaged;
     }
     function swordHasHit(man)
     {
          if(Math.abs(man.y - this.y) > 20)
          {
               return false;
          }
          if(this.currentDirection * (man.getX() - this.x) > this.WIZARD_RANGE + 20 || this.currentDirection * (man.getX() - this.x) <= -50)
          {
               return false;
          }
          return true;
     }
     function swordSwing(type)
     {
          if(!this.isSwinging)
          {
               if(type == "summon")
               {
                    this.spellType = type;
                    this.isSwinging = true;
                    this.lastSwordSwing = this.game.getGameTime();
                    this.hasDamaged = false;
               }
               else
               {
                    this.spellType = "shock";
                    this.isSwinging = true;
                    this.lastSwordSwing = this.game.getGameTime();
                    this.hasDamaged = false;
                    this.near = this.squad.getEnemyTeam().getMen().slice();
               }
          }
          return false;
     }
     function damage(amount, direction, type)
     {
          var _loc6_ = amount * amount / this.MASS * direction * this.DAMAGE_MOMENTOM_CONSTANT;
          this.setDx(this.getDx() + _loc6_);
          if(this.isBlocking && !this.isSwinging && direction != this.currentDirection)
          {
               if(int(Math.random() * 5) == 5)
               {
                    super.damage(amount,direction,type);
               }
          }
          else
          {
               super.damage(amount,direction,type);
          }
     }
     function getHasDamaged()
     {
          return this.hasDamaged;
     }
     function getIsSwinging()
     {
          return this.isSwinging;
     }
     function getWIZARD_RANGE()
     {
          return this.WIZARD_RANGE;
     }
     function isAttacking()
     {
          if(!this.isSwinging)
          {
               return false;
          }
          if(this.isSwinging)
          {
               return this.clip.swing._currentframe <= 75;
          }
     }
     function shouldAttack()
     {
          return true;
     }
     function updateMinionList()
     {
          for(var _loc2_ in this.minions)
          {
               if(this.minions[_loc2_].getIsAlive() == false)
               {
                    this.minions.splice(_loc2_,1);
               }
          }
     }
     function canAddMinion()
     {
          this.updateMinionList();
          return this.minions.length < this.MAX_MINION;
     }
     function setAsGlacialWizard()
     {
          this.health *= 2;
          this.MAX_HEALTH *= 2;
          this.isGlacialWizard = true;
          this.baseScale *= 0.9;
          this.MAX_MINION = 2;
     }
     function setAsGrandWizard()
     {
          this.health *= 4;
          this.MAX_HEALTH *= 4;
          this.isGrandWizard = true;
          this.baseScale *= 0.8;
          this.MAX_MINION = 3;
          this.WIZARD_RANGE *= 1.5;
     }
     function setAsSavageWizard()
     {
          this.MAX_VELOCITY = 1.75;
          this.MAX_ACCELERATION = 1.75;
          this.isSavageWizard = true;
          this.MAX_HEALTH *= 1.5;
          this.health *= 1.5;
          this.MAX_MINION = 2;
          this.WIZARD_RANGE *= 1.25;
          this.baseScale *= 0.9;
     }
     function setAsVampWizard()
     {
          this.isVampWizard = true;
          this.MAX_HEALTH *= 2;
          this.health *= 2;
          this.MAX_MINION = 2;
          this.baseScale *= 0.93;
     }
     function setAsLavaWizard()
     {
          this.isLavaWizard = true;
          this.MAX_HEALTH *= 1.5;
          this.health *= 1.5;
          this.MAX_MINION = 2;
     }
}
