package com.brockw.stickwar.campaign
{
     import com.brockw.game.KeyboardState;
     import com.brockw.game.Screen;
     import com.brockw.stickwar.BaseMain;
     import flash.display.MovieClip;
     import flash.events.Event;
     import flash.events.MouseEvent;
     import flash.net.URLRequest;
     import flash.net.navigateToURL;
     
     public class CampaignScreen extends Screen
     {
           
          
          private var main:BaseMain;
          
          private var txtDisplayLevel:GenericText;
          
          private var btnNextLevel:GenericButton;
          
          private var btnMainMenu:GenericButton;
          
          private var mc:campaignMap;
          
          private var keyboard:KeyboardState;
          
          public function CampaignScreen(main:BaseMain)
          {
               super();
               this.main = main;
               this.mc = new campaignMap();
               addChild(this.mc);
               this.mc.x = -657.7;
               this.mc.y = -584.9;
          }
          
          override public function maySwitchOnDisconnect() : Boolean
          {
               return false;
          }
          
          override public function enter() : void
          {
               this.main.soundManager.playSoundInBackground("loginMusic");
               this.keyboard = new KeyboardState(this.main.stage);
               if(this.main.campaign.currentLevel != 0)
               {
                    this.mc.gotoAndStop("level" + this.main.campaign.currentLevel);
               }
               else
               {
                    this.mc.gotoAndStop(1);
                    this.mc.map.stop();
               }
               addEventListener(Event.ENTER_FRAME,this.update);
               addEventListener(MouseEvent.CLICK,this.click);
               this.mc.bottomPanel.campaignButtons.autoSaveEnabled.addEventListener(MouseEvent.CLICK,this.disableSave);
               this.mc.bottomPanel.campaignButtons.autoSaveDisabled.addEventListener(MouseEvent.CLICK,this.enableSave);
               this.mc.bottomPanel.campaignButtons.playOnline.addEventListener(MouseEvent.CLICK,this.playOnlineClick);
               this.mc.bottomPanel.campaignButtons.strategyGuide.addEventListener(MouseEvent.CLICK,this.strategyGuideClick);
               this.mc.saveGamePrompt.visible = false;
               this.mc.saveGamePrompt.okButton.addEventListener(MouseEvent.CLICK,this.okButton);
               this.mc.text.mouseEnabled = false;
               this.mc.title.mouseEnabled = false;
               if(this.main.campaign.currentLevel == 0)
               {
                    this.main.showScreen("campaignGameScreen",false,true);
               }
          }
          
          private function strategyGuideClick(e:Event) : void
          {
               var url:URLRequest = new URLRequest("http://www.stickpage.com/stickempiresguide.shtml");
               navigateToURL(url,"_blank");
               if(this.main.tracker)
               {
                    this.main.tracker.trackEvent("link","http://www.stickpage.com/stickempiresguide.shtml");
               }
               this.main.soundManager.playSoundFullVolume("clickButton");
          }
          
          private function playOnlineClick(e:Event) : void
          {
               var url:URLRequest = new URLRequest("http://www.stickempires.com");
               navigateToURL(url,"_blank");
               if(this.main.tracker)
               {
                    this.main.tracker.trackEvent("link","http://www.stickempires.com");
               }
               this.main.soundManager.playSoundFullVolume("clickButton");
          }
          
          private function okButton(even:Event) : void
          {
               this.mc.saveGamePrompt.visible = false;
               this.main.soundManager.playSoundFullVolume("clickButton");
          }
          
          private function enableSave(evt:Event) : void
          {
               this.main.campaign.isAutoSaveEnabled = true;
               this.saveGame();
               trace("Enable Save");
               this.main.soundManager.playSoundFullVolume("clickButton");
          }
          
          private function disableSave(evt:Event) : void
          {
               this.main.campaign.isAutoSaveEnabled = false;
               trace("Disable Save");
               this.main.soundManager.playSoundFullVolume("clickButton");
          }
          
          private function saveGame() : void
          {
               this.main.campaign.save();
               if(this.main.tracker != null)
               {
                    this.main.tracker.trackEvent(this.main.campaign.getLevelDescription(),"save");
               }
               this.mc.saveGamePrompt.visible = true;
               this.mc.saveGamePrompt.messageText.text = "Game saved at " + this.main.campaign.getCurrentLevel().title;
          }
          
          private function click(evt:MouseEvent) : void
          {
               if(evt.target == this.mc.map.playbuttonflag && this.mc.currentFrameLabel == "level" + (this.main.campaign.currentLevel + 1))
               {
                    this.main.soundManager.playSoundFullVolume("clickButton");
                    this.clickPlay(null);
               }
          }
          
          public function update(evt:Event) : void
          {
               if(!this.main.isKongregate && this.main.isCampaignDebug && this.keyboard.isDown(78) && this.keyboard.isShift)
               {
                    ++this.main.campaign.currentLevel;
                    if(this.main.campaign.currentLevel % 2)
                    {
                         ++this.main.campaign.campaignPoints;
                    }
                    ++this.main.campaign.campaignPoints;
                    if(this.main.campaign.isGameFinished())
                    {
                         this.main.showScreen("summary",false,true);
                    }
                    else
                    {
                         this.leave();
                         this.enter();
                    }
               }
               this.mc.stop();
               if(this.mc.currentFrameLabel != "level" + (this.main.campaign.currentLevel + 1))
               {
                    this.mc.nextFrame();
                    if(this.mc.currentFrameLabel == "level" + (this.main.campaign.currentLevel + 1))
                    {
                         this.main.soundManager.playSoundFullVolume("SelectRaceSound");
                         if(this.main.campaign.isAutoSaveEnabled == true)
                         {
                              this.saveGame();
                         }
                    }
                    this.mc.map.playbuttonflag.turning.visible = false;
                    if(this.main.campaign.getCurrentLevel() != null)
                    {
                         this.mc.text.text = this.main.campaign.getCurrentLevel().storyName;
                         this.mc.title.text = this.main.campaign.getCurrentLevel().title;
                    }
               }
               else
               {
                    this.mc.map.playbuttonflag.turning.visible = true;
                    this.mc.text.text = this.main.campaign.getCurrentLevel().storyName;
                    this.mc.title.text = this.main.campaign.getCurrentLevel().title;
                    this.mc.bottomPanel.y += (1192.15 - this.mc.bottomPanel.y) * 1;
               }
               MovieClip(this.mc.map.playbuttonflag.turning).mouseEnabled = false;
               MovieClip(this.mc.map.playbuttonflag.turning).mouseChildren = false;
               MovieClip(this.mc.map.playbuttonflag).buttonMode = true;
               this.mc.map.gotoAndStop(this.mc.currentFrame);
               if(this.main.campaign.isAutoSaveEnabled)
               {
                    this.mc.bottomPanel.campaignButtons.autoSaveDisabled.visible = false;
                    this.mc.bottomPanel.campaignButtons.autoSaveEnabled.visible = true;
               }
               else
               {
                    this.mc.bottomPanel.campaignButtons.autoSaveDisabled.visible = true;
                    this.mc.bottomPanel.campaignButtons.autoSaveEnabled.visible = false;
               }
          }
          
          override public function leave() : void
          {
               this.keyboard.cleanUp();
               removeEventListener(Event.ENTER_FRAME,this.update);
               removeEventListener(MouseEvent.CLICK,this.click);
               this.mc.bottomPanel.campaignButtons.autoSaveEnabled.removeEventListener(MouseEvent.CLICK,this.disableSave);
               this.mc.bottomPanel.campaignButtons.autoSaveDisabled.removeEventListener(MouseEvent.CLICK,this.enableSave);
               this.mc.saveGamePrompt.okButton.removeEventListener(MouseEvent.CLICK,this.okButton);
          }
          
          private function clickMainMenu(evt:MouseEvent) : void
          {
               this.main.showScreen("login");
               this.main.soundManager.playSoundFullVolume("clickButton");
          }
          
          private function clickPlay(evt:MouseEvent) : void
          {
               this.main.showScreen("campaignGameScreen",false,true);
               this.main.soundManager.playSoundFullVolume("clickButton");
          }
     }
}
