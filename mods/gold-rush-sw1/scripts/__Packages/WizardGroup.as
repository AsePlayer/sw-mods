class WizardGroup extends Group
{
     function WizardGroup(game, squad, stance)
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
          var _loc2_ = undefined;
          var _loc5_ = undefined;
          var _loc6_ = undefined;
          var _loc4_ = undefined;
          var _loc14_ = undefined;
          var _loc3_ = undefined;
          for(_loc2_ in this.men)
          {
               _loc14_ = this.men[_loc2_].instance;
               _loc14_.update();
               if(this.men[_loc2_].instance != this.game.getCurrentCharacter())
               {
                    if(this.men[_loc2_].instance.dx != 0 || this.men[_loc2_].instance.dy != 0)
                    {
                         this.men[_loc2_].instance.clearStatus();
                    }
                    _loc5_ = Infinity;
                    this.men[_loc2_].state = 0;
                    if((!this.men[_loc2_].target || !this.men[_loc2_].target.getIsAlive() || this.men[_loc2_].target.getIsAlive()) && this.game.getGameTime() - this.men[_loc2_].targetAquireTime > this.UPDATE_PERIOD)
                    {
                         if(!this.men[_loc2_].target.getIsAlive() || this.men[_loc2_].target == undefined || !(Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < this.men[_loc2_].instance.getSWORD_MAN_RANGE() && Math.abs(this.men[_loc2_].target.y - this.men[_loc2_].instance.y) < 50))
                         {
                              this.men[_loc2_].targetRange = Infinity;
                              this.men[_loc2_].target = undefined;
                              this.men[_loc2_].state = 0;
                              for(_loc3_ in this.squad.getOponents())
                              {
                                   if(!this.squad.getOponents()[_loc3_].getIsGarrisoned())
                                   {
                                        if(this.squad.getOponents()[_loc3_].getIsAlive() && this.closeScore(this.squad.getOponents()[_loc3_],this.men[_loc2_].instance) < this.men[_loc2_].targetRange)
                                        {
                                             this.men[_loc2_].target = this.squad.getOponents()[_loc3_];
                                             this.men[_loc2_].targetRange = this.closeScore(this.squad.getOponents()[_loc3_],this.men[_loc2_].instance);
                                             this.men[_loc2_].state = 1;
                                        }
                                   }
                              }
                         }
                         this.men[_loc2_].targetAquireTime = this.game.getGameTime();
                    }
                    if(this.men[_loc2_].instance.canAddMinion() && Math.random() < 0.1)
                    {
                         this.men[_loc2_].instance.swordSwing("summon");
                    }
                    else if(this.men[_loc2_].target == undefined && Math.abs(this.squad.getEnemyTeam().getCastleHitArea()._x - this.men[_loc2_].instance.x) < this.men[_loc2_].instance.getWIZARD_RANGE())
                    {
                         this.men[_loc2_].state = 2;
                         var _loc9_ = (this.squad.getEnemyTeam().getCastleHitArea()._x - this.men[_loc2_].instance.x) / Math.abs(this.squad.getEnemyTeam().getCastleHitArea()._x - this.men[_loc2_].instance.x);
                         this.men[_loc2_].instance.faceDirection(_loc9_);
                         if(this.men[_loc2_].instance.getCurrentDirection() == _loc9_)
                         {
                              this.men[_loc2_].instance.swordSwing();
                         }
                    }
                    else if(Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < this.men[_loc2_].instance.getWIZARD_RANGE() && Math.abs(this.men[_loc2_].target.y - this.men[_loc2_].instance.y) < 100)
                    {
                         this.men[_loc2_].state = 2;
                         _loc9_ = (this.squad.getEnemyTeam().getCastleHitArea()._x - this.men[_loc2_].instance.x) / Math.abs(this.squad.getEnemyTeam().getCastleHitArea()._x - this.men[_loc2_].instance.x);
                         this.men[_loc2_].instance.faceDirection(_loc9_);
                         if(this.men[_loc2_].instance.getCurrentDirection() == _loc9_)
                         {
                              this.men[_loc2_].instance.swordSwing();
                         }
                    }
                    else
                    {
                         if(this.formation[0][0] == this.men[_loc2_])
                         {
                              var _loc7_ = this.squad.getForwardMan(1).getX();
                              if(_loc7_ == undefined)
                              {
                                   _loc5_ = Infinity;
                                   var _loc8_ = undefined;
                                   for(_loc3_ in this.squad.getOponents())
                                   {
                                        if(this.squad.getOponents()[_loc3_].getIsAlive() && Math.abs(this.squad.getOponents()[_loc3_].x - this.men[_loc2_].instance.x) < _loc5_)
                                        {
                                             _loc5_ = Math.abs(this.squad.getOponents()[_loc3_].x - this.men[_loc2_].instance.x);
                                             _loc8_ = _loc3_;
                                        }
                                   }
                                   _loc7_ = forwardPos;
                                   if(_loc5_ != Infinity)
                                   {
                                        _loc7_ = this.squad.getOponents()[_loc8_].getX() - (this.men[_loc2_].instance.getWIZARD_RANGE() - 100) * this.squad.getTeamDirection();
                                   }
                              }
                              var _loc13_ = _loc7_ - this.squad.getTeamDirection() * 100;
                              var _loc12_ = _loc13_ + this.men[_loc2_].row * this.FORMATION_Y_OFFSET * -1 * this.squad.getTeamDirection();
                              var _loc11_ = this.getYOffset(this.men[_loc2_].col,this.formation[this.men[_loc2_].row].length);
                              _loc4_ = int(_loc12_ - this.men[_loc2_].instance.x);
                              _loc6_ = int(_loc11_ - this.men[_loc2_].instance.y);
                         }
                         else
                         {
                              _loc13_ = this.formation[0][0].instance.getX();
                              _loc12_ = _loc13_ + this.men[_loc2_].row * this.FORMATION_Y_OFFSET * -1 * this.squad.getTeamDirection();
                              _loc11_ = this.getYOffset(this.men[_loc2_].col,this.formation[this.men[_loc2_].row].length);
                              _loc4_ = int(_loc12_ - this.men[_loc2_].instance.x);
                              _loc6_ = int(_loc11_ - this.men[_loc2_].instance.y);
                         }
                         if(_loc4_ == 0)
                         {
                              _loc4_ = 1;
                         }
                         var _loc10_ = _loc6_ / Math.abs(_loc6_) * this.men[_loc2_].instance.getMAX_ACCELERATION();
                         if(_loc6_ == 0)
                         {
                              _loc10_ = 0;
                         }
                         if(this.men[_loc2_].instance.getSquad().getTeamDirection() * (this.men[_loc2_].instance.getX() + _loc4_) < this.men[_loc2_].instance.getSquad().getTeamDirection() * (this.men[_loc2_].instance.getSquad().getBaseX() + this.men[_loc2_].instance.getSquad().getTeamDirection() * 100))
                         {
                              _loc4_ = this.men[_loc2_].instance.getSquad().getBaseX() + this.men[_loc2_].instance.getSquad().getTeamDirection() * 100 - this.men[_loc2_].instance.getX();
                         }
                         if(_loc4_ * _loc4_ + _loc6_ * _loc6_ >= 100)
                         {
                              this.men[_loc2_].instance.walk(_loc4_ / Math.abs(_loc4_) * this.men[_loc2_].instance.getMAX_ACCELERATION(),_loc10_);
                         }
                         else if(this.men[_loc2_].instance.getSpeed() == 0)
                         {
                              this.men[_loc2_].instance.faceDirection(this.squad.getTeamDirection());
                         }
                    }
               }
          }
     }
}
