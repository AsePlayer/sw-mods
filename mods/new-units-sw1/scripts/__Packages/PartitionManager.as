class PartitionManager
{
     var PARTITION_SIZE = 35;
     function PartitionManager(game)
     {
          this.game = game;
          this.allIndex = {blue:{},red:{}};
          var _loc2_ = undefined;
          this.allPartitions = {blue:[],red:[]};
          _loc2_ = 0;
          while(_loc2_ < game.getRIGHT())
          {
               this.allPartitions.blue.push([]);
               this.allPartitions.red.push([]);
               _loc2_ += this.PARTITION_SIZE;
          }
     }
     function remove(man)
     {
          var _loc3_ = this.allPartitions[man.getSquad().getTeamName()];
          var _loc5_ = this.allIndex[man.getSquad().getTeamName()];
          var _loc2_ = man.getName();
          var _loc4_ = _loc5_[_loc2_];
          var _loc7_ = _loc4_ - 1;
          var _loc6_ = _loc4_ + 1;
          this.getEnemyTeam();
          delete _loc3_[_loc4_][_loc2_];
          if(_loc7_ >= 0)
          {
               delete _loc3_[_loc7_][_loc2_];
          }
          if(_loc6_ < _loc3_.length)
          {
               delete _loc3_[_loc6_][_loc2_];
          }
          delete _loc5_[_loc2_];
     }
     function add(man)
     {
          var _loc5_ = this.allPartitions[man.getSquad().getTeamName()];
          var _loc8_ = this.allIndex[man.getSquad().getTeamName()];
          var _loc3_ = man.getName();
          var _loc4_ = int(man.getClip()._x / this.PARTITION_SIZE);
          var _loc7_ = _loc4_ - 1;
          var _loc6_ = _loc4_ + 1;
          if(_loc7_ >= 0)
          {
               _loc5_[_loc7_][_loc3_] = man;
          }
          _loc5_[_loc4_][_loc3_] = man;
          if(_loc6_ < _loc5_.length)
          {
               _loc5_[_loc6_][_loc3_] = man;
          }
          _loc8_[_loc3_] = _loc4_;
     }
     function update(man)
     {
          var _loc5_ = this.allPartitions[man.getSquad().getTeamName()];
          var _loc4_ = this.allIndex[man.getSquad().getTeamName()];
          var _loc3_ = man.getName();
          this.remove(man);
          this.add(man);
     }
     function getTeamAround(x, teamName, menArray)
     {
          var _loc3_ = this.allPartitions[teamName];
          var _loc9_ = this.allIndex[teamName];
          var _loc4_ = int(x / this.PARTITION_SIZE);
          var _loc7_ = _loc4_ - 1;
          var _loc6_ = _loc4_ + 1;
          var _loc2_ = undefined;
          if(_loc7_ >= 0)
          {
               for(_loc2_ in _loc3_[_loc7_])
               {
                    menArray[_loc2_] = _loc3_[_loc7_][_loc2_];
               }
          }
          for(_loc2_ in _loc3_[_loc4_])
          {
               for(_loc2_ in _loc3_[_loc4_])
               {
                    menArray[_loc2_] = _loc3_[_loc4_][_loc2_];
               }
          }
          if(_loc6_ < _loc3_.length)
          {
               for(_loc2_ in _loc3_[_loc6_])
               {
                    menArray[_loc2_] = _loc3_[_loc6_][_loc2_];
               }
          }
     }
     function getEnemyTeam(man, x)
     {
          var _loc2_ = [];
          if(man.getSquad().getTeamName() == "blue")
          {
               this.getTeamAround(x,"red",_loc2_);
          }
          else
          {
               this.getTeamAround(x,"blue",_loc2_);
          }
          return _loc2_;
     }
     function getLabeledTeam(team, x)
     {
          var _loc2_ = [];
          if(team == "blue")
          {
               this.getTeamAround(x,"red",_loc2_);
          }
          else
          {
               this.getTeamAround(x,"blue",_loc2_);
          }
          return _loc2_;
     }
     function getMenAround(x)
     {
          var _loc2_ = [];
          this.getTeamAround(x,"blue",_loc2_);
          this.getTeamAround(x,"red",_loc2_);
          return _loc2_;
     }
}
