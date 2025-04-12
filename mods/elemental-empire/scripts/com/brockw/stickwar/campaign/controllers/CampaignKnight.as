package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     
     public class CampaignKnight extends CampaignController
     {
           
          
          private var message:InGameMessage;
          
          private var frames:int;
          
          public function CampaignKnight(param1:GameScreen)
          {
               super(param1);
          }
          
          override public function update(param1:GameScreen) : void
          {
               param1.game.fogOfWar.isFogOn = false;
          }
     }
}
