class AiLevel0 extends Ai
{
     function AiLevel0()
     {
          super();
          this.lastTime = getTimer();
          this.messageState = 1;
     }
     function init(game, squad)
     {
     }
     function update(game, squad)
     {
          _root.game.screen.leftStatue._visible = false;
          _root.game.screen.rightCastle._visible = false;
          _root.game.screen.leftCastle._visible = false;
          _root.HUD.attackDefenceMenu.gotoAndStop(4);
          if(this.messageState == 4 && _root.game.squad1.getTeamsGold() > 700)
          {
               _root.tips.removeMovieClip();
               this.messageState = 5;
          }
          else if(this.messageState == 3 && _root.game.squad1.getTeamsGold() > 400)
          {
               _root.tips.gotoAndStop(4);
               this.messageState = 4;
          }
          else if(this.messageState == 2 && game.getCurrentCharacter() != undefined)
          {
               _root.tips.gotoAndStop(3);
               this.messageState = 3;
          }
          else if(this.messageState == 1 && squad.getEnemyTeam().getMenFromGroup(1).length > 0)
          {
               _root.tips.gotoAndStop(2);
               this.messageState = 2;
          }
          if(_root.game.squad1.getTeamsGold() >= 800)
          {
               _root.game.finishLevel();
          }
     }
}
