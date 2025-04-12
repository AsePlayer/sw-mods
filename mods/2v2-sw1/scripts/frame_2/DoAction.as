function save_campaign()
{
     var _loc2_ = SharedObject.getLocal("stickwar_save");
     _loc2_.data.data = _root.campaignData;
     trace("SAVE: " + _loc2_.data.data.getLevel() + " " + _root.campaignData.getLevel());
     _loc2_.flush();
}
function load_campaign()
{
     var _loc2_ = SharedObject.getLocal("stickwar_save");
     _root.campaignData = _loc2_.data.data;
}
