onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "+25% arrow damage.";
     var heading = "Archer arrow damage Upgrade";
     var price = 100;
     var effect = "setArcherDamage";
     var orig = "getArcherDamage";
     var maxLevel = 4;
     if(_root.campaignData.technology.getArcherEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
     setbar();
}
