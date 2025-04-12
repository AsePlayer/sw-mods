class AiLevel2 extends Ai
{
     function AiLevel2()
     {
          super();
     }
     function AiLevel2()
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
          this.messageState = 6;
          this.lastInjectionTime = 0;
          squad.addSpartan();
          this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
          this.spartan.setAsSpecialIce();
          _root.soundManager.playBackgroundMusic("victoryHorns");
     }
     function update(game, squad)
     {
          if(this.messageState == 6 && game.getGameTime() > 175000)
          {
               _root.attachMovie("tips3","tips",10000000);
               this.messageState = 7;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 7 && game.getGameTime() > 180000)
          {
               this.messageState = 8;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 8 && game.getGameTime() > 185000)
          {
               _root.tips.removeMovieClip();
          }
          this.createMiners(squad,3);
          if(game.getGameTime() - this.lastTime > 20000)
          {
               if(this.getSquadMilitary(squad) == 1)
               {
                    squad.addSpartanInQueue();
               }
               else if(this.getSquadMilitary(squad) == 2)
               {
                    squad.addSpartan();
               }
               else if(this.getSquadMilitary(squad) == 3)
               {
                    squad.addSwordMan();
               }
               else if(this.getSquadMilitary(squad) == 4)
               {
                    squad.addWizard();
               }
               else if(this.getSquadMilitary(squad) == 5)
               {
                    squad.addArcherInQueue();
                    squad.addSpartan();
               }
               else if(this.getSquadMilitary(squad) == 6)
               {
                    squad.addSwordMan();
               }
               else if(this.getSquadMilitary(squad) == 7)
               {
                    squad.addSpartanInQueue();
               }
               else if(this.getSquadMilitary(squad) == 8)
               {
                    squad.addSwordMan();
               }
               else if(this.getSquadMilitary(squad) == 9)
               {
                    squad.addWizardInQueue();
               }
               else if(this.getSquadMilitary(squad) == 10)
               {
                    squad.addSwordMan();
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
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 3)
          {
               _loc5_ = 0;
               while(_loc5_ < 2)
               {
                    squad.addSpartan();
                    _loc5_ += 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
          if(game.getGameTime() > 10000)
          {
               if(this.waveAvalible)
               {
                    squad.addGiant();
                    this.waveAvalible = false;
               }
          }
          if(game.getGameTime() > 45000)
          {
               if(this.wave2Avalible)
               {
                    squad.addGiant();
                    this.giant = Giant(squad.addGiant());
                    this.giant.setX(squad.getCastle()._x - 900);
                    this.giant.setY(squad.getCastle()._y - 10);
                    this.wave2Avalible = false;
               }
          }
          if(game.getGameTime() > 120000)
          {
               if(this.wave3Avalible)
               {
                    this.giant = Giant(squad.addGiant());
                    this.giant.setX(squad.getCastle()._x - 900);
                    this.giant.setY(squad.getCastle()._y - 10);
                    this.giant = Giant(squad.addGiant());
                    this.giant.setX(squad.getCastle()._x - 900);
                    this.giant.setY(squad.getCastle()._y - 20);
                    this.wave3Avalible = false;
               }
          }
          if(game.getGameTime() > 180000)
          {
               if(this.wave4Avalible)
               {
                    this.giant = Giant(squad.addGiant());
                    this.giant.setX(squad.getCastle()._x - 900);
                    this.giant.setY(squad.getCastle()._y - 10);
                    this.giant = Giant(squad.addGiant());
                    this.giant.setX(squad.getCastle()._x - 900);
                    this.giant.setY(squad.getCastle()._y - 20);
                    this.giant = Giant(squad.addGiant());
                    this.giant.setAsXXLGiant();
                    squad.addWizard();
                    squad.addGiant();
                    this.isJustAttack = true;
                    this.wave4Avalible = false;
               }
          }
          _root.HUD.wizardButton._visible = true;
          _root.HUD.giantButton._visible = false;
          _root.HUD.spartanButton._visible = true;
          _root.HUD.archerButton._visible = true;
          if(!this.playerLastStand && squad.enemyTeam.getCastleHealth() < squad.enemyTeam.getTechnology().getCastleHealth() / 3)
          {
               _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    squad.getEnemyTeam().addMiner();
                    squad.getEnemyTeam().addMiner();
                    squad.getEnemyTeam().addSpartan();
                    squad.getEnemyTeam().addSpartan();
                    squad.getEnemyTeam().addSwordMan();
                    squad.getEnemyTeam().addSwordMan();
                    _loc5_ += 1;
               }
               this.playerLastStand = true;
          }
     }
}
