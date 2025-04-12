class AiLevel4 extends Ai
{
     function AiLevel4()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = Math.random() * 0.75;
          this.lastStand = false;
          this.messageState = 0;
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
          if(this.messageState == 0 && game.getGameTime() > 3000)
          {
               _root.attachMovie("Speech2","Speech2",10000000);
               this.messageState = 1;
          }
          else if(this.messageState == 1 && game.getGameTime() > 10000)
          {
               this.messageState = 2;
               _root.tips.removeMovieClip();
          }
          this.createMiners(squad,2);
          if(game.getGameTime() - this.lastTime > 35000)
          {
               if(this.getSquadMilitary(squad) < this.getSquadMilitary(squad.getEnemyTeam()) + 1)
               {
                    squad.addSpartanInQueue();
                    if(_root.campaignData.difficultyLevel == 2)
                    {
                         squad.addArcherInQueue();
                    }
                    else if(_root.campaignData.difficultyLevel == 3)
                    {
                         squad.addArcher();
                         squad.addArcherInQueue();
                    }
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
               if(game.getGameTime() < 120000)
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
          if(game.getGameTime() - this.lastInjectionTime > 15000)
          {
               var _loc5_ = 0;
               while(_loc5_ < 4)
               {
                    squad.addSwordManInQueue();
                    _loc5_ += 1;
               }
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 3)
          {
               _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    squad.addSwordMan();
                    squad.addSwordMan();
                    squad.addSwordMan();
                    squad.addSwordMan();
                    squad.addSpartan();
                    squad.addSpartan();
                    squad.addWizard();
                    this.wizard = Wizard(squad.addWizard());
                    this.wizard.setAsEliteMage();
                    _loc5_ += 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
     }
}
