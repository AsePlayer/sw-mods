class AiLevel1 extends Ai
{
     function AiLevel1()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
          this.playerLastStand = false;
          this.isCreateType = true;
          this.lastCreateTime = 0;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addMiner();
          squad.addSwordMan();
          squad.addMiner();
          squad.addSwordManInQueue();
          _root.soundManager.playBackgroundMusic("victoryHorns");
     }
     function update(game, squad)
     {
          if(game.getGameTime() - this.lastCreateTime > 120000)
          {
               this.isCreateType = !this.isCreateType;
               this.lastCreateTime = game.getGameTime();
               if(squad.getMenFromGroup(6).length < 1)
               {
                    squad.addGiant();
                    if(_root.campaignData.difficultyLevel == 3)
                    {
                         squad.addWizard();
                         squad.getEnemyTeam().addSpartan();
                         squad.addSpartanInQueue();
                    }
                    else if(_root.campaignData.difficultyLevel == 2)
                    {
                         squad.addWizardInQueue();
                    }
                    else
                    {
                         squad.addSpartanInQueue();
                    }
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
          if(game.getGameTime() - this.lastTime > 30000)
          {
               if(this.isCreateType)
               {
                    if(this.getSquadMilitary(squad) < 5)
                    {
                         squad.addArcher();
                         squad.addSwordManInQueue();
                         squad.addSwordManInQueue();
                         squad.addSwordManInQueue();
                         squad.addArcherInQueue();
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
               if(game.getGameTime() < 30000)
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
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 2)
          {
               var _loc5_ = 0;
               while(_loc5_ < 3)
               {
                    squad.addSwordMan();
                    _loc5_ += 1;
               }
               _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    squad.addGiant();
                    squad.addWizard();
                    squad.addSpartan();
                    squad.getEnemyTeam().addWizard();
                    _loc5_ += 1;
               }
               _loc5_ = 0;
               squad.addMiner();
               squad.addMiner();
               squad.addMiner();
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
          if(!this.playerLastStand && squad.enemyTeam.getCastleHealth() < squad.enemyTeam.getTechnology().getCastleHealth() / 2)
          {
               _loc5_ = 0;
               while(_loc5_ < 2)
               {
                    squad.getEnemyTeam.addSwordMan();
                    _loc5_ += 1;
               }
               _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    squad.getEnemyTeam().addSpartan();
                    squad.getEnemyTeam().addSpartan();
                    squad.getEnemyTeam().addWizard();
                    _loc5_ += 1;
               }
               squad.getEnemyTeam().addMiner();
               squad.getEnemyTeam().addMiner();
               this.playerLastStand = true;
          }
          if(!this.playerLastStand)
          {
               _root.HUD.giantButton._visible = false;
          }
          else
          {
               _root.HUD.giantButton._visible = true;
          }
     }
}
