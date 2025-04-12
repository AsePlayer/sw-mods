class Man
{
     var controlMultiplier = 3;
     var type = 0;
     var DAMAGE_MOMENTOM_CONSTANT = 1;
     var POWER = 100;
     var FRICTION = 0.9;
     var ZERO_VELOCITY_LIMIT = 0.08;
     var MAX_VELOCITY = 4;
     var MAX_ACCELERATION = 0.2;
     var MASS = 500;
     var MAX_HEALTH = 100;
     var ACTION_TIMEOUT = 5000;
     var SHOCK_AMOUNT = 3300;
     function Man(x, y, squad, simUnits, game)
     {
          this.x = x;
          this.y = y;
          this.health = this.MAX_HEALTH;
          this.squad = squad;
          this.game = game;
          this.simUnits = simUnits;
          this.yOffset = Math.random() * 8 - 4;
          this.dy = this.dy = 0;
          this.isAlive = true;
          this.unitType = undefined;
          this.maxVelocityModifier = 1;
          this.damageTime = 0;
          this.damageDirectionTime = 1000;
          this.currentDirection = 1;
          this.lastActionTime = game.getGameTime();
          this.isInAction = false;
          this.isGarrisoned = false;
          this.isQueued = false;
          this.deathType = undefined;
          this.inShock = false;
          this.shockTime = game.getGameTime();
          this.currentTint = -200;
     }
     function updateTint()
     {
     }
     function initMovieClip(movieName)
     {
          var _loc3_ = this.game.nextUnitIndex();
          this.game.screen.attachMovie(movieName,movieName + _loc3_,this.game.getManBaseDepth() + _loc3_,{_x:this.x,_y:this.y});
          this.clip = this.game.screen[movieName + _loc3_];
          this.clip.name = movieName + _loc3_;
          this.clip._x = -100;
          this.clip._y = this.y;
          this.name = movieName + _loc3_;
          this.baseScale = 1700;
          var _loc5_ = _root.campaignData.isGlow;
          if(_loc5_ == undefined || _loc5_ == true)
          {
               var _loc6_ = new flash.filters.GlowFilter(16777215,1,4,4,1.5,1);
               this.clip.filters = [_loc6_];
          }
          this.game.getPartitionManager().add(this);
          this.dieTime = undefined;
          if(this.squad.getTeamName() == "red")
          {
               this.clip.click._visible = false;
          }
     }
     function walkDamage(ddx, ddy)
     {
          if(this.inShock)
          {
               return undefined;
          }
          if(isNaN(ddx))
          {
               trace("HERE");
          }
          if(this.isAttacking() && this.type != 2)
          {
               return undefined;
          }
          if(this.game.getGameTime() - this.damageTime > this.damageDirectionTime)
          {
               if(this.dx < 0 && this.currentDirection == 1)
               {
                    this.currentDirection = -1;
               }
               else if(this.dx > 0 && this.currentDirection == -1)
               {
                    this.currentDirection = 1;
               }
               if(this.dx + ddx > this.MAX_VELOCITY * this.maxVelocityModifier)
               {
                    this.dx = this.MAX_VELOCITY * this.maxVelocityModifier;
               }
               else if(this.dx + ddx < (- this.MAX_VELOCITY) * this.maxVelocityModifier)
               {
                    this.dx = (- this.MAX_VELOCITY) * this.maxVelocityModifier;
               }
               else
               {
                    this.dx += ddx;
               }
               if(this.dy + ddy > this.MAX_VELOCITY * this.maxVelocityModifier / 2)
               {
                    this.dy = this.MAX_VELOCITY * this.maxVelocityModifier / 2;
               }
               else if(this.dy + ddy < (- this.MAX_VELOCITY) * this.maxVelocityModifier / 2)
               {
                    this.dy = (- this.MAX_VELOCITY) * this.maxVelocityModifier / 2;
               }
               else
               {
                    this.dy += ddy;
               }
          }
     }
     function walk(ddx, ddy)
     {
          if(this.inShock)
          {
               return undefined;
          }
          if(this.isAttacking() && this.type != 2)
          {
               return undefined;
          }
          if(isNaN(ddx))
          {
               trace("HERE");
          }
          this.damageTime = 0;
          if(this.game.getGameTime() - this.damageTime > this.damageDirectionTime)
          {
               if(!(this.isAttacking() && this.type == 2))
               {
                    if(ddx < 0 && this.currentDirection == 1)
                    {
                         this.currentDirection = -1;
                    }
                    else if(ddx > 0 && this.currentDirection == -1)
                    {
                         this.currentDirection = 1;
                    }
               }
               if(this.dx + ddx > this.MAX_VELOCITY * this.maxVelocityModifier)
               {
                    this.dx = this.MAX_VELOCITY * this.maxVelocityModifier;
               }
               else if(this.dx + ddx < (- this.MAX_VELOCITY) * this.maxVelocityModifier)
               {
                    this.dx = (- this.MAX_VELOCITY) * this.maxVelocityModifier;
               }
               else
               {
                    this.dx += ddx;
               }
               if(this.dy + ddy > this.MAX_VELOCITY * this.maxVelocityModifier / 2)
               {
                    this.dy = this.MAX_VELOCITY * this.maxVelocityModifier / 2;
               }
               else if(this.dy + ddy < (- this.MAX_VELOCITY) * this.maxVelocityModifier / 2)
               {
                    this.dy = (- this.MAX_VELOCITY) * this.maxVelocityModifier / 2;
               }
               else
               {
                    this.dy += ddy;
               }
          }
     }
     function update()
     {
          if(this.clip == undefined)
          {
               trace("MAN DISAPPEARING");
               this.health = 0;
          }
          if(Math.abs(this.dx) > 2 * this.MAX_VELOCITY * this.maxVelocityModifier)
          {
               this.dx = this.dx / Math.abs(this.dx) * 2 * this.MAX_VELOCITY * this.maxVelocityModifier;
          }
          var _loc5_ = false;
          var _loc9_ = undefined;
          var _loc6_ = undefined;
          var _loc4_ = undefined;
          var _loc3_ = this.game.getPartitionManager().getEnemyTeam(this,this.x);
          var _loc8_ = undefined;
          var _loc12_ = undefined;
          this.updateTint();
          this.clip.swapDepths(this.game.getManBaseDepth() + this.y * this.game.getScreenWidth() + this.x);
          if(this.inShock == true && this.game.getGameTime() - this.shockTime > this.squad.getEnemyTeam().getTechnology().getWizardStunTime())
          {
               this.inShock = false;
          }
          if(this.health <= 0 && this.dieTime == undefined)
          {
               this.dieTime = this.game.getGameTime();
               if(this.isAlive)
               {
                    this.clip.filters = [];
                    this.game.getPartitionManager().remove(this);
                    this.squad.removeManFromFormation(this,this.simUnits);
                    var _loc11_ = int(Math.random() * 4) + 4;
                    _root.soundManager.playSound("pain" + _loc11_,this.x);
                    this.squad.numBodies = this.squad.numBodies + 1;
               }
               this.isAlive = false;
          }
          if(!this.isAlive)
          {
               this.die();
               return undefined;
          }
          _loc9_ = false;
          for(_loc4_ in _loc3_)
          {
               _loc8_ = _loc3_[_loc4_].getClip();
               if(this.isMenHitTest(this,_loc3_[_loc4_],0,0) && _loc3_[_loc4_].getSquad().getTeamName() != this.getSquad().getTeamName())
               {
                    _loc6_ = _loc3_[_loc4_];
                    _loc9_ = true;
               }
          }
          if(this.dx != 0)
          {
               var _loc7_ = undefined;
               for(_loc4_ in _loc3_)
               {
                    _loc8_ = _loc3_[_loc4_].getClip();
                    if(this.isMenHitTest(this,_loc3_[_loc4_],this.dx,0))
                    {
                         _loc5_ = true;
                         _loc7_ = _loc3_[_loc4_];
                    }
               }
               if(!this.willHitCastles(this.dx) && this.x + this.dx > -100 && this.x + this.dx < this.game.getRIGHT() + 100 && !_loc5_ || _loc9_)
               {
                    this.x += this.dx;
               }
               else if(_loc5_ && !_loc9_)
               {
                    var _loc10_ = _loc7_.getDx() * _loc7_.getMASS() + this.dx * this.MASS;
                    if(_loc9_)
                    {
                         _loc7_.setDx(this.POWER / _loc7_.getMASS() * this.currentDirection);
                    }
                    else
                    {
                         _loc10_ /= this.MASS + _loc7_.getMASS();
                         _loc7_.setDx(_loc10_);
                         this.setDx(_loc10_);
                    }
               }
          }
          if(_loc9_)
          {
               if(this.x < _loc6_.getX())
               {
                    _loc6_.setDx(_loc6_.getDx() + 0.5);
               }
               else
               {
                    _loc6_.setDx(_loc6_.getDx() - 0.5);
               }
               if(this.y < _loc6_.getY())
               {
                    _loc6_.setDy(_loc6_.getDy() + 0.5);
               }
               else
               {
                    _loc6_.setDy(_loc6_.getDy() - 0.5);
               }
          }
          _loc5_ = false;
          if(this.dy != 0)
          {
               for(_loc4_ in _loc3_)
               {
                    if(this.isMenHitTest(this,_loc3_[_loc4_],0,this.dy))
                    {
                         _loc5_ = true;
                         _loc3_[_loc4_].setDy(this.POWER / _loc3_[_loc4_].getMASS() * this.currentDirection);
                    }
               }
               if(this.y + this.dy < this.game.getBOTTOM() && this.y + this.dy > this.game.getTOP() && !_loc5_ || _loc9_)
               {
                    this.y += this.dy;
               }
          }
          if(this.y < this.game.getTOP())
          {
               this.y = this.game.getTOP();
          }
          else if(this.y > this.game.getBOTTOM())
          {
               this.y = this.game.getBOTTOM();
          }
          this.dx *= this.FRICTION;
          this.dy *= this.FRICTION / 1.5;
          if(Math.abs(this.dx) < this.ZERO_VELOCITY_LIMIT)
          {
               this.dx = 0;
          }
          if(Math.abs(this.dy) < this.ZERO_VELOCITY_LIMIT)
          {
               this.dy = 0;
          }
          this.clip._xscale = this.getScale();
          this.clip._yscale = this.getScale();
          if(this.currentDirection == -1)
          {
               this.clip._xscale *= -1;
          }
          if(!this.getIsGarrisoned())
          {
               if(this.clip._x - 10 < this.game.screen.leftCastle._x + this.game.screen.leftCastle._width + 60)
               {
                    this.dx = 0.4;
                    this.dy = 0;
                    this.x += this.MAX_VELOCITY;
               }
               if(this.clip._x + 10 > this.game.screen.rightCastle._x - this.game.screen.rightCastle._width - 60)
               {
                    this.dx = -0.4;
                    this.dy = 0;
                    this.x -= this.MAX_VELOCITY;
               }
          }
          this.clip._x = this.x;
          this.clip._y = this.y + this.yOffset;
          this.game.getPartitionManager().update(this);
          this.unaction();
          this.visibleUpdate();
     }
     function willHitCastles(dx)
     {
          return false;
     }
     function visibleUpdate()
     {
          if(this.game.screen._x + this.clip._x + this.clip._width > 0 && this.game.screen._x + this.clip._x < 650)
          {
               this.clip._visible = true;
          }
          else
          {
               this.clip._visible = false;
          }
     }
     function die()
     {
          this.isAlive = false;
          if(this.squad.numBodies > 3)
          {
               if(this.game.getGameTime() - this.dieTime >= 5000)
               {
                    this.cleanUp();
               }
          }
          else if(this.game.getGameTime() - this.dieTime >= 50000)
          {
               this.cleanUp();
          }
     }
     function cleanUp()
     {
          this.squad.removeMan(this,this.simUnits);
          removeMovieClip(this.clip);
          this.squad.numBodies--;
     }
     function damage(amount, direction, type)
     {
          if(this.isGarrisoned)
          {
               return undefined;
          }
          this.action();
          var _loc2_ = amount * amount / this.MASS * direction * this.DAMAGE_MOMENTOM_CONSTANT;
          if(type == "arrow" || type == "arrow_headshot")
          {
               _loc2_ = 0;
          }
          if(type == "giant")
          {
               this.clearStatus();
               this.inShock = true;
               this.shockTime = this.game.getGameTime();
               this.setDy(-10 + Math.random() * 20);
               _loc2_ *= 30;
          }
          else if(type == "wizard")
          {
               this.clearStatus();
               this.inShock = true;
               this.shockTime = this.game.getGameTime();
               _loc2_ *= 10;
          }
          this.setDx(_loc2_);
          if(direction == this.currentDirection)
          {
               amount *= 4;
          }
          if(type != "arrow")
          {
               this.game.getBloodManager().addSplatter(this.x,this.y - 30,this.getScale(),this.getCurrentDirection());
          }
          this.damageTime = this.game.getGameTime();
          if(this.game.getCurrentCharacter() == this)
          {
               this.health -= amount * 0.8;
          }
          else
          {
               this.health -= amount;
          }
          this.game.getBloodManager().addBlood(this.x,this.y,this.getScale(),this.getCurrentDirection());
          this.deathType = type;
          return true;
     }
     function isMenHitTest(a, b, dx, dy)
     {
          if(!a.getIsAlive() || !b.getIsAlive())
          {
               trace("Problem: " + b.clip + " " + b.clip._x);
          }
          if(a == b)
          {
               return false;
          }
          var _loc3_ = undefined;
          _loc3_ = 1;
          if(a.getSquad().getTeamName() == b.getSquad().getTeamName())
          {
               _loc3_ = 1;
          }
          if(Math.abs(b.getY() - a.getY() - dy) > 8 * _loc3_)
          {
               return false;
          }
          if(Math.abs(b.getX() - a.getX() - dx) > 40)
          {
               return false;
          }
          return true;
     }
     function keyInterface()
     {
     }
     function faceDirection(direction)
     {
          if(this.isAttacking())
          {
               return undefined;
          }
          if(this.game.getGameTime() - this.damageTime <= this.damageDirectionTime)
          {
               return undefined;
          }
          if(isNaN(direction) || direction == undefined)
          {
               return undefined;
          }
          if(Math.abs(direction) != 1)
          {
               return undefined;
          }
          if(this.getCurrentDirection() != direction)
          {
               this.currentDirection = direction;
          }
     }
     function getX()
     {
          return this.x;
     }
     function getY()
     {
          return this.y;
     }
     function setX(num)
     {
          this.x = num;
     }
     function setY(num)
     {
          this.y = num;
     }
     function getSpeed()
     {
          return Math.sqrt(this.dx * this.dx + this.dy * this.dy);
     }
     function getMAXSPEED()
     {
          return this.MAX_VELOCITY;
     }
     function getClip()
     {
          return this.clip;
     }
     function clearStatus()
     {
     }
     function getUnitType()
     {
          return this.unitType;
     }
     function getScale()
     {
          return this.y * this.y / this.baseScale;
     }
     function getSquad()
     {
          return this.squad;
     }
     function getCurrentDirection()
     {
          return this.currentDirection;
     }
     function getName()
     {
          return this.name;
     }
     function getMAX_ACCELERATION()
     {
          return this.MAX_ACCELERATION;
     }
     function getIsAlive()
     {
          return this.isAlive;
     }
     function isAttacking()
     {
          return false;
     }
     function shouldAttack()
     {
          return true;
     }
     function getDx()
     {
          return this.dx;
     }
     function getDy()
     {
          return this.dy;
     }
     function setDx(dx)
     {
          this.damageTime = this.game.getGameTime();
          this.dx = dx;
     }
     function setDy(dy)
     {
          this.dy = dy;
     }
     function getMASS()
     {
          return this.MASS;
     }
     function heal()
     {
          this.clearStatus();
     }
     function action()
     {
          this.lastActionTime = this.game.getGameTime();
          this.squad.action();
          this.isInAction = true;
     }
     function unaction()
     {
          if(this.game.getGameTime() - this.lastActionTime > this.ACTION_TIMEOUT)
          {
               this.isInAction = false;
          }
     }
     function getIsInAction()
     {
          return this.isInAction;
     }
     function getIsGarrisoned()
     {
          return this.isGarrisoned;
     }
     function setIsGarrisoned(v)
     {
          this.isGarrisoned = v;
     }
     function getIsQueued()
     {
          return this.isQueued;
     }
     function setIsQueued(v)
     {
          this.isQueued = v;
     }
     function controlMultiply()
     {
          if(this.game.getCurrentCharacter() == this)
          {
               return this.controlMultiplier;
          }
          return 1;
     }
     function compound(base, rate, level)
     {
          return Math.pow(1 + rate,level) * base;
     }
     function getHealth()
     {
          return this.health;
     }
     function enableGlow()
     {
          var _loc2_ = new flash.filters.GlowFilter(16777215,1,4,4,1.5,1);
          this.clip.filters = [_loc2_];
     }
     function disableGlow()
     {
          this.clip.filters = [];
     }
}
