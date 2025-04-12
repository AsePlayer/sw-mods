function getDxTime(num)
{
     if(num < savedGameTime / 10)
     {
          return num;
     }
     return savedGameTime / 10;
}
function getDxGold(num)
{
     if(num < savedGameGold / 10)
     {
          return num;
     }
     return savedGameGold / 10;
}
var newColour;
newColour = new Color(menu);
newColour.setTint(0,0,0,100);
var tintAmount = 100;
var goto = undefined;
soundManager.stopBackgroundMusic();
if(game != undefined)
{
     var num = 1 + int(Math.random() * 3);
     _root.savedGameTime = game.getGameTime() / 1000;
     _root.savedGameGold = game.getSquad1().getTeamsGold();
     _root.time = game.getGameTime() / 1000;
     _root.gold = game.getSquad1().getTeamsGold();
     var seconds = Math.round(game.getGameTime() / 1000);
     var minutes = Math.floor(seconds / 60);
     seconds -= minutes * 60;
     menu.summary.timeDisplay.text = "Level completed in " + minutes + "m and " + seconds + "s";
     if(_root.campaignData.getLevel() == 12)
     {
          seconds = Math.round(_root.campaignData.getTotalTime() / 1000);
          minutes = Math.floor(seconds / 60);
          seconds -= minutes * 60;
          menu.summary.timeDisplay.text = "";
     }
     if(game.squad1.getCastleHealth() != 0)
     {
          campaignData.setLevelTime(game.getGameTime() / 1000);
          campaignData.levelUp();
          removeMovieClip(game.screen);
          removeMovieClip(game.HUD);
          game = undefined;
          var level = _root.campaignData.getLevel();
          _root.menu.display.gotoAndStop(level * 2);
          _root.soundManager.playSoundCentre("victorysound" + num);
     }
     else
     {
          menu.summary.timeDisplay.text = "";
          var num = 1 + int(Math.random() * 0);
          _root.soundManager.playSoundCentre("failmission1");
          removeMovieClip(game.screen);
          removeMovieClip(game.HUD);
          game = undefined;
          _root.menu.display.gotoAndStop(level * 2 + 1);
     }
}
