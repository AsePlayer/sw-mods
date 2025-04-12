onClipEvent(load){
     function setbar()
     {
          bar._yscale = 100 * ((_root.campaignData.technology[orig]() - 1) / (maxLevel - 1));
          if(maxLevel == _root.campaignData.technology[orig]())
          {
               plus._visible = false;
          }
     }
     var description = "+15% stun time";
     var heading = "Wizard stun spell Upgrade";
     var price = 100;
     var effect = "setWizardAttack";
     var orig = "getWizardAttack";
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
