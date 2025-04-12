class SoundManager
{
     var soundDepth = 1900000000;
     var soundNumber = 0;
     var trackDepth = 2000000000;
     var trackNumber = 0;
     function SoundManager()
     {
          this.game = this.game;
          this.sounds = [];
          this.currentTrack = undefined;
          this.tracks = {};
          this.isSound = true;
          this.fadeAmount = 0;
          this.addTrack("Battle_of_the_Shadow_Elves");
          this.addTrack("fieldOfMemories");
          this.addTrack("victoryHorns");
          this.addTrack("menu_Theme");
          this.addTrack("Entering_the_Stronghold");
          this.addSound("marching","marching");
          this.addSound("arrowShot","arrowShot");
          this.addSound("magicSound","magicSound");
          this.addSound("arrowHitDirt","arrowHitDirt");
          this.addSound("arrowHitMetal","arrowHitMetal");
          this.addSound("swordHit1","swordHit1");
          this.addSound("swordHit2","swordHit2");
          this.addSound("swordHit3","swordHit3");
          this.addSound("swordHit4","swordHit4");
          this.addSound("magesummon","magesummon");
          this.addSound("magespellfail","magespellfail");
          this.addSound("buildingDestroySound","buildingDestroySound");
          this.addSound("attack1","attack1");
          this.addSound("defend1","defend1");
          this.addSound("manTheFort","manTheFort");
          this.addSound("pain4","pain4");
          this.addSound("IWillFinishThis","IWillFinishThis");
          this.addSound("pain5","pain5");
          this.addSound("pain6","pain6");
          this.addSound("pain7","pain7");
          this.addSound("Vamp_Pain","Vamp_Pain");
          this.addSound("giantSwing1","giantSwing1");
          this.addSound("giantSwing2","giantSwing2");
          this.addSound("failmission1","failmission1");
          this.addSound("victorysound1","victorysound1");
          this.addSound("victorysound2","victorysound2");
          this.addSound("victorysound3","victorysound3");
     }
     function setGame(game)
     {
          this.game = game;
     }
     function update()
     {
          this.x = this.game.getScreenX();
          this.y = 0;
     }
     function playSoundCentre(soundLabel)
     {
          this.playSoundStunt(soundLabel,- this.game.getScreenX());
     }
     function playSound(soundLabel, xPosition)
     {
          if(!this.isSound)
          {
               return undefined;
          }
          if(this.sounds[soundLabel] != undefined)
          {
               var _loc4_ = 100 * Math.abs(this.game.getScreenX() + xPosition) / (this.game.getRIGHT() - this.game.getLEFT());
               if(this.game == undefined)
               {
                    _loc4_ = 0;
               }
               var _loc5_ = (100 - _loc4_) * (100 - _loc4_) / 100;
               this.sounds[soundLabel].setVolume(_loc5_);
               var _loc6_ = 200 * (this.game.getScreenX() + xPosition) / (this.game.getRIGHT() - this.game.getLEFT());
               this.sounds[soundLabel].setPan(_loc6_);
               if(this.sounds[soundLabel].position == this.sounds[soundLabel].duration)
               {
                    this.sounds[soundLabel].start();
               }
               else if(this.sounds[soundLabel].position == 0)
               {
                    this.sounds[soundLabel].start();
               }
          }
     }
     function playSoundStunt(soundLabel, xPosition)
     {
          if(!this.isSound)
          {
               return undefined;
          }
          if(this.sounds[soundLabel] != undefined)
          {
               var _loc4_ = 100 * Math.abs(this.game.getScreenX() + xPosition) / (this.game.getRIGHT() - this.game.getLEFT());
               if(this.game == undefined)
               {
                    _loc4_ = 0;
               }
               var _loc5_ = (100 - _loc4_) * (100 - _loc4_) / 100;
               this.sounds[soundLabel].setVolume(_loc5_ * 0.7);
               var _loc6_ = 200 * (this.game.getScreenX() + xPosition) / (this.game.getRIGHT() - this.game.getLEFT());
               this.sounds[soundLabel].setPan(_loc6_);
               this.sounds[soundLabel].start();
          }
     }
     function addTrack(labelName)
     {
          var _loc4_ = _root.attachMovie(labelName + "Mc",labelName + "Mc",this.trackDepth + this.trackNumber);
          var _loc5_ = new Sound(_loc4_);
          _loc5_.attachSound(labelName);
          this.tracks[labelName] = _loc5_;
          this.trackNumber++;
     }
     function addSound(labelName, libraryName)
     {
          var _loc5_ = _root.attachMovie(labelName + "Mc",libraryName + "Mc",this.soundDepth + this.soundNumber);
          var _loc6_ = new Sound(_loc5_);
          _loc6_.attachSound(libraryName);
          this.sounds[labelName] = _loc6_;
          this.soundNumber++;
     }
     function playBackgroundMusic(name)
     {
          this.tracks[this.currentTrack].stop();
          this.currentTrack = name;
          this.tracks[name].setVolume(100);
          if(!this.isSound)
          {
               this.tracks[name].setVolume(0);
          }
          this.tracks[name].start(0,99);
     }
     function stopBackgroundMusic()
     {
          this.tracks[this.currentTrack].stop();
     }
     function setSoundToggle()
     {
          this.toggleSound();
          this.toggleSound();
     }
     function toggleSound()
     {
          if(this.isSound)
          {
               this.isSound = false;
               this.tracks[this.currentTrack].setVolume(0);
               _root.HUD.soundToggle.gotoAndStop(2);
          }
          else
          {
               this.isSound = true;
               this.tracks[this.currentTrack].setVolume(100);
               _root.HUD.soundToggle.gotoAndStop(1);
          }
     }
}
