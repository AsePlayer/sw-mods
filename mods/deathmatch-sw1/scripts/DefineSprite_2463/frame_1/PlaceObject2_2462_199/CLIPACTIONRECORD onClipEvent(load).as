onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "Improves arrows fired by castle archers by 25%.";
     var heading = "Castle archer upgrade";
     var price = 100;
     var effect = "setCastleArcherNumber";
     var orig = "getCastleArcherNumber";
     var maxLevel = 4;
     setbar();
}
