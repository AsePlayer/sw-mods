onClipEvent(load){
     wand = _root.campaignData.technology.getWizardAttack();
     hat = _root.campaignData.technology.getWizardHealing();
     if(_root.campaignData.technology.getWizardEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
}
