package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.Ai.command.HoldCommand;
     import com.brockw.stickwar.engine.units.Bomber;
     import com.brockw.stickwar.engine.units.Cat;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.elementals.ChromeElement;
     
     public class CampaignBomber extends CampaignController
     {
          
          private static const MIN_NUM_BOMBERS:int = 3;
          
          private static const FREQUENCY_SPAWN:int = 10;
           
          
          private var numToSpawn:int = 0;
          
          private var nah:Boolean = false;
          
          private var v:ChromeElement;
          
          public function CampaignBomber(param1:GameScreen)
          {
               super(param1);
               this.numToSpawn = MIN_NUM_BOMBERS;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:int = 0;
               var _loc3_:Unit = null;
               if(!this.nah)
               {
                    this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                    param1.team.spawn(this.v,param1.game);
                    this.v.vType = "v";
                    this.nah = true;
               }
               if(param1.game.frame % (30 * FREQUENCY_SPAWN) == 0)
               {
                    _loc2_ = 0;
                    while(_loc2_ < this.numToSpawn)
                    {
                         _loc3_ = Bomber(param1.game.unitFactory.getUnit(Unit.U_BOMBER));
                         param1.team.enemyTeam.spawn(_loc3_,param1.game);
                         _loc3_.px = param1.team.enemyTeam.statue.x;
                         _loc3_.py = param1.game.map.height / 2;
                         _loc3_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                         _loc3_ = Cat(param1.game.unitFactory.getUnit(Unit.U_CAT));
                         param1.team.enemyTeam.spawn(_loc3_,param1.game);
                         _loc3_.px = param1.team.enemyTeam.statue.x;
                         _loc3_.py = param1.game.map.height / 2;
                         _loc3_.ai.setCommand(param1.game,new HoldCommand(param1.game));
                         ++param1.team.enemyTeam.population;
                         _loc2_++;
                    }
               }
               param1.game.team.enemyTeam.attack(true);
          }
     }
}
