package com.brockw.stickwar.engine.projectile
{
     import com.brockw.game.*;
     import com.brockw.stickwar.engine.*;
     import com.brockw.stickwar.engine.units.*;
     import flash.display.*;
     
     public class SummonMinion extends Projectile
     {
           
          
          internal var spellMc:MovieClip;
          
          internal var explosionRadius:Number;
          
          internal var explosionDamage:Number;
          
          private var clusterLad:Swordwrath;
          
          public function SummonMinion(param1:StickWar)
          {
               super();
               type = SUMMON_MINION;
               this.spellMc = new spawnTowerMc();
               this.addChild(this.spellMc);
               this.explosionRadius = param1.xml.xml.Chaos.Units.bomber.explosionRadius;
          }
          
          override public function cleanUp() : void
          {
               super.cleanUp();
               removeChild(this.spellMc);
               this.spellMc = null;
          }
          
          override public function update(param1:StickWar) : void
          {
               Util.animateMovieClip(this.spellMc,4);
               this.scaleX = scale * 0.6 * team.direction;
               this.scaleY = scale * 0.6;
               if(this.spellMc.mc.currentFrame == 3)
               {
                    param1.spatialHash.mapInArea(px - this.explosionRadius,py - this.explosionRadius,px + this.explosionRadius,py + this.explosionRadius);
               }
          }
          
          override public function isReadyForCleanup() : Boolean
          {
               return this.spellMc.mc.currentFrame == this.spellMc.mc.totalFrames;
          }
          
          override public function isInFlight() : Boolean
          {
               return this.spellMc.mc.currentFrame != this.spellMc.mc.totalFrames;
          }
     }
}
