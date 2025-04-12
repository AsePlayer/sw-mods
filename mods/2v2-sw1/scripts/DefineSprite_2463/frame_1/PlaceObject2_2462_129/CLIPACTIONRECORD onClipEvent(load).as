onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 3) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "Increases Spearton health by 10% and increases the chance that a Speartons block will be successfull";
     var heading = "Spearton shield Upgrade";
     var price = 100;
     var effect = "setSpartanShield";
     var orig = "getSpartanShield";
     var maxLevel = 5;
     if(_root.campaignData.technology.getSpartanEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
     setbar();
}
