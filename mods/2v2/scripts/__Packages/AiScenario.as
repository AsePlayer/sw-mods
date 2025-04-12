class AiScenario extends Ai
{
     function AiScenario()
     {
          super();
          this.lastTime = getTimer();
     }
     function init(game, squad)
     {
          squad.addArcherInQueue();
     }
     function update(game, squad)
     {
          if(squad.getMen().length < 20)
          {
               squad.setMode(this.DEFEND);
          }
          else
          {
               squad.setMode(this.ATTACK);
          }
          if(getTimer() - this.lastTime > 15000)
          {
               var _loc2_ = 0;
               while(_loc2_ < 5)
               {
                    _loc2_ = _loc2_ + 1;
               }
               this.lastTime = getTimer();
          }
     }
}
