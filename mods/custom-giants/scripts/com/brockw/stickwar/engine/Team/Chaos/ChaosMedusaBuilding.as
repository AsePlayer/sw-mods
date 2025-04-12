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
           
          
          public function ChaosMedusaBuilding(game:StickWar, tech:ChaosTech, button:MovieClip, hitAreaMc:MovieClip)
          {
               super(game);
               this.button = button;
               _hitAreaMovieClip = hitAreaMc;
               this.type = Unit.B_CHAOS_MEDUSA;
               this.tech = tech;
          }
          
          override public function setActionInterface(param1:ActionInterface) : void
          {
               param1.clear();
               if(!tech.isResearched(Tech.MEDUSA_POISON))
               {
                    param1.setAction(0,1,Tech.MEDUSA_POISON);
               }
               if(!tech.isResearched(Tech.STATUE_HEALTH))
               {
                    param1.setAction(0,0,Tech.STATUE_HEALTH);
               }
               if(!tech.isResearched(Tech.MAGIKILL_POISON))
               {
                    param1.setAction(1,0,Tech.MAGIKILL_POISON);
               }
               if(!tech.isResearched(Tech.MAGIKILL_WALL))
               {
                    param1.setAction(2,0,Tech.MAGIKILL_WALL);
               }
          }
     }
}
