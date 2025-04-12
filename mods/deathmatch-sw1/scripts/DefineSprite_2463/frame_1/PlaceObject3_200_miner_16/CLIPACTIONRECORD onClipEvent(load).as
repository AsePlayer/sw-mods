onClipEvent(load){
     weapon = _root.campaignData.technology.getMinerPickaxe() * 2;
     bag = _root.campaignData.technology.getMinerBag();
     if(_root.campaignData.technology.getMinerEnabled())
     {
          _visible = true;
     }
     else
     {
          _visible = false;
     }
}
