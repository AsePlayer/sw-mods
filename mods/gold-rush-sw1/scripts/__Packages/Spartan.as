class Spartan extends Man
{
     var type = 4;
     var MAX_VELOCITY = 3.5;
     var MAX_ACCELERATION = 0.4;
     var SPARTAN_RANGE = 50;
     var MIN_THRUST_TIME = 900;
     var MIN_WAIT_TIME = 0;
     var MIN_HIT_TIME = 350;
     var MAX_HEALTH = 600;
     var HIT_WIDTH = 16;
     var WALK_MODIFIER = 0.25;
     var SPEAR_THROW_TIME = 3666.666666666667;
     function Spartan(x, y, squad, simUnits, game)
     {
          super();
          this.x = x;
          this.y = y;
          this.dy = this.dx = 0;
          this.health = squad.getTechnology().getSpartanHealth();
          this.attackPower = squad.getTechnology().getSpartanAttack();
          this.squad = squad;
          this.game = game;
          this.simUnits = simUnits;
          this.lastThrust = 0;
          this.isThrusting = false;
          this.isBlocking = false;
          this.hasThrown = false;
          this.blockTime = 0;
          this.hasDamaged = false;
          this.unitType = "spartan";
          this.technology = {};
          this.clip.helmet = squad.getTechnology().getSpartanHelmet();
          this.technology.weapon = squad.getTechnology().getSpartanSpear() * 2 - 1;
          this.technology.secondary = squad.getTechnology().getSpartanSpear() * 2;
          this.technology.shield = squad.getTechnology().getSpartanShield();
          this.technology.helmet = squad.getTechnology().getSpartanHelmet();
          this.yOffset = 0;
          this.MAX_HEALTH = squad.getTechnology().getSpartanHealth();
          this.initMovieClip("spartan");
          this.health = this.MAX_HEALTH;
     }
     function walk(ddx, ddy)
     {
          if(!this.isThrowing)
          {
               super.walk(ddx,ddy);
          }
     }
     function update()
     {
          super.update();
          if(this.hasThrown)
          {
               this.clip.weapon = this.squad.getTechnology().getSpartanSpear() * 2;
          }
          else
          {
               this.clip.weapon = this.squad.getTechnology().getSpartanSpear() * 2 - 1;
          }
          this.clip.shield = this.squad.getTechnology().getSpartanShield();
          this.clip.helmet = this.squad.getTechnology().getSpartanHelmet();
          if(this.squad.getTechnology().getIsNotSpartan())
          {
               this.clip.helmet = this.squad.getTechnology().getSpartanHelmet() + 5;
          }
          if(this.inShock)
          {
               this.isThrusting = false;
          }
          if(this.isThrusting && this.game.getGameTime() - this.lastThrust > this.MIN_THRUST_TIME)
          {
               this.isThrusting = false;
          }
          if(this.isThrowing && this.hasThrown && this.game.getGameTime() - this.throwTime > this.SPEAR_THROW_TIME)
          {
               this.isThrowing = false;
          }
          if(!this.isAlive)
          {
               this.clip.gotoAndStop("death");
          }
          else if(this.inShock)
          {
               this.clip.gotoAndStop("shocked");
          }
          else if(this.isThrowing)
          {
               if(this.clip.spartan != undefined && this.clip.spartan._currentframe == this.clip.spartan._totalframes)
               {
                    this.clip.gotoAndStop("drawsword");
               }
               else if(this.clip.drawSword == undefined)
               {
                    this.clip.gotoAndStop("throw");
               }
               if(!this.hasThrown && this.clip.spartan._currentframe == 38)
               {
                    this.throwAngle = -12;
                    if(this.currentDirection == 1)
                    {
                         this.game.projectileManager.addSpear(this,this.throwAngle);
                    }
                    else
                    {
                         this.game.projectileManager.addSpear(this,180 - this.throwAngle);
                    }
                    this.hasThrown = true;
               }
          }
          else if(this.isThrusting)
          {
               this.damageTime = this.game.getGameTime();
               this.clip.gotoAndStop(this.spartanThrust);
               var _loc4_ = undefined;
               var _loc5_ = undefined;
               if(this.isHitPeriod())
               {
                    _loc4_ = this.game.getPartitionManager().getEnemyTeam(this,this.x + this.getSPARTAN_RANGE() / 2 * this.currentDirection);
                    for(_loc5_ in _loc4_)
                    {
                         if(Math.abs(_loc4_[_loc5_].getClip()._y - this.y) < this.HIT_WIDTH)
                         {
                              if(_loc4_[_loc5_].getSquad() != this.getSquad() && this.thrustHasHit(_loc4_[_loc5_]))
                              {
                                   var _loc6_ = 1 + int(Math.random() * 4);
                                   _root.soundManager.playSound("swordHit" + _loc6_,this.x);
                                   _loc4_[_loc5_].damage(this.controlMultiply() * this.squad.getTechnology().getSpartanAttack(),this.currentDirection,"spear");
                                   this.hasDamaged = true;
                                   return undefined;
                              }
                         }
                    }
                    if(this.clip.hitTest(this.squad.getEnemyTeam().getCastleHitArea()))
                    {
                         _loc6_ = 1 + int(Math.random() * 4);
                         _root.soundManager.playSound("swordHit" + _loc6_,this.x);
                         this.squad.getEnemyTeam().damageCastle(this.controlMultiply() * this.squad.getTechnology().getSpartanAttack());
                         this.hasDamaged = true;
                    }
               }
          }
          else if(this.dx != 0 || this.dy != 0)
          {
               if(this.isBlocking)
               {
                    if(this.game.getGameTime() - this.blockTime < 500.00000000000006)
                    {
                         this.clip.gotoAndStop("block");
                    }
                    else
                    {
                         this.clip.gotoAndStop("walk");
                    }
               }
               else
               {
                    this.clip.gotoAndStop("run");
               }
          }
          else if(this.isBlocking)
          {
               this.clip.gotoAndStop("block");
               if(this.game.getGameTime() - this.blockTime > 500.00000000000006)
               {
                    this.clip.spartan.gotoAndStop(21);
               }
          }
          else
          {
               this.clip.gotoAndStop("stand");
          }
     }
     function keyInterface()
     {
          if(!this.isThrusting)
          {
               if(Key.isDown(this.game.getKey("BLOCK")))
               {
                    this.block();
               }
               else
               {
                    this.unblock();
               }
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
                    this.thrust();
               }
               else if(Key.isDown(this.game.getKey("THROW")))
               {
                    var _loc3_ = Math.atan((_root._xmouse - this.x - this.game.getScreenX()) / (_root._ymouse - this.y)) * 180 / 3.141592653589793;
                    if(this.currentDirection == 1)
                    {
                         if(_root._ymouse >= this.y)
                         {
                              _loc3_ = 90 - _loc3_;
                         }
                         else
                         {
                              _loc3_ = -90 - _loc3_;
                         }
                    }
                    else if(_root._ymouse >= this.y)
                    {
                         _loc3_ = 90 + _loc3_;
                    }
                    else
                    {
                         _loc3_ -= 90;
                    }
                    this.throwSpear(_loc3_);
               }
          }
          else if(Key.isDown(32))
          {
               this.thrust();
          }
     }
     function clearStatus()
     {
          this.unblock();
          this.isThrowing = false;
          this.isThrusting = false;
     }
     function isHitPeriod()
     {
          return this.game.getGameTime() - this.lastThrust <= this.MIN_THRUST_TIME && this.game.getGameTime() - this.lastThrust >= this.MIN_HIT_TIME && !this.hasDamaged;
     }
     function thrustHasHit(man)
     {
          if(Math.abs(man.y - this.y) > 30)
          {
               return false;
          }
          if(this.currentDirection * (man.getX() - this.x) > this.getSPARTAN_RANGE() * 1.1 || this.currentDirection * (man.getX() - this.x) <= 0)
          {
               return false;
          }
          return true;
     }
     function thrust()
     {
          if(this.game.getGameTime() - this.lastThrust >= this.MIN_THRUST_TIME + this.MIN_WAIT_TIME - 100)
          {
               this.isThrusting = true;
               this.isThrowing = false;
               this.lastThrust = this.game.getGameTime();
               this.hasDamaged = false;
               this.damageTime = this.game.getGameTime();
               this.spartanThrust = "thrust";
               if(Math.random() < 0.3)
               {
                    this.spartanThrust = "thrust2";
               }
          }
          return false;
     }
     function isAttacking()
     {
          return this.isThrusting;
     }
     function unblock()
     {
          this.isBlocking = false;
          this.maxVelocityModifier = 1;
     }
     function block()
     {
          if(!this.isBlocking)
          {
               this.blockTime = this.game.getGameTime();
          }
          this.isBlocking = true;
          this.maxVelocityModifier = this.WALK_MODIFIER;
     }
     function damage(amount, direction, type)
     {
          if(this.isBlocking && !this.isThrusting && direction != this.currentDirection)
          {
               var _loc5_ = this.squad.getTechnology().getSpartanBlockChance();
               if(type == "sword")
               {
                    _loc5_ /= 3;
               }
               if(Math.random() >= _loc5_)
               {
                    var _loc4_ = amount * amount / this.MASS * direction * this.DAMAGE_MOMENTOM_CONSTANT;
                    if(type == "arrow" || type == "arrow_headshot")
                    {
                         this.game.getSoundManager().playSound("arrowHitMetal",this.x);
                         _loc4_ = 0;
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
                         this.setDy(_loc4_ * (1 - Math.random() * 2) * 70);
                         _loc4_ *= 31;
                    }
                    this.setDx(_loc4_);
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
     function getisThrusting()
     {
          return this.isThrusting;
     }
     function getSPARTAN_RANGE()
     {
          if(this.hasThrown)
          {
               return this.SPARTAN_RANGE;
          }
          return this.SPARTAN_RANGE * 1.5;
     }
     function shouldAttack()
     {
          return true;
     }
     function faceDirection(num)
     {
          if(this.getisThrusting())
          {
               return undefined;
          }
          super.faceDirection(num);
     }
     function throwSpear(throwAngle)
     {
          if(throwAngle < -90 && throwAngle >= -180)
          {
               throwAngle = -90;
          }
          else if(throwAngle > 90 && throwAngle <= 180)
          {
               throwAngle = 90;
          }
          if(!this.hasThrown && !this.isThrowing)
          {
               this.throwTime = this.game.getGameTime();
               this.throwAngle = throwAngle;
               this.isThrusting = false;
               this.isThrowing = true;
          }
     }
     function isThrown()
     {
          if(this.squad.getTechnology().getIsNotSpartan())
          {
               return true;
          }
          return this.hasThrown;
     }
     function heal()
     {
          this.hasThrown = false;
          this.isThrowing = false;
          this.isThrusting = false;
          this.isBlocking = false;
     }
}
