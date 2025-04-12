var difficulty = _root.campaignData.difficultyLevel;
var difficultyStr = "normal";
if(difficulty == 2)
{
     difficultyStr = "hard";
}
else if(difficulty == 3)
{
     difficultyStr = "insane";
}
titleDisplay.text = "Congratulations on finishing the game on " + difficultyStr + "!";
var seconds = Math.round(_root.campaignData.getTotalTime());
var minutes = Math.floor(seconds / 60);
seconds -= minutes * 60;
trace(_root.campaignData.getTotalTime());
timeDisplay.text = "";
var i = 1;
while(i < 13)
{
     lvlStr = i;
     seconds = Math.round(_root.campaignData.getTime(i));
     minutes = Math.floor(seconds / 60);
     seconds -= minutes * 60;
     time = minutes + "m and " + seconds + "s!\n";
     if(i < 10)
     {
          i = "0" + i;
     }
     timeDisplay.text += "Lvl " + i + " finished in " + time;
     i++;
}
seconds = Math.round(_root.campaignData.getTotalTime());
minutes = Math.floor(seconds / 60);
seconds -= minutes * 60;
timeDisplay.text += "\nYou have completed the game on " + difficultyStr + " in " + minutes + "m and " + seconds + "s!";
