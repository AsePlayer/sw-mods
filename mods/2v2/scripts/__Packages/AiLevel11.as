class AiLevel11 extends Ai
{
     function AiLevel11()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
          this.isCreateType = true;
          this.lastCreateTime = 0;
          _root.soundManager.playBackgroundMusic("Entering_the_Stronghold");
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addArcher();
          squad.addSwordManInQueue();
          squad.addMiner();
          squad.addSwordManInQueue();
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
