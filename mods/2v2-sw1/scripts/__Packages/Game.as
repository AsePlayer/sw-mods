class Game
{
     var KEY_DOUBLE_TIME = 1000;
     var KEY_DOUBLE_TIME_MIN = 30;
     var baseDepth = 2;
     var manBaseDepth = 10000;
     var topDepth = 5000000;
     var unitIndex = 0;
     var isMouseDown = false;
     var wasIsMouseDown = false;
     var SCROLL_SPEED = 20;
     var tintAmount = 100;
     var GAME_END_WAIT = 2000;
     function Game(currentLevel, screen, viewportWidth, viewportHeight, level, gold, redTech, blueTech, ai, backNumber, middleNumber, foreNumber)
     {
          this.lastCharacter = undefined;
          this.enemyAi = ai;
          this.viewportWidth = viewportWidth;
          this.viewportHeight = viewportHeight;
          this.level = level;
          this.gold = gold;
          this.canvas = screen;
          this.screenX = 0;
          this.currentLevel = currentLevel;
          this.screenDx = 0;
          this.redTechnology = redTech;
          this.blueTechnology = blueTech;
          this.selectedGroup = 0;
          this.backNumber = backNumber;
          this.middleNumber = middleNumber;
          this.foreNumber = foreNumber;
          this.init();
          this.lastMousePress = getTimer();
          this.lastManAdd = getTimer();
          this.startTime = getTimer();
          this.pauseTime = 0;
          this.hadCharacter = false;
          this.charChangeTime = 0;
          this.pauseStartTime = getTimer();
     }
     function init()
     {
          _root.soundManager.setGame(this);
          _root.soundManager.playBackgroundMusic("Battle_of_the_Shadow_Elves");
          this.isPaused = true;
          this.isGameStart = true;
          this.keys = {};
          this.keys.UP = 87;
          this.keys.DOWN = 83;
          this.keys.LEFT = 65;
          this.keys.RIGHT = 68;
          this.keys.ARROW_UP = 38;
          this.keys.ARROW_DOWN = 40;
          this.keys.ARROW_LEFT = 37;
          this.keys.ARROW_RIGHT = 39;
          this.keys.ATTACK = 32;
          this.keys.BLOCK = 81;
          this.keys.THROW = 70;
          _root.attachMovie("levelDescription","levelDescription",19999999,{_x:0,_y:0});
          _root.levelDescription.screen.gotoAndStop(_root.campaignData.getLevel() + 1);
          _root.attachMovie("gameMenu","gameMenu",19999998,{_x:0,_y:0,_visible:false});
          this.canvas.attachMovie("background" + this.backNumber,"background",this.baseDepth++,{_x:0,_y:0});
          this.canvas.background.cacheAsBitmap = true;
          this.background = this.canvas.background;
          this.canvas.attachMovie("middleground" + this.middleNumber,"middleground",this.baseDepth++,{_x:0,_y:0});
          this.canvas.middleground.cacheAsBitmap = true;
          this.middleground = this.canvas.middleground;
          this.canvas.createEmptyMovieClip("screen",this.baseDepth++);
          this.screen = this.canvas.screen;
          this.screen.attachMovie("foreground" + this.foreNumber,"gameBackground",this.baseDepth++,{_x:0,_y:0});
          this.screen.gameBackground.cacheAsBitmap = true;
          this.screenWidth = this.screen._width;
          this.screenHeight = 400;
          this.screen.attachMovie("castle","leftCastle",this.topDepth++);
          this.screen.leftCastle._x = -55;
          this.screen.leftCastle.type = -1;
          this.screen.leftCastle.x = this.screen.leftCastle._x;
          this.screen.leftCastle._y = this.screenHeight;
          this.screen.leftCastle._visible = true;
          this.screen.leftCastle.cacheAsBitmap = true;
          this.screen.attachMovie("castle","rightCastle",this.topDepth++);
          this.screen.rightCastle._x = this.screenWidth + 55;
          this.screen.rightCastle.type = -1;
          this.screen.rightCastle.x = this.screen.rightCastle._x;
          this.screen.rightCastle._y = this.screenHeight;
          this.screen.rightCastle._xscale *= -1;
          this.screen.rightCastle._visible = true;
          this.screen.rightCastle.cacheAsBitmap = true;
          this.screen.attachMovie("statues","leftStatue",this.topDepth++);
          this.screen.leftStatue.gotoAndStop(this.blueTechnology.statue);
          this.screen.leftStatue._x = 200;
          this.screen.leftStatue.type = -1;
          this.screen.leftStatue.x = this.screen.leftStatue._x;
          this.screen.leftStatue._y = this.screenHeight - 30;
          this.screen.leftStatue.cacheAsBitmap(true);
          this.screen.leftStatue.swapDepths(this.getManBaseDepth() + this.screen.leftStatue._y * this.getScreenWidth() + this.screen.leftStatue._x);
          this.screen.leftStatue.cacheAsBitmap = true;
          this.screen.attachMovie("castleHitArea","leftStatueHitArea",this.topDepth++);
          this.screen.leftStatueHitArea._x = 200;
          this.screen.leftStatueHitArea.type = -1;
          this.screen.leftStatueHitArea.x = this.screen.leftStatue._x;
          this.screen.leftStatueHitArea._y = this.screenHeight - 30;
          this.screen.leftStatueHitArea._alpha = 0;
          this.screen.attachMovie("statues","rightStatue",this.topDepth++);
          this.screen.rightStatue.gotoAndStop(this.redTechnology.statue);
          this.screen.rightStatue._x = this.screenWidth - 200;
          this.screen.rightStatue.type = -1;
          this.screen.rightStatue.x = this.screen.rightStatue._x;
          this.screen.rightStatue._y = this.screenHeight - 30;
          this.screen.rightStatue._xscale *= -1;
          this.screen.rightStatue.cacheAsBitmap(true);
          this.screen.rightStatue.swapDepths(this.getManBaseDepth() + this.screen.rightStatue._y * this.getScreenWidth() + this.screen.rightStatue._x);
          this.screen.rightStatue.cacheAsBitmap = true;
          this.screen.attachMovie("castleHitArea","rightStatueHitArea",this.topDepth++);
          this.screen.rightStatueHitArea._x = this.screenWidth - 200;
          this.screen.rightStatueHitArea.type = -1;
          this.screen.rightStatueHitArea.x = this.screen.rightStatue._x;
          this.screen.rightStatueHitArea._y = this.screenHeight - 30;
          this.screen.rightStatueHitArea._alpha = 0;
          this.screen.attachMovie("cursor","cursor",100000001);
          this.cursor = this.screen.cursor;
          _root.attachMovie("HUD","HUD",9999999,{_x:0,_y:0});
          this.HUD = _root.HUD;
          this.HUD.attackDefenceMenu.gotoAndStop(2);
          this.LEFT_BOUNDARY = 0;
          this.RIGHT_BOUNDARY = this.screenWidth;
          this.TOP_BOUNDARY = this.screenHeight - 50;
          this.BOTTOM_BOUNDARY = this.screenHeight - 5;
          this.mineHolder = new GoldMineManager(this);
          this.bloodManager = new BloodManager(this);
          this.projectileManager = new ProjectileManager(this);
          this.partitionManager = new PartitionManager(this);
          this.initSound();
          this.squad1Members = [];
          this.squad2Members = [];
          this.squad1 = new AiSquad(this.screen.leftCastle,this.screen.leftStatue,this.screen.leftStatueHitArea,this.squad1Members,this.squad2Members,0,350,"blue",this,this.blueTechnology);
          this.squad2 = new AiSquad(this.screen.rightCastle,this.screen.rightStatue,this.screen.rightStatueHitArea,this.squad2Members,this.squad1Members,this.RIGHT_BOUNDARY + 0,350,"red",this,this.redTechnology);
          this.squad1.setEnemySquad(this.squad2);
          this.squad2.setEnemySquad(this.squad1);
          this.mineHolder.addCloseMines();
          this.mineHolder.addCloseMines();
          this.enemyAi.init(this,this.squad2);
          this.squad1.update();
          this.squad2.update();
          _root.soundManager.setSoundToggle();
          this.updateHUDButtons();
     }
     function initSound()
     {
     }
     function update()
     {
          if(!this.isGameStart)
          {
               if(_root.levelDescription._x > -400)
               {
                    _root.levelDescription._x -= 9;
               }
               else
               {
                    _root.levelDescription._visible = false;
               }
          }
          if(!this.isGameOver && this.isPaused && !this.isGameStart)
          {
               _root.gameMenu.screen.qualityBox.gotoAndStop(_root._quality);
               if(_root.campaignData.isGlow)
               {
                    _root.gameMenu.screen.glowBox.gotoAndStop(1);
               }
               else
               {
                    _root.gameMenu.screen.glowBox.gotoAndStop(2);
               }
               if(_root.gameMenu._x < 0)
               {
                    _root.gameMenu._x += 40;
                    if(_root.gameMenu._x > 0)
                    {
                         _root.gameMenu._x = 0;
                    }
               }
               _root.gameMenu._visible = true;
               var _loc3_ = this.canvas.filters;
               if(_loc3_[0].blurX < 10)
               {
                    this.canvas.filters = _loc3_;
               }
               if(Key.isDown(27))
               {
                    if(_root.gameMenu._x == 0)
                    {
                         this.unpauseGame();
                    }
               }
               return undefined;
          }
          if(_root.gameMenu._x > -400)
          {
               _root.gameMenu._x -= 20;
          }
          else
          {
               _root.gameMenu._visible = false;
          }
          if(this.isGameOver && getTimer() - this.gameEndTime > this.GAME_END_WAIT)
          {
               if(this.tintAmount < 100)
               {
                    if(this.tintAmount >= 0)
                    {
                         this.tintAmount += (110 - this.tintAmount) / 5;
                    }
                    if(this.tintAmount < 0)
                    {
                         this.tintAmount = 0;
                    }
                    this.colourTint = new Color(this.canvas);
                    this.colourTint.setTint(0,0,0,this.tintAmount);
                    this.colourTint = new Color(_root.HUD);
                    this.colourTint.setTint(0,0,0,this.tintAmount);
                    this.colourTint = new Color(_root.levelDescription);
                    this.colourTint.setTint(0,0,0,this.tintAmount);
               }
               else
               {
                    _root.canvas._visible = false;
                    this.HUD._visible = false;
                    _root.levelDescription.removeMovieClip();
                    _root.gameMenu.removeMovieClip();
                    _root.tips.removeMovieClip();
                    _root.gotoAndPlay("postLevelCampaign");
               }
               return undefined;
          }
          this.HUD.goldBox.goldDisplay.text = Math.round(this.squad1.getTeamsGold());
          this.HUD.goldBox.populationDisplay.text = this.squad1.getNumberLiving() + this.squad1.getQueueSize() + "/30";
          this.HUD.menuDisplay.text = this.squad1.getTeamSize() + this.squad2.getTeamSize();
          if(this.tintAmount > 0)
          {
               if(this.tintAmount > 0)
               {
                    this.tintAmount -= (110 - this.tintAmount) / 5;
               }
               if(this.tintAmount < 0)
               {
                    this.tintAmount = 0;
               }
               this.colourTint = new Color(this.canvas);
               this.colourTint.setTint(0,0,0,this.tintAmount);
               this.colourTint = new Color(_root.HUD);
               this.colourTint.setTint(0,0,0,this.tintAmount);
               this.colourTint = new Color(_root.levelDescription);
               this.colourTint.setTint(0,0,0,this.tintAmount);
          }
          _loc3_ = this.canvas.filters;
          if(_loc3_.length != 0)
          {
               _loc3_[0].blurX -= 0.5;
               _loc3_[0].blurY -= 0.5;
               this.canvas.filters = _loc3_;
               if(_loc3_[0].blurX == 0)
               {
                    _loc3_.pop();
                    this.canvas.filters = _loc3_;
               }
          }
          if(this.isGameStart)
          {
               return undefined;
          }
          var _loc4_ = undefined;
          var _loc5_ = undefined;
          var _loc6_ = undefined;
          this.enemyAi.update(this,this.squad2);
          if(Key.isDown(192))
          {
               if(this.selectedGroup != 0)
               {
                    this.currentCharacter = undefined;
               }
               this.selectedGroup = 0;
          }
          if(Key.isDown(49))
          {
               if(this.selectedGroup != 1)
               {
                    this.currentCharacter = undefined;
               }
               this.selectedGroup = 1;
               this.currentCharacter = this.squad1.getManFromGroup(this.selectedGroup);
               this.lastKeyDown = 49;
               this.lastKeyTime = getTimer();
          }
          if(Key.isDown(50))
          {
               if(this.selectedGroup != 2)
               {
                    this.currentCharacter = undefined;
               }
               this.selectedGroup = 2;
               this.currentCharacter = this.squad1.getManFromGroup(this.selectedGroup);
               this.lastKeyDown = 50;
               this.lastKeyTime = getTimer();
          }
          if(Key.isDown(51))
          {
               if(this.selectedGroup != 3)
               {
                    this.currentCharacter = undefined;
               }
               this.selectedGroup = 3;
               this.currentCharacter = this.squad1.getManFromGroup(this.selectedGroup);
               this.lastKeyDown = 51;
               this.lastKeyTime = getTimer();
          }
          if(Key.isDown(52))
          {
               if(this.selectedGroup != 4)
               {
                    this.currentCharacter = undefined;
               }
               this.selectedGroup = 4;
               this.currentCharacter = this.squad1.getManFromGroup(this.selectedGroup);
               this.lastKeyDown = 52;
               this.lastKeyTime = getTimer();
          }
          if(Key.isDown(53))
          {
               if(this.selectedGroup != 5)
               {
                    this.currentCharacter = undefined;
               }
               this.selectedGroup = 5;
               this.currentCharacter = this.squad1.getManFromGroup(this.selectedGroup);
               this.lastKeyDown = 53;
               this.lastKeyTime = getTimer();
          }
          if(Key.isDown(54))
          {
               if(this.selectedGroup != 6)
               {
                    this.currentCharacter = undefined;
               }
               this.selectedGroup = 6;
               this.currentCharacter = this.squad1.getManFromGroup(this.selectedGroup);
               this.lastKeyDown = 54;
               this.lastKeyTime = getTimer();
          }
          if(getTimer() - this.lastManAdd > 100)
          {
               if(Key.isDown(55))
               {
                    this.swordman = SwordMan(this.squad1.addSwordMan());
                    this.swordman.setAsXenophon();
                    this.lastManAdd = getTimer();
               }
               if(Key.isDown(56))
               {
                    this.spartan = Spartan(this.squad1.addSpartan());
                    this.spartan.setAsWoodlandPrince();
                    this.lastManAdd = getTimer();
               }
               if(Key.isDown(57))
               {
                    game.finishLevel();
                    this.lastManAdd = getTimer();
               }
               if(Key.isDown(58))
               {
                    this.squad2.addSpartan();
                    this.lastManAdd = getTimer();
               }
          }
          _loc6_ = (this.screenX - this.screen._x) / 6;
          this.screen._x += _loc6_;
          this.middleground._x += _loc6_ / 2;
          if(this.middleground._x + _loc6_ <= 0 && this.middleground._x + _loc6_ >= - this.screenWidth + this.viewportWidth)
          {
               this.middleground._x += _loc6_;
          }
          if(this.screen._x + _loc6_ <= 0 && this.screen._x + _loc6_ >= - this.screenWidth + this.viewportWidth)
          {
               this.screen._x += _loc6_;
          }
          if(this.screenX > 0)
          {
               this.screenX = 0;
          }
          if(this.screenX < - this.screenWidth + this.viewportWidth)
          {
               this.screenX = - this.screenWidth + this.viewportWidth;
          }
          this.updateSelected();
          if(this.currentCharacter.getUnitType() == "archer" && !Archer(this.currentCharacter).getIsShooting() || this.currentCharacter.getUnitType() != "archer")
          {
               if(this.isMouseDown)
               {
                    _loc5_ = this.squad1.getCastleArcherGroup();
                    for(_loc4_ in _loc5_)
                    {
                         if(getTimer() - this.lastMousePress > 300 && _loc5_[_loc4_].clip.hitTest(_root._xmouse,_root._ymouse))
                         {
                              _root.attachMovie("tipsDefence","tipsDefence",99999999999432);
                         }
                    }
                    _loc5_ = this.squad2.getCastleArcherGroup();
                    for(_loc4_ in _loc5_)
                    {
                         if(getTimer() - this.lastMousePress > 300 && _loc5_[_loc4_].clip.hitTest(_root._xmouse,_root._ymouse))
                         {
                              _root.attachMovie("tipsAttack","tipsAttack",99999999999433);
                         }
                    }
                    _loc5_ = this.squad1.getMen();
                    for(_loc4_ in _loc5_)
                    {
                         if(getTimer() - this.lastMousePress > 300 && _loc5_[_loc4_].clip.hitTest(_root._xmouse,_root._ymouse))
                         {
                              if(this.currentCharacter == _loc5_[_loc4_])
                              {
                                   this.currentCharacter = undefined;
                                   this.selectedGroup = this.currentCharacter.type;
                                   this.currentCharacter.clearStatus();
                                   this.lastMousePress = getTimer();
                              }
                              else
                              {
                                   this.currentCharacter = _loc5_[_loc4_];
                                   this.selectedGroup = this.currentCharacter.type;
                                   this.currentCharacter.clearStatus();
                                   this.lastMousePress = getTimer();
                              }
                         }
                    }
               }
          }
          if(this.currentCharacter)
          {
               if(this.currentCharacter.getClip().filters.length == 0)
               {
               }
               if(Math.abs(this.currentCharacter.getX() - this.cursor._x) > 20)
               {
               }
               this.cursor._xscale = this.currentCharacter.getScale() * 1.5;
               this.cursor._yscale = this.currentCharacter.getScale() * 1.5;
               this.cursor._x += (this.currentCharacter.getX() - this.cursor._x) / 4;
               this.cursor._y += (this.currentCharacter.getY() - 90 * this.currentCharacter.getScale() / 100 - this.cursor._y) / 4;
          }
          else
          {
               this.cursor._y = -5;
          }
          if(this.currentCharacter.getIsAlive() == false)
          {
               this.currentCharacter = undefined;
               this.charChangeTime = getTimer();
          }
          if(this.lastCharacter != this.currentCharacter)
          {
          }
          this.userInput();
          this.squad1.update();
          this.squad2.update();
          this.mineHolder.update();
          this.projectileManager.update();
          this.bloodManager.update();
          this.centerScreen();
          this.wasIsMouseDown = this.isMouseDown;
          this.lastCharacter = this.currentCharacter;
     }
     function updateHUDButtons()
     {
          this.HUD.minerButton._visible = this.squad1.getTechnology().getMinerEnabled();
          this.HUD.swordmanButton._visible = this.squad1.getTechnology().getSwordmanEnabled();
          this.HUD.archerButton._visible = this.squad1.getTechnology().getArcherEnabled();
          this.HUD.spartanButton._visible = this.squad1.getTechnology().getSpartanEnabled();
          this.HUD.wizardButton._visible = this.squad1.getTechnology().getWizardEnabled();
          this.HUD.giantButton._visible = this.squad1.getTechnology().getGiantEnabled();
     }
     function updateSelected()
     {
          if(this.currentCharacter != undefined)
          {
               this.selectedGroup = this.currentCharacter.type;
          }
          _root.HUD.groupDisplay.gotoAndStop(this.selectedGroup + 1);
     }
     function centerScreen()
     {
          if(this.currentCharacter)
          {
               if(this.currentCharacter.getUnitType() == "archer")
               {
                    if(this.currentCharacter.getCurrentDirection() == 1)
                    {
                         this.screenX = - this.currentCharacter.getX() + this.viewportWidth / 6;
                         if(this.currentCharacter.getX() < this.viewportWidth / 6)
                         {
                              this.screenX = 0;
                         }
                         if(this.currentCharacter.getX() > this.RIGHT_BOUNDARY - this.viewportWidth + this.viewportWidth / 6)
                         {
                              this.screenX = - this.RIGHT_BOUNDARY + this.viewportWidth;
                         }
                    }
                    else
                    {
                         this.screenX = - this.currentCharacter.getX() + this.viewportWidth * 5 / 6;
                         if(this.currentCharacter.getX() < this.viewportWidth * 5 / 6)
                         {
                              this.screenX = 0;
                         }
                         if(this.currentCharacter.getX() > this.RIGHT_BOUNDARY - this.viewportWidth / 6)
                         {
                              this.screenX = - this.RIGHT_BOUNDARY + this.viewportWidth;
                         }
                    }
               }
               else
               {
                    this.screenX = - this.currentCharacter.getX() + this.viewportWidth / 2;
                    if(this.currentCharacter.getX() < this.viewportWidth / 2)
                    {
                         this.screenX = 0;
                    }
                    if(this.currentCharacter.getX() > this.RIGHT_BOUNDARY - this.viewportWidth / 2)
                    {
                         this.screenX = - this.RIGHT_BOUNDARY + this.viewportWidth;
                    }
               }
          }
     }
     function userInput()
     {
          if(Key.isDown(27))
          {
               if(_root.gameMenu._x < -300)
               {
                    this.pauseGame();
               }
          }
          if(this.currentCharacter)
          {
               this.currentCharacter.keyInterface();
          }
          else if(getTimer() - this.charChangeTime > 500)
          {
               if(Key.isDown(this.getKey("ARROW_LEFT")) || Key.isDown(this.getKey("LEFT")) || _root._ymouse > 60 && _root._xmouse < 60)
               {
                    if(this.screenX + this.SCROLL_SPEED < 0)
                    {
                         this.screenX += this.SCROLL_SPEED;
                    }
                    else
                    {
                         this.screenX = 0;
                    }
               }
               else if(Key.isDown(this.getKey("ARROW_RIGHT")) || Key.isDown(this.getKey("RIGHT")) || _root._ymouse > 60 && _root._xmouse > 540)
               {
                    if(this.screenX - this.SCROLL_SPEED > - this.screenWidth + this.viewportWidth)
                    {
                         this.screenX += - this.SCROLL_SPEED;
                    }
                    else
                    {
                         this.screenX = - this.screenWidth + this.viewportWidth;
                    }
               }
          }
     }
     function getScreenWidth()
     {
          return this.screenWidth;
     }
     function getScreenHeight()
     {
          return this.screenHeight;
     }
     function nextUnitIndex()
     {
          return this.unitIndex++;
     }
     function getManBaseDepth()
     {
          return this.manBaseDepth;
     }
     function setCurrentCharacter(man)
     {
          this.currentCharacter = man;
     }
     function getCurrentCharacter()
     {
          return this.currentCharacter;
     }
     function setMouseDown(v)
     {
          this.isMouseDown = v;
     }
     function getIsMouseDown()
     {
          return this.isMouseDown;
     }
     function getLEFT()
     {
          return this.LEFT_BOUNDARY;
     }
     function getRIGHT()
     {
          return this.RIGHT_BOUNDARY;
     }
     function getTOP()
     {
          return this.TOP_BOUNDARY;
     }
     function getBOTTOM()
     {
          return this.BOTTOM_BOUNDARY;
     }
     function getMineHolder()
     {
          return this.mineHolder;
     }
     function getScreenX()
     {
          return this.screenX;
     }
     function setScreenX(num)
     {
          this.screenX = num;
     }
     function getPartitionManager()
     {
          return this.partitionManager;
     }
     function getBloodManager()
     {
          return this.bloodManager;
     }
     function setSquad1Mode(newMode)
     {
          this.squad1.setGroupMode(newMode,0);
     }
     function getSoundManager()
     {
          return _root.soundManager;
     }
     function getKey(str)
     {
          return this.keys[str];
     }
     function getSquad1()
     {
          return this.squad1;
     }
     function getSquad2()
     {
          return this.squad2;
     }
     function pauseGame()
     {
          if(this.isPaused)
          {
               return undefined;
          }
          this.isPaused = true;
          this.pauseStartTime = getTimer();
          var _loc3_ = new flash.filters.BlurFilter(0,0,1);
          var _loc4_ = this.canvas.filters;
          _loc4_ = [];
          _loc4_.push(_loc3_);
          this.canvas.filters = _loc4_;
          _root.gameMenu.scroll.gotoAndPlay(1);
          _root.gameMenu.mask.gotoAndPlay(1);
     }
     function unpauseGame()
     {
          if(!this.isPaused)
          {
               return undefined;
          }
          if(this.pauseStartTime != undefined)
          {
               this.pauseTime += getTimer() - this.pauseStartTime;
          }
          this.isPaused = false;
          _root.levelDescription.scroll.play();
          _root.levelDescription.mask.play();
          _root.gameMenu.scroll.gotoAndPlay(14);
          _root.gameMenu.mask.gotoAndPlay(14);
     }
     function finishLevel()
     {
          if(this.isGameOver)
          {
               return undefined;
          }
          this.isGameOver = true;
          this.gameEndTime = getTimer();
          if(this.isPaused)
          {
               this.unpauseGame();
          }
     }
     function getGameTime()
     {
          if(this.isPaused)
          {
               var _loc2_ = getTimer() - this.startTime - this.pauseTime - (getTimer() - this.pauseStartTime);
               if(isNaN(_loc2_))
               {
                    return 0;
               }
               return getTimer() - this.startTime - this.pauseTime - (getTimer() - this.pauseStartTime);
          }
          _loc2_ = getTimer() - this.startTime - this.pauseTime;
          if(isNaN(_loc2_))
          {
               return 0;
          }
          return getTimer() - this.startTime - this.pauseTime;
     }
     function getIsGlow()
     {
          return _root.campaignData.isGlow;
     }
     function enableGlow()
     {
          _root.campaignData.isGlow = true;
          this.squad1.enableGlow();
          this.squad2.enableGlow();
     }
     function disableGlow()
     {
          _root.campaignData.isGlow = false;
          this.squad1.disableGlow();
          this.squad2.disableGlow();
     }
}
