package com.brockw.stickwar.engine.maps
{
     import com.brockw.stickwar.engine.Background;
     import com.brockw.stickwar.engine.Hill;
     import com.brockw.stickwar.engine.Ore;
     import com.brockw.stickwar.engine.StickWar;
     import flash.display.MovieClip;
     
     public class Halloween extends Map
     {
           
          
          private var _width:int;
          
          private var _height:int;
          
          private var _y:int;
          
          private var _screenWidth:int;
          
          private var _screenHeight:int;
          
          private var _gold:Vector.<Ore>;
          
          private var _hills:Vector.<Hill>;
          
          private var divider:String;
          
          private var comment:String;
          
          public function Halloween(param1:StickWar)
          {
               super();
               this.init(param1);
          }
          
          override public function init(param1:StickWar) : void
          {
               var _loc2_:Vector.<MovieClip> = new Vector.<MovieClip>();
               _loc2_.push(new halloweenForeground());
               _loc2_.push(new halloweenMiddleground());
               _loc2_.push(new halloweenClouds());
               _loc2_.push(new halloweenSky());
               param1.background = new Background(_loc2_,param1);
               param1.addChild(param1.background);
               setDimensions(param1);
               createMiningBlock(param1,this.screenWidth + 670,1);
               createMiningBlock(param1,this.width - this.screenWidth - 670,-1);
               createMiningBlock(param1,this.width - this.screenWidth - 700,-1);
               createMiningBlock(param1,this.screenWidth + 1200,1);
               createMiningBlock(param1,this.width - this.screenWidth - 1200,-1);
               createMiningBlock(param1,this.width - this.screenWidth - 1230,-1);
               this.addTower_0(this.width / 2,this.height / 4.4,param1);
               this.comment = "Tower_0 corresponds to Team Class: spawnMiddleUnit: _loc6_.x = _loc6_.px = param1.map.hills[0].px";
               this.divider = "---------------------------------------------------------------------------";
               this.addTower_1(this.width / 2,this.height / 1.15,param1);
               this.comment = "Tower_1 corresponds to Team Class: spawnMiddleUnit1: _loc3_.x = _loc3_.px = param1.map.hills[1].px";
               this.divider = "---------------------------------------------------------------------------";
               this.addTower_2(this.width / 2.28,this.height / 2,param1);
               this.comment = "Tower_2 corresponds to Team Class: spawnMiddleUnit2: _loc3_.x = _loc3_.px = param1.map.hills[2].px";
               this.divider = "---------------------------------------------------------------------------";
               this.addTower_3(this.width / 5.74,this.height / 2,param1);
               this.comment = "Tower_3 corresponds to Team Class: spawnMiddleUnit3: _loc3_.x = _loc3_.px = param1.map.hills[3].px";
               this.divider = "---------------------------------------------------------------------------";
               this.addTower_4(this.width / 1.8,this.height / 2,param1);
               this.comment = "Tower_4 corresponds to Team Class: spawnMiddleUnit4: _loc3_.x = _loc3_.px = param1.map.hills[4].px";
               this.divider = "---------------------------------------------------------------------------";
               this.addTower_5(this.width / 1.21,this.height / 2,param1);
               this.comment = "Tower_5 corresponds to Team Class: spawnMiddleUnit5: _loc3_.x = _loc3_.px = param1.map.hills[5].px";
               this.divider = "---------------------------------------------------------------------------";
               this.comment = "(this.width / 2): Higher width number moves tower to the left, lower to the right.";
               this.comment = "(this.height / 2): Lower height number moves tower down, higher moves it up.";
               super.init(param1);
          }
          
          private function addTower_0(param1:Number, param2:Number, param3:*) : void
          {
               var _loc4_:Hill = null;
               (_loc4_ = new Hill(param3)).init(param1,param2,param3);
               hills.push(_loc4_);
          }
          
          private function addTower_1(param1:Number, param2:Number, param3:*) : void
          {
               var _loc4_:Hill = null;
               (_loc4_ = new Hill(param3)).init(param1,param2,param3);
               hills.push(_loc4_);
          }
          
          private function addTower_2(param1:Number, param2:Number, param3:*) : void
          {
               var _loc4_:Hill = null;
               (_loc4_ = new Hill(param3)).init(param1,param2,param3);
               hills.push(_loc4_);
          }
          
          private function addTower_3(param1:Number, param2:Number, param3:*) : void
          {
               var _loc4_:Hill = null;
               (_loc4_ = new Hill(param3)).init(param1,param2,param3);
               hills.push(_loc4_);
          }
          
          private function addTower_4(param1:Number, param2:Number, param3:*) : void
          {
               var _loc4_:Hill = null;
               (_loc4_ = new Hill(param3)).init(param1,param2,param3);
               hills.push(_loc4_);
          }
          
          private function addTower_5(param1:Number, param2:Number, param3:*) : void
          {
               var _loc4_:Hill = null;
               (_loc4_ = new Hill(param3)).init(param1,param2,param3);
               hills.push(_loc4_);
          }
     }
}
