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
          var _loc5_ = 0;
          while(_loc5_ < 10)
          {
               squad.addSwordMan();
               _loc5_ += 1;
          }
          this.count = 0;
          _root.soundManager.playBackgroundMusic("fieldOfMemories");
          squad.getCastleHitArea()._x = squad.getCastleHitArea()._x + 1000;
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
