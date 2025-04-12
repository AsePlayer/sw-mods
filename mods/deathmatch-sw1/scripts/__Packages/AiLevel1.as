class AiLevel1 extends Ai
{
     function AiLevel1()
     {
          super();
          this.isJustAttack = false;
          this.newBuildPercent = Math.random() * 0.75;
          this.lastStand = false;
          this.playerLastStand = false;
          this.canGiveGold = true;
          this.canGiveGold2 = true;
          this.canGiveGold3 = true;
          this.messageState = 0;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastInjectionTime = 0;
          squad.addSwordMan();
          squad.addArcher();
          squad.addArcher();
          _root.soundManager.playBackgroundMusic("fieldOfMemories");
          this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
          this.swordman.setAsToxophilite();
     }
     function update(game, squad)
     {
          if(this.messageState == 0 && game.getGameTime() > 3000)
          {
               _root.attachMovie("tips3","tips",10000000);
               this.messageState = 1;
          }
          else if(this.messageState == 1 && game.getGameTime() > 10000)
          {
               this.messageState = 2;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 2 && game.getGameTime() > 15000)
          {
               this.messageState = 3;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 3 && game.getGameTime() > 35000)
          {
               this.messageState = 4;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 4 && game.getGameTime() > 40000)
          {
               this.messageState = 5;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 5 && game.getGameTime() > 120000)
          {
               this.messageState = 6;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 6 && game.getGameTime() > 125000)
          {
               _root.tips.removeMovieClip();
          }
          if(this.canGiveGold)
          {
               if(game.getGameTime() > 10000)
               {
                    this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
                    this.swordman.setAsToxophilite();
                    this.archer = Archer(squad.addArcher());
                    this.archer.setAsArcherPrince();
                    squad.getEnemyTeam().giveGold(1000);
                    squad.giveGold(1500);
                    this.canGiveGold = false;
               }
          }
          this.createMiners(squad,4);
          if(game.getGameTime() - this.lastTime > 15000)
          {
               if(this.getSquadMilitary(squad) < this.getSquadMilitary(squad.getEnemyTeam()) + 1)
               {
                    squad.addSpartan();
                    squad.addSwordManInQueue();
                    squad.addSwordManInQueue();
                    squad.addArcher();
                    if(_root.campaignData.difficultyLevel == 3)
                    {
                         squad.addSwordManInQueue();
                         squad.addSwordManInQueue();
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
               while(_loc5_ < 3)
               {
                    squad.addSwordMan();
                    squad.addArcher();
                    _loc5_ += 1;
               }
               squad.addMiner();
               squad.addMiner();
               this.lastStand = true;
          }
          _root.HUD.wizardButton._visible = true;
          _root.HUD.giantButton._visible = true;
          _root.HUD.spartanButton._visible = true;
          _root.HUD.archerButton._visible = false;
          if(this.canGiveGold2)
          {
               if(game.getGameTime() > 35000)
               {
                    this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
                    this.swordman.setAsToxophilite();
                    this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
                    this.spartan.setAsWoodland();
                    squad.getEnemyTeam().giveGold(1500);
                    squad.giveGold(1500);
                    this.canGiveGold2 = false;
               }
          }
          if(this.canGiveGold3)
          {
               if(game.getGameTime() > 120000)
               {
                    this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
                    this.swordman.setAsToxophilite();
                    this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
                    this.spartan.setAsWoodland();
                    this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
                    this.swordman.setAsToxophilite();
                    this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
                    this.swordman.setAsToxophilite();
                    this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
                    this.spartan.setAsWoodlandPrince();
                    squad.getEnemyTeam().giveGold(2500);
                    squad.giveGold(2000);
                    this.canGiveGold3 = false;
               }
          }
          if(!this.playerLastStand && squad.enemyTeam.getCastleHealth() < squad.enemyTeam.getTechnology().getCastleHealth() / 3)
          {
               _loc5_ = 0;
               while(_loc5_ < 1)
               {
                    squad.getEnemyTeam().addMiner();
                    squad.getEnemyTeam().addMiner();
                    squad.getEnemyTeam().addSpartan();
                    squad.getEnemyTeam().addSpartan();
                    squad.getEnemyTeam().addWizard();
                    squad.getEnemyTeam().addSpartan();
                    _loc5_ += 1;
               }
               this.playerLastStand = true;
          }
     }
}
