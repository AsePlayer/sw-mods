package com.brockw.stickwar.engine.Team.Chaos
{
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Building;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.MovieClip;
     
     public class ChaosMedusaBuilding extends Building
     {
           
          
          public function ChaosMedusaBuilding(param1:StickWar, param2:ChaosTech, param3:MovieClip, param4:MovieClip)
          {
               super(param1);
               this.button = param3;
               _hitAreaMovieClip = param4;
               this.type = Unit.B_CHAOS_MEDUSA;
               this.tech = param2;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               param1.clear();
               if(!tech.isResearched(Tech.MAGIKILL_WALL))
               {
                    param1.setAction(1,0,Tech.MAGIKILL_WALL);
               }
               if(!tech.isResearched(Tech.MAGIKILL_POISON))
               {
                    param1.setAction(2,0,Tech.MAGIKILL_POISON);
               }
               if(!tech.isResearched(Tech.MEDUSA_POISON))
               {
                    param1.setAction(0,1,Tech.MEDUSA_POISON);
               }
               if(!tech.isResearched(Tech.CHROME_SPLIT_1))
               {
                    param1.setAction(0,0,Tech.CHROME_SPLIT_1);
               }
               else if(!tech.isResearched(Tech.CHROME_SPLIT_2))
               {
                    param1.setAction(0,0,Tech.CHROME_SPLIT_2);
               }
          }
     }
}
