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
          this.playerLastTime = 0;
          this.lastInjectionTime = 0;
          this.spartan = Spartan(squad.addSpartan());
          this.spartan.setAsWoodlandSpearton();
          this.spartan.setX(squad.getCastle()._x - 1050);
          this.spartan.setY(squad.getCastle()._y - 10);
          this.spartan = Spartan(squad.addSpartan());
          this.spartan.setAsWoodlandSpearton();
          this.spartan.setX(squad.getCastle()._x - 1050);
          this.spartan.setY(squad.getCastle()._y - 30);
          this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
          this.spartan.setAsFisherAtreyos();
          this.miner = Miner(squad.getEnemyTeam().addMiner());
          this.miner.setAsLavaMiner();
     }
     function update(game, squad)
     {
          game.finishLevel();
     }
}
