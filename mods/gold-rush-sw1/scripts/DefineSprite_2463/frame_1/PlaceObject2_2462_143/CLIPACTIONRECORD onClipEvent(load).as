onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "Increases speed by 20%";
     var heading = "Swordman speed Upgrade";
     var price = 100;
     var effect = "setSwordmanSpeed";
     var orig = "getSwordmanSpeed";
     var maxLevel = 4;
     if(_root.campaignData.technology.getSwordmanEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
     setbar();
}
