class Group
{
     var UPDATE_PERIOD = 1000;
     var GARRISON = 1;
     var DEFEND = 2;
     var ATTACK = 3;
     var FORMATION_Y_OFFSET = 50;
     function Group(game, squad, stance)
     {
          this.squad = squad;
          this.game = game;
          this.stance = stance;
          this.men = [];
          this.formation = new Array();
     }
     function update(forwardPos)
     {
          if(this.stance == this.GARRISON)
          {
               this.garrison();
          }
          else if(this.stance == this.DEFEND)
          {
               this.attack(forwardPos + 100 * this.squad.getTeamDirection());
          }
          else if(this.stance == this.ATTACK)
          {
               if(this.squad.getTeamDirection() == 1)
               {
                    this.attack(this.game.getScreenWidth());
               }
               else
               {
                    this.attack(0);
               }
          }
     }
     function garrison()
     {
          for(var _loc9_ in this.men)
          {
               if(this.game.getCurrentCharacter() == this.men[_loc9_].instance)
               {
                    this.men[_loc9_].instance.update();
               }
               else
               {
                    var _loc2_ = this.men[_loc9_].instance;
                    var _loc7_ = undefined;
                    var _loc8_ = undefined;
                    var _loc3_ = undefined;
                    var _loc4_ = 0;
                    var _loc6_ = 0;
                    var _loc5_ = 0;
                    if(!_loc2_.getIsQueued() && !_loc2_.getIsGarrisoned())
                    {
                         _loc7_ = this.squad.getBaseX() + 50 * this.squad.getTeamDirection();
                         _loc3_ = int(_loc7_ - _loc2_.getX());
                         if(Math.abs(_loc3_) < 50)
                         {
                              this.squad.addToGarrisonQueue(_loc2_);
                         }
                    }
                    else if(_loc2_.getIsGarrisoned())
                    {
                         _loc7_ = this.squad.getBaseX() - 60 * this.squad.getTeamDirection();
                         _loc8_ = (this.game.getTOP() + this.game.getBOTTOM()) / 2;
                         _loc3_ = int(_loc7_ - _loc2_.getX());
                         _loc4_ = int(_loc8_ - _loc2_.getY());
                    }
                    _loc6_ = _loc5_ = 0;
                    if(_loc3_ != 0)
                    {
                         _loc6_ = _loc3_ / Math.abs(_loc3_) * _loc2_.getMAX_ACCELERATION();
                    }
                    if(_loc4_ != 0)
                    {
                         _loc5_ = _loc4_ / Math.abs(_loc4_) * _loc2_.getMAX_ACCELERATION();
                    }
                    _loc2_.clearStatus();
                    _loc2_.faceDirection((this.squad.getBaseX() - _loc2_.getX()) / Math.abs(this.squad.getBaseX() - _loc2_.getX()));
                    if(Math.abs(this.squad.getBaseX() - 60 * this.squad.getTeamDirection() - _loc2_.getX()) < 10)
                    {
                         _loc2_.heal();
                         _loc2_.clearStatus();
                         _loc2_.setDx(0);
                         _loc2_.setDy(0);
                    }
                    else if(Math.abs(_loc3_) > 10)
                    {
                         _loc2_.walk(_loc6_,_loc5_);
                    }
                    _loc2_.update();
               }
          }
     }
     function attack(forwardPos)
     {
     }
     function closeScore(a, b)
     {
          return Math.pow(a.getX() - b.getX(),2) + Math.pow(a.getY() - b.getY(),2);
     }
     function addMan(man)
     {
          this.men.push(man);
     }
     function addToFormation(man)
     {
          var _loc2_ = this.formation.length - 1;
          if(this.formation[_loc2_].length >= 5)
          {
               var _loc4_ = new Array();
               this.formation.push(_loc4_);
               _loc2_ = _loc2_ + 1;
          }
          this.formation[_loc2_].push(man);
          man.row = _loc2_;
          man.col = this.formation[_loc2_].length - 1;
          man.formation = this.formation;
     }
     function filterDown(line, deletedIndex)
     {
          if(line < this.formation.length - 1)
          {
               if(deletedIndex > this.formation[line + 1].length - 1)
               {
                    deletedIndex = this.formation[line + 1].length - 1;
               }
               var _loc6_ = this.formation[line + 1].splice(deletedIndex,1)[0];
               var _loc4_ = [];
               for(var _loc7_ in this.formation[line])
               {
                    if(_loc7_ == deletedIndex)
                    {
                         _loc4_.push(_loc6_);
                    }
                    _loc4_.push(this.formation[line]);
               }
               this.formation[line] = _loc4_;
               this.filterDown(line + 1,deletedIndex);
          }
          line = 0;
          while(line < this.formation.length)
          {
               var _loc3_ = 0;
               while(_loc3_ < this.formation[line].length)
               {
                    this.formation[line][_loc3_].row = line;
                    this.formation[line][_loc3_].col = _loc3_;
                    _loc3_ = _loc3_ + 1;
               }
               line = line + 1;
          }
     }
     function removeFromFormation(man)
     {
          var _loc4_ = undefined;
          var _loc2_ = man.formation;
          _loc2_[man.row].splice(man.col,1);
          this.filterDown(man.row,man.col);
          if(_loc2_[_loc2_.length - 1].length == 0)
          {
               _loc2_.pop();
          }
     }
     function removeManFromFormation(man, simUnits)
     {
          var _loc2_ = undefined;
          for(_loc2_ in simUnits)
          {
               if(simUnits[_loc2_].instance == man)
               {
                    this.removeFromFormation(simUnits[_loc2_]);
               }
          }
     }
     function setStance(stance)
     {
          this.stance = stance;
     }
     function getStance()
     {
          return this.stance;
     }
     function getMen()
     {
          return this.men;
     }
     function getFormation()
     {
          return this.formation;
     }
     function getYOffset(position, partners)
     {
          var _loc2_ = (this.game.getBOTTOM() - this.game.getTOP()) / (partners + 1);
          return this.game.getTOP() + (position + 1) * _loc2_;
     }
     function getIfIsForward(num, man)
     {
          if(num * this.squad.getTeamDirection() > man.getX() * this.squad.getTeamDirection())
          {
               return num;
          }
          return man.getX();
     }
}
