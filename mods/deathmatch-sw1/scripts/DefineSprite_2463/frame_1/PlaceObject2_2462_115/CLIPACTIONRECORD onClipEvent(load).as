onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "Increases Archer health by 20%";
     var heading = "Archer health Upgrade";
     var price = 100;
     var effect = "setArcherAccuracy";
     var orig = "getArcherAccuracy";
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
