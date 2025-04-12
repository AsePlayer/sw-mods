class AiLevel8 extends Ai
{
     function AiLevel8()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addSpartan();
          _root.soundManager.playBackgroundMusic("Entering_the_Stronghold");
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
