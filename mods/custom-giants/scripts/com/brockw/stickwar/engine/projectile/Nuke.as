package com.brockw.stickwar.engine.projectile
{
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.display.MovieClip;
     
     public class Nuke extends Projectile
     {
           
          
          internal var spellMc:MovieClip;
          
          internal var explosionRadius:Number;
          
          internal var explosionDamage:Number;
          
          public function Nuke(game:StickWar)
          {
               super();
               type = NUKE;
               this.spellMc = new explosionBomber();
               this.addChild(this.spellMc);
               this.explosionRadius = game.xml.xml.Chaos.Units.bomber.explosionRadius;
               this.explosionDamage = game.xml.xml.Chaos.Units.bomber.explosionDamage;
          }
          
          override public function cleanUp() : void
          {
               super.cleanUp();
               removeChild(this.spellMc);
               this.spellMc = null;
          }
          
          override public function update(game:StickWar) : void
          {
               Util.animateMovieClip(this.spellMc,4);
               this.scaleX = 1 * (game.backScale + py / game.map.height * (game.frontScale - game.backScale));
               this.scaleY = 1 * (game.backScale + py / game.map.height * (game.frontScale - game.backScale));
               var units:Array = team.enemyTeam.units;
               var n:int = int(units.length);
               if(this.spellMc.explosion.currentFrame == 3)
               {
                    game.spatialHash.mapInArea(px - this.explosionRadius,py - this.explosionRadius,px + this.explosionRadius,py + this.explosionRadius,this.damageUnit);
               }
          }
          
          private function damageUnit(unit:Unit) : void
          {
               var minDamage:* = NaN;
               var maxDamage:* = NaN;
               if(unit.team != this.team)
               {
                    if(Math.pow(unit.px - this.px,2) + Math.pow(unit.py - this.py,2) < Math.pow(this.explosionRadius,2))
                    {
                         dz = dx = dy = 0;
                         minDamage = this.explosionDamage;
                         maxDamage = this.explosionDamage;
                         unit.damage(1,minDamage,null);
                    }
               }
          }
          
          override public function isReadyForCleanup() : Boolean
          {
               return this.spellMc.explosion.currentFrame == this.spellMc.explosion.totalFrames;
          }
          
          override public function isInFlight() : Boolean
          {
               return this.spellMc.explosion.currentFrame != this.spellMc.explosion.totalFrames;
          }
     }
}
