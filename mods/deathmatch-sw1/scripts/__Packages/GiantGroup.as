class GiantGroup extends Group
{
     function GiantGroup(game, squad, stance)
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
          var _loc15_ = undefined;
          var _loc6_ = undefined;
          var _loc4_ = undefined;
          var _loc13_ = undefined;
          var _loc5_ = undefined;
          for(_loc3_ in this.men)
          {
               _loc13_ = this.men[_loc3_].instance;
               _loc13_.update();
               if(this.men[_loc3_].instance != this.game.getCurrentCharacter())
               {
                    if(this.men[_loc3_].instance.dx != 0 || this.men[_loc3_].instance.dy != 0)
                    {
                         this.men[_loc3_].instance.clearStatus();
                    }
                    if(!this.men[_loc3_].target || !this.men[_loc3_].target.getIsAlive() || this.game.getGameTime() - this.men[_loc3_].targetAquireTime > this.UPDATE_PERIOD)
                    {
                         if(!this.men[_loc3_].target.getIsAlive() || this.men[_loc3_].target == undefined || !(Math.abs(this.men[_loc3_].target.x - this.men[_loc3_].instance.x) < this.men[_loc3_].instance.getGIANT_RANGE() && Math.abs(this.men[_loc3_].target.y - this.men[_loc3_].instance.y) < 10))
                         {
                              this.men[_loc3_].targetRange = Infinity;
                              this.men[_loc3_].target = undefined;
                              this.men[_loc3_].state = 0;
                              for(_loc5_ in this.squad.getOponents())
                              {
                                   if(!this.squad.getOponents()[_loc5_].getIsGarrisoned())
                                   {
                                        if(this.squad.getOponents()[_loc5_].getIsAlive() && this.closeScore(this.squad.getOponents()[_loc5_],this.men[_loc3_].instance) < this.men[_loc3_].targetRange)
                                        {
                                             this.men[_loc3_].target = this.squad.getOponents()[_loc5_];
                                             this.men[_loc3_].targetRange = this.closeScore(this.squad.getOponents()[_loc5_],this.men[_loc3_].instance);
                                             this.men[_loc3_].state = 1;
                                        }
                                   }
                              }
                         }
                         this.men[_loc3_].targetAquireTime = this.game.getGameTime();
                    }
                    if(!(_root.campaignData.getLevel() == 12 && this.squad.getTeamName() == "blue"))
                    {
                         if(!this.men[_loc3_].instance.isAttacking() && (this.squad.getTeamDirection() * this.men[_loc3_].target.getX() - this.men[_loc3_].instance.getX() > this.squad.getTeamDirection() * 50 || Math.random() < 0.9))
                         {
                              this.men[_loc3_].state = 1;
                              this.men[_loc3_].targetRange = 5001;
                              this.men[_loc3_].target = this.men[_loc3_].instance.getSquad().getEnemyTeam().getCastleHitArea();
                         }
                    }
                    if(this.men[_loc3_].target == undefined)
                    {
                         this.men[_loc3_].state = 1;
                         this.men[_loc3_].targetRange = 5001;
                         this.men[_loc3_].target = this.men[_loc3_].instance.getSquad().getEnemyTeam().getCastleHitArea();
                    }
                    if(this.men[_loc3_].instance.isAttacking() == false && this.men[_loc3_].target != undefined && Math.abs(this.men[_loc3_].target.getX() - this.men[_loc3_].instance.getX()) < 60)
                    {
                    }
                    if(this.men[_loc3_].target != undefined && Math.abs(this.men[_loc3_].target.x - this.men[_loc3_].instance.x) < this.men[_loc3_].instance.getGIANT_RANGE() && Math.abs(this.men[_loc3_].target.y - this.men[_loc3_].instance.y) < 14 || Math.abs(this.men[_loc3_].target.x - this.men[_loc3_].instance.x - this.men[_loc3_].instance.getSquad().getTeamDirection() * this.men[_loc3_].target._width / 2) < this.men[_loc3_].instance.getGIANT_RANGE())
                    {
                         this.men[_loc3_].state = 2;
                         if(this.men[_loc3_].target.isAttacking() && int(Math.random() * 10) == 1)
                         {
                              this.men[_loc3_].instance.block();
                         }
                         var _loc8_ = (this.men[_loc3_].target.x - this.men[_loc3_].instance.x) / Math.abs(this.men[_loc3_].target.x - this.men[_loc3_].instance.x);
                         this.men[_loc3_].instance.faceDirection(_loc8_);
                         if(this.men[_loc3_].instance.getCurrentDirection() == _loc8_ && this.men[_loc3_].instance.swordSwing(this.men[_loc3_].target))
                         {
                              this.men[_loc3_].state = 0;
                              this.men[_loc3_].target = undefined;
                              this.men[_loc3_].instance.clearStatus();
                         }
                    }
                    else
                    {
                         var _loc12_ = undefined;
                         _loc12_ = this.formation[0][0].instance.getX();
                         if(this.formation[0][0] != this.men[_loc3_] && this.men[_loc3_].targetRange > 5000)
                         {
                              var _loc11_ = _loc12_ + this.men[_loc3_].row * 50 * -1 * this.squad.getTeamDirection();
                              var _loc10_ = this.game.getTOP() + this.FORMATION_Y_OFFSET / this.formation[this.men[_loc3_].row].length * this.men[_loc3_].col;
                              _loc4_ = int(_loc11_ - this.men[_loc3_].instance.x);
                              _loc6_ = int(_loc10_ - this.men[_loc3_].instance.y);
                         }
                         else
                         {
                              var _loc9_ = _root.campaignData.getLevel() == 12 && this.squad.getTeamName() == "blue";
                              if(this.men[_loc3_].target != undefined && _loc9_ || (Math.abs(this.men[_loc3_].target.x - this.men[_loc3_].instance.x) < this.men[_loc3_].instance.getGIANT_RANGE() && Math.abs(this.men[_loc3_].target.y - this.men[_loc3_].instance.y) < 10 || this.men[_loc3_].target == this.men[_loc3_].instance.getSquad().getEnemyTeam().getCastleHitArea()))
                              {
                                   _loc4_ = int(this.men[_loc3_].target.x - this.men[_loc3_].instance.x);
                                   _loc6_ = int(this.men[_loc3_].target.y - this.men[_loc3_].instance.y);
                                   if(Math.abs(_loc4_) < 30)
                                   {
                                        _loc4_ = 1;
                                   }
                              }
                              else
                              {
                                   _loc4_ = 0;
                                   _loc10_ = this.game.getTOP() + this.FORMATION_Y_OFFSET / this.formation[this.men[_loc3_].row].length * this.men[_loc3_].col;
                                   _loc6_ = int(_loc10_ - this.men[_loc3_].instance.y);
                              }
                         }
                         if(_loc4_ == 0)
                         {
                              _loc4_ = 1;
                         }
                         if((_loc4_ + this.men[_loc3_].instance.getX()) * this.squad.getTeamDirection() > forwardPos * this.squad.getTeamDirection())
                         {
                              _loc4_ = forwardPos - this.men[_loc3_].instance.getX();
                         }
                         if(this.men[_loc3_].instance.getSquad().getTeamDirection() * (this.men[_loc3_].instance.getX() + _loc4_) < this.men[_loc3_].instance.getSquad().getTeamDirection() * (this.men[_loc3_].instance.getSquad().getBaseX() + this.men[_loc3_].instance.getSquad().getTeamDirection() * 100))
                         {
                              _loc4_ = this.men[_loc3_].instance.getSquad().getBaseX() + this.men[_loc3_].instance.getSquad().getTeamDirection() * 100 - this.men[_loc3_].instance.getX();
                         }
                         var _loc7_ = _loc6_ / Math.abs(_loc6_) * this.men[_loc3_].instance.getMAX_ACCELERATION();
                         if(_loc6_ == 0)
                         {
                              _loc7_ = 0;
                         }
                         if(_loc4_ / Math.abs(_loc4_) != this.squad.getTeamDirection())
                         {
                              _loc4_ = this.squad.getTeamDirection() * 100;
                         }
                         if(_loc4_ * _loc4_ + _loc6_ * _loc6_ >= 40)
                         {
                              this.men[_loc3_].instance.walk(_loc4_ / Math.abs(_loc4_) * this.men[_loc3_].instance.getMAX_ACCELERATION(),_loc7_);
                         }
                    }
               }
          }
     }
}
