class Giant extends Man
{
     var type = 6;
     var MAX_VELOCITY = 1.2;
     var MAX_ACCELERATION = 0.2;
     var GIANT_RANGE = 80;
     var MIN_SWING_TIME = 3010;
     var MIN_WAIT_TIME = 0;
     var MIN_HIT_TIME = 1650;
     var HIT_WIDTH = 60;
     var MASS = 100000;
     var POWER = 100;
     function Giant(x, y, squad, simUnits, game)
     {
          super();
          this.x = x;
          this.y = y;
          this.dy = this.dx = 0;
          this.healthLostnum = 0;
          this.squad = squad;
          this.game = game;
          this.simUnits = simUnits;
          this.lastSwordSwing = 0;
          this.isSwinging = false;
          this.hasDamaged = false;
          this.unitType = "giant";
          this.initMovieClip("giant");
          this.damageDirectionTime = 200;
          this.isBlocking = false;
          this.yOffset = 0;
          this.baseScale /= 1 + squad.getTechnology().getGiantStrength() * 0.1;
          this.MAX_HEALTH = squad.getTechnology().getGiantHealth();
          this.health = this.MAX_HEALTH;
     }
     function update()
     {
          super.update();
          this.clip.health.bar._xscale = this.health / this.MAX_HEALTH * 100;
          this.clip.weapon = this.squad.getTechnology().getGiantClub() * 2 - 1;
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
               this.setDx(0);
               this.setDy(0);
               this.clip.gotoAndStop(this.swingType);
               var _loc4_ = undefined;
               if(this.clip.swing._currentframe == 20)
               {
                    var _loc5_ = 1 + int(Math.random() * 2);
                    _root.soundManager.playSound("giantSwing" + _loc5_,this.x);
               }
               if(this.isHitPeriod())
               {
                    for(_loc4_ in this.near)
                    {
                         if(Math.abs(this.near[_loc4_].getClip()._y - this.y) < this.HIT_WIDTH && this.near[_loc4_].getIsAlive())
                         {
                              if(this.near[_loc4_].getSquad() != this.getSquad() && this.swordHasHit(this.near[_loc4_]))
                              {
                                   this.near[_loc4_].damage(this.squad.getTechnology().getGiantAttack(),this.currentDirection,"giant");
                                   this.near.splice(_loc4_,1);
                                   this.hasDamaged = true;
                              }
                         }
                    }
                    if(this.clip.hitTest(this.squad.getEnemyTeam().getCastleHitArea()))
                    {
                         this.squad.getEnemyTeam().damageCastle(this.squad.getTechnology().getGiantAttack() * 10);
                         this.hasDamaged = true;
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
          if(this.isSwinging && this.clip.swing._currentframe >= 127)
          {
               this.isSwinging = false;
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
          return this.clip.swing._currentFrame == this.hitFrame && !this.hasDamaged;
     }
     function swordHasHit(man)
     {
          if(Math.abs(man.y - this.y) > this.HIT_WIDTH)
          {
               return false;
          }
          if(this.currentDirection * (man.getX() - this.x) > this.GIANT_RANGE || this.currentDirection * (man.getX() - this.x) <= -30)
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
               this.lastSwordSwing = this.game.getGameTime();
               this.hasDamaged = false;
               this.damageTime = this.game.getGameTime();
               this.near = this.squad.getEnemyTeam().getMen().slice();
               this.swingType = "swing";
               this.hitFrame = 42;
               this.MIN_HIT_TIME = 1250;
               if(Math.random() <= 0.5)
               {
                    this.hitFrame = 64;
                    this.MIN_HIT_TIME = 1900;
                    this.swingType = "swing2";
               }
          }
          return false;
     }
     function damage(amount, direction, type)
     {
          if(type == "giant")
          {
               amount *= 40;
          }
          var _loc4_ = amount;
          if(type == "sword" || type == "spear")
          {
               _loc4_ *= 2;
               super.damage(2 * amount,- this.currentDirection,"");
          }
          else
          {
               super.damage(amount,- this.currentDirection,"");
          }
          this.healthLostnum = (this.healthLostnum + 1) % 5;
          var _loc3_ = "healthLost" + this.healthLostnum;
          this.game.screen.attachMovie("healthLost",_loc3_,10000000000040 + this.healthLostnum);
          this.game.screen[_loc3_]._x = this.x;
          this.game.screen[_loc3_]._y = this.y - 100;
          this.game.screen[_loc3_].gold.gold.text = "- " + int(_loc4_);
     }
     function getHasDamaged()
     {
          return this.hasDamaged;
     }
     function getIsSwinging()
     {
          return this.isSwinging;
     }
     function getGIANT_RANGE()
     {
          return this.GIANT_RANGE;
     }
     function isAttacking()
     {
          if(!this.isSwinging)
          {
               return false;
          }
          return this.clip.swing._currentframe <= 122;
     }
     function shouldAttack()
     {
          return true;
     }
     function setAsSuperGiant()
     {
          this.isSuperGiant = true;
          this.health *= 5;
          this.MAX_HEALTH *= 5;
          this.GIANT_RANGE *= 2.1;
          this.baseScale /= 2.1;
     }
}
