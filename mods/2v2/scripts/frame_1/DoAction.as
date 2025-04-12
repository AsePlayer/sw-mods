function checkSO()
{
     mySO = SharedObject.getLocal("test");
     if(!mySO.flush(1))
     {
          System.showSettings(1);
     }
}
_root.isTesting = false;
sites = ["farm.stickpage.com","www.stickpage.com"];
checkSO();
stop();
