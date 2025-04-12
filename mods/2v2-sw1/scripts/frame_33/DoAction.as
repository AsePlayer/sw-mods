Color.prototype.setTint = function(r, g, b, amount)
{
     var _loc4_ = 100 - amount;
     var _loc2_ = new Object();
     _loc2_.ra = _loc2_.ga = _loc2_.ba = _loc4_;
     var _loc3_ = amount / 100;
     _loc2_.rb = r * _loc3_;
     _loc2_.gb = g * _loc3_;
     _loc2_.bb = b * _loc3_;
     this.setTransform(_loc2_);
};
