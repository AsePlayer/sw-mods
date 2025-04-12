class SwordMan extends Man
{
     var type = 3;
     var MAX_VELOCITY = 4;
     var MAX_ACCELERATION = 0.4;
     var SWORD_MAN_RANGE = 50;
     var MIN_SWING_TIME = 1010;
     var MIN_WAIT_TIME = 0;
     var MAX_HEALTH = 500;
     var MIN_HIT_TIME = 700;
     var HIT_WIDTH = 20;
     var RUN_MIN = 0.2;
     function SwordMan(x, y, squad, simUnits, game)
     {
          super();
          this.x = x;
          this.y = y;
          this.dy = this.dx = 0;
          this.squad = squad;
          this.game = game;
          this.simUnits = simUnits;
          this.lastSwordSwing = 0;
          this.isSwinging = false;
          this.hasDamaged = false;
          this.unitType = "swordMan";
          this.initMovieClip("swordMan");
          this.isBlocking = false;
          this.yOffset = 0;
          this.MAX_VELOCITY = this.compound(3,0.2,squad.getTechnology().getSwordmanSpeed() - 1);
          this.MAX_ACCELERATION = this.MAX_VELOCITY * 0.1;
          this.MAX_HEALTH = squad.getTechnology().getSwordmanHealth();
          this.isDieing = false;
          this.health = this.MAX_HEALTH;
          this.isMinion = false;
          this.isXiphos = false;
     }
     function update()
     {
          super.update();
          if(this.isMinion)
          {
               this.clip.weapon = 5;
               this.MAX_VELOCITY = 3;
          }
          else
          {
               this.clip.weapon = this.squad.getTechnology().getSwordmanSword();
          }
          if(this.inShock)
          {
               this.isSwinging = false;
          }
          if(this.isSwinging)
          {
               this.dx = this.dy = 0;
          }
          if(this.isSwinging && this.clip.swing != undefined && this.clip.swing._currentframe == this.clip.swing._totalframes)
          {
               this.isSwinging = false;
          }
          if(!this.isAlive)
          {
               if(this.isDieing == false)
               {
                    if((this.deathType == "sword" || this.deathType == "spear") && Math.random() < 0.3)
                    {
                         this.clip.gotoAndStop("death2");
                    }
                    else if(this.deathType == "arrow_headshot")
                    {
                         this.clip.gotoAndStop("death3");
                    }
                    else
                    {
                         this.clip.gotoAndStop("death");
                    }
               }
               this.isDieing = true;
          }
          else if(this.inShock)
          {
               this.clip.gotoAndStop("shocked");
          }
          else if(this.clip.block._currentframe < 14 && !this.isBlocking)
          {
               this.clip.block.play();
          }
          else if(this.isBlocking)
          {
               this.clip.gotoAndStop("block");
               if(this.clip.block._currentframe == 7)
               {
                    this.clip.block.stop();
               }
          }
          else if(this.isSwinging)
          {
               this.damageTime = this.game.getGameTime();
               this.clip.gotoAndStop(this.swingType);
               var _loc4_ = undefined;
               var _loc5_ = undefined;
               if(this.isHitPeriod())
               {
                    _loc4_ = this.game.getPartitionManager().getEnemyTeam(this,this.x + this.SWORD_MAN_RANGE / 2 * this.currentDirection);
                    for(_loc5_ in _loc4_)
                    {
                         if(Math.abs(_loc4_[_loc5_].getClip()._y - this.y) < this.HIT_WIDTH)
                         {
                              if(_loc4_[_loc5_].getSquad() != this.getSquad() && this.swordHasHit(_loc4_[_loc5_]))
                              {
                                   var _loc6_ = 1 + int(Math.random() * 4);
                                   _root.soundManager.playSound("swordHit" + _loc6_,this.x);
                                   if(this.isMinion)
                                   {
                                        _loc4_[_loc5_].damage(this.controlMultiply() * this.squad.getTechnology().getSwordmanAttack() / 1.5,this.currentDirection,"sword");
                                   }
                                   else
                                   {
                                        _loc4_[_loc5_].damage(this.controlMultiply() * this.squad.getTechnology().getSwordmanAttack(),this.currentDirection,"sword");
                                   }
                                   this.hasDamaged = true;
                                   return undefined;
                              }
                         }
                    }
                    if(this.clip.hitTest(this.squad.getEnemyTeam().getCastleHitArea()))
                    {
                         _loc6_ = 1 + int(Math.random() * 4);
                         _root.soundManager.playSound("swordHit" + _loc6_,this.x);
                         this.squad.getEnemyTeam().damageCastle(this.controlMultiply() * this.squad.getTechnology().getSwordmanAttack());
                         this.hasDamaged = true;
                    }
               }
          }
          else if(Math.abs(this.dx) > this.RUN_MIN || Math.abs(this.dy) > this.RUN_MIN)
          {
               this.clip.gotoAndStop("run");
          }
          else
          {
               this.clip.gotoAndStop("stand");
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
                         this.swordSwing();
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
          return this.game.getGameTime() - this.lastSwordSwing <= this.MIN_SWING_TIME && this.game.getGameTime() - this.lastSwordSwing >= this.MIN_HIT_TIME && !this.hasDamaged;
     }
     function swordHasHit(man)
     {
          if(Math.abs(man.y - this.y) > 50)
          {
               return false;
          }
          if(this.currentDirection * (man.getX() - this.x) > this.SWORD_MAN_RANGE * 1.8 || this.currentDirection * (man.getX() - this.x) <= 0)
          {
               return false;
          }
          return true;
     }
     function swordSwing()
     {
          if(this.game.getGameTime() - this.lastSwordSwing >= this.MIN_SWING_TIME + this.MIN_WAIT_TIME)
          {
               this.isSwinging = true;
               this.swingType = "swing";
               this.MIN_SWING_TIME = 1133.3333333333333;
               this.MIN_HIT_TIME = 700;
               if(Math.random() <= 0.2)
               {
                    this.swingType = "swing2";
                    this.MIN_HIT_TIME = 500;
                    this.MIN_SWING_TIME = 1000;
               }
               else if(Math.random() <= 0.2)
               {
                    this.swingType = "swing3";
                    this.MIN_HIT_TIME = 1166.6666666666667;
                    this.MIN_SWING_TIME = 2033.3333333333333;
               }
               else if(Math.random() <= 0.2)
               {
                    this.swingType = "swing4";
                    this.MIN_HIT_TIME = 1000;
                    this.MIN_SWING_TIME = 1666.6666666666667;
               }
               this.lastSwordSwing = this.game.getGameTime();
               this.hasDamaged = false;
          }
          return false;
     }
     function damage(amount, direction, type)
     {
          if(this.clip.block != undefined && !this.isSwinging && direction != this.currentDirection)
          {
               if(int(Math.random() * 5) >= 2)
               {
                    var _loc6_ = amount * amount / this.MASS * direction * this.DAMAGE_MOMENTOM_CONSTANT;
                    if(type == "arrow" || type == "arrow_headshot")
                    {
                         this.game.getSoundManager().playSound("arrowHitMetal",this.x);
                         _loc6_ = 0;
                    }
                    if(type == "wizard")
                    {
                         this.inShock = true;
                         this.shockTime = this.game.getGameTime();
                    }
                    if(type == "giant")
                    {
                         this.clearStatus();
                         this.inShock = true;
                         this.shockTime = this.game.getGameTime();
                         this.setDy(_loc6_ * (1 - Math.random() * 2) * 70);
                         _loc6_ *= 31;
                    }
                    this.setDx(_loc6_);
                    return false;
               }
               super.damage(amount,direction,type);
          }
          else
          {
               super.damage(amount,direction,type);
          }
          return true;
     }
     function getHasDamaged()
     {
          return this.hasDamaged;
     }
     function getIsSwinging()
     {
          return this.isSwinging;
     }
     function getSWORD_MAN_RANGE()
     {
          return this.SWORD_MAN_RANGE;
     }
     function isAttacking()
     {
          return this.isSwinging;
     }
     function shouldAttack()
     {
          return true;
     }
     function setAsMinion()
     {
          this.baseScale *= 1.25;
          this.MAX_HEALTH /= 1.5;
          this.isMinion = true;
     }
     function setAsXiphos()
     {
          this.baseScale *= 0.9;
          this.health *= 5;
          this.MAX_HEALTH *= 5;
          this.isXiphos = true;
     }
}
