onClipEvent(enterFrame){
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
          else
          {
               _root.gotoAndPlay(goto);
          }
          newColour.setTint(0,0,0,tintAmount);
     }
}
