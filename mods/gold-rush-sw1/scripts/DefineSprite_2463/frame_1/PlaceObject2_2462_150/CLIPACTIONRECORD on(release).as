on(release){
     var n = _root.campaignData.technology[orig]() + 1;
     if(n <= maxLevel)
     {
          _root.tryToBuy(price,effect,n);
          setbar();
     }
}
