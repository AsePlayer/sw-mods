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
          if(this.messageState == 0 && game.getGameTime() > 1000)
          {
               _root.attachMovie("tips6","tips",10000000);
               this.messageState = 1;
          }
          else if(this.messageState == 1 && game.getGameTime() > 10000)
          {
               this.messageState = 2;
               _root.tips.removeMovieClip();
          }
          this.createMiners(squad,4);
          if(!this.hasInitial && game.getGameTime() - this.lastTime > 20000)
          {
               squad.addWizard();
               this.hasInitial = true;
          }
          if(game.getGameTime() - this.lastTime > 30000)
          {
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
                         this.newBuildPercent = 0.25 + Math.random() * 0.75;
                    }
               }
               else
               {
                    this.isJustAttack = true;
                    squad.setMode(this.ATTACK);
               }
          }
          if(game.getGameTime() - this.lastInjectionTime > 70000 && squad.getMenFromGroup(5).length < 3)
          {
               squad.addWizard();
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 3.5)
          {
               var _loc3_ = 0;
               while(_loc3_ < 2)
               {
                    squad.addWizard();
                    _loc3_ = _loc3_ + 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
     }
}
