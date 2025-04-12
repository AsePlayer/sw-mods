onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "+20% attack strength";
     var heading = "Swordman sword Upgrade";
     var price = 100;
     var effect = "setSwordmanSword";
     var orig = "getSwordmanSword";
     var maxLevel = 4;
     if(!_root.campaignData.technology.getIsNotClubman())
     {
          maxLevel = 1;
     }
     if(_root.campaignData.technology.getSwordmanEnabled() && _root.campaignData.technology.getIsNotClubman())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
     setbar();
}
