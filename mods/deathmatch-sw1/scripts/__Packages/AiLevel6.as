class AiLevel6 extends Ai
{
     function AiLevel6()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = Math.random() * 0.75;
          this.lastStand = false;
          this.hasInitial = false;
          this.messageState = 0;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          _root.soundManager.playBackgroundMusic("Entering_the_Stronghold");
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
