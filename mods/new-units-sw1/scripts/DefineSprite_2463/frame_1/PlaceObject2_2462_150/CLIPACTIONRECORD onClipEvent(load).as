onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "Increases Spearton attack by 20%";
     var heading = "Spearton spear Upgrade";
     var price = 100;
     var effect = "setSpartanSpear";
     var orig = "getSpartanSpear";
     var maxLevel = 3;
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
