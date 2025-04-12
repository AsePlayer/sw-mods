class GoldMineManager
{
     var AMOUNT_IN_MINE = 1600;
     var MINE_RANDOMNES = 300;
     function GoldMineManager(game)
     {
          this.game = game;
          this.mines = [];
          this.mineIndex = 0;
          this.mineBaseDepth = 5000;
          this.MAX_MINES = 11;
          this.MINE_DISTANCE = 40;
     }
     function addCloseMines()
     {
          var _loc2_ = 150 + Math.random() * 30;
          var _loc3_ = this.game.getTOP() + Math.random() * (this.game.getBOTTOM() - this.game.getTOP());
          this.addMine(_loc2_,_loc3_,this.AMOUNT_IN_MINE + this.MINE_RANDOMNES * Math.random());
          this.addMine(_loc2_ + 300,_loc3_,this.AMOUNT_IN_MINE + this.MINE_RANDOMNES * Math.random());
          _loc2_ = this.game.getRIGHT() - 150 - Math.random() * 30;
          _loc3_ = this.game.getTOP() + Math.random() * (this.game.getBOTTOM() - this.game.getTOP());
          this.addMine(_loc2_,_loc3_,this.AMOUNT_IN_MINE + this.MINE_RANDOMNES * Math.random());
          this.addMine(_loc2_ - 300,_loc3_,this.AMOUNT_IN_MINE + this.MINE_RANDOMNES * Math.random());
          this.addMine(_loc2_,_loc3_,this.AMOUNT_IN_MINE + this.MINE_RANDOMNES * Math.random());
          this.addMine(_loc2_ - 300,_loc3_,this.AMOUNT_IN_MINE + this.MINE_RANDOMNES * Math.random());
     }
     function addMiddleMine()
     {
          var _loc2_ = (this.game.getRIGHT() - this.game.getLEFT()) / 2 - 100 + 200 * Math.random();
          var _loc3_ = this.game.getTOP() + Math.random() * (this.game.getBOTTOM() - this.game.getTOP());
          this.addMine(_loc2_,_loc3_,this.AMOUNT_IN_MINE + this.MINE_RANDOMNES * Math.random());
     }
     function addMine(x, y, amount)
     {
          this.mineIndex %= this.MAX_MINES;
          var _loc5_ = "mine_" + this.mineIndex;
          this.game.screen.attachMovie("gold",_loc5_,this.mineBaseDepth + this.mineIndex);
          this.game.screen[_loc5_]._x = x;
          this.game.screen[_loc5_]._y = y;
          this.game.screen[_loc5_]._alpha = 0;
          this.game.screen[_loc5_].name = _loc5_;
          this.game.screen[_loc5_].cacheAsBitmap = true;
          this.game.screen[_loc5_].swapDepths(this.game.getManBaseDepth() + this.game.screen[_loc5_]._y * this.game.getScreenWidth() + this.game.screen[_loc5_]._x);
          this.mines.push({clip:this.game.screen[_loc5_],goldRemaining:amount});
          this.mineIndex++;
     }
     function update()
     {
          var _loc2_ = undefined;
          var _loc3_ = undefined;
          for(_loc2_ in this.mines)
          {
               if(this.mines[_loc2_].goldRemaining <= 0)
               {
                    removeMovieClip(this.mines[_loc2_].clip);
                    this.mines.splice(_loc2_,1);
                    this.addMiddleMine();
               }
               else if(this.mines[_loc2_].clip._alpha <= 100)
               {
                    this.mines[_loc2_].clip._alpha += 5;
               }
               _loc3_ = this.AMOUNT_IN_MINE / 2 + this.mines[_loc2_].goldRemaining / this.AMOUNT_IN_MINE * this.AMOUNT_IN_MINE / 2;
               this.mines[_loc2_].clip._yscale = _loc3_ / this.AMOUNT_IN_MINE * 100;
               this.mines[_loc2_].clip._xscale = _loc3_ / this.AMOUNT_IN_MINE * 100;
          }
     }
     function distance(a, b)
     {
          return (a._x - b._x) * (a._x - b._x) + Math.abs((a._y - b._y) * (a._y - b._y));
     }
     function getClosestMine(man)
     {
          var _loc3_ = undefined;
          var _loc4_ = undefined;
          var _loc5_ = undefined;
          var _loc6_ = 9999999;
          for(_loc3_ in this.mines)
          {
               _loc4_ = this.distance(man.getClip(),this.mines[_loc3_].clip);
               if(_loc4_ < _loc6_)
               {
                    _loc6_ = _loc4_;
                    _loc5_ = this.mines[_loc3_];
               }
          }
          return _loc5_;
     }
     function closeToMine(man)
     {
          var _loc3_ = undefined;
          for(_loc3_ in this.mines)
          {
               if(Math.abs(man.getClip()._x - this.mines[_loc3_].clip._x) < this.MINE_DISTANCE && Math.abs(man.getClip()._y - this.mines[_loc3_].clip._y) < 20)
               {
                    return this.mines[_loc3_];
               }
          }
          return undefined;
     }
     function getMINE_DISTANCE()
     {
          return this.MINE_DISTANCE;
     }
}
