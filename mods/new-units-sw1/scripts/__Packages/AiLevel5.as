class AiLevel5 extends Ai
{
     function AiLevel5()
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
          this.swordman = SwordMan(squad.addSwordMan());
          this.swordman.setAsSickleWrath();
          _root.soundManager.playBackgroundMusic("victoryHorns");
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
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    if(_root.campaignData.difficultyLevel == 2)
                    {
                         this.swordman = SwordMan(squad.addSwordMan());
                         this.swordman.setAsSickleWrath();
                         squad.addArcher();
                    }
                    else if(_root.campaignData.difficultyLevel == 3)
                    {
                         this.swordman = SwordMan(squad.addSwordMan());
                         this.swordman.setAsSickleWrath();
                         squad.addArcher();
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
                    squad.addArcher();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    _loc5_ += 2;
               }
               this.lastInjectionTime = getTimer();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 2)
          {
               _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleWrath();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsSickleBear();
                    this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
                    this.swordman.setAsBloodBlade();
                    this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
                    this.swordman.setAsBloodBlade();
                    this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
                    this.swordman.setAsBloodBlade();
                    _loc5_ += 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
     }
}
