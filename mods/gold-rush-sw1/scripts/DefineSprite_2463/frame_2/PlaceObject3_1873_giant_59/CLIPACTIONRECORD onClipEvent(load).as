onClipEvent(load){
     weapon = _root.campaignData.technology.getGiantClub() * 2 - 1;
     trace(weapon);
     _xscale = _xscale * (1 + _root.campaignData.technology.getGiantStrength() * 0.1);
     _yscale = _yscale * (1 + _root.campaignData.technology.getGiantStrength() * 0.1);
     health._visible = false;
     if(_root.campaignData.technology.getGiantEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
}
