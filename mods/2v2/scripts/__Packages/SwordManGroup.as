class SwordManGroup extends Group
{
     function SwordManGroup(game, squad, stance)
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
          var _loc15_ = undefined;
          var _loc6_ = undefined;
          var _loc3_ = undefined;
          var _loc9_ = undefined;
          var _loc4_ = undefined;
          for(_loc2_ in this.men)
          {
               _loc9_ = this.men[_loc2_].instance;
               _loc9_.update();
               if(this.men[_loc2_].instance != this.game.getCurrentCharacter())
               {
                    if(this.men[_loc2_].instance.dx != 0 || this.men[_loc2_].instance.dy != 0)
                    {
                         this.men[_loc2_].instance.clearStatus();
                    }
                    var _loc8_ = this.men[_loc2_].target;
                    if(!this.men[_loc2_].target || !this.men[_loc2_].target.getIsAlive() || this.game.getGameTime() - this.men[_loc2_].targetAquireTime > this.UPDATE_PERIOD)
                    {
                         if(this.men[_loc2_].row <= 4)
                         {
                              if(this.game.getGameTime() - this.men[_loc2_].targetAquireTime > this.UPDATE_PERIOD || !this.men[_loc2_].target.getIsAlive() || this.men[_loc2_].target == undefined || !(Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < this.men[_loc2_].instance.getSWORD_MAN_RANGE() && Math.abs(this.men[_loc2_].target.y - this.men[_loc2_].instance.y) < 14))
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
                         if(_loc8_ == this.men[_loc2_].instance.getSquad().getEnemyTeam().getCastleHitArea() && this.stance == this.ATTACK && Math.abs(this.men[_loc2_].target.getX() - this.men[_loc2_].instance.getX()) > Math.abs(_loc8_._x - this.men[_loc2_].instance.getX()))
                         {
                              this.men[_loc2_].target = _loc8_;
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
                         var _loc14_ = this.men[_loc2_].target.x - this.squad.getTeamDirection() * 40;
                         var _loc13_ = this.getYOffset(this.men[_loc2_].col,this.formation[this.men[_loc2_].row].length);
                         _loc3_ = int(_loc14_ - this.men[_loc2_].instance.x);
                         _loc6_ = int(_loc13_ - this.men[_loc2_].instance.y);
                         if(_loc3_ == 0)
                         {
                              _loc3_ = 1;
                         }
                         if(this.formation[0][0] == this.men[_loc2_] && (_loc3_ + this.men[_loc2_].instance.getX()) * this.squad.getTeamDirection() > forwardPos * this.squad.getTeamDirection())
                         {
                              _loc3_ = forwardPos - this.men[_loc2_].instance.getX();
                         }
                         var _loc11_ = _loc6_ / Math.abs(_loc6_) * this.men[_loc2_].instance.getMAX_ACCELERATION();
                         if(_loc6_ == 0)
                         {
                              _loc11_ = 0;
                         }
                         if(_loc3_ * _loc3_ + _loc6_ * _loc6_ >= 5)
                         {
                              this.men[_loc2_].instance.walk(_loc3_ / Math.abs(_loc3_) * this.men[_loc2_].instance.getMAX_ACCELERATION(),_loc11_);
                         }
                    }
                    else if(Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < this.men[_loc2_].instance.getSWORD_MAN_RANGE() && Math.abs(this.men[_loc2_].target.y - this.men[_loc2_].instance.y) < 14 || this.men[_loc2_].target.type == -1 && Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x - this.men[_loc2_].instance.getSquad().getTeamDirection() * this.men[_loc2_].target._width / 2) < this.men[_loc2_].instance.getSWORD_MAN_RANGE())
                    {
                         this.men[_loc2_].state = 2;
                         if(!this.men[_loc2_].target.getIsAlive() && !this.men[_loc2_].instance.getSquad().getEnemyTeam().getCastleHitArea() == this.men[_loc2_].target)
                         {
                              trace("SWORDMAN ATTACKS DEAD PEOPLE");
                         }
                         var _loc12_ = (this.men[_loc2_].target.x - this.men[_loc2_].instance.x) / Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x);
                         this.men[_loc2_].instance.faceDirection(_loc12_);
                         if(this.men[_loc2_].instance.getCurrentDirection() == _loc12_ && this.men[_loc2_].instance.swordSwing(this.men[_loc2_].target))
                         {
                              this.men[_loc2_].state = 0;
                              this.men[_loc2_].target = undefined;
                              this.men[_loc2_].instance.clearStatus();
                         }
                    }
                    else
                    {
                         var _loc5_ = undefined;
                         if(this.formation[0][0] == this.men[_loc2_])
                         {
                              if(this.squad.getSpartanFormation().length > 0)
                              {
                                   if(this.stance == this.ATTACK)
                                   {
                                        _loc5_ = this.getIfIsForward(this.squad.getSpartanFormation()[this.squad.getSpartanFormation().length - 1][0].instance.getX() - this.FORMATION_Y_OFFSET * this.squad.getTeamDirection(),this.men[_loc2_].instance);
                                   }
                                   else
                                   {
                                        _loc5_ = this.squad.getSpartanFormation()[this.squad.getSpartanFormation().length - 1][0].instance.getX() - this.FORMATION_Y_OFFSET * this.squad.getTeamDirection();
                                   }
                              }
                              else
                              {
                                   _loc5_ = forwardPos;
                              }
                              if(_loc5_ == undefined || isNaN(_loc5_))
                              {
                                   _loc5_ = forwardPos;
                              }
                         }
                         else
                         {
                              _loc5_ = this.formation[0][0].instance.getX();
                         }
                         if((this.formation[0][0] != this.men[_loc2_] || this.squad.getSpartanFormation().length != 0) && Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) > 160 / ((this.men[_loc2_].row + 1) * (this.men[_loc2_].row + 1) * (this.men[_loc2_].row + 1)))
                         {
                              _loc14_ = _loc5_ + this.men[_loc2_].row * this.FORMATION_Y_OFFSET * -1 * this.squad.getTeamDirection();
                              _loc13_ = this.getYOffset(this.men[_loc2_].col,this.formation[this.men[_loc2_].row].length);
                              _loc3_ = int(_loc14_ - this.men[_loc2_].instance.x);
                              _loc6_ = int(_loc13_ - this.men[_loc2_].instance.y);
                         }
                         else if(this.men[_loc2_].target != undefined)
                         {
                              _loc3_ = int(this.men[_loc2_].target.x - this.men[_loc2_].instance.x);
                              _loc6_ = int(this.men[_loc2_].target.y - this.men[_loc2_].instance.y);
                              if(Math.abs(_loc3_) < 10)
                              {
                                   _loc3_ = 1;
                              }
                         }
                         else
                         {
                              _loc14_ = _loc5_ + this.men[_loc2_].row * this.FORMATION_Y_OFFSET * -1 * this.squad.getTeamDirection();
                              _loc13_ = this.getYOffset(this.men[_loc2_].col,this.formation[this.men[_loc2_].row].length);
                              _loc3_ = int(_loc14_ - this.men[_loc2_].instance.x);
                              _loc6_ = int(_loc13_ - this.men[_loc2_].instance.y);
                         }
                         if(!(this.stance == this.DEFEND && Math.abs(this.men[_loc2_].target.x - this.men[_loc2_].instance.x) < 120))
                         {
                              if(this.stance == this.DEFEND && (_loc3_ + this.men[_loc2_].instance.getX()) * this.squad.getTeamDirection() > forwardPos * this.squad.getTeamDirection())
                              {
                                   _loc3_ = forwardPos - this.men[_loc2_].instance.getX();
                                   this.men[_loc2_].clearStatus();
                              }
                         }
                         if(_loc3_ * _loc3_ + _loc6_ * _loc6_ < 40 && this.stance == this.DEFEND && (_loc9_.getIsInAction() || this.game.getGameTime() - this.globalActionTime < 2000))
                         {
                              this.men[_loc2_].instance.block();
                              if(_loc9_.getIsInAction())
                              {
                                   this.globalActionTime = this.game.getGameTime();
                              }
                         }
                         if(_loc3_ == 0)
                         {
                              _loc3_ = 1;
                         }
                         if(this.formation[0][0] == this.men[_loc2_] && (_loc3_ + this.men[_loc2_].instance.getX()) * this.squad.getTeamDirection() > forwardPos * this.squad.getTeamDirection())
                         {
                         }
                         _loc11_ = _loc6_ / Math.abs(_loc6_) * this.men[_loc2_].instance.getMAX_ACCELERATION();
                         if(_loc6_ == 0)
                         {
                              _loc11_ = 0;
                         }
                         var _loc10_ = this.men[_loc2_].target.getX() - this.men[_loc2_].instance.getX();
                         if(!(this.men[_loc2_].target != undefined && _loc10_ / Math.abs(_loc10_) != this.squad.getTeamDirection()))
                         {
                              if(this.stance == this.ATTACK && _loc3_ / Math.abs(_loc3_) != this.squad.getTeamDirection())
                              {
                                   _loc3_ = 1;
                                   this.men[_loc2_].instance.block();
                              }
                         }
                         if(_loc3_ * _loc3_ + _loc6_ * _loc6_ >= 40)
                         {
                              this.men[_loc2_].instance.walk(_loc3_ / Math.abs(_loc3_) * this.men[_loc2_].instance.getMAX_ACCELERATION(),_loc11_);
                         }
                    }
               }
          }
     }
}
