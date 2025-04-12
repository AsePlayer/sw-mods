class MinerGroup extends Group
{
     function MinerGroup(game, squad, stance)
     {
          super();
          this.squad = squad;
          this.game = game;
          this.stance = stance;
          this.men = [];
          this.formation = new Array();
     }
     function attack(forwardPos)
     {
          var _loc3_ = undefined;
          var _loc6_ = undefined;
          var _loc5_ = undefined;
          var _loc4_ = undefined;
          var _loc2_ = undefined;
          for(_loc3_ in this.men)
          {
               _loc2_ = this.men[_loc3_].instance;
               _loc2_.update();
               if(_loc2_ == this.game.getCurrentCharacter() && !_loc2_.getIsMining())
               {
                    _loc2_.clearStatus();
               }
               if(_loc2_ != this.game.getCurrentCharacter())
               {
                    _loc6_ = this.game.getMineHolder().getClosestMine(_loc2_);
                    if(_loc6_ == undefined || _loc2_.isGoldFull())
                    {
                         _loc2_.stopMining();
                         this.men[_loc3_].state = 1;
                    }
                    else
                    {
                         this.men[_loc3_].state = 0;
                    }
                    if(this.men[_loc3_].state == 0)
                    {
                         _loc5_ = _loc6_.clip._y - _loc2_.getClip()._y;
                         _loc4_ = _loc6_.clip._x - _loc2_.getClip()._x - this.squad.getTeamDirection() * 30;
                         if(_loc3_ >= this.men.length / 2)
                         {
                              _loc4_ = _loc6_.clip._x - _loc2_.getClip()._x + this.squad.getTeamDirection() * 30;
                         }
                         if(_loc4_ == 0)
                         {
                              _loc4_ = 1;
                         }
                         if(_loc5_ == 0)
                         {
                              _loc5_ = 1;
                         }
                         if(Math.abs(_loc5_) >= 10 || Math.abs(_loc4_) >= 10)
                         {
                              _loc2_.walk(_loc4_ / Math.abs(_loc4_) * _loc2_.getMAX_ACCELERATION(),_loc5_ / Math.abs(_loc5_) * _loc2_.getMAX_ACCELERATION() / 1.5);
                              _loc2_.stopMining();
                         }
                         else
                         {
                              _loc2_.startMining();
                              if(this.game.getGameTime() - this.men[_loc3_].lastStateChange > 500)
                              {
                                   _loc2_.hit();
                                   this.men[_loc3_].lastStateChange = this.game.getGameTime();
                              }
                         }
                    }
                    else if(_loc2_.hasGold())
                    {
                         _loc2_.walk((- (_loc2_.getX() - this.squad.getBaseX() + 100 * this.squad.getTeamDirection())) / Math.abs(_loc2_.getX() - this.squad.getBaseX() + 100 * this.squad.getTeamDirection()) * _loc2_.getMAX_ACCELERATION(),0);
                    }
                    else
                    {
                         this.men[_loc3_].state = 0;
                    }
               }
          }
     }
}
