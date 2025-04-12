class AiSquad
{
     var MIN_SPAWN_FREQ = 500;
     var FORMATION_Y_OFFSET = 50;
     var ARCHER_COST = 400;
     var MINER_COST = 250;
     var SWORD_MAN_COST = 150;
     var SPARTAN_COST = 400;
     var GIANT_COST = 1400;
     var WIZARD_COST = 1200;
     var ARCHER_TIME = 8000;
     var MINER_TIME = 4000;
     var SWORD_MAN_TIME = 3000;
     var SPARTAN_TIME = 10000;
     var GIANT_TIME = 20000;
     var WIZARD_TIME = 20000;
     var GARRISON = 1;
     var DEFEND = 2;
     var ATTACK = 3;
     var GARRISON_SPEED = 200;
     var GOLD_ADD_FREQUENCY = 1000;
     var GOLD_ADD_AMOUNT = 1;
     function AiSquad(castle, statue, statueHitArea, friends, oponents, baseX, baseY, name, game, technology)
     {
          this.friends = friends;
          this.oponents = oponents;
          this.game = game;
          this.statue = statue;
          this.baseX = baseX;
          this.baseY = baseY;
          this.teamName = name;
          this.technology = technology;
          this.statueHitArea = statueHitArea;
          this.newUnGarrisonMode = 1;
          this.numBodies = 0;
          this.isUnGarrison = false;
          this.unGarrisonTime = 0;
          if(this.teamName == "blue")
          {
               this.teamDirection = 1;
          }
          else
          {
               this.teamDirection = -1;
          }
          this.goldAddedNum = 0;
          this.castle = castle;
          this.castleHealth = technology.getCastleHealth();
          if(this.teamName == "red")
          {
               var _loc5_ = undefined;
               _loc5_ = new Color(castle);
               _loc5_.setTint(100,0,0,60);
          }
          this.defenceForwardPosition = baseX + this.teamDirection * 100;
          this.men = friends;
          this.queue = new QueueManager(this);
          this.swordManGroup = new SwordManGroup(game,this,this.ATTACK);
          this.spartanGroup = new SpartanGroup(game,this,this.ATTACK);
          this.archerGroup = new ArcherGroup(game,this,this.ATTACK);
          this.minerGroup = new MinerGroup(game,this,this.ATTACK);
          this.giantGroup = new GiantGroup(game,this,this.ATTACK);
          this.wizardGroup = new WizardGroup(game,this,this.ATTACK);
          this.groups = new Array();
          this.groups = [this.minerGroup,this.archerGroup,this.swordManGroup,this.spartanGroup,this.wizardGroup,this.giantGroup];
          this.lastSpawnTime = 0;
          this.aiMode = this.DEFEND;
          this.setMode(2);
          this.garrisonQueue = new Array();
          this.numGarrisoned = 0;
          this.lastGarrisonTime = game.getGameTime();
          this.castleArcherGroup = new CastleArcherGroup(game,this);
          this.lastGoldTime = game.getGameTime();
          var _loc4_ = 1 + technology.getCastleHealthLevel() / 4;
          statue._xscale *= _loc4_ * 80 / 100;
          statue._yscale = _loc4_ * 80;
          this.actionTime = 0;
          if(this.getCastle()._currentframe != 1)
          {
               var _loc2_ = 0;
               while(_loc2_ < 5)
               {
                    game.getBloodManager().addDust(this.getCastle()._x - 30 + Math.random() * 40,this.getCastle()._y - 30 + Math.random() * 40,100,this.getTeamDirection());
                    _loc2_ = _loc2_ + 1;
               }
          }
     }
     function update()
     {
          if(this.getTower() == undefined)
          {
               trace("CASTLE DISAPPEARING");
          }
          if(this.getCastleHealth() <= 0 && !(_root.campaignData.getLevel() == 12 && this.getTeamName() == "red"))
          {
               this.game.getBloodManager().addDust(this.getCastle()._x - 20 + Math.random() * 40,this.getCastle()._y - 10 + Math.random() * 20,100 + Math.random() * 100,this.getTeamDirection());
          }
          var _loc3_ = this.game.getMineHolder().getClosestMine(this.getMenFromGroup(1)[0].instance).clip._x;
          if(_loc3_ == undefined)
          {
               _loc3_ = this.castle._x + this.teamDirection * 200;
          }
          this.queue.update();
          this.archerGroup.update(_loc3_);
          this.minerGroup.update(_loc3_);
          this.giantGroup.update(_loc3_);
          this.wizardGroup.update(_loc3_);
          this.swordManGroup.update(_loc3_);
          this.spartanGroup.update(_loc3_);
          this.castleArcherGroup.update();
          this.garrisonUnits();
          if(this.game.getGameTime() - this.lastGoldTime > this.GOLD_ADD_FREQUENCY)
          {
               this.lastGoldTime = this.game.getGameTime();
               this.giveGold(2 + this.getTechnology().getCastleIncome() * 2);
          }
     }
     function closeScore(a, b)
     {
          return Math.pow(a.getX() - b.getX(),2) + Math.pow(a.getY() - b.getY(),4);
     }
     function addToGarrisonQueue(man)
     {
          this.garrisonQueue.push(man);
          man.setIsQueued(true);
     }
     function garrisonUnits()
     {
          var _loc3_ = undefined;
          var _loc2_ = undefined;
          if(this.garrisonQueue.length > 0 && this.game.getGameTime() - this.lastGarrisonTime > this.GARRISON_SPEED)
          {
               _loc2_ = this.garrisonQueue.pop();
               _loc2_.setIsGarrisoned(true);
               this.numGarrisoned = this.numGarrisoned + 1;
               _loc2_.setIsQueued(false);
               this.lastGarrisonTime = this.game.getGameTime();
          }
     }
     function addMiner()
     {
          var _loc2_ = new Miner(this.baseX,this.game.getTOP() + (this.game.getTOP() - this.game.getBOTTOM()) * Math.random(),this,this.minerGroup.getMen(),this.game);
          var _loc3_ = {instance:_loc2_};
          _loc3_ = {instance:_loc2_,state:0,lastStateChange:this.game.getGameTime()};
          this.miners.push(_loc3_);
          this.minerGroup.addMan(_loc3_);
          this.addMan(_loc2_);
          this.minerGroup.addToFormation(_loc3_);
     }
     function addArcher()
     {
          var _loc3_ = new Archer(this.baseX,this.game.getTOP() + (this.game.getTOP() - this.game.getBOTTOM()) * Math.random(),this,this.archerGroup.getMen(),this.game);
          var _loc2_ = {instance:_loc3_,state:0,lastStateChange:this.game.getGameTime(),target:undefined,targetAquireTime:0,targetRange:Infinity,row:undefined,col:undefined,formation:Array};
          this.archerGroup.addMan(_loc2_);
          this.addMan(_loc3_);
          this.archerGroup.addToFormation(_loc2_);
     }
     function addSwordMan()
     {
          var _loc2_ = new SwordMan(this.baseX,this.game.getTOP() + (this.game.getTOP() - this.game.getBOTTOM()) * Math.random(),this,this.swordManGroup.getMen(),this.game);
          var _loc3_ = {instance:_loc2_,state:0,lastStateChange:this.game.getGameTime(),target:undefined,targetAquireTime:0,targetRange:Infinity,row:undefined,col:undefined,formation:Array};
          this.swordManGroup.addMan(_loc3_);
          this.addMan(_loc2_);
          this.swordManGroup.addToFormation(_loc3_);
          return _loc2_;
     }
     function addSpartan()
     {
          var _loc3_ = new Spartan(this.baseX,this.game.getTOP() + (this.game.getTOP() - this.game.getBOTTOM()) * Math.random(),this,this.spartanGroup.getMen(),this.game);
          var _loc2_ = {instance:_loc3_,state:0,lastStateChange:this.game.getGameTime(),target:undefined,targetAquireTime:0,targetRange:Infinity,row:undefined,col:undefined,formation:Array};
          this.spartanGroup.addMan(_loc2_);
          this.addMan(_loc3_);
          this.spartanGroup.addToFormation(_loc2_);
     }
     function addGiant()
     {
          var _loc2_ = new Giant(this.baseX,this.game.getTOP() + (this.game.getTOP() - this.game.getBOTTOM()) * Math.random(),this,this.giantGroup.getMen(),this.game);
          var _loc3_ = {instance:_loc2_,state:0,lastStateChange:this.game.getGameTime(),target:undefined,targetAquireTime:0,targetRange:Infinity,row:undefined,col:undefined,formation:Array};
          this.giantGroup.addMan(_loc3_);
          this.addMan(_loc2_);
          this.giantGroup.addToFormation(_loc3_);
          return _loc2_;
     }
     function addWizard()
     {
          var _loc2_ = new Wizard(this.baseX,this.game.getTOP() + (this.game.getTOP() - this.game.getBOTTOM()) * Math.random(),this,this.wizardGroup.getMen(),this.game);
          var _loc3_ = {instance:_loc2_,state:0,lastStateChange:this.game.getGameTime(),target:undefined,targetAquireTime:0,targetRange:Infinity,row:undefined,col:undefined,formation:Array};
          this.wizardGroup.addMan(_loc3_);
          this.addMan(_loc2_);
          this.wizardGroup.addToFormation(_loc3_);
          return _loc2_;
     }
     function addToFormation(man, formation)
     {
          var _loc1_ = formation.length - 1;
          if(formation[_loc1_].length >= 5)
          {
               var _loc4_ = new Array();
               formation.push(_loc4_);
               _loc1_ = _loc1_ + 1;
          }
          formation[_loc1_].push(man);
          man.row = _loc1_;
          man.col = formation[_loc1_].length - 1;
          man.formation = formation;
     }
     function filterDown(formation, line, deletedIndex)
     {
          if(line < formation.length - 1)
          {
               if(deletedIndex > formation[line + 1].length - 1)
               {
                    deletedIndex = formation[line + 1].length - 1;
               }
               var _loc8_ = formation[line + 1].shift();
               var _loc5_ = Array();
               var _loc7_ = false;
               for(var _loc9_ in formation[line])
               {
                    if(_loc9_ == deletedIndex)
                    {
                         _loc5_.push(_loc8_);
                         _loc7_ = true;
                    }
                    _loc5_.push(formation[line][_loc9_]);
               }
               if(_loc7_ == false)
               {
                    _loc5_.push(_loc8_);
               }
               formation[line] = _loc5_;
               this.filterDown(formation,line + 1,deletedIndex);
          }
          line = 0;
          while(line < formation.length)
          {
               var _loc3_ = 0;
               while(_loc3_ < formation[line].length)
               {
                    formation[line][_loc3_].row = line;
                    formation[line][_loc3_].col = _loc3_;
                    _loc3_ = _loc3_ + 1;
               }
               line = line + 1;
          }
     }
     function removeFromFormation(man)
     {
          var _loc4_ = undefined;
          var _loc2_ = man.formation;
          _loc2_[man.row].splice(man.col,1);
          this.filterDown(_loc2_,man.row,man.col);
          if(_loc2_[_loc2_.length - 1].length == 0)
          {
               _loc2_.pop();
          }
     }
     function removeManFromFormation(man, simUnits)
     {
          var _loc2_ = undefined;
          for(_loc2_ in simUnits)
          {
               if(simUnits[_loc2_].instance == man)
               {
                    this.removeFromFormation(simUnits[_loc2_]);
               }
          }
     }
     function addMan(man)
     {
          var _loc3_ = undefined;
          _loc3_ = new Color(man.getClip());
          this.men.push(man);
          if(this.teamName == "blue")
          {
               man.walk(4,0);
          }
          else
          {
               man.walk(-4,0);
               _loc3_.setTint(100,0,0,60);
          }
          this.lastSpawnTime = this.game.getGameTime();
     }
     function removeMan(man, simUnits)
     {
          var _loc2_ = undefined;
          for(_loc2_ in this.men)
          {
               if(this.men[_loc2_] == man)
               {
                    this.men.splice(_loc2_,1);
               }
          }
          for(_loc2_ in simUnits)
          {
               if(simUnits[_loc2_].instance == man)
               {
                    simUnits.splice(_loc2_,1);
               }
          }
     }
     function getNumGarrisoned()
     {
          return this.numGarrisoned;
     }
     function setMode(newMode)
     {
          this.aiMode = newMode;
          this.swordManGroup.setStance(newMode);
          this.spartanGroup.setStance(newMode);
          this.archerGroup.setStance(newMode);
          this.wizardGroup.setStance(newMode);
          this.minerGroup.setStance(newMode);
          if(newMode != this.GARRISON)
          {
               this.numGarrisoned = 0;
               for(var _loc3_ in this.men)
               {
                    this.men[_loc3_].setIsGarrisoned(false);
                    this.men[_loc3_].setIsQueued(false);
               }
          }
     }
     function setGroupMode(newMode, group)
     {
          if(group == 0)
          {
               this.setMode(newMode);
          }
          this.groups[group - 1].setStance(newMode);
          if(newMode != this.GARRISON)
          {
               var _loc2_ = this.groups[group - 1].getMen();
               for(var _loc3_ in _loc2_)
               {
                    _loc2_[_loc3_].instance.setIsGarrisoned(false);
                    _loc2_[_loc3_].instance.setIsQueued(false);
               }
          }
     }
     function getGroupMode(group)
     {
          if(group == 0)
          {
               var _loc2_ = 0;
               while(_loc2_ < this.groups.length - 1)
               {
                    if(this.groups[_loc2_].getStance() != this.groups[_loc2_ + 1].getStance())
                    {
                         return 4;
                    }
                    _loc2_ = _loc2_ + 1;
               }
               return this.groups[0];
          }
          return this.groups[group - 1].getStance();
     }
     function getMode()
     {
          return this.aiMode;
     }
     function getMen()
     {
          return this.men;
     }
     function getBaseX()
     {
          return this.baseX;
     }
     function getBaseY()
     {
          return this.baseY;
     }
     function minerGiveGold(g)
     {
          if(this.teamName == "red")
          {
               this.giveGold(g);
          }
          if(g == 0)
          {
               return undefined;
          }
          this.goldAddedNum = (this.goldAddedNum + 1) % 5;
          var _loc2_ = "goldAdded" + this.goldAddedNum;
          this.game.screen.attachMovie("goldAdded",_loc2_,10000000000006 + this.goldAddedNum);
          this.game.screen[_loc2_]._x = this.baseX + 50;
          this.game.screen[_loc2_]._y = 300;
          this.game.screen[_loc2_].gold.gold.text = "+ " + int(g);
          this.giveGold(g);
     }
     function giveGold(g)
     {
          this.technology.gold += g;
     }
     function getTeamsGold()
     {
          return this.technology.gold;
     }
     function getTeamName()
     {
          return this.teamName;
     }
     function getTeamDirection()
     {
          return this.teamDirection;
     }
     function getTeamSize()
     {
          return this.men.length;
     }
     function getTechnology()
     {
          return this.technology;
     }
     function getEnemyTeam()
     {
          return this.enemyTeam;
     }
     function setEnemySquad(squad)
     {
          this.enemyTeam = squad;
     }
     function damageCastle(num)
     {
          this.castleHealth -= num;
          if(this.castleHealth < 0)
          {
               this.castleHealth = 0;
               if(!(_root.campaignData.getLevel() == 12 && this.teamName == "red"))
               {
                    this.game.finishLevel();
                    _root.soundManager.playSoundCentre("buildingDestroySound");
               }
          }
          this.game.getBloodManager().addDust(this.getCastle()._x - 20 + Math.random() * 40,this.getCastle()._y - 10 + Math.random() * 20,100,this.getTeamDirection());
          if(isNaN(100 * this.castleHealth / this.technology.getCastleHealth()))
          {
               trace("ERROR with castle health");
          }
          this.getCastle().health.bar._xscale = 100 * this.castleHealth / this.technology.getCastleHealth();
     }
     function getCastleHealth()
     {
          return this.castleHealth;
     }
     function getCastle()
     {
          return this.statue;
     }
     function getCastleHitArea()
     {
          return this.statueHitArea;
     }
     function getOponents()
     {
          return this.oponents;
     }
     function getMenFromGroup(group)
     {
          return this.groups[group - 1].getMen();
     }
     function getSpartanFormation()
     {
          return this.spartanGroup.getFormation();
     }
     function getSwordmenFormation()
     {
          return this.swordManGroup.getFormation();
     }
     function getManFromGroup(group)
     {
          return this.groups[group - 1].getFormation()[0][0].instance;
     }
     function addMinerInQueue()
     {
          if(this.technology.gold >= this.MINER_COST and this.canAddMan())
          {
               this.technology.gold -= this.MINER_COST;
               this.queue.push("addMiner",this.MINER_TIME);
               this.unitCreateSound();
          }
          else if(this.technology.gold < this.MINER_COST)
          {
               if(this.teamName == "blue")
               {
                    _root.HUD.goldBox.gold.play();
               }
               this.unitNotCreateSound();
          }
     }
     function removeMinerInQueue()
     {
          if(this.queue.pop("addMiner"))
          {
               this.technology.gold += this.MINER_COST;
               this.unitStopCreateSound();
          }
     }
     function addArcherInQueue()
     {
          if(this.technology.gold >= this.ARCHER_COST and this.canAddMan())
          {
               this.technology.gold -= this.ARCHER_COST;
               this.queue.push("addArcher",this.ARCHER_TIME);
               this.unitCreateSound();
          }
          else if(this.technology.gold < this.ARCHER_COST)
          {
               if(this.teamName == "blue")
               {
                    _root.HUD.goldBox.gold.play();
               }
               this.unitNotCreateSound();
          }
     }
     function removeArcherInQueue()
     {
          if(this.queue.pop("addArcher"))
          {
               this.technology.gold += this.ARCHER_COST;
               this.unitStopCreateSound();
          }
     }
     function addSpartanInQueue()
     {
          if(this.technology.gold >= this.SPARTAN_COST and this.canAddMan())
          {
               this.technology.gold -= this.SPARTAN_COST;
               this.queue.push("addSpartan",this.SPARTAN_TIME);
               this.unitCreateSound();
          }
          else if(this.technology.gold < this.SPARTAN_COST)
          {
               if(this.teamName == "blue")
               {
                    _root.HUD.goldBox.gold.play();
               }
               this.unitNotCreateSound();
          }
     }
     function removeSpartanInQueue()
     {
          if(this.queue.pop("addSpartan"))
          {
               this.technology.gold += this.SPARTAN_COST;
               this.unitStopCreateSound();
          }
     }
     function addSwordManInQueue()
     {
          if(this.technology.gold >= this.SWORD_MAN_COST and this.canAddMan())
          {
               this.technology.gold -= this.SWORD_MAN_COST;
               this.queue.push("addSwordMan",this.SWORD_MAN_TIME);
               this.unitCreateSound();
          }
          else if(this.technology.gold < this.SWORD_MAN_COST)
          {
               if(this.teamName == "blue")
               {
                    _root.HUD.goldBox.gold.play();
               }
               this.unitNotCreateSound();
          }
     }
     function removeSwordManInQueue()
     {
          if(this.queue.pop("addSwordMan"))
          {
               this.technology.gold += this.SWORD_MAN_COST;
               this.unitStopCreateSound();
          }
     }
     function addGiantInQueue()
     {
          if(this.technology.gold >= this.GIANT_COST and this.canAddMan())
          {
               this.technology.gold -= this.GIANT_COST;
               this.queue.push("addGiant",this.GIANT_TIME);
               this.unitCreateSound();
          }
          else if(this.technology.gold < this.GIANT_COST)
          {
               if(this.teamName == "blue")
               {
                    _root.HUD.goldBox.gold.play();
               }
               this.unitNotCreateSound();
          }
     }
     function removeGiantInQueue()
     {
          if(this.queue.pop("addGiant"))
          {
               this.technology.gold += this.GIANT_COST;
               this.unitStopCreateSound();
          }
     }
     function addWizardInQueue()
     {
          if(this.technology.gold >= this.WIZARD_COST and this.canAddMan())
          {
               this.technology.gold -= this.WIZARD_COST;
               this.queue.push("addWizard",this.WIZARD_TIME);
               this.unitCreateSound();
          }
          else if(this.technology.gold < this.WIZARD_COST)
          {
               if(this.teamName == "blue")
               {
                    _root.HUD.goldBox.gold.play();
               }
               this.unitNotCreateSound();
          }
     }
     function removeWizardInQueue()
     {
          if(this.queue.pop("addWizard"))
          {
               this.technology.gold += this.WIZARD_COST;
               this.unitStopCreateSound();
          }
     }
     function unitCreateSound()
     {
          if(this.teamName == "blue")
          {
               _root.soundManager.playSoundCentre("unitCreateButtonSound");
          }
     }
     function unitNotCreateSound()
     {
          if(this.teamName == "blue")
          {
               _root.soundManager.playSoundCentre("arrowHitMetal");
          }
     }
     function unitStopCreateSound()
     {
          if(this.teamName == "blue")
          {
               _root.soundManager.playSoundCentre("arrowHitDirt");
          }
     }
     function canAddMan()
     {
          if(this.getNumberLiving() + this.queue.size() < 20)
          {
               return true;
          }
          if(this.teamName == "blue")
          {
               _root.HUD.goldBox.populationFlicker.play();
          }
          return false;
     }
     function getQueueSize()
     {
          return this.queue.size();
     }
     function getForwardMan(exclude)
     {
          var _loc5_ = undefined;
          var _loc4_ = -Infinity * this.getTeamDirection();
          var _loc3_ = undefined;
          _loc3_ = 1;
          while(_loc3_ < 6)
          {
               var _loc2_ = this.groups[_loc3_].getFormation()[0][0].instance;
               if(_loc2_ != undefined && _loc3_ != exclude)
               {
                    if(_loc2_.getX() * this.getTeamDirection() > _loc4_ * this.getTeamDirection())
                    {
                         _loc4_ = _loc2_.getX();
                         _loc5_ = _loc2_;
                    }
               }
               _loc3_ = _loc3_ + 1;
          }
          return _loc5_;
     }
     function getNumberGarrisoned()
     {
          var _loc2_ = 0;
          for(var _loc3_ in this.men)
          {
               if(this.men[_loc3_].getIsGarrisoned() && this.men[_loc3_].getX() * this.teamDirection < (this.baseX + 10 * this.teamDirection) * this.teamDirection)
               {
                    _loc2_ = _loc2_ + 1;
               }
          }
          return _loc2_;
     }
     function getTower()
     {
          return this.castle;
     }
     function getNumberLiving()
     {
          var _loc2_ = 0;
          for(var _loc3_ in this.men)
          {
               if(this.men[_loc3_].getIsAlive())
               {
                    _loc2_ += 1;
               }
          }
          return _loc2_;
     }
     function action()
     {
          this.actionTime = this.game.getGameTime();
     }
     function isAction()
     {
          return this.game.getGameTime() - this.actionTime < 5000;
     }
     function getCastleArcherGroup()
     {
          return this.castleArcherGroup.getMen();
     }
     function enableGlow()
     {
          for(var _loc3_ in this.men)
          {
               if(this.men[_loc3_].getIsAlive())
               {
                    this.men[_loc3_].enableGlow();
               }
          }
          var _loc2_ = this.castleArcherGroup.getMen();
          for(_loc3_ in _loc2_)
          {
               if(_loc2_[_loc3_].getIsAlive())
               {
                    _loc2_[_loc3_].enableGlow();
               }
          }
     }
     function disableGlow()
     {
          for(var _loc3_ in this.men)
          {
               if(this.men[_loc3_].getIsAlive())
               {
                    this.men[_loc3_].disableGlow();
               }
          }
          var _loc2_ = this.castleArcherGroup.getMen();
          for(_loc3_ in _loc2_)
          {
               if(_loc2_[_loc3_].getIsAlive())
               {
                    _loc2_[_loc3_].disableGlow();
               }
          }
     }
}
