class Archer extends Man
{
     var type = 2;
     var MAX_VELOCITY = 3.5;
     var MAX_ACCELERATION = 0.4;
     var MAX_HEALTH = 300;
     function Archer(x, y, squad, simUnits, game)
     {
          super();
          this.x = x;
          this.y = y;
          this.dy = this.dx = 0;
          this.healthLostnum = 0;
          this.squad = squad;
          this.game = game;
          this.hasPrep = false;
          this.simUnits = simUnits;
          this.unitType = "archer";
          this.initMovieClip("archer");
          this.isShooting = false;
          this.hasShot = false;
          this.armRotation = 0;
          this.shootStartTime = game.getGameTime();
          this.shootFinishTime = game.getGameTime();
          this.ARCHER_RANGE = 700;
          this.inaccuracy = Math.random() * 300 - 100;
          this.yOffset = 0;
          this.MAX_HEALTH = squad.getTechnology().getArcherHealth();
          this.health = this.MAX_HEALTH;
          this.arrowType = squad.getTechnology().getArcherDamage();
          this.isKytchu = false;
     }
     function update()
     {
          super.update();
          this.clip.health.bar._xscale = this.health / this.MAX_HEALTH * 100;
          if(this.isKytchu)
          {
               this.clip.quiver = 3;
               this.clip.arrows = this.squad.getTechnology().getArcherDamage();
          }
          else
          {
               this.clip.arrows = this.squad.getTechnology().getArcherDamage();
          }
          if(this.hasShot)
          {
               if(Math.abs(this.clip.prep.bow.bow._rotation) > 5 || this.game.getGameTime() - this.shootFinishTime <= 500)
               {
                    this.aim(0);
               }
               else
               {
                    this.hasShot = false;
                    this.isShooting = false;
               }
          }
          if(!this.isAlive)
          {
               this.clip.gotoAndStop("death");
               this.clip.health._visible = false;
          }
          else if(this.isShooting)
          {
               if(this != this.game.getCurrentCharacter() || this.clip.prep.bow._currentframe < 34)
               {
                    this.clip.prep.bar._visible = false;
               }
               else
               {
                    this.clip.prep.bar._visible = true;
                    var _loc3_ = 150 - this.power;
                    if(!this.hasShot)
                    {
                         if(this.powerDirection == 1)
                         {
                              this.power += 500 * (1 / _loc3_);
                         }
                         else
                         {
                              this.power -= 500 * (1 / _loc3_);
                         }
                    }
                    if(this.power > 100)
                    {
                         this.power = 99;
                         this.powerDirection = -1;
                    }
                    else if(this.power < 0)
                    {
                         this.power = 1;
                         this.powerDirection = 1;
                    }
                    this.clip.prep.bar.bar._xscale = this.power;
               }
               this.clip.gotoAndStop("walk");
               if(this.dx != 0 || this.dy != 0)
               {
                    this.clip.prep.play();
               }
               else
               {
                    this.clip.prep.gotoAndStop(1);
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
     }
     function aim(gangle)
     {
          if(this.game.getGameTime() - this.shootStartTime > 866.6666666666667)
          {
               this.clip.prep.bow.bow._rotation += (gangle - this.clip.prep.bow.bow._rotation) / 5;
               if(Math.abs(gangle - this.clip.prep.bow.bow._rotation) < 1.5)
               {
                    this.clip.prep.bow.bow._rotation = gangle;
               }
               return Math.abs(gangle - this.clip.prep.bow.bow._rotation) < 0.4;
          }
          return false;
     }
     function shoot()
     {
          if(this.hasShot || !this.isAlive)
          {
               return undefined;
          }
          if(this.clip.prep != undefined && this.clip.prep.bow._currentframe >= 39)
          {
               var _loc2_ = this.arrowType;
               if(this.controlMultiply() == this.controlMultiplier)
               {
                    _loc2_ += 1;
               }
               if(this.game.getCurrentCharacter() != this)
               {
                    this.power = 70;
               }
               if(this.currentDirection == 1)
               {
                    this.game.projectileManager.addArrow(this,this.clip.prep.bow.bow._rotation,_loc2_,this.power / 100);
               }
               else
               {
                    this.game.projectileManager.addArrow(this,180 - this.clip.prep.bow.bow._rotation,_loc2_,this.power / 100);
               }
               this.clip.prep.bow.bow.play();
               this.hasShot = true;
               this.shootFinishTime = this.game.getGameTime();
          }
     }
     function shootFail()
     {
          if(this.hasShot || !this.isAlive)
          {
               return undefined;
          }
          var _loc2_ = this.arrowType;
          if(this.controlMultiply() == 2)
          {
               _loc2_ += 1;
          }
          if(this.currentDirection == 1)
          {
               this.game.projectileManager.addArrowFail(this,0,_loc2_);
          }
          else
          {
               this.game.projectileManager.addArrowFail(this,180,_loc2_);
          }
          this.clip.prep.bow.bow.play();
          this.hasShot = true;
          this.shootFinishTime = this.game.getGameTime();
     }
     function beginShot()
     {
          this.isShooting = true;
          this.shootStartTime = this.game.getGameTime();
          var _loc2_ = this.compound(2,0.5,this.squad.getTechnology().getArcherAccuracy());
          this.inaccuracy = (Math.random() * 300 - 150) / _loc2_;
          this.power = 0;
          this.powerDirection = 1;
          this.hasPrep = false;
     }
     function keyInterface()
     {
          var _loc3_ = undefined;
          if(!this.hasShot)
          {
               if(this.isShooting)
               {
                    if(Key.isDown(this.game.getKey("LEFT")) || Key.isDown(this.game.getKey("ARROW_LEFT")))
                    {
                         this.walk((- this.MAX_ACCELERATION) / 4,0);
                    }
                    if(Key.isDown(this.game.getKey("RIGHT")) || Key.isDown(this.game.getKey("ARROW_RIGHT")))
                    {
                         this.walk(this.MAX_ACCELERATION / 4,0);
                    }
                    if(Key.isDown(this.game.getKey("UP")) || Key.isDown(this.game.getKey("ARROW_UP")))
                    {
                         this.walk(0,(- this.MAX_ACCELERATION) / 4);
                    }
                    if(Key.isDown(this.game.getKey("DOWN")) || Key.isDown(this.game.getKey("ARROW_DOWN")))
                    {
                         this.walk(0,this.MAX_ACCELERATION / 4);
                    }
                    _loc3_ = Math.atan((_root._xmouse - this.x - this.game.getScreenX()) / (_root._ymouse - this.y + 40)) * 180 / 3.141592653589793;
                    if(this.currentDirection == 1)
                    {
                         if(_root._ymouse >= this.y - 40)
                         {
                              this.aim(90 - _loc3_);
                         }
                         else
                         {
                              this.aim(-90 - _loc3_);
                         }
                    }
                    else if(_root._ymouse >= this.y - 40)
                    {
                         this.aim(90 + _loc3_);
                    }
                    else
                    {
                         this.aim(_loc3_ - 90);
                    }
                    if(!this.game.getIsMouseDown())
                    {
                         this.shoot();
                    }
               }
               else if(_root._ymouse > 60 && this.game.getIsMouseDown() && this.game.getGameTime() - this.shootFinishTime > 500)
               {
                    this.beginShot();
               }
               else
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
               }
          }
     }
     function aimAtTarget(mc, dx)
     {
          var _loc4_ = mc._x - this.x;
          if(dx != undefined)
          {
               _loc4_ += dx * 10;
          }
          _loc4_ = 0.9 * Math.abs(_loc4_) + this.inaccuracy;
          if(_loc4_ >= 700)
          {
               return this.aim(-45);
          }
          var _loc5_ = 0.001530612244897959 * _loc4_ / 2;
          return this.aim(-57.29577951308232 * Math.asin(_loc5_));
     }
     function shootAtTarget(mc, isCastle, dx)
     {
          if(mc == undefined)
          {
          }
          if(this.hasShot)
          {
               return true;
          }
          if(Math.abs(mc._y - this.y) >= 4 && !this.isShooting && !isCastle)
          {
               this.walk(0,(mc._y - this.y) / Math.abs(mc._y - this.y) * this.MAX_ACCELERATION);
          }
          else if(this.canShootForAi())
          {
               if(!this.isShooting)
               {
                    this.beginShot();
               }
               else if(this.aimAtTarget(mc,dx) == true)
               {
                    this.shoot();
               }
          }
          return false;
     }
     function clearStatus()
     {
          this.shootFinishTime = this.game.getGameTime();
          this.isShooting = false;
          this.hasShot = false;
     }
     function getIsShooting()
     {
          return this.isShooting;
     }
     function getARCHER_RANGE()
     {
          return this.ARCHER_RANGE;
     }
     function isAttacking()
     {
          return this.isShooting;
     }
     function shouldAttack()
     {
          return true;
     }
     function canShootForAi()
     {
          return this.game.getGameTime() - this.shootFinishTime > 1000;
     }
     function setAsKytchu()
     {
          this.MAX_HEALTH *= 12;
          this.health *= 12;
          this.ARCHER_RANGE = 850;
          this.isKytchu = true;
     }
}
