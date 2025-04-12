class AiLevel3 extends Ai
{
     var isDone = false;
     var finalPos = 200;
     var setTime = 120000;
     var startPos = 85;
     function AiLevel3()
     {
          super();
          this.messageState = 0;
     }
     function init(game, squad)
     {
          this.isDone = false;
          this.playerLastStand = false;
          this.lastTime = 0;
          this.canGetElites = true;
          game.background.moon_y = this.startPos;
          var _loc5_ = 0;
          while(_loc5_ < 8)
          {
               squad.addSwordMan();
               _loc5_ += 1;
          }
          squad.addArcher();
          squad.addArcher();
          squad.addArcher();
          squad.addArcher();
          squad.addArcher();
          this.count = 10;
          this.messageState = 10;
          _root.soundManager.playBackgroundMusic("Entering_the_Stronghold");
          squad.getCastleHitArea()._x = squad.getCastleHitArea()._x + 1000;
     }
     function update(game, squad)
     {
          if(this.messageState == 10 && game.getGameTime() > 5000)
          {
               _root.attachMovie("tips3","tips",10000000);
               _root.tips.gotoAndStop(this.messageState);
               this.spartan = Spartan(squad.getEnemyTeam().addSpartan());
               this.spartan.setAsElite();
               this.messageState = 11;
          }
          else if(this.messageState == 11 && game.getGameTime() > 10000)
          {
               this.messageState = 3;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 3 && game.getGameTime() > 120000)
          {
               this.messageState = 12;
               _root.tips.gotoAndStop(this.messageState);
          }
          else if(this.messageState == 12 && game.getGameTime() > 125000)
          {
               _root.tips.removeMovieClip();
          }
          game.background.moon._y = game.getGameTime() / this.setTime * (this.finalPos - this.startPos) + this.startPos;
          if(!this.isDone && game.getGameTime() > this.setTime)
          {
               this.isDone = true;
          }
          if(game.getGameTime() > 120000)
          {
               squad.setMode(this.ATTACK);
          }
          if(squad.getNumberLiving() == 0 && game.getGameTime() > this.setTime)
          {
               game.finishLevel();
          }
          if(game.getGameTime() > 120000 && this.canGetElites)
          {
               this.spartan = Spartan(squad.addSpartan());
               this.spartan.setAsElite();
               this.spartan = Spartan(squad.addSpartan());
               this.spartan.setAsElite();
               this.spartan = Spartan(squad.addSpartan());
               this.spartan.setAsElite();
               this.spartan = Spartan(squad.addSpartan());
               this.spartan.setAsElite();
               squad.addArcher();
               squad.addArcher();
               _root.soundManager.playSoundCentre("marching");
               this.canGetElites = false;
          }
          _root.HUD.wizardButton._visible = true;
          _root.HUD.giantButton._visible = true;
          _root.HUD.spartanButton._visible = true;
          _root.HUD.archerButton._visible = true;
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
                    squad.getEnemyTeam().addSwordMan();
                    _loc5_ += 1;
               }
               this.playerLastStand = true;
          }
     }
}
