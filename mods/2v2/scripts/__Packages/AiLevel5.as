class AiLevel5 extends Ai
{
     function AiLevel5()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
          this.generalSpawnable = true;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          this.spartan = Spartan(squad.addSpartan());
          this.spartan.setAsGoldenSpearton();
          _root.soundManager.playBackgroundMusic("victoryHorns");
     }
     function update(game, squad)
     {
          this.createMiners(squad,5);
          if(game.getGameTime() - this.lastTime > 30000)
          {
               squad.addSpartanInQueue();
               squad.addSpartanInQueue();
               if(squad.getMenFromGroup(2).length < 2)
               {
                    squad.addArcherInQueue();
                    squad.addArcherInQueue();
               }
               this.newBuildPercent = Math.random() * 0.75;
               this.lastTime = game.getGameTime();
          }
          if(this.lastStand)
          {
               squad.setMode(this.ATTACK);
          }
          else if(!this.garrisionIfLosing(squad))
          {
               if(game.getGameTime() < 60000)
               {
                    squad.setMode(this.DEFEND);
                    this.isJustAttack = true;
               }
               else if(this.getSquadMilitary(squad) < this.getSquadMilitary(squad.getEnemyTeam()) * this.newBuildPercent)
               {
                    squad.setMode(this.DEFEND);
                    if(this.isJustAttack)
                    {
                         this.isJustAttack = false;
                         this.newBuildPercent = 0.25 + Math.random() * 0.75;
                    }
               }
               else
               {
                    this.isJustAttack = true;
                    squad.setMode(this.ATTACK);
               }
          }
          if(game.getGameTime() - this.lastInjectionTime > 60000 && squad.getMenFromGroup(6).length < 3)
          {
               if(this.getSquadMilitary(squad) < 3)
               {
                    if(squad.getMenFromGroup(2).length < 2)
                    {
                         squad.addArcherInQueue();
                    }
                    squad.addSpartan();
               }
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 2)
          {
               var _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsGoldenSpearton();
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsGoldenSpearton();
                    squad.addSpartan();
                    squad.addArcher();
                    squad.addArcher();
                    _loc5_ += 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
          if(game.getGameTime() > 50000)
          {
               if(this.generalSpawnable)
               {
                    this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
                    this.spartan.setAsGlacialSpearos();
                    this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
                    this.spartan.setAsGoldenSpearton();
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsFisherAtreyos();
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsGoldenSpearton();
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsGoldenSpearton();
                    this.archer = Archer(squad.addArcher());
                    this.archer.setAsKytchu();
                    this.generalSpawnable = false;
               }
          }
          _root.HUD.wizardButton._visible = true;
          _root.HUD.spartanButton._visible = true;
     }
}
