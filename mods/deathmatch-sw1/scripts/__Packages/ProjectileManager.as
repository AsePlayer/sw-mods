class ProjectileManager
{
     var ARROW_INIT_VELOCITY = 14;
     var SPEAR_INIT_VELOCITY = 14;
     var baseArrayDepth = 6000;
     var GRAVITY = 0.3;
     var HIT_WIDTH = 10;
     var ARROW_DAMAGE = 5;
     var SPEAR_DAMAGE = 40;
     var baseScale = 2000;
     function ProjectileManager(game)
     {
          this.game = game;
          this.arrows = [];
          this.deadArrows = [];
          this.arrayIndex = 0;
          this.lastCollection = getTimer();
     }
     function update()
     {
          this.updateArrows();
     }
     function updateArrows()
     {
          var _loc2_ = undefined;
          var _loc4_ = undefined;
          var _loc8_ = undefined;
          var _loc3_ = undefined;
          for(_loc2_ in this.arrows)
          {
               if(this.game.getSquad1().getCastleHitArea().hitTest(this.arrows[_loc2_].clip) && this.arrows[_loc2_].team == "red")
               {
                    this.arrows[_loc2_].state = 2;
                    this.arrows[_loc2_].hitTime = getTimer();
                    this.game.getSquad1().damageCastle(this.arrows[_loc2_].damage / 5);
               }
               else if(this.game.getSquad2().getCastleHitArea().hitTest(this.arrows[_loc2_].clip) && this.arrows[_loc2_].team == "blue")
               {
                    this.arrows[_loc2_].state = 2;
                    this.arrows[_loc2_].hitTime = getTimer();
                    this.game.getSquad2().damageCastle(this.arrows[_loc2_].damage / 5);
               }
               else if(this.arrows[_loc2_].state == 0)
               {
                    _loc3_ = this.game.getPartitionManager().getLabeledTeam(this.arrows[_loc2_].team,this.arrows[_loc2_].clip._x);
                    for(_loc4_ in _loc3_)
                    {
                         if(Math.abs(_loc3_[_loc4_].getClip()._y - this.arrows[_loc2_].initY) < this.HIT_WIDTH)
                         {
                              if(_loc3_[_loc4_].getSquad().getTeamName() != this.arrows[_loc2_].team && this.arrows[_loc2_].clip.hitTest(_loc3_[_loc4_].getClip()))
                              {
                                   var _loc5_ = false;
                                   var _loc6_ = _loc3_[_loc4_].getClip()._y - _loc3_[_loc4_].getClip()._height;
                                   var _loc7_ = 10 * this.arrows[_loc2_].man.getScale() / 100;
                                   if(this.arrows[_loc2_].clip._y > _loc6_ && this.arrows[_loc2_].clip._y < _loc6_ + _loc7_)
                                   {
                                        _loc5_ = _loc3_[_loc4_].damage(this.arrows[_loc2_].damage * 7,this.arrows[_loc2_].dx / Math.abs(this.arrows[_loc2_].dx),"arrow_headshot");
                                        if(_loc3_[_loc4_].getHealth() <= 0)
                                        {
                                             if(this.arrows[_loc2_].clip._xscale > 0)
                                             {
                                                  _loc3_[_loc4_].faceDirection(1);
                                             }
                                             else
                                             {
                                                  _loc3_[_loc4_].faceDirection(-1);
                                             }
                                        }
                                   }
                                   else
                                   {
                                        _loc5_ = _loc3_[_loc4_].damage(this.arrows[_loc2_].damage,this.arrows[_loc2_].dx / Math.abs(this.arrows[_loc2_].dx),"arrow");
                                   }
                                   if(_loc5_)
                                   {
                                        this.game.getBloodManager().addSplatter(_loc3_[_loc4_].clip._x,this.arrows[_loc2_].clip._y,_loc3_[_loc4_].getScale(),_loc3_[_loc4_].getCurrentDirection());
                                   }
                                   this.arrows[_loc2_].state = 2;
                                   this.arrows[_loc2_].hitTime = getTimer();
                                   break;
                              }
                         }
                    }
               }
               if(this.arrows[_loc2_].state == 0)
               {
                    if(this.arrows[_loc2_].clip._y >= this.arrows[_loc2_].initY + Math.random() * 5)
                    {
                         if(this.arrows[_loc2_].clip.arrow._currentframe == 4)
                         {
                              this.game.getBloodManager().addSpark(this.arrows[_loc2_].clip._x,this.arrows[_loc2_].clip._y,this.arrows[_loc2_].clip._y * this.arrows[_loc2_].clip._y / this.baseScale,1);
                         }
                         this.arrows[_loc2_].clip._xscale = this.arrows[_loc2_].scale * 3 / 4;
                         this.arrows[_loc2_].state = 1;
                         this.arrows[_loc2_].hitTime = getTimer();
                         this.game.getSoundManager().playSound("arrowHitDirt",this.arrows[_loc2_].clip._x);
                    }
                    else
                    {
                         this.arrows[_loc2_].clip._x += this.arrows[_loc2_].dx;
                         this.arrows[_loc2_].clip._y += this.arrows[_loc2_].dy;
                         if(this.arrows[_loc2_].dy < 0)
                         {
                              _loc8_ = Math.atan(this.arrows[_loc2_].dx / (- this.arrows[_loc2_].dy)) * 180 / 3.141592653589793 - 90;
                         }
                         else
                         {
                              _loc8_ = Math.atan(this.arrows[_loc2_].dx / (- this.arrows[_loc2_].dy)) * 180 / 3.141592653589793 + 90;
                         }
                         this.arrows[_loc2_].clip._rotation = _loc8_;
                         this.arrows[_loc2_].dy += this.GRAVITY;
                    }
               }
               else if(this.arrows[_loc2_].state == 2)
               {
                    this.deadArrows.push(this.arrows[_loc2_]);
                    this.arrows.splice(_loc2_,1);
               }
          }
          if(getTimer() - this.lastCollection > 10000)
          {
               for(_loc2_ in this.deadArrows)
               {
                    if(this.deadArrows[_loc2_].state != 2)
                    {
                         this.deadArrows.splice(_loc2_,1);
                    }
                    else if(this.deadArrows[_loc2_].state == 2 || getTimer() - this.deadArrows[_loc2_].hitTime > 60000)
                    {
                         removeMovieClip(this.deadArrows[_loc2_].clip);
                         this.deadArrows.splice(_loc2_,1);
                    }
               }
          }
     }
     function addArrow(man, rot, type, power)
     {
          var _loc10_ = undefined;
          var _loc9_ = undefined;
          this.arrayIndex = this.arrayIndex + 1;
          this.arrayIndex %= 75;
          if(isNaN(rot) || rot == undefined)
          {
               rot = 0;
          }
          var _loc4_ = this.ARROW_INIT_VELOCITY * 1.5 * power;
          _loc10_ = _loc4_ * Math.cos(rot / 57.29577951308232);
          _loc9_ = _loc4_ * Math.sin(rot / 57.29577951308232);
          _root.soundManager.playSound("arrowShot",man.getX());
          this.game.screen.attachMovie("arrow","arrow_" + this.arrayIndex,this.baseArrayDepth + this.arrayIndex,{_x:man.getX(),_y:man.getY() - 50 * man.getScale() / 100});
          this.game.screen["arrow_" + this.arrayIndex]._xscale = man.getScale();
          this.game.screen["arrow_" + this.arrayIndex]._yscale = man.getScale();
          if(man == this.game.getCurrentCharacter())
          {
               type = type - 1;
               this.arrows.push({team:man.getSquad().getTeamName(),clip:this.game.screen["arrow_" + this.arrayIndex],dx:_loc10_,dy:_loc9_,man:man,state:0,initY:man.getY(),hitTime:0,damage:2 * Math.pow(1.25,type - 1) * this.ARROW_DAMAGE});
          }
          else
          {
               this.arrows.push({team:man.getSquad().getTeamName(),clip:this.game.screen["arrow_" + this.arrayIndex],dx:_loc10_,dy:_loc9_,man:man,state:0,initY:man.getY(),hitTime:0,damage:Math.pow(1.25,type - 1) * this.ARROW_DAMAGE});
          }
          this.game.screen["arrow_" + this.arrayIndex].arrow.gotoAndStop(type);
     }
     function addArrowFail(man, rot, type)
     {
          var _loc9_ = undefined;
          var _loc8_ = undefined;
          this.arrayIndex = this.arrayIndex + 1;
          this.arrayIndex %= 100;
          if(isNaN(rot) || rot == undefined)
          {
               rot = 0;
          }
          _loc9_ = this.ARROW_INIT_VELOCITY / 10 * Math.cos(rot / 57.29577951308232);
          _loc8_ = this.ARROW_INIT_VELOCITY / 10 * Math.sin(rot / 57.29577951308232);
          _root.soundManager.playSound("arrowShot",man.getX());
          this.game.screen.attachMovie("arrow","arrow_" + this.arrayIndex,this.baseArrayDepth + this.arrayIndex,{_x:man.getX(),_y:man.getY() - 50 * man.getScale() / 100});
          if(man == this.game.getCurrentCharacter())
          {
               type = type - 1;
          }
          this.game.screen["arrow_" + this.arrayIndex].arrow.gotoAndStop(type);
          this.game.screen["arrow_" + this.arrayIndex]._xscale = man.getScale();
          this.game.screen["arrow_" + this.arrayIndex]._yscale = man.getScale();
          this.arrows.push({team:man.getSquad().getTeamName(),clip:this.game.screen["arrow_" + this.arrayIndex],dx:_loc9_,dy:_loc8_,man:man,state:0,initY:man.getY(),hitTime:0,damage:Math.pow(1.25,type - 1) * this.ARROW_DAMAGE});
     }
     function addArrowFromCastle(x, y, rot, type, teamName)
     {
          var _loc8_ = undefined;
          var _loc6_ = undefined;
          this.arrayIndex = this.arrayIndex + 1;
          this.arrayIndex %= 100;
          y -= 25;
          _loc8_ = this.ARROW_INIT_VELOCITY * Math.cos(rot / 57.29577951308232);
          _loc6_ = this.ARROW_INIT_VELOCITY * Math.sin(rot / 57.29577951308232);
          _root.soundManager.playSound("arrowShot",x);
          this.game.screen.attachMovie("arrow","arrow_" + this.arrayIndex,this.baseArrayDepth + this.arrayIndex,{_x:x,_y:y});
          this.game.screen["arrow_" + this.arrayIndex].arrow.gotoAndStop(type);
          y += 25;
          this.game.screen["arrow_" + this.arrayIndex]._xscale = y * y / (this.baseScale / 1.5);
          this.game.screen["arrow_" + this.arrayIndex]._yscale = y * y / (this.baseScale / 1.5);
          this.arrows.push({team:teamName,clip:this.game.screen["arrow_" + this.arrayIndex],dx:_loc8_,dy:_loc6_,man:undefined,state:0,initY:y,hitTime:0,damage:Math.pow(1.25,type - 1) * this.ARROW_DAMAGE});
     }
     function addSpear(man, rot)
     {
          var _loc6_ = undefined;
          var _loc5_ = undefined;
          this.arrayIndex = this.arrayIndex + 1;
          this.arrayIndex %= 100;
          _loc6_ = this.SPEAR_INIT_VELOCITY * Math.cos(rot / 57.29577951308232);
          _loc5_ = this.SPEAR_INIT_VELOCITY * Math.sin(rot / 57.29577951308232);
          this.game.screen.attachMovie("throwspear","arrow_" + this.arrayIndex,this.baseArrayDepth + this.arrayIndex,{_x:man.getX(),_y:man.getY() - 50 * man.getScale() / 100});
          this.game.screen["arrow_" + this.arrayIndex]._xscale = man.getScale();
          this.game.screen["arrow_" + this.arrayIndex]._yscale = man.getScale();
          this.arrows.push({team:man.getSquad().getTeamName(),clip:this.game.screen["arrow_" + this.arrayIndex],dx:_loc6_,dy:_loc5_,man:man,state:0,initY:man.getY(),hitTime:0,damage:this.SPEAR_DAMAGE});
     }
}
