function tryToBuy(cost, item, level)
{
     cost /= 100;
     if(campaignData.getGold() < cost)
     {
          _root.soundManager.playSoundCentre("arrowHitDirt");
          return undefined;
     }
     campaignData.technology.item(level);
     _root.soundManager.playSoundCentre("swordHit1");
     campaignData.setGold(campaignData.getGold() - cost);
     _root.menu.gotoAndPlay("reloadshop");
}
_root.campaignData.getTotalTime();
defaultDescription = "Click on boxes to select upgrades";
defaultHeading = "Select upgrades";
menu.gold.text = campaignData.getGold();
var newColour;
newColour = new Color(menu);
newColour.setTint(0,0,0,100);
var tintAmount = 100;
var goto = undefined;
