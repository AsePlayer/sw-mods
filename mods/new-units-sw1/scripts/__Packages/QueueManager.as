class QueueManager
{
     function QueueManager(squad)
     {
          this.lastSpawnTime = squad.game.getGameTime();
          this.queue = new Array();
          this.PRODUCTION_TIME = 2000;
          this.squad = squad;
          this.numMiners = this.numArchers = this.numSwordman = this.numSpartan = this.numWizard = this.numGiants = 0;
     }
     function update()
     {
          if(this.queue.length != 0)
          {
               if(this.squad.game.getGameTime() - this.lastSpawnTime > this.queue[0].time)
               {
                    if(this.queue[0].init == "addMiner")
                    {
                         this.numMiners = this.numMiners - 1;
                    }
                    if(this.queue[0].init == "addArcher")
                    {
                         this.numArchers = this.numArchers - 1;
                    }
                    if(this.queue[0].init == "addGiant")
                    {
                         this.numGiants = this.numGiants - 1;
                    }
                    if(this.queue[0].init == "addSwordMan")
                    {
                         this.numSwordman = this.numSwordman - 1;
                    }
                    if(this.queue[0].init == "addSpartan")
                    {
                         this.numSpartan = this.numSpartan - 1;
                    }
                    if(this.queue[0].init == "addWizard")
                    {
                         this.numWizard = this.numWizard - 1;
                    }
                    this.lastSpawnTime = this.squad.game.getGameTime();
                    this.squad[this.queue[0].init]();
                    this.queue.shift();
               }
          }
          if(this.squad.getTeamName() == "blue")
          {
               this.updateLoadingElement(this.numMiners,_root.HUD.minerLoading,_root.HUD.minerCancel,"addMiner");
               this.updateLoadingElement(this.numSwordman,_root.HUD.swordManLoading,_root.HUD.swordManCancel,"addSwordMan");
               this.updateLoadingElement(this.numArchers,_root.HUD.archerLoading,_root.HUD.archerCancel,"addArcher");
               this.updateLoadingElement(this.numSpartan,_root.HUD.spartanLoading,_root.HUD.spartanCancel,"addSpartan");
               this.updateLoadingElement(this.numGiants,_root.HUD.giantLoading,_root.HUD.giantCancel,"addGiant");
               this.updateLoadingElement(this.numWizard,_root.HUD.wizardLoading,_root.HUD.wizardCancel,"addWizard");
          }
     }
     function updateLoadingElement(number, clip, cancelClip, init)
     {
          if(number != 0)
          {
               clip._visible = true;
               cancelClip._visible = true;
               clip.num.text = number;
               if(this.queue[0].init == init)
               {
                    clip.gotoAndStop(int((this.squad.game.getGameTime() - this.lastSpawnTime) / this.queue[0].time * 5) + 1);
               }
          }
          else
          {
               cancelClip._visible = false;
               clip._visible = false;
          }
     }
     function pop(initFunction)
     {
          if(initFunction == "addMiner")
          {
               this.numMiners = this.numMiners - 1;
          }
          if(initFunction == "addArcher")
          {
               this.numArchers = this.numArchers - 1;
          }
          if(initFunction == "addGiant")
          {
               this.numGiants = this.numGiants - 1;
          }
          if(initFunction == "addSwordMan")
          {
               this.numSwordman = this.numSwordman - 1;
          }
          if(initFunction == "addSpartan")
          {
               this.numSpartan = this.numSpartan - 1;
          }
          if(initFunction == "addWizard")
          {
               this.numWizard = this.numWizard - 1;
          }
          var _loc4_ = -1;
          var _loc2_ = 0;
          while(_loc2_ < this.queue.length)
          {
               if(this.queue[_loc2_].init == initFunction)
               {
                    _loc4_ = _loc2_;
               }
               _loc2_ = _loc2_ + 1;
          }
          if(_loc4_ != -1)
          {
               this.queue.splice(_loc4_,1);
               return true;
          }
          return false;
     }
     function push(initFunction, productionTime)
     {
          if(this.queue.length == 0)
          {
               this.lastSpawnTime = this.squad.game.getGameTime();
          }
          if(initFunction == "addMiner")
          {
               this.numMiners = this.numMiners + 1;
          }
          if(initFunction == "addArcher")
          {
               this.numArchers = this.numArchers + 1;
          }
          if(initFunction == "addGiant")
          {
               this.numGiants = this.numGiants + 1;
          }
          if(initFunction == "addSwordMan")
          {
               this.numSwordman = this.numSwordman + 1;
          }
          if(initFunction == "addSpartan")
          {
               this.numSpartan = this.numSpartan + 1;
          }
          if(initFunction == "addWizard")
          {
               this.numWizard = this.numWizard + 1;
          }
          this.queue.push({init:initFunction,time:productionTime});
     }
     function size()
     {
          return this.queue.length;
     }
}
