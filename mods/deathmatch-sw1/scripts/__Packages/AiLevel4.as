class AiLevel4 extends Ai
{
     function AiLevel4()
     {
          super();
     }
     function AiLevel4()
     {
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
     }
     function init(game, squad)
     {
          this.lastTime = -20000;
          this.lastStand = false;
          this.waveAvalible = true;
          this.wave2Avalible = true;
          this.wave3Avalible = true;
          this.wave4Avalible = true;
          this.playerLastStand = false;
          this.messageState = 8;
          this.lastInjectionTime = 0;
          squad.addSpartan();
          squad.addSwordManInQueue();
     }
     function update(game, squad)
     {
          if(this.messageState == 8 && game.getGameTime() > 5000)
          {
               _root.attachMovie("tips3","tips",10000000);
               this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
               this.spartan.setAsPrince();
               squad.getEnemyTeam().addSpartan();
               this.messageState = 9;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 9 && game.getGameTime() > 10000)
          {
               _root.tips.removeMovieClip();
          }
          this.createMiners(squad,5);
          if(game.getGameTime() - this.lastTime > 20000)
          {
               if(this.getSquadMilitary(squad) == 1)
               {
                    squad.addSpartanInQueue();
               }
               else if(this.getSquadMilitary(squad) == 2)
               {
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsElite();
               }
               else if(this.getSquadMilitary(squad) == 3)
               {
                    squad.addArcherInQueue();
               }
               else if(this.getSquadMilitary(squad) == 4)
               {
                    squad.addWizardInQueue();
               }
               else if(this.getSquadMilitary(squad) == 5)
               {
                    squad.addArcherInQueue();
                    squad.addSpartan();
               }
               else if(this.getSquadMilitary(squad) == 6)
               {
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsElite();
               }
               else if(this.getSquadMilitary(squad) == 7)
               {
                    squad.addSwordMan();
               }
               else if(this.getSquadMilitary(squad) == 8)
               {
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsElite();
               }
               else if(this.getSquadMilitary(squad) == 9)
               {
                    squad.addGiantInQueue();
               }
               else if(this.getSquadMilitary(squad) == 10)
               {
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsElite();
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsElite();
                    squad.addArcher();
               }
               this.newBuildPercent = 0.5 + Math.random() * 0.5;
               this.lastTime = game.getGameTime();
          }
          if(this.getSquadMilitary(squad) <= 0.2 * this.getSquadMilitary(squad.getEnemyTeam()) && this.getNumMiners(squad) >= 3)
          {
          }
          if(this.lastStand)
          {
               squad.setMode(this.ATTACK);
          }
          else if(game.getGameTime() < 20000)
          {
               squad.setMode(this.DEFEND);
          }
          else if(!this.garrisionIfLosing(squad))
          {
               if(game.getGameTime() < 60)
               {
                    squad.setMode(this.ATTACK);
                    this.isJustAttack = true;
               }
               else if(this.getSquadMilitary(squad) < this.getSquadMilitary(squad.getEnemyTeam()) * this.newBuildPercent)
               {
                    squad.setMode(this.DEFEND);
                    if(this.isJustAttack)
                    {
                         this.isJustAttack = false;
                         this.newBuildPercent = 0.5 + Math.random() * 0.5;
                    }
               }
               else
               {
                    this.isJustAttack = true;
                    squad.setMode(this.ATTACK);
               }
          }
          if(game.getGameTime() - this.lastInjectionTime > 120000)
          {
               var _loc5_ = 0;
               while(_loc5_ < 3)
               {
                    _loc5_ += 1;
               }
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 2)
          {
               _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsElite();
                    this.spartan = Spartan(squad.addSpartan());
                    this.spartan.setAsElite();
                    squad.addArcher();
                    squad.addGiant();
                    this.wizard = Wizard(squad.addWizard());
                    this.wizard.setAsElite();
                    _loc5_ += 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
          _root.HUD.wizardButton._visible = true;
          _root.HUD.giantButton._visible = true;
          _root.HUD.spartanButton._visible = false;
          _root.HUD.archerButton._visible = true;
          if(!this.playerLastStand && squad.enemyTeam.getCastleHealth() < squad.enemyTeam.getTechnology().getCastleHealth() / 2)
          {
               _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    squad.getEnemyTeam().addMiner();
                    squad.getEnemyTeam().addMiner();
                    squad.getEnemyTeam().addSwordMan();
                    squad.getEnemyTeam().addArcher();
                    squad.getEnemyTeam().addGiant();
                    squad.getEnemyTeam().addWizard();
                    squad.getEnemyTeam().addSwordMan();
                    _loc5_ += 1;
               }
               this.playerLastStand = true;
          }
     }
}
