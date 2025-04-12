onClipEvent(load){
     weapon = _root.campaignData.technology.getSwordmanSword();
     helmet = _root.campaignData.technology.getSwordmanSpeed();
     if(_root.campaignData.technology.getSwordmanEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
}
