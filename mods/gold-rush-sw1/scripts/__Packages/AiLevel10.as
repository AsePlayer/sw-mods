class AiLevel10 extends Ai
{
     var isDone = false;
     var finalPos = 250;
     var setTime = 120000;
     var startPos = 120;
     function AiLevel10()
     {
          super();
     }
     function init(game, squad)
     {
          this.isDone = false;
          this.lastTime = 0;
          game.background.sun._y = this.startPos;
          squad.addGiant();
          var _loc3_ = 0;
          while(_loc3_ < 10)
          {
               squad.addSwordMan();
               _loc3_ = _loc3_ + 1;
          }
          this.count = 0;
          _root.soundManager.playBackgroundMusic("fieldOfMemories");
          squad.getCastleHitArea()._x = squad.getCastleHitArea()._x + 1000;
     }
     function update(game, squad)
     {
          game.background.sun._y = game.getGameTime() / this.setTime * (this.finalPos - this.startPos) + this.startPos;
          if(!this.isDone && game.getGameTime() > this.setTime)
          {
               this.isDone = true;
          }
          if(game.getGameTime() > this.setTime)
          {
               squad.setMode(this.ATTACK);
          }
          while(this.count < 30 && this.getSquadMilitary(squad) < 10)
          {
               squad.addSwordMan();
               this.count = this.count + 1;
          }
          if(squad.getNumberLiving() == 0 && game.getGameTime() > this.setTime)
          {
               game.finishLevel();
          }
     }
}
