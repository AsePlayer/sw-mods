onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "+20% mining bag capacity";
     var heading = "Mining bag Upgrade";
     var price = 100;
     var effect = "setMinerBagsize";
     var orig = "getMinerBag";
     var maxLevel = 4;
     if(_root.campaignData.technology.getMinerEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
     setbar();
}
