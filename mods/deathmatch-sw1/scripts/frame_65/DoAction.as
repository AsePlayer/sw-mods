if(tintAmount == 0 && !hasPlayed && level >= 0)
{
     _root.menu.path.play();
     hasPlayed = true;
}
if(goto == undefined)
{
     if(tintAmount > 0)
     {
          tintAmount -= (110 - tintAmount) / 5;
     }
     else
     {
          tintAmount = 0;
     }
     if(tintAmount < 0)
     {
          tintAmount = 0;
     }
     newColour.setTint(0,0,0,tintAmount);
}
else
{
     if(tintAmount < 100)
     {
          tintAmount += (110 - tintAmount) / 5;
     }
     else if(goto == "loadLevel")
     {
          _root.campaignData.loadLevel();
          _root.gotoAndPlay("game");
     }
     newColour.setTint(0,0,0,tintAmount);
}
