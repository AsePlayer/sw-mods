class AiLevel10 extends Ai
{
     function AiLevel10()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
          this.isCreateType = true;
          this.lastCreateTime = 0;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addArcher();
          squad.addMiner();
          squad.addSwordManInQueue();
          squad.addSwordManInQueue();
          this.hasGiant = this.hasGianted = false;
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
