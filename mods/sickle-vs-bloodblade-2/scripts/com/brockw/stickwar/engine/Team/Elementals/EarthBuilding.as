package com.brockw.stickwar.engine.Team.Elementals
{
     import com.brockw.stickwar.engine.ActionInterface;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Building;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.MovieClip;
     
     public class EarthBuilding extends Building
     {
           
          
          public function EarthBuilding(param1:StickWar, param2:ElementalTech, param3:MovieClip, param4:MovieClip)
          {
               super(param1);
               this.button = param3;
               _hitAreaMovieClip = param4;
               this.type = Unit.B_ELEMENTAL_EARTH;
               this.tech = param2;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               param1.clear();
               if(!tech.isResearched(Tech.TREE_POISON))
               {
                    param1.setAction(0,0,Tech.TREE_POISON);
               }
               else if(!tech.isResearched(Tech.TREE_POISON_2))
               {
                    param1.setAction(0,0,Tech.TREE_POISON_2);
               }
               if(!tech.isResearched(Tech.CLOAK))
               {
                    param1.setAction(1,0,Tech.CLOAK);
               }
               else if(!tech.isResearched(Tech.CLOAK_II))
               {
                    param1.setAction(1,0,Tech.CLOAK_II);
               }
               if(!tech.isResearched(Tech.SWORDWRATH_RAGE))
               {
                    param1.setAction(2,0,Tech.SWORDWRATH_RAGE);
               }
               if(!tech.isResearched(Tech.KNIGHT_CHARGE))
               {
                    param1.setAction(2,1,Tech.KNIGHT_CHARGE);
               }
               if(!tech.isResearched(Tech.BLOCK))
               {
                    param1.setAction(0,1,Tech.BLOCK);
               }
               if(!tech.isResearched(Tech.SHIELD_BASH))
               {
                    param1.setAction(1,1,Tech.SHIELD_BASH);
               }
               if(!tech.isResearched(Tech.CAT_PACK))
               {
                    param1.setAction(0,2,Tech.CAT_PACK);
               }
               if(!tech.isResearched(Tech.CAT_SPEED))
               {
                    param1.setAction(1,2,Tech.CAT_SPEED);
               }
          }
     }
}
