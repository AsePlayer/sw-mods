class AiLevel1 extends Ai
{
     function AiLevel1()
     {
          super();
     }
     function AiLevel1()
     {
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
     }
     function init(game, squad)
     {
          this.lastTime = -20000;
          this.lastInjectionTime = 0;
          squad.addSpartan();
          this.swordman = SwordMan(squad.addSwordMan());
          this.swordman.setAsEmberSword();
          this.messageState = 0;
     }
     function update(game, squad)
     {
          if(this.messageState == 0 && game.getGameTime() > 2000)
          {
               this.messageState = 1;
          }
          else if(this.messageState == 1 && game.getGameTime() > 10000)
          {
               this.messageState = 2;
          }
          this.createMiners(squad,3);
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
               var _loc4_ = 0;
               while(_loc4_ < 3)
               {
                    _loc4_ += 1;
               }
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 3)
          {
               _loc4_ = 0;
               while(_loc4_ < 1)
               {
                    squad.addSpartan();
                    squad.addWizard();
                    squad.addArcher();
                    _loc4_ += 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
     }
}
