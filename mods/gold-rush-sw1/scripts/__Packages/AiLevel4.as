class AiLevel4 extends Ai
{
     function AiLevel4()
     {
          super();
     }
     function AiLevel3()
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
               var _loc3_ = 0;
               while(_loc3_ < 3)
               {
                    _loc3_ = _loc3_ + 1;
               }
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 3)
          {
               _loc3_ = 0;
               while(_loc3_ < 2)
               {
                    squad.addSpartan();
                    _loc3_ = _loc3_ + 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
     }
}
