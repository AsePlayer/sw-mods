onClipEvent(load){
     helmet = _root.campaignData.technology.getSpartanHelmet();
     weapon = 1 + (_root.campaignData.technology.getSpartanSpear() - 1) * 2;
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
