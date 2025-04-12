class AiLevel12 extends Ai
{
     function AiLevel12()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
          this.isCreateType = true;
          this.lastCreateTime = 0;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addArcher();
          squad.addMiner();
          squad.addSwordManInQueue();
          squad.addSwordManInQueue();
          this.hasGiant = this.hasGianted = false;
     }
     function update(game, squad)
     {
          if(!this.hasGianted && squad.getCastleHealth() == 0)
          {
               squad.getCastle().giantStatue.play();
               this.hasGianted = true;
          }
          if(!this.hasGiant && this.hasGianted && squad.getCastle().giantStatue._currentframe == squad.getCastle().giantStatue._totalframes)
          {
               this.giant = Giant(squad.addGiant());
               this.giant.setAsSuperGiant();
               this.giant.setX(squad.getCastle()._x - 140);
               this.giant.setY(squad.getCastle()._y - 10);
               this.hasGiant = true;
               this.giantedTime = getTimer();
          }
          if(this.hasGiant && getTimer() - this.giantedTime < 1000)
          {
               this.giant.faceDirection(-1);
          }
          if(this.hasGiant && !this.giant.getIsAlive())
          {
               game.finishLevel();
          }
          if(!this.hasGiant && game.getGameTime() - this.lastCreateTime > 120000)
          {
               this.isCreateType = !this.isCreateType;
               this.lastCreateTime = game.getGameTime();
               if(squad.getMenFromGroup(6).length < 2)
               {
                    squad.addGiant();
               }
          }
          this.createMiners(squad,6);
          if(game.getGameTime() < 60000)
          {
               if(this.getSquadMilitary(squad) < 1)
               {
                    squad.addSwordMan();
               }
          }
          if(!this.hasGiant && game.getGameTime() - this.lastTime > 30000)
          {
               if(this.isCreateType)
               {
                    if(this.getSquadMilitary(squad) < 5)
                    {
                         squad.addArcher();
                         squad.addSwordManInQueue();
                         squad.addSwordManInQueue();
                         squad.addSwordManInQueue();
                         squad.addSwordManInQueue();
                    }
               }
               else if(_root.campaignData.difficultyLevel == 3)
               {
                    if(squad.getMenFromGroup(5).length < 2)
                    {
                         squad.addWizardInQueue();
                    }
               }
               else if(squad.getMenFromGroup(5).length < 1)
               {
                    squad.addWizardInQueue();
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
          if(game.getGameTime() - this.lastInjectionTime > 60000 && squad.getMenFromGroup(6).length < 3)
          {
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 3)
          {
               var _loc4_ = 0;
               while(_loc4_ < 2)
               {
                    _loc4_ = _loc4_ + 1;
               }
               _loc4_ = 0;
               while(_loc4_ < 1)
               {
                    _loc4_ = _loc4_ + 1;
               }
               this.lastStand = true;
          }
     }
}
