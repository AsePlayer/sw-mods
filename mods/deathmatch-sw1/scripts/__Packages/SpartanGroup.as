class SpartanGroup extends Group
{
     function SpartanGroup(game, squad, stance)
     {
          super();
          this.squad = squad;
          this.game = game;
          this.stance = stance;
          this.men = [];
          this.formation = new Array();
          this.globalActionTime = game.getGameTime();
     }
     function attack(forwardPos)
     {
          var _loc2_ = undefined;
          var _loc12_ = undefined;
          var _loc5_ = undefined;
          var _loc3_ = undefined;
          var _loc13_ = undefined;
          var _loc4_ = undefined;
          for(_loc2_ in this.men)
          {
               _loc13_ = this.men[_loc2_].instance;
               _loc13_.update();
               if(this.men[_loc2_].instance != this.game.getCurrentCharacter())
               {
                    _loc12_ = Infinity;
                    this.men[_loc2_].state = 0;
                    var _loc7_ = this.men[_loc2_].target;
                    if(this.men[_loc2_].target == undefined || !this.men[_loc2_].target.getIsAlive() || this.game.getGameTime() - this.men[_loc2_].targetAquireTime > this.UPDATE_PERIOD)
                    {
                         if(this.men[_loc2_].row <= 4)
                         {
                              if(!this.men[_loc2_].target.getIsAlive() || this.men[_loc2_].target == undefined || !(Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < this.men[_loc2_].instance.getSWORD_MAN_RANGE() && Math.abs(this.men[_loc2_].target.y - this.men[_loc2_].instance.y) < 14))
                              {
                                   this.men[_loc2_].targetRange = Infinity;
                                   this.men[_loc2_].target = undefined;
                                   this.men[_loc2_].state = 0;
                                   for(_loc4_ in this.squad.getOponents())
                                   {
                                        if(!this.squad.getOponents()[_loc4_].getIsGarrisoned())
                                        {
                                             if(this.squad.getOponents()[_loc4_].getIsAlive() && this.closeScore(this.squad.getOponents()[_loc4_],this.men[_loc2_].instance) < this.men[_loc2_].targetRange)
                                             {
                                                  this.men[_loc2_].target = this.squad.getOponents()[_loc4_];
                                                  this.men[_loc2_].targetRange = this.closeScore(this.squad.getOponents()[_loc4_],this.men[_loc2_].instance);
                                                  this.men[_loc2_].state = 1;
                                             }
                                        }
                                   }
                              }
                         }
                         this.men[_loc2_].targetAquireTime = this.game.getGameTime();
                    }
                    if(this.squad.getTeamName() != "blue")
                    {
                         if(_loc7_ == this.men[_loc2_].instance.getSquad().getEnemyTeam().getCastleHitArea() && this.stance == this.ATTACK && Math.abs(this.men[_loc2_].target.getX() - this.men[_loc2_].instance.getX()) > Math.abs(_loc7_._x - this.men[_loc2_].instance.getX()))
                         {
                              this.men[_loc2_].target = _loc7_;
                         }
                    }
                    if((this.men[_loc2_].target == undefined || this.men[_loc2_].target == this.men[_loc2_].instance.getSquad().getEnemyTeam().getCastleHitArea()) && this.stance == this.ATTACK)
                    {
                         this.men[_loc2_].state = 7;
                         this.men[_loc2_].targetRange = 5001;
                         this.men[_loc2_].target = this.men[_loc2_].instance.getSquad().getEnemyTeam().getCastleHitArea();
                    }
                    if(this.men[_loc2_].target != undefined && this.men[_loc2_].state != 7)
                    {
                         this.men[_loc2_].instance.faceDirection((this.men[_loc2_].target.x - this.men[_loc2_].instance.x) / Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x));
                    }
                    if(this.men[_loc2_].state == 7 && Math.abs(this.men[_loc2_].target.x - this.squad.getTeamDirection() * 40 - this.men[_loc2_].instance.getX()) > 10)
                    {
                         var _loc10_ = this.men[_loc2_].target.x - this.squad.getTeamDirection() * 40;
                         var _loc9_ = this.getYOffset(this.men[_loc2_].col,this.formation[this.men[_loc2_].row].length);
                         _loc3_ = int(_loc10_ - this.men[_loc2_].instance.x);
                         _loc5_ = int(_loc9_ - this.men[_loc2_].instance.y);
                         if(_loc3_ == 0)
                         {
                              _loc3_ = 1;
                         }
                         if(this.formation[0][0] == this.men[_loc2_] && (_loc3_ + this.men[_loc2_].instance.getX()) * this.squad.getTeamDirection() > forwardPos * this.squad.getTeamDirection())
                         {
                              _loc3_ = forwardPos - this.men[_loc2_].instance.getX();
                         }
                         var _loc8_ = _loc5_ / Math.abs(_loc5_) * this.men[_loc2_].instance.getMAX_ACCELERATION();
                         if(_loc5_ == 0)
                         {
                              _loc8_ = 0;
                         }
                         if(_loc3_ / Math.abs(_loc3_) == this.squad.getTeamDirection())
                         {
                              this.men[_loc2_].instance.block();
                         }
                         else
                         {
                              this.men[_loc2_].instance.unblock();
                         }
                         if(_loc3_ * _loc3_ + _loc5_ * _loc5_ >= 5)
                         {
                              this.men[_loc2_].instance.walk(_loc3_ / Math.abs(_loc3_) * this.men[_loc2_].instance.getMAX_ACCELERATION(),_loc8_);
                         }
                    }
                    else if(this.stance == this.ATTACK && !this.men[_loc2_].instance.isThrown() && Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < 400 && (Math.abs(this.men[_loc2_].target.y - this.men[_loc2_].instance.y) < 10 || this.men[_loc2_].target.type == -1))
                    {
                         this.men[_loc2_].state = 2;
                         this.men[_loc2_].instance.throwSpear(-7);
                    }
                    else if(Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < this.men[_loc2_].instance.getSPARTAN_RANGE() && Math.abs(this.men[_loc2_].target.y - this.men[_loc2_].instance.y) < 14 || this.men[_loc2_].target.type == -1 && Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x - this.men[_loc2_].instance.getSquad().getTeamDirection() * this.men[_loc2_].target._width / 2) < this.men[_loc2_].instance.getSPARTAN_RANGE())
                    {
                         this.men[_loc2_].state = 2;
                         if(this.men[_loc2_].target == this.men[_loc2_].instance.getSquad().getEnemyTeam().getCastleHitArea())
                         {
                              this.men[_loc2_].instance.faceDirection((this.men[_loc2_].target.x - this.men[_loc2_].instance.x) / Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x));
                         }
                         if((this.men[_loc2_].target.shouldAttack() || this.men[_loc2_].instance.isAttacking() || this.men[_loc2_].target.type == -1) && this.men[_loc2_].instance.thrust(this.men[_loc2_].target))
                         {
                              this.men[_loc2_].state = 0;
                              this.men[_loc2_].target = undefined;
                         }
                         if(this.squad.getTeamDirection() != this.men[_loc2_].instance.getCurrentDirection())
                         {
                              this.men[_loc2_].instance.unblock();
                         }
                         else
                         {
                              this.men[_loc2_].instance.block();
                         }
                    }
                    else
                    {
                         if(this.formation[0][0] != this.men[_loc2_] && _loc12_ > 5000)
                         {
                              var _loc11_ = this.formation[0][0].instance.getX();
                              _loc10_ = _loc11_ + this.men[_loc2_].row * this.FORMATION_Y_OFFSET * -1 * this.squad.getTeamDirection();
                              _loc9_ = this.getYOffset(this.men[_loc2_].col,this.formation[this.men[_loc2_].row].length);
                              _loc3_ = int(_loc10_ - this.men[_loc2_].instance.x);
                              _loc5_ = int(_loc9_ - this.men[_loc2_].instance.y);
                         }
                         else if(this.men[_loc2_].target != undefined)
                         {
                              _loc3_ = int(this.men[_loc2_].target.x - this.men[_loc2_].instance.x);
                              _loc5_ = int(this.men[_loc2_].target.y - this.men[_loc2_].instance.y);
                              if(Math.abs(_loc3_) < 30)
                              {
                                   _loc3_ = 1;
                              }
                         }
                         else
                         {
                              _loc11_ = forwardPos;
                              _loc10_ = _loc11_ + this.men[_loc2_].row * this.FORMATION_Y_OFFSET * -1 * this.squad.getTeamDirection();
                              _loc9_ = this.getYOffset(this.men[_loc2_].col,this.formation[this.men[_loc2_].row].length);
                              _loc3_ = int(_loc10_ - this.men[_loc2_].instance.x);
                              _loc5_ = int(_loc9_ - this.men[_loc2_].instance.y);
                         }
                         if(this.stance == this.DEFEND && _loc3_ == 0 && (this.men[_loc2_].target != undefined && Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < 700))
                         {
                              this.men[_loc2_].instance.block();
                         }
                         else if(this.men[_loc2_].instance.getIsInAction() && this.squad.getTeamDirection() == this.men[_loc2_].instance.getCurrentDirection() || this.men[_loc2_].target != undefined && Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < 100 && this.men[_loc2_].target.getCurrentDirection() != this.men[_loc2_].instance.getCurrentDirection())
                         {
                              this.men[_loc2_].instance.block();
                         }
                         else
                         {
                              this.men[_loc2_].instance.unblock();
                         }
                         if(this.formation[0][0] == this.men[_loc2_] && (_loc3_ + this.men[_loc2_].instance.getX()) * this.squad.getTeamDirection() > forwardPos * this.squad.getTeamDirection())
                         {
                              _loc3_ = forwardPos - this.men[_loc2_].instance.getX();
                         }
                         if(this.men[_loc2_].instance.getSquad().getTeamDirection() * (this.men[_loc2_].instance.getX() + _loc3_) < this.men[_loc2_].instance.getSquad().getTeamDirection() * (this.men[_loc2_].instance.getSquad().getBaseX() + this.men[_loc2_].instance.getSquad().getTeamDirection() * 100))
                         {
                              _loc3_ = this.men[_loc2_].instance.getSquad().getBaseX() + this.men[_loc2_].instance.getSquad().getTeamDirection() * 100 - this.men[_loc2_].instance.getX();
                         }
                         if(_loc5_ == 0)
                         {
                              _loc8_ = 0;
                         }
                         else
                         {
                              _loc8_ = _loc5_ / Math.abs(_loc5_) * this.men[_loc2_].instance.getMAX_ACCELERATION();
                         }
                         if(_loc3_ == 0)
                         {
                              _loc3_ = 1;
                         }
                         var _loc14_ = this.men[_loc2_].target.getX() - this.men[_loc2_].instance.getX();
                         if(_loc3_ * _loc3_ + _loc5_ * _loc5_ >= 60)
                         {
                              this.men[_loc2_].instance.walk(_loc3_ / Math.abs(_loc3_) * this.men[_loc2_].instance.getMAX_ACCELERATION(),_loc8_);
                         }
                    }
               }
          }
     }
}
