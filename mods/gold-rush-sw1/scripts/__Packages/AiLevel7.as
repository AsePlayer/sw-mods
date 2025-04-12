class AiLevel7 extends Ai
{
     function AiLevel7()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = Math.random() * 0.75;
          this.lastStand = false;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addSwordMan();
     }
     function update(game, squad)
     {
          this.createMiners(squad,4);
          if(game.getGameTime() - this.lastTime > 30000)
          {
               squad.addSwordManInQueue();
               squad.addSwordManInQueue();
               squad.addSwordManInQueue();
               squad.addSwordManInQueue();
               if(squad.getMenFromGroup(2).length < 2)
               {
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
                         this.newBuildPercent = Math.random() * 0.75;
                    }
               }
               else
               {
                    this.isJustAttack = true;
                    squad.setMode(this.ATTACK);
               }
          }
          if(game.getGameTime() - this.lastInjectionTime > 60000)
          {
               if(squad.getMenFromGroup(2).length < 2)
               {
                    squad.addArcher();
               }
               squad.addSwordMan();
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 2.5)
          {
               var _loc3_ = 0;
               while(_loc3_ < 3)
               {
                    squad.addSwordMan();
                    _loc3_ = _loc3_ + 1;
               }
               _loc3_ = 0;
               while(_loc3_ < 3)
               {
                    squad.addArcher();
                    _loc3_ = _loc3_ + 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
     }
}
