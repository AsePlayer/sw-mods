class AiLevel2 extends Ai
{
     var isDone = false;
     var finalPos = 195;
     var setTime = 120000;
     var startPos = 120;
     function AiLevel2()
     {
          super();
          this.messageState = 0;
     }
     function init(game, squad)
     {
          this.isDone = false;
          this.lastTime = 0;
          game.background.sun._y = this.startPos;
          var _loc5_ = 0;
          while(_loc5_ < 5)
          {
               squad.addSpartan();
               _loc5_ += 1;
          }
          this.count = 0;
          _root.soundManager.playBackgroundMusic("Entering_the_Stronghold");
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
          while(this.count < 4 && this.getSquadMilitary(squad) < 8)
          {
               squad.addSwordMan();
               squad.addArcher();
               this.count++;
          }
          if(squad.getNumberLiving() == 0 && game.getGameTime() > this.setTime)
          {
               game.finishLevel();
          }
     }
}
