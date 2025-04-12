on(release){
     var n = _root.campaignData.technology[orig]();
     if(n <= maxLevel)
     {
          _root.tryToBuy(price,effect,n);
          setbar();
     }
}
