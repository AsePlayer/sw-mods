class AiLevel9 extends Ai
{
     function AiLevel9()
     {
          super();
          this.lastTime = 0;
          this.lastStand = false;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastGiantTime = 0;
          squad.addGiant();
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
