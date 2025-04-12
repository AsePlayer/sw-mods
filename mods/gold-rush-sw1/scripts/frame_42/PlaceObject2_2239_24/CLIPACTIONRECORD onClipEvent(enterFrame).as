onClipEvent(enterFrame){
     if(c++ % 2 == 0)
     {
          time = getTimer();
     }
     else
     {
          fps.text = Math.round(1000 / (getTimer() - time));
     }
}
