class AiLevel7 extends Ai
{
     function AiLevel7()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = Math.random() * 0.75;
          this.lastStand = false;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addSwordMan();
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
