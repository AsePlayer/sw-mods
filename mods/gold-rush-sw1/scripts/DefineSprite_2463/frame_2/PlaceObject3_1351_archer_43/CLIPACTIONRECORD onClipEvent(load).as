onClipEvent(load){
     quiver = _root.campaignData.technology.getArcherAccuracy();
     if(_root.campaignData.technology.getArcherEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
}
