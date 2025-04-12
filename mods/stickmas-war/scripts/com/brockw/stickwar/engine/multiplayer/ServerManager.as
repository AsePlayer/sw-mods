package com.brockw.stickwar.engine.multiplayer
{
     import com.smartfoxserver.v2.*;
     import com.smartfoxserver.v2.core.*;
     import com.smartfoxserver.v2.entities.data.*;
     import com.smartfoxserver.v2.requests.*;
     import flash.events.*;
     import flash.utils.*;
     
     public class ServerManager
     {
           
          
          public var sfs:SmartFox;
          
          internal var timer:Timer;
          
          private var ip:String;
          
          private var extensionHandler:Function;
          
          private var connectRetryTimer:Timer;
          
          private var connectionHandler:Function;
          
          private var lostConnectionHandler:Function;
          
          public function ServerManager(param1:String, param2:Function, param3:Function, param4:Function)
          {
               super();
               this.ip = param1;
               this.extensionHandler = param2;
               this.lostConnectionHandler = param4;
               this.connectionHandler = param3;
               this.sfs = new SmartFox();
               this.sfs.useBlueBox = false;
               this.sfs.addEventListener(SFSEvent.SOCKET_ERROR,this.connectRetry);
               this.sfs.addEventListener(SFSEvent.CONNECTION,this.onConnection);
               this.sfs.addEventListener(SFSEvent.CONNECTION_LOST,this.onConnectionLost);
               this.sfs.debug = false;
               this.sfs.connect(param1,9933);
               this.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE,param2);
               this.connectRetryTimer = new Timer(250);
               this.connectRetryTimer.addEventListener(TimerEvent.TIMER,this.connectRetry);
          }
          
          private function connectRetry(param1:Event) : void
          {
               trace("try to connect the register server");
          }
          
          public function cleanUp() : void
          {
               this.sfs.removeEventListener(SFSEvent.SOCKET_ERROR,this.connectRetry);
               this.sfs.removeEventListener(SFSEvent.CONNECTION,this.onConnection);
               this.sfs.removeEventListener(SFSEvent.LOGOUT,this.onConnectionLost);
          }
          
          private function onConnection(param1:SFSEvent) : void
          {
               trace("Success! NOW STOP TRYING!");
               this.connectRetryTimer.stop();
          }
          
          private function onConnectionLost(param1:SFSEvent) : void
          {
               trace("Connection Lost! NOW STOP TRYING!");
          }
     }
}
