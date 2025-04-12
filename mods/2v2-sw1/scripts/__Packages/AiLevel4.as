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
          this.lastStand = false;
     }
     function init(game, squad)
     {
          this.lastTime = -20000;
          this.lastInjectionTime = 0;
          this.canSpawnUnits = true;
          squad.addSpartan();
          squad.addSpartan();
          squad.addSwordMan();
          squad.addSwordMan();
          squad.addMiner();
          squad.addMiner();
          squad.addWizard();
          this.messageState = 0;
          _root.soundManager.playBackgroundMusic("fieldOfMemories");
     }
     function update(game, squad)
     {
          _root.game.screen.leftCastle._visible = false;
          if(this.messageState == 0 && game.getGameTime() > 2000)
          {
               this.messageState = 1;
          }
          else if(this.messageState == 1 && game.getGameTime() > 10000)
          {
               this.messageState = 2;
          }
          this.createMiners(squad,2);
          if(game.getGameTime() - this.lastTime > 20000)
          {
               if(this.getSquadMilitary(squad) < 3)
               {
                    squad.addSpartanInQueue();
               }
               this.newBuildPercent = 0.5 + Math.random() * 0.5;
               this.lastTime = game.getGameTime();
          }
          if(this.getSquadMilitary(squad) <= 0.2 * this.getSquadMilitary(squad.getEnemyTeam()) && this.getNumMiners(squad) >= 3)
          {
          }
          if(this.lastStand)
          {
               squad.setMode(this.DEFEND);
          }
          else if(game.getGameTime() < 20000)
          {
               squad.setMode(this.DEFEND);
          }
          else if(!this.garrisionIfLosing(squad))
          {
               if(game.getGameTime() < 60)
               {
                    squad.setMode(this.DEFEND);
                    §§push(this);
                    §§push("isJustAttack");
                    §§push(true);
               }
               else
               {
                    if(this.getSquadMilitary(squad) < this.getSquadMilitary(squad.getEnemyTeam()) * this.newBuildPercent)
                    {
                         squad.setMode(this.DEFEND);
                         if(this.isJustAttack)
                         {
                              this.isJustAttack = false;
                              this.newBuildPercent = 0.5 + Math.random() * 0.5;
                         }
                         addr255:
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
                              while(_loc5_ < 2)
                              {
                                   squad.addSpartan();
                                   _loc5_ += 1;
                              }
                              squad.addMiner();
                              squad.addMiner();
                              this.lastStand = true;
                         }
                         if(game.getGameTime() > 195000)
                         {
                              if(this.canSpawnUnits)
                              {
                                   this.giant = Giant(squad.addGiant());
                                   this.giant.setAsKillerGiant();
                                   this.giant = Giant(squad.addGiant());
                                   this.giant.setAsKillerGiant();
                                   this.giant = Giant(squad.addGiant());
                                   this.giant.setAsKillerGiant();
                                   this.giant = Giant(squad.addGiant());
                                   this.giant.setAsKillerGiant();
                                   this.giant = Giant(squad.addGiant());
                                   this.giant.setAsKillerGiant();
                                   this.squad.getEnemyTeam.castleHeatlh *= 0;
                                   this.squad.getEnemyTeam.castleHeatlh -= 999;
                                   this.canSpawnUnits = false;
                              }
                         }
                         _root.HUD.giantButton._visible = true;
                    }
                    else
                    {
                         this.isJustAttack = true;
                         squad.setMode(this.DEFEND);
                         §§goto(addr255);
                    }
                    §§goto(addr255);
               }
          }
          §§goto(addr255);
     }
}
