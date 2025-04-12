var amountLoaded = _root.getBytesLoaded() / _root.getBytesTotal();
bar.barFill._xscale = amountLoaded * 100;
bar._visible = true;
