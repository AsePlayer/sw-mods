onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "+20% giant health";
     var heading = "Giant health Upgrade";
     var price = 100;
     var effect = "setGiantStrength";
     var orig = "getGiantStrength";
     var maxLevel = 4;
     if(_root.campaignData.technology.getGiantEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
     setbar();
}
