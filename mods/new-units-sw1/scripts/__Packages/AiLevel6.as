class AiLevel6 extends Ai
{
     var isDone = false;
     var finalPos = 80;
     var setTime = 120000;
     var startPos = 250;
     function AiLevel6()
     {
     }
     function AiLevel2()
     {
          super();
          this.messageState = 0;
     }
     function init(game, squad)
     {
          this.isDone = false;
          this.lastTime = 0;
          game.background.sun._y = this.startPos;
          var _loc5_ = 0;
          while(_loc5_ < 1)
          {
               this.swordman = SwordMan(squad.addSwordMan());
               this.swordman.setAsBloodBlade();
               this.swordman = SwordMan(squad.addSwordMan());
               this.swordman.setAsBloodBlade();
               _loc5_ += 1;
          }
          _loc5_ = 0;
          while(_loc5_ < 1)
          {
               squad.getEnemyTeam().addMiner();
               squad.getEnemyTeam().addMiner();
               this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
               this.swordman.setAsSickleWrath();
               this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
               this.swordman.setAsSickleWrath();
               this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
               this.swordman.setAsSickleWrath();
               this.swordman = SwordMan(squad.getEnemyTeam().addSwordMan());
               this.swordman.setAsSickleWrath();
               _loc5_ += 1;
          }
          _root.soundManager.playBackgroundMusic("fieldOfMemories");
          this.waveNum = 0;
          squad.getCastleHitArea()._x = squad.getCastleHitArea()._x + 1000;
     }
     function update(game, squad)
     {
          if(this.messageState == 0 && game.getGameTime() > 3000)
          {
               _root.attachMovie("tips2","tips",10000000);
               this.messageState = 1;
          }
          else if(this.messageState == 1 && game.getGameTime() > 11000)
          {
               this.messageState = 2;
               _root.tips.removeMovieClip();
          }
          game.background.sun._y = game.getGameTime() / this.setTime * (this.finalPos - this.startPos) + this.startPos;
          if(game.getGameTime() > this.setTime && squad.getNumberLiving() == 0)
          {
               game.finishLevel();
          }
          squad.setMode(this.ATTACK);
          if(squad.getNumberLiving() == 0 && this.waveNum < 3)
          {
               var _loc5_ = 0;
               while(_loc5_ < 2 + 1 * this.waveNum)
               {
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsBloodBlade();
                    this.swordman = SwordMan(squad.addSwordMan());
                    this.swordman.setAsBloodBlade();
                    _loc5_ += 1;
               }
               this.waveNum++;
          }
     }
}
