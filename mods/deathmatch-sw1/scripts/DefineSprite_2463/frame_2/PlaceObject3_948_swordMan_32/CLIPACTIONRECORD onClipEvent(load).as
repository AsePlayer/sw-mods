onClipEvent(load){
     weapon = _root.campaignData.technology.getSwordmanSword();
     if(_root.campaignData.technology.getSwordmanEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
}
