package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.engine.units.Magikill;
     import com.brockw.stickwar.engine.units.Unit;
     
     public class CampaignArcher extends CampaignController
     {
           
          
          private var arrow:tutorialArrow;
          
          private var TheMagikill:Magikill;
          
          private var TheMagikill2:Magikill;
          
          private var TheMagikill3:Magikill;
          
          private var oneMinTimer:int;
          
          private var oneMinConstant:int;
          
          private var twoMinTimer:int;
          
          private var twoMinConstant:int;
          
          private var threeMinTimer:int;
          
          private var threeMinConstant:int;
          
          private var fourMinTimer:int;
          
          private var fourMinConstant:int;
          
          private var sevenMinTimer:int;
          
          private var sevenMinConstant:int;
          
          private var tenMinTimer:int;
          
          private var tenMinConstant:int;
          
          private var frames:int;
          
          public function CampaignArcher(param1:GameScreen)
          {
               this.oneMinTimer = 30 * 30;
               this.oneMinConstant = this.oneMinTimer;
               this.twoMinTimer = 30 * 60;
               this.twoMinConstant = this.twoMinTimer;
               this.threeMinTimer = 30 * 90;
               this.threeMinConstant = this.threeMinTimer;
               super(param1);
               this.frames = 0;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:Unit = null;
               if(this.oneMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.oneMinTimer;
                         }
                         --this.oneMinTimer;
                    }
               }
               else if(this.oneMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 30) == 0)
                    {
                         param1.game.team.enemyTeam.attack(true);
                    }
               }
               if(this.twoMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.twoMinTimer;
                         }
                         --this.twoMinTimer;
                    }
               }
               else if(this.twoMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 60) == 0)
                    {
                         param1.game.team.enemyTeam.defend(true);
                    }
               }
               if(this.threeMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.threeMinTimer;
                         }
                         --this.threeMinTimer;
                    }
               }
               else if(this.threeMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 90) == 0)
                    {
                         param1.game.team.enemyTeam.attack(true);
                    }
               }
               if(this.fourMinTimer > 0)
               {
                    if(!param1.isPaused)
                    {
                         if(param1.isFastForward)
                         {
                              --this.fourMinTimer;
                         }
                         --this.fourMinTimer;
                    }
               }
               else if(this.fourMinTimer != -10)
               {
                    if(param1.game.frame % (30 * 120) == 0)
                    {
                         param1.game.team.enemyTeam.defend(true);
                    }
               }
          }
     }
}
