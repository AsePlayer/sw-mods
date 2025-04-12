class BloodManager
{
     var MAX_SPLATTER = 10;
     var MAX_SCREEN_SPLATTER = 10;
     var MAX_BLOOD = 30;
     var BLOOD_BASE_DEPTH = 9000;
     var SPLATTER_BASE_DEPTH = 9500;
     var SCREEN_SPLATTER_BASE_DEPTH = 9000000;
     var NUMBER_OF_BLOODS = 3;
     var NUMBER_OF_SPLATTERS = 5;
     var NUMBER_OF_SCREEN_SPLATTERS = 2;
     function BloodManager(game)
     {
          this.game = game;
          this.bloodIndex = 0;
          this.splatIndex = 0;
          this.screenSplatIndex = 0;
          this.screenSplatArray = [];
     }
     function update()
     {
          for(var _loc3_ in this.screenSplatArray)
          {
               var _loc2_ = this.screenSplatArray[_loc3_];
               if(_loc2_._alpha > 0)
               {
                    _loc2_._alpha -= 2;
               }
               else
               {
                    removeMovieClip(_loc2_);
                    this.screenSplatArray.splice(_loc3_,1);
               }
          }
     }
     function addBlood(x, y, scale, direction)
     {
          this.bloodIndex = (this.bloodIndex + 1) % this.MAX_BLOOD;
          var _loc2_ = "blood_" + this.bloodIndex;
          this.game.screen.attachMovie("blood",_loc2_,this.BLOOD_BASE_DEPTH + this.bloodIndex);
          this.game.screen[_loc2_]._x = x;
          this.game.screen[_loc2_]._y = y;
          this.game.screen[_loc2_].name = _loc2_;
          this.game.screen[_loc2_]._xscale = scale * direction * -1;
          this.game.screen[_loc2_]._yscale = scale;
          this.game.screen[_loc2_].gotoAndStop(int(Math.random() * this.NUMBER_OF_BLOODS) + 1);
          this.game.screen[_loc2_].cacheAsBitmap = true;
          this.bloodArray[this.bloodIndex] = this.game.screen[_loc2_];
     }
     function addDust(x, y, scale, direction)
     {
          this.splatIndex = (this.splatIndex + 1) % this.MAX_SPLATTER;
          var _loc2_ = "splat_" + this.splatIndex;
          if(this.game.screen[_loc2_] != undefined)
          {
               this.game.screen[_loc2_].removeMovieClip();
          }
          this.game.screen.attachMovie("dustsplat",_loc2_,this.game.getManBaseDepth() + y * this.game.getScreenWidth() + x);
          this.game.screen[_loc2_]._x = x;
          this.game.screen[_loc2_]._y = y;
          this.game.screen[_loc2_].name = _loc2_;
          this.game.screen[_loc2_]._xscale = scale * direction;
          this.game.screen[_loc2_]._yscale = scale;
          this.game.screen[_loc2_].gotoAndStop(1);
     }
     function addSplatter(x, y, scale, direction)
     {
          this.splatIndex = (this.splatIndex + 1) % this.MAX_SPLATTER;
          var _loc2_ = "splat_" + this.splatIndex;
          this.game.screen.attachMovie("bloodsplat",_loc2_,this.SPLATTER_BASE_DEPTH + this.splatIndex);
          this.game.screen[_loc2_]._x = x;
          this.game.screen[_loc2_]._y = y;
          this.game.screen[_loc2_].name = _loc2_;
          this.game.screen[_loc2_]._xscale = scale * direction;
          this.game.screen[_loc2_]._yscale = scale;
          this.game.screen[_loc2_].gotoAndStop(int(Math.random() * this.NUMBER_OF_SPLATTERS) + 1);
     }
     function addSpark(x, y, scale, direction)
     {
          this.splatIndex = (this.splatIndex + 1) % this.MAX_SPLATTER;
          var _loc2_ = "splat_" + this.splatIndex;
          this.game.screen.attachMovie("footsteps",_loc2_,this.SPLATTER_BASE_DEPTH + this.splatIndex);
          this.game.screen[_loc2_]._x = x;
          this.game.screen[_loc2_]._y = y;
          this.game.screen[_loc2_].name = _loc2_;
          this.game.screen[_loc2_]._xscale = 0.7 * scale * direction;
          this.game.screen[_loc2_]._yscale = 0.7 * scale;
     }
     function addScreenSplatter(x, y, scale)
     {
          this.screenSplatIndex = (this.screenSplatIndex + 1) % this.MAX_SCREEN_SPLATTER;
          var _loc2_ = "screensplat_" + this.screenSplatIndex;
          this.game.canvas.attachMovie("screensplat",_loc2_,this.SCREEN_SPLATTER_BASE_DEPTH + this.screenSplatIndex);
          this.game.canvas[_loc2_]._x = x;
          this.game.canvas[_loc2_]._y = y;
          this.game.canvas[_loc2_].name = _loc2_;
          this.game.canvas[_loc2_]._xscale *= scale;
          this.game.canvas[_loc2_]._yscale *= scale;
          this.game.canvas[_loc2_].gotoAndStop(int(Math.random() * this.NUMBER_OF_SCREEN_SPLATTERS) + 1);
          this.screenSplatArray.push(this.game.canvas[_loc2_]);
     }
}
