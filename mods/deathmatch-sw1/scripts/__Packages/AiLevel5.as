class AiLevel5 extends Ai
{
     var isDone = false;
     var finalPos = 250;
     var setTime = 120000;
     var startPos = 0;
     function AiLevel5()
     {
          super();
          this.messageState = 0;
     }
     function init(game, squad)
     {
          this.isDone = false;
          this.Wave1Avalible = true;
          this.Wave2Avalible = true;
          this.Wave3Avalible = true;
          this.Wave4Avalible = true;
          this.playerLastStand = false;
          this.lastTime = 0;
          game.background.sun._y = this.startPos;
          var _loc4_ = 0;
          while(_loc4_ < 1)
          {
               squad.getEnemyTeam().addMiner();
               squad.getEnemyTeam().addMiner();
               squad.addSpartan();
               _loc4_ += 1;
          }
          this.waveNum = 0;
          squad.getCastleHitArea()._x = squad.getCastleHitArea()._x + 1000;
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
