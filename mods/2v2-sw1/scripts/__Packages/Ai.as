class Ai
{
     var GARRISON = 1;
     var DEFEND = 2;
     var ATTACK = 3;
     function Ai()
     {
     }
     function init(game, squad)
     {
     }
     function update(game, squad)
     {
     }
     function createMiners(squad, numMiners)
     {
          if(squad.getQueueSize() == 0 && squad.getMenFromGroup(1).length < numMiners)
          {
               squad.addMinerInQueue();
          }
     }
     function getNumMiners(squad)
     {
          return squad.getMenFromGroup(1).length;
     }
     function getSquadMilitary(squad)
     {
          return squad.getNumberLiving() - this.getNumMiners(squad);
     }
     function garrisionIfLosing(squad)
     {
          var _loc4_ = squad.getEnemyTeam().getForwardMan(-1).getX();
          var _loc3_ = false;
          if(_loc4_ != undefined && Math.abs(_loc4_ - squad.getCastle()._x) < 180)
          {
               _loc3_ = true;
          }
          if(this.getSquadMilitary(squad) == 0 && this.getSquadMilitary(squad.getEnemyTeam()) != 0 && squad.getEnemyTeam().getMode() == this.ATTACK && Math.abs(_loc4_ - squad.getCastle()._x) < 1000)
          {
               _loc3_ = true;
               squad.setMode(this.GARRISON);
               return true;
          }
          if(squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 3)
          {
               _loc3_ = false;
          }
          if(this.getSquadMilitary(squad) < this.getSquadMilitary(squad.getEnemyTeam()) / 3 && _loc3_)
          {
               squad.setMode(this.GARRISON);
               return true;
          }
          return false;
     }
}
