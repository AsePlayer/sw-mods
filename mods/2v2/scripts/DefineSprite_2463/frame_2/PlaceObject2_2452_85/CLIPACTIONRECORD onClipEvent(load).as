onClipEvent(load){
     var scale = 1 + _root.campaignData.technology.getCastleHealthLevel() / 10;
     _xscale = scale * 100;
     _yscale = scale * 100;
}
