onClipEvent(load){
     helmet = _root.campaignData.technology.getSpartanHelmet();
     weapon = _root.campaignData.technology.getSpartanSpear() * 2 - 1;
     shield = _root.campaignData.technology.getSpartanShield();
     if(_root.campaignData.technology.getSpartanEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
}
