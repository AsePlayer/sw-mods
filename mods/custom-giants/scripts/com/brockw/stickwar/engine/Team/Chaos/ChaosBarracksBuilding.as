package com.brockw.stickwar.engine.Team.Chaos
{
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Building;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.MovieClip;
     
     public class ChaosBarracksBuilding extends Building
     {
           
          
          public function ChaosBarracksBuilding(param1:StickWar, param2:ChaosTech, param3:MovieClip, param4:MovieClip)
          {
               super(param1);
               this.button = param3;
               _hitAreaMovieClip = param4;
               this.type = Unit.B_CHAOS_BARRACKS;
               this.tech = param2;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               param1.clear();
               if(!tech.isResearched(Tech.BLOCK))
               {
                    param1.setAction(1,1,Tech.BLOCK);
               }
               if(!tech.isResearched(Tech.SHIELD_BASH))
               {
                    param1.setAction(2,0,Tech.SHIELD_BASH);
               }
               if(!tech.isResearched(Tech.CLOAK))
               {
                    param1.setAction(1,2,Tech.CLOAK);
               }
               else if(!tech.isResearched(Tech.CLOAK_II))
               {
                    param1.setAction(1,2,Tech.CLOAK_II);
               }
               if(!tech.isResearched(Tech.CAT_PACK))
               {
                    param1.setAction(0,0,Tech.CAT_PACK);
               }
               if(!tech.isResearched(Tech.CAT_SPEED))
               {
                    param1.setAction(1,0,Tech.CAT_SPEED);
               }
               if(!tech.isResearched(Tech.SWORDWRATH_RAGE))
               {
                    param1.setAction(2,1,Tech.SWORDWRATH_RAGE);
               }
               if(!tech.isResearched(Tech.KNIGHT_CHARGE))
               {
                    param1.setAction(0,1,Tech.KNIGHT_CHARGE);
               }
          }
     }
}
