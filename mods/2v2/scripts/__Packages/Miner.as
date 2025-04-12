class Miner extends Man
{
     var type = 1;
     var MAX_VELOCITY = 1.6;
     var MAX_HEALTH = 100;
     var GOLD_HIT_INC = 20;
     var MAX_GOLD = 100;
     var MINING_WAIT = 2000;
     function Miner(x, y, squad, simUnits, game)
     {
          super();
          this.x = x;
          this.y = y;
          this.isPostMine = false;
          this.dy = this.dx = 0;
          this.squad = squad;
          this.game = game;
          this.simUnits = simUnits;
          this.isMining = false;
          this.gold = 0;
          this.currentMine = undefined;
          this.lastKeyPress = game.getGameTime();
          this.lastMineHit = game.getGameTime();
          this.unitType = "miner";
          this.initMovieClip("miner");
          this.yOffset = 2;
          this.MAX_GOLD = this.compound(100,0.2,squad.getTechnology().getMinerBag() - 1);
          this.GOLD_HIT_INC = this.compound(10,0.2,squad.getTechnology().getMinerPickaxe() - 1);
          this.MAX_HEALTH = squad.getTechnology().getMinerHealth();
          this.health = this.MAX_HEALTH;
          this.miningTime = game.getGameTime();
          this.isGlacialMiner = false;
          this.isLavaMiner = false;
     }
     function update()
     {
          super.update();
          if(this.isGlacialMiner)
          {
               this.clip.bag = 5;
               this.clip.weapon = 10;
          }
          else if(this.isLavaMiner)
          {
               this.clip.bag = 6;
               this.clip.weapon = 11;
          }
          else
          {
               this.clip.weapon = this.squad.getTechnology().getMinerPickaxe() * 2;
               this.clip.bag = this.squad.getTechnology().getMinerBag();
          }
          if(this.game.getCurrentCharacter() == this)
          {
               this.clip.bar._visible = true;
               this.clip.bar.barFill._xscale = 100 * this.gold / this.MAX_GOLD;
               if(this.currentDirection == -1)
               {
               }
          }
          else
          {
               this.clip.bar._visible = false;
          }
          if(!this.isAlive)
          {
               this.clip.gotoAndStop("death");
          }
          else if(this.isMining)
          {
               this.mine();
               this.clip.gotoAndStop("mine");
               this.faceDirection((this.currentMine.clip._x - this.x) / Math.abs(this.currentMine.clip._x - this.x));
               if(this.clip.mining._currentframe == 20)
               {
                    this.addGold();
               }
               if(this.isPostMine && this.game.getGameTime() - this.miningTime > this.MINING_WAIT)
               {
                    this.isMining = false;
               }
               if(this.clip.mining._currentframe == 43)
               {
                    this.miningTime = this.game.getGameTime();
                    this.clip.mining.gotoAndStop(1);
                    this.isPostMine = true;
               }
          }
          else if(this.dx != 0 || this.dy != 0)
          {
               this.clip.gotoAndStop("walk");
               this.faceDirection(this.dx / Math.abs(this.dx));
               this.isMining = false;
          }
          else
          {
               this.clip.gotoAndStop("stand");
          }
          if(Math.abs(this.x - this.squad.getBaseX()) < 100)
          {
               this.squad.minerGiveGold(this.dropOffGold());
          }
     }
     function mine()
     {
          this.currentMine = this.game.getMineHolder().closeToMine(this);
          this.dx = this.dy = 0;
     }
     function addGold()
     {
          if(this.gold + this.GOLD_HIT_INC * this.controlMultiply() <= this.MAX_GOLD)
          {
               this.currentMine.goldRemaining -= this.GOLD_HIT_INC * this.controlMultiply();
               this.gold += this.GOLD_HIT_INC * this.controlMultiply();
               return true;
          }
          if(this.gold + this.GOLD_HIT_INC * this.controlMultiply() > this.MAX_GOLD)
          {
               this.currentMine.goldRemaining -= this.MAX_GOLD - this.gold;
               this.gold = this.MAX_GOLD;
               return true;
          }
          return false;
     }
     function hit()
     {
          if(this.gold + this.GOLD_HIT_INC <= this.MAX_GOLD)
          {
               return true;
          }
          if(this.gold + this.GOLD_HIT_INC > this.MAX_GOLD)
          {
               return true;
          }
          return false;
     }
     function startMining()
     {
          var _loc2_ = this.game.getMineHolder().closeToMine(this);
          if(_loc2_)
          {
               this.isPostMine = false;
               this.isMining = true;
               this.clip.mining.play();
          }
     }
     function stopMining()
     {
          this.isMining = false;
     }
     function keyInterface()
     {
          if(Key.isDown(32) && (this.isMining == false || this.isPostMine) && this.game.getGameTime() - this.lastKeyPress > 500)
          {
               this.startMining();
               this.lastKeyPress = this.game.getGameTime();
          }
          if(this.isMining == false)
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
          else
          {
               if(this.currentMine && this.gold < this.MAX_GOLD && this.game.getGameTime() - this.lastKeyPress > 200)
               {
                    if(Key.isDown(32))
                    {
                         this.hit();
                         this.lastKeyPress = this.game.getGameTime();
                    }
               }
               if(!Key.isDown(32))
               {
                    this.lastKeyPress = this.game.getGameTime() - 10000;
               }
               if(Key.isDown(this.game.getKey("LEFT")) || Key.isDown(this.game.getKey("ARROW_LEFT")))
               {
                    this.stopMining();
               }
               if(Key.isDown(this.game.getKey("RIGHT")) || Key.isDown(this.game.getKey("ARROW_RIGHT")))
               {
                    this.stopMining();
               }
               if(Key.isDown(this.game.getKey("UP")) || Key.isDown(this.game.getKey("ARROW_UP")))
               {
                    this.stopMining();
               }
               if(Key.isDown(this.game.getKey("DOWN")) || Key.isDown(this.game.getKey("ARROW_DOWN")))
               {
                    this.stopMining();
               }
          }
     }
     function clearStatus()
     {
          this.isMining = false;
     }
     function dropOffGold()
     {
          var _loc2_ = this.gold;
          this.gold = 0;
          return _loc2_;
     }
     function isGoldFull()
     {
          return this.gold >= this.MAX_GOLD;
     }
     function hasGold()
     {
          return this.gold > 0;
     }
     function getIsMining()
     {
          return this.isMining;
     }
     function isAttacking()
     {
          return false;
     }
     function shouldAttack()
     {
          return true;
     }
     function setAsGlacialMiner()
     {
          this.MAX_GOLD = 125;
          this.baseScale *= 0.9;
          this.MAX_HEALTH *= 1.5;
          this.health *= 1.5;
          this.isGlacialMiner = true;
     }
     function setAsLavaMiner()
     {
          this.MAX_GOLD = 125;
          this.baseScale *= 0.9;
          this.MAX_HEALTH *= 1.75;
          this.health *= 1.75;
          this.isLavaMiner = true;
     }
}
