onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "+1 to number of units summoned by wizard";
     var heading = "Wizard summoning spell Upgrade";
     var price = 100;
     var effect = "setWizardHealing";
     var orig = "getWizardHealing";
     var maxLevel = 4;
     if(_root.campaignData.technology.getWizardEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
     setbar();
}
