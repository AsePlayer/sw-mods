class CastleArcherGroup
{
     var VOLLEY_INTERVAL = 500;
     var GARRISON = 1;
     var DEFEND = 2;
     var ATTACK = 3;
     var ARCHER_RATIO = 3;
     function CastleArcherGroup(game, squad)
     {
          this.squad = squad;
          this.game = game;
          this.numberArchers = Math.ceil(20 / this.ARCHER_RATIO);
          this.lastVolleyTime = game.getGameTime();
          squad.getTower().archer.prep.stop();
          this.archers = [];
          this.targets = [];
          var _loc2_ = 0;
          while(_loc2_ < this.numberArchers)
          {
               this.createMan(_loc2_);
               _loc2_ = _loc2_ + 1;
          }
     }
     function createMan(i)
     {
          var _loc2_ = new Archer(this.squad.getBaseX() - 50 * this.squad.getTeamDirection(),this.game.getTOP(),this.squad,this.archers,this.game);
          _loc2_.update();
          this.archers.push(_loc2_);
          _loc2_.setIsGarrisoned(true);
          this.targets[_loc2_] = undefined;
          if(this.squad.getTeamName() == "red")
          {
               var _loc3_ = undefined;
               _loc3_ = new Color(_loc2_.getClip());
               _loc3_.setTint(100,0,0,60);
          }
          _loc2_.arrowType = this.squad.getTechnology().getCastleArcherNumber();
     }
     function update()
     {
          var _loc7_ = Math.ceil(this.squad.getNumberGarrisoned() / this.ARCHER_RATIO);
          var _loc6_ = (this.game.getBOTTOM() - this.game.getTOP()) / (_loc7_ + 1);
          var _loc2_ = 0;
          while(_loc2_ < Math.ceil(20 / this.ARCHER_RATIO))
          {
               if(_loc2_ < _loc7_)
               {
                    var _loc5_ = this.game.getTOP() + _loc2_ * _loc6_;
                    var _loc3_ = this.squad.getTower()._x + (65 - _loc2_ * 2) * this.squad.getTeamDirection();
                    if(Math.abs(_loc3_ - this.archers[_loc2_].getX()) > 20)
                    {
                         this.archers[_loc2_].walk(_loc3_ - this.archers[_loc2_].getX(),_loc5_ - this.archers[_loc2_].getY());
                    }
                    else
                    {
                         this.archers[_loc2_].faceDirection(this.squad.getTeamDirection());
                         if(this.archers[_loc2_].getDx() == 0)
                         {
                              if(!this.shootIfCan(this.archers[_loc2_]))
                              {
                                   if(Math.abs(_loc5_ - this.archers[_loc2_].getY()) > 5)
                                   {
                                        this.archers[_loc2_].walk(0,_loc5_ - this.archers[_loc2_].getY());
                                   }
                              }
                         }
                    }
               }
               else
               {
                    _loc5_ = this.game.getTOP() + _loc2_ * _loc6_;
                    _loc3_ = this.squad.getTower()._x - 100 * this.squad.getTeamDirection();
                    if(this.archers[_loc2_].isAttacking())
                    {
                         this.archers[_loc2_].shootFail();
                    }
                    if(Math.abs(_loc3_ - this.archers[_loc2_].getX()) > 20)
                    {
                         this.archers[_loc2_].walk(_loc3_ - this.archers[_loc2_].getX(),_loc5_ - this.archers[_loc2_].getY());
                    }
                    else
                    {
                         this.archers[_loc2_].faceDirection(this.squad.getTeamDirection());
                    }
               }
               _loc2_ = _loc2_ + 1;
          }
          _loc2_ = 0;
          while(_loc2_ < Math.ceil(20 / this.ARCHER_RATIO))
          {
               var _loc4_ = this.archers[_loc2_];
               _loc4_.update();
               _loc2_ = _loc2_ + 1;
          }
     }
     function shootIfCan(archer)
     {
          var _loc3_ = this.targets[archer];
          if(_loc3_ != undefined && _loc3_.getIsAlive() && Math.abs(_loc3_.getX() - archer.getX()) < archer.getARCHER_RANGE())
          {
               archer.shootAtTarget(_loc3_.getClip(),false,_loc3_.getDx());
               return true;
          }
          var _loc4_ = this.findNextTarget(archer);
          if(_loc4_ != undefined)
          {
               if(Math.abs(_loc4_.getX() - archer.getX()) < archer.getARCHER_RANGE())
               {
                    archer.shootAtTarget(_loc4_.getClip(),false,_loc4_.getDx());
                    this.targets[archer] = _loc4_;
                    return true;
               }
          }
          this.targets[archer] = undefined;
          return false;
     }
     function findNextTarget(archer)
     {
          var _loc2_ = Infinity;
          var _loc4_ = undefined;
          for(var _loc5_ in this.squad.getOponents())
          {
               if(!this.squad.getOponents()[_loc5_].getIsGarrisoned())
               {
                    if(this.squad.getOponents()[_loc5_].getIsAlive() && this.closeScore(this.squad.getOponents()[_loc5_],archer) < _loc2_)
                    {
                         _loc4_ = this.squad.getOponents()[_loc5_];
                         _loc2_ = this.closeScore(this.squad.getOponents()[_loc5_],archer);
                    }
               }
          }
          return _loc4_;
     }
     function closeScore(a, b)
     {
          return Math.pow(a.getX() - b.getX(),2) + Math.pow(a.getY() - b.getY(),4);
     }
     function getMen()
     {
          return this.archers;
     }
}
