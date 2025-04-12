class AiLevel9 extends Ai
{
     function AiLevel9()
     {
          super();
          this.lastTime = 0;
          this.lastStand = false;
     }
     function init(game, squad)
     {
          this.lastTime = 0;
          this.lastGiantTime = 0;
          squad.addGiant();
     }
     function update(game, squad)
     {
          if(game.getGameTime() > 60000)
          {
               this.createMiners(squad,5);
          }
          else
          {
               this.createMiners(squad,3);
          }
          if(this.lastStand)
          {
               squad.setMode(this.ATTACK);
          }
          else if(!this.garrisionIfLosing(squad))
          {
               if(game.getGameTime() < 60000)
               {
                    squad.setMode(this.ATTACK);
               }
               else
               {
                    squad.setMode(this.ATTACK);
               }
          }
          if(game.getGameTime() - this.lastGiantTime > 70000 && squad.getMenFromGroup(6).length < 2)
          {
               squad.addGiant();
               this.lastGiantTime = game.getGameTime();
          }
          if(!this.lastStand && squad.getCastleHealth() < squad.getTechnology().getCastleHealth() / 2.5)
          {
               squad.addGiant();
               this.lastStand = true;
          }
     }
}
