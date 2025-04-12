onClipEvent(enterFrame){
     if(_currentframe == 1 && getTimer() - lastBreath > time)
     {
          play();
          lastBreath = getTimer();
     }
}
