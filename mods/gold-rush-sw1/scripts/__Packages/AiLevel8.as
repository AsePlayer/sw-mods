class AiLevel8 extends Ai
{
     function AiLevel8()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = 0.5 + Math.random() * 0.5;
          this.lastStand = false;
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
          this.createMiners(squad,5);
          if(game.getGameTime() - this.lastTime > 30000)
          {
               squad.addSpartanInQueue();
               squad.addSpartanInQueue();
               if(squad.getMenFromGroup(2).length < 2)
               {
                    squad.addArcherInQueue();
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
               if(game.getGameTime() < 60000)
               {
                    squad.setMode(this.DEFEND);
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
          if(game.getGameTime() - this.lastInjectionTime > 60000 && squad.getMenFromGroup(6).length < 3)
          {
               if(this.getSquadMilitary(squad) < 3)
               {
                    if(squad.getMenFromGroup(2).length < 2)
                    {
                         squad.addArcherInQueue();
                    }
                    squad.addSpartan();
               }
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 3)
          {
               var _loc3_ = 0;
               while(_loc3_ < 1)
               {
                    squad.addSpartan();
                    _loc3_ = _loc3_ + 1;
               }
               _loc3_ = 0;
               while(_loc3_ < 1)
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
