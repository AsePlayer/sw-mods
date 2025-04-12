class AiLevel1 extends Ai
{
     var startPos = 135;
     function AiLevel1()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
          this.isCreateType = true;
          this.playerLastStand = false;
          this.lastCreateTime = 0;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addArcher();
          squad.getEnemyTeam().addArcher();
          squad.getEnemyTeam().addMiner();
          this.wizard = Wizard(squad.getEnemyTeam().addWizard());
          this.wizard.setAsGlacialWizard();
          this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
          this.swordman.setAsGlacialSword();
          this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
          this.swordman.setAsGlacialSword();
          this.wizard = Wizard(squad.addWizard());
          this.wizard.setAsGrandWizard();
          this.miner = Miner(squad.getEnemyTeam().addMiner());
          this.miner.setAsGlacialMiner();
          squad.addMiner();
          squad.addMiner();
          squad.addSwordManInQueue();
          squad.addSwordManInQueue();
          squad.addSwordManInQueue();
          squad.addSpartan();
          this.hasGiant = this.hasGianted = false;
          _root.soundManager.playBackgroundMusic("victoryHorns");
     }
     function update(game, squad)
     {
          if(!this.hasGianted && squad.getCastleHealth() == 0)
          {
               squad.getCastle().giantStatue.play();
               this.hasGianted = true;
          }
          !this.hasGiant && this.hasGianted && squad.getCastle();
     }
}
