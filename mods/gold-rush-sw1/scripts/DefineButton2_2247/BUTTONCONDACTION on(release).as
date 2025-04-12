on(release){
     var so = SharedObject.getLocal("stickwar_save");
     so.data.data = _root.campaignData;
     so.flush();
     _root.campaignData = Campaign(so.data.data);
     _parent.gotoAndStop(2);
     _visible = false;
}
