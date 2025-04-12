onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "+100% hitpoints";
     var heading = "Castle hitpoints upgrade";
     var price = 100;
     var effect = "setCastleHealth";
     var orig = "getCastleHealthLevel";
     var maxLevel = 3;
     setbar();
}
