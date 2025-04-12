onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 2) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "Increase Spearton health by 20%.";
     var heading = "Spearton Helmet upgrade";
     var price = 100;
     var effect = "setSpartanHelmet";
     var orig = "getSpartanHelmet";
     var maxLevel = 4;
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
