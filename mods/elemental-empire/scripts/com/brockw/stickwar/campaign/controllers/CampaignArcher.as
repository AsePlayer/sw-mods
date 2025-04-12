package com.brockw.stickwar.campaign.controllers
{
     import com.brockw.stickwar.GameScreen;
     import com.brockw.stickwar.campaign.InGameMessage;
     import com.brockw.stickwar.engine.units.Dead;
     import com.brockw.stickwar.engine.units.Unit;
     import com.brockw.stickwar.engine.units.elementals.ChromeElement;
     import com.brockw.stickwar.engine.units.elementals.EarthElement;
     
     public class CampaignArcher extends CampaignController
     {
          
          private static const MIN_NUM_BOMBERS:int = 1;
          
          private static const FREQUENCY_SPAWN:int = 20;
          
          private static const FREQUENCY_SPAWN_2:int = 419;
           
          
          private var message:InGameMessage;
          
          private var message2:InGameMessage;
          
          private var frames:int;
          
          private var numToSpawn:int = 0;
          
          private var nah:Boolean = false;
          
          private var v:ChromeElement;
          
          private var z:EarthElement;
          
          private var a:Dead;
          
          private var b:Dead;
          
          public function CampaignArcher(param1:GameScreen)
          {
               super(param1);
               this.numToSpawn = MIN_NUM_BOMBERS;
          }
          
          override public function update(param1:GameScreen) : void
          {
               var _loc2_:int = 0;
               var _loc3_:Unit = null;
               if(!this.nah && !this.message)
               {
                    this.v = ChromeElement(param1.game.unitFactory.getUnit(Unit.U_CHROME_ELEMENT));
                    param1.team.spawn(this.v,param1.game);
                    this.v.vType = "v";
                    this.message = new InGameMessage("",param1.game);
                    this.message.x = param1.game.stage.stageWidth / 2;
                    this.message.y = param1.game.stage.stageHeight / 4 - 75;
                    this.message.scaleX *= 1.3;
                    this.message.scaleY *= 1.3;
                    param1.addChild(this.message);
                    this.message.setMessage("We need to hold out for 7 minutes to get these guys out. Come on guys","V");
                    this.frames = 0;
                    this.nah = true;
               }
               if(param1.game.frame % (30 * FREQUENCY_SPAWN) == 0)
               {
                    _loc2_ = 0;
                    while(_loc2_ < this.numToSpawn)
                    {
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         this.a.px = param1.team.enemyTeam.homeX - 1775;
                         this.a.py = param1.game.map.height / 3;
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 1800;
                         this.a.py = param1.game.map.height / 2;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 1930;
                         this.a.py = param1.game.map.height / 3;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 1945;
                         this.a.py = param1.game.map.height / 4;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 1954;
                         this.a.py = param1.game.map.height / 4;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 1975;
                         this.a.py = param1.game.map.height / 3;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 2112;
                         this.a.py = param1.game.map.height / 2;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         this.a.px = param1.team.enemyTeam.homeX - 2000;
                         this.a.py = param1.game.map.height / 1;
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 2200;
                         this.a.py = param1.game.map.height / 3;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 2400;
                         this.a.py = param1.game.map.height / 1;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 1930;
                         this.a.py = param1.game.map.height / 1;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 2400;
                         this.a.py = param1.game.map.height / 2;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 2200;
                         this.a.py = param1.game.map.height / 1;
                         this.a = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.a.aType = "a";
                         param1.team.enemyTeam.spawn(this.a,param1.game);
                         this.a.px = param1.team.enemyTeam.homeX - 2200;
                         this.a.py = param1.game.map.height / 3;
                         _loc2_++;
                    }
               }
               else if(param1.game.frame % (30 * FREQUENCY_SPAWN_2) == 0 && !this.message2)
               {
                    _loc2_ = 0;
                    while(_loc2_ < this.numToSpawn)
                    {
                         param1.game.targetScreenX = param1.game.team.enemyTeam.statue.x - 325;
                         param1.game.screenX = param1.game.team.enemyTeam.statue.x - 325;
                         this.b = Dead(param1.game.unitFactory.getUnit(Unit.U_DEAD));
                         this.b.bType = "b";
                         param1.team.enemyTeam.spawn(this.b,param1.game);
                         this.b.px = param1.team.enemyTeam.homeX - 2200;
                         this.b.py = param1.game.map.height / 2;
                         _loc2_++;
                    }
                    param1.game.fogOfWar.isFogOn = false;
                    this.message2 = new InGameMessage("",param1.game);
                    this.message2.x = param1.game.stage.stageWidth / 2;
                    this.message2.y = param1.game.stage.stageHeight / 4 - 75;
                    this.message2.scaleX *= 1.3;
                    this.message2.scaleY *= 1.3;
                    param1.addChild(this.message2);
                    this.message2.setMessage("Well done!","V");
                    this.frames = 0;
               }
               param1.game.team.enemyTeam.attack(true);
               if(this.message && param1.contains(this.message))
               {
                    this.message.update();
                    if(this.frames++ > 30 * 5)
                    {
                         param1.removeChild(this.message);
                    }
               }
               else if(this.message2 && param1.contains(this.message2))
               {
                    this.message2.update();
                    if(this.frames++ > 30 * 5)
                    {
                         param1.removeChild(this.message2);
                    }
               }
          }
     }
}
