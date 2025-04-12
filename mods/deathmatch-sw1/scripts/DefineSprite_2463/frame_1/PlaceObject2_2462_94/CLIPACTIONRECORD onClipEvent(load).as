onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "+20% mining rate";
     var heading = "Pickaxe Upgrade";
     var price = 100;
     var effect = "setMinerPickaxe";
     var orig = "getMinerPickaxe";
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
