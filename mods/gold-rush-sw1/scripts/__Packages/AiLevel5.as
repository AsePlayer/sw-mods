class AiLevel5 extends Ai
{
     var isDone = false;
     var finalPos = 195;
     var setTime = 120000;
     var startPos = 120;
     function AiLevel5()
     {
          super();
          this.messageState = 0;
     }
     function init(game, squad)
     {
          this.isDone = false;
          this.lastTime = 0;
          game.background.sun._y = this.startPos;
          var _loc3_ = 0;
          while(_loc3_ < 8)
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
          if(this.messageState == 0 && game.getGameTime() > 3000)
          {
               _root.attachMovie("tips5","tips",10000000);
               this.messageState = 1;
          }
          else if(this.messageState == 1 && game.getGameTime() > 11000)
          {
               this.messageState = 2;
               _root.tips.removeMovieClip();
          }
          game.background.sun._y = game.getGameTime() / this.setTime * (this.finalPos - this.startPos) + this.startPos;
          if(!this.isDone && game.getGameTime() > this.setTime)
          {
               this.isDone = true;
          }
          if(game.getGameTime() > this.setTime)
          {
               squad.setMode(this.ATTACK);
          }
          while(this.count < 15 && this.getSquadMilitary(squad) < 8)
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
