package com.brockw.stickwar.engine.Team.Elementals
{
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Building;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.MovieClip;
     
     public class TempleBuilding extends Building
     {
           
          
          public function TempleBuilding(param1:StickWar, param2:ElementalTech, param3:MovieClip, param4:MovieClip)
          {
               super(param1);
               this.button = param3;
               _hitAreaMovieClip = param4;
               this.type = Unit.B_ELEMENTAL_TEMPLE;
               this.tech = param2;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               param1.clear();
               if(!tech.isResearched(Tech.CHROME_SPLIT_1))
               {
                    param1.setAction(0,0,Tech.CHROME_SPLIT_1);
               }
               else if(!tech.isResearched(Tech.CHROME_SPLIT_2))
               {
                    param1.setAction(0,0,Tech.CHROME_SPLIT_2);
               }
               if(!tech.isResearched(Tech.MEDUSA_POISON))
               {
                    param1.setAction(1,0,Tech.MEDUSA_POISON);
               }
               if(!tech.isResearched(Tech.SKELETON_FIST_ATTACK))
               {
                    param1.setAction(2,0,Tech.SKELETON_FIST_ATTACK);
               }
               if(!tech.isResearched(Tech.MAGIKILL_POISON))
               {
                    param1.setAction(0,1,Tech.MAGIKILL_POISON);
               }
               if(!tech.isResearched(Tech.MAGIKILL_WALL))
               {
                    param1.setAction(1,1,Tech.MAGIKILL_WALL);
               }
          }
     }
}
