on(release){
     var so = SharedObject.getLocal("stickwar_save");
     _root.campaignData.gold = so.data.data.gold;
     _root.campaignData.difficultyLevel = so.data.data.difficultyLevel;
     _root.campaignData.level = so.data.data.level;
     _root.campaignData.times = so.data.data.times;
     for(a in so.data.data.technology)
     {
          _root.campaignData.technology[a] = so.data.data.technology[a];
     }
     _root.menu.goto = "campaign";
}
