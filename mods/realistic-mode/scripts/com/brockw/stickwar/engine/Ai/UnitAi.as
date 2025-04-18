package com.brockw.stickwar.engine.Ai
{
     import com.brockw.ds.Queue;
     import com.brockw.game.Util;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.Gold;
     import com.brockw.stickwar.engine.Ore;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.units.*;
     
     public class UnitAi
     {
           
          
          protected var unit:Unit;
          
          private var _commandQueue:Queue;
          
          protected var _currentCommand:UnitCommand;
          
          private var defaultStandCommand:StandCommand;
          
          protected var _mayAttack:Boolean;
          
          protected var _mayMoveToAttack:Boolean;
          
          protected var _mayMove:Boolean;
          
          protected var isTargeted:Boolean;
          
          protected var goalX:int;
          
          protected var goalY:int;
          
          protected var intendedX:int;
          
          protected var _currentTarget:Unit;
          
          protected var lastCommand:UnitCommand;
          
          protected var isNonAttackingMage:Boolean;
          
          private var cachedTarget:Unit;
          
          private var lastCacheFrame:int;
          
          public function UnitAi()
          {
               super();
               this.currentCommand = this.defaultStandCommand = new StandCommand(null);
               this.commandQueue = new Queue(1000);
               this.isNonAttackingMage = false;
               this.lastCacheFrame = 0;
               this.init();
               this.intendedX = 1;
          }
          
          public static function checkForMineAtCoordinate(team:Team, game:StickWar, x:Number, y:Number) : Ore
          {
               var ore:String = null;
               var o:Ore = null;
               if(team.statue.hitTest(x,y))
               {
                    return team.statue;
               }
               for(ore in game.map.gold)
               {
                    o = game.map.gold[ore];
                    if(o.hitTest(x,y))
                    {
                         return game.map.gold[ore];
                    }
               }
               return null;
          }
          
          public function init() : void
          {
               this.isTargeted = false;
               this.mayAttack = false;
               this.mayMoveToAttack = false;
               this.mayMove = false;
               this.currentTarget = null;
               this.lastCommand = null;
               this.goalX = 0;
               this.goalY = 0;
          }
          
          public function update(game:StickWar) : void
          {
          }
          
          public function appendCommand(game:StickWar, c:UnitCommand) : void
          {
               this.commandQueue.push(c);
          }
          
          public function setCommand(game:StickWar, c:UnitCommand) : void
          {
               this.commandQueue.clear();
               if(!this.unit.team.isAi == true)
               {
                    if(!(this.currentCommand.type == UnitCommand.ATTACK_MOVE && c.type == UnitCommand.ATTACK_MOVE) && (this.currentCommand.targetId != c.targetId || c.targetId == -1))
                    {
                         this.unit.stateFixForCutToWalk();
                    }
               }
               this.lastCommand = this.currentCommand;
               this.currentCommand = c;
               this.setParamatersFromCommand(game);
               if(c.type == UnitCommand.REMOVE_TOWER_COMMAND)
               {
                    trace("REMOVE");
               }
          }
          
          protected function checkNextMove(game:StickWar) : void
          {
               if(this.currentCommand.isFinished(this.unit))
               {
                    if(this.currentCommand != this.defaultStandCommand)
                    {
                    }
                    this.nextMove(game);
               }
          }
          
          protected function restoreMove(game:StickWar) : void
          {
               if(this.lastCommand == null)
               {
                    this.currentCommand = this.defaultStandCommand;
               }
               else
               {
                    this.currentCommand = this.lastCommand;
               }
               if(this.currentCommand.isToggle)
               {
                    this.currentCommand = this.defaultStandCommand;
               }
               this.setParamatersFromCommand(game,true);
          }
          
          protected function nextMove(game:StickWar) : void
          {
               this.lastCommand = this.currentCommand;
               if(this.commandQueue.isEmpty())
               {
                    this.currentCommand = this.defaultStandCommand;
                    this.setParamatersFromCommand(game);
               }
               else
               {
                    this.currentCommand = UnitCommand(this.commandQueue.pop());
                    this.setParamatersFromCommand(game);
               }
          }
          
          public function baseUpdate(game:StickWar) : void
          {
               var yMovement:Number = NaN;
               var offset:Number = NaN;
               this.checkNextMove(game);
               var target:Unit = this.getClosestTarget();
               if(this.mayAttack && (this.unit.mayAttack(target) || target is Wall && Math.abs(target.px - this.unit.px) < target.pwidth + this.unit.pwidth / 2))
               {
                    if(target.damageWillKill(0,this.unit.getDamageToUnit(target)) && this.unit.getDirection() != target.getDirection() && this.unit.getDirection() == Util.sgn(target.px - this.unit.px))
                    {
                         if(!this.unit.startDual(target))
                         {
                              this.unit.attack();
                         }
                    }
                    else
                    {
                         this.unit.attack();
                    }
               }
               else if(this.mayMoveToAttack && this.unit.sqrDistanceTo(target) < 640000 && !this.unit.isGarrisoned)
               {
                    if(this.isNonAttackingMage)
                    {
                         if(this.unit.type == Unit.U_MONK)
                         {
                              if(this.unit.sqrDistanceTo(target) > 50000)
                              {
                                   yMovement = 0;
                                   if(target.type != Unit.U_WALL && Math.abs(this.unit.px - target.px) < 200)
                                   {
                                        yMovement = target.py - this.unit.py;
                                   }
                                   if(Util.sgn(target.dx) == Util.sgn(this.unit.dx) && Math.abs(target.dx) > 1)
                                   {
                                        this.unit.walk((target.px - this.unit.px) / 20,yMovement,Util.sgn(target.px - this.unit.px));
                                   }
                                   else
                                   {
                                        offset = Util.sgn(target.px - this.unit.px) * this.unit.weaponReach() * 0.5;
                                        if(Math.abs(target.px - this.unit.px) < this.unit.weaponReach() * 0.9)
                                        {
                                             this.unit.walk(0,yMovement,Util.sgn(target.px - this.unit.px));
                                        }
                                        else
                                        {
                                             this.unit.walk((target.px - offset - this.unit.px) / 100,yMovement,Util.sgn(target.px - this.unit.px));
                                        }
                                   }
                                   if(Math.abs(target.px - this.unit.px - (this.unit.pwidth + target.pwidth) * 0.125 * this.unit.team.direction) < 10)
                                   {
                                        this.unit.faceDirection(target.px - this.unit.px);
                                   }
                              }
                              else if(this.unit.team.isAi)
                              {
                                   yMovement = 0;
                                   if(target.type != Unit.U_WALL && Math.abs(this.unit.px - target.px) < 200)
                                   {
                                        yMovement = target.py - this.unit.py;
                                   }
                                   if(Util.sgn(target.dx) == Util.sgn(this.unit.dx) && Math.abs(target.dx) > 1)
                                   {
                                        this.unit.walk((target.px - this.unit.px) / 20,yMovement,Util.sgn(target.px - this.unit.px));
                                   }
                                   else
                                   {
                                        offset = Util.sgn(target.px - this.unit.px) * this.unit.weaponReach() * 0.5;
                                        if(Math.abs(target.px - this.unit.px) < this.unit.weaponReach() * 0.9)
                                        {
                                             this.unit.walk(0,yMovement,Util.sgn(target.px - this.unit.px));
                                        }
                                        else
                                        {
                                             this.unit.walk((target.px - offset - this.unit.px) / 100,yMovement,Util.sgn(target.px - this.unit.px));
                                        }
                                   }
                                   if(Math.abs(target.px - this.unit.px - (this.unit.pwidth + target.pwidth) * 0.125 * this.unit.team.direction) < 10)
                                   {
                                        this.unit.faceDirection(target.px - this.unit.px);
                                   }
                              }
                         }
                         else if(this.currentCommand.type != UnitCommand.STAND)
                         {
                              yMovement = 0;
                              if(target.type != Unit.U_WALL && Math.abs(this.unit.px - target.px) < 200)
                              {
                                   yMovement = target.py - this.unit.py;
                              }
                              if(Util.sgn(target.dx) == Util.sgn(this.unit.dx) && Math.abs(target.dx) > 1)
                              {
                                   this.unit.walk((target.px - this.unit.px) / 20,yMovement,Util.sgn(target.px - this.unit.px));
                              }
                              else
                              {
                                   offset = Util.sgn(target.px - this.unit.px) * this.unit.weaponReach() * 0.5;
                                   if(Math.abs(target.px - this.unit.px) < this.unit.weaponReach() * 0.9)
                                   {
                                        this.unit.walk(0,yMovement,Util.sgn(target.px - this.unit.px));
                                   }
                                   else
                                   {
                                        this.unit.walk((target.px - offset - this.unit.px) / 100,yMovement,Util.sgn(target.px - this.unit.px));
                                   }
                              }
                              if(Math.abs(target.px - this.unit.px - (this.unit.pwidth + target.pwidth) * 0.125 * this.unit.team.direction) < 10)
                              {
                                   this.unit.faceDirection(target.px - this.unit.px);
                              }
                         }
                         else
                         {
                              this.unit.faceDirection(target.px - this.unit.px);
                         }
                    }
                    else
                    {
                         yMovement = 0;
                         if(target.type != Unit.U_WALL && Math.abs(this.unit.px - target.px) < 200)
                         {
                              if(Math.abs(this.unit.py - target.py) < 40)
                              {
                                   yMovement = 0;
                              }
                              else
                              {
                                   yMovement = target.py - this.unit.py;
                              }
                         }
                         if(Util.sgn(target.dx) == Util.sgn(this.unit.dx) && Math.abs(target.dx) > 1)
                         {
                              this.unit.walk((target.px - this.unit.px) / 20,yMovement,Util.sgn(target.px - this.unit.px));
                         }
                         else
                         {
                              offset = Util.sgn(target.px - this.unit.px) * this.unit.weaponReach() * 0.5;
                              if(Math.abs(target.px - this.unit.px) < this.unit.weaponReach() * 0.9)
                              {
                                   this.unit.walk(0,yMovement,Util.sgn(target.px - this.unit.px));
                              }
                              else
                              {
                                   this.unit.walk((target.px - offset - this.unit.px) / 100,yMovement,Util.sgn(target.px - this.unit.px));
                              }
                         }
                         if(Math.abs(target.px - this.unit.px - (this.unit.pwidth + target.pwidth) * 0.125 * this.unit.team.direction) < 10)
                         {
                              this.unit.faceDirection(target.px - this.unit.px);
                         }
                    }
                    this.unit.mayWalkThrough = false;
               }
               else if(this.mayMove)
               {
                    this.unit.mayWalkThrough = false;
                    this.unit.walk((this.goalX - this.unit.px) / 100,(this.goalY - this.unit.py) / 100,this.intendedX);
               }
          }
          
          protected function checkForMines(game:StickWar) : Ore
          {
               if(this.currentCommand is MoveCommand)
               {
                    if(this.currentCommand.targetId in game.units)
                    {
                         if(game.units[this.currentCommand.targetId] is Gold || game.units[this.currentCommand.targetId] is Statue)
                         {
                              return game.units[this.currentCommand.targetId];
                         }
                    }
               }
               return null;
          }
          
          protected function checkForUnitAttack(game:StickWar) : Unit
          {
               var x:int = 0;
               var y:int = 0;
               if(this.currentCommand is MoveCommand)
               {
                    x = MoveCommand(this.currentCommand).realX;
                    y = MoveCommand(this.currentCommand).realY;
                    if(x * this.unit.team.direction < this.unit.team.direction * this.unit.team.homeX)
                    {
                         return null;
                    }
                    if(this.currentCommand.targetId in game.units && game.units[this.currentCommand.targetId] is Unit)
                    {
                         if(game.units[this.currentCommand.targetId].team.id == this.unit.team.id)
                         {
                              return null;
                         }
                         if(Boolean(game.units[this.currentCommand.targetId].isFlying()) && !this.unit.canAttackAir())
                         {
                              return null;
                         }
                         this.currentTarget = game.units[this.currentCommand.targetId];
                         this.intendedX = Util.sgn(this.currentTarget.x - this.unit.px);
                         this.mayAttack = true;
                         this.mayMoveToAttack = true;
                         this.isTargeted = true;
                         return game.units[this.currentCommand.targetId];
                    }
                    this.isTargeted = false;
                    return null;
               }
               return null;
          }
          
          private function setParamatersFromCommand(game:StickWar, isRestore:Boolean = false) : void
          {
               if(this.currentCommand.type == UnitCommand.STAND)
               {
                    this.mayAttack = true;
                    this.mayMoveToAttack = true;
                    this.mayMove = false;
                    this.unit.mayWalkThrough = false;
               }
               else if(this.currentCommand.type == UnitCommand.HOLD)
               {
                    this.mayAttack = true;
                    this.mayMoveToAttack = false;
                    this.mayMove = false;
                    this.unit.mayWalkThrough = false;
               }
               else if(this.currentCommand.type == UnitCommand.GARRISON)
               {
                    this.mayAttack = false;
                    this.mayMoveToAttack = false;
                    this.mayMove = true;
                    this.unit.mayWalkThrough = true;
                    this.unit.garrison();
               }
               else if(this.currentCommand.type == UnitCommand.UNGARRISON)
               {
                    this.unit.ungarrison();
                    this.unit.mayWalkThrough = true;
                    this.mayAttack = false;
                    this.mayMoveToAttack = false;
                    this.mayMove = true;
                    this.goalX = this.unit.team.homeX + this.unit.team.direction * 200;
                    this.intendedX = Util.sgn(this.goalX - this.unit.px);
               }
               else if(this.currentCommand.type == UnitCommand.MOVE)
               {
                    this.unit.mayWalkThrough = false;
                    this.mayAttack = false;
                    this.mayMoveToAttack = false;
                    this.mayMove = true;
                    this.goalX = MoveCommand(this.currentCommand).goalX;
                    this.intendedX = Util.sgn(this.goalX - this.unit.px);
                    this.goalY = MoveCommand(this.currentCommand).goalY;
                    if(this.goalX * this.unit.team.direction > this.unit.team.homeX * this.unit.team.direction)
                    {
                         this.unit.ungarrison();
                    }
                    this.currentTarget = this.checkForUnitAttack(game);
                    if(this.unit.type == Unit.U_MONK && this.currentTarget != null)
                    {
                         this.mayAttack = true;
                         this.mayMoveToAttack = true;
                         this.mayMove = true;
                    }
                    else if(this.unit.type == Unit.U_MINER || this.unit.type == Unit.U_CHAOS_MINER)
                    {
                         if(!this.unit.isGarrisoned)
                         {
                              MinerAi(this).targetOre = this.checkForMines(game);
                              if(MinerAi(this).targetOre is Statue)
                              {
                                   MinerAi(this).isGoingForOre = false;
                              }
                              else
                              {
                                   MinerAi(this).isGoingForOre = true;
                              }
                         }
                    }
               }
               else if(this.currentCommand.type == UnitCommand.ATTACK_MOVE)
               {
                    this.unit.ungarrison();
                    if(this.unit.type != Unit.U_MINER && this.unit.type != Unit.U_CHAOS_MINER)
                    {
                         this.mayAttack = true;
                         this.mayMoveToAttack = true;
                         this.mayMove = true;
                         this.goalX = AttackMoveCommand(this.currentCommand).goalX;
                         this.intendedX = Util.sgn(this.goalX - this.unit.px);
                         this.goalY = AttackMoveCommand(this.currentCommand).goalY;
                         this.unit.mayWalkThrough = true;
                    }
                    else
                    {
                         if(this.unit.team.isAi == false && MinerAi(this).targetOre != null)
                         {
                              MinerAi(this).targetOre = null;
                         }
                         this.mayAttack = true;
                         this.mayMoveToAttack = true;
                         this.mayMove = true;
                         this.goalX = AttackMoveCommand(this.currentCommand).goalX;
                         this.intendedX = Util.sgn(this.goalX - this.unit.px);
                         this.goalY = AttackMoveCommand(this.currentCommand).goalY;
                    }
               }
          }
          
          public function getClosestUnitTarget() : Unit
          {
               var rIndex:* = undefined;
               var u:Unit = null;
               var d:Number = NaN;
               if(this.unit.team.enemyTeam.units.length == 0)
               {
                    return this.unit.team.enemyTeam.statue;
               }
               var minDistance:Number = Number.POSITIVE_INFINITY;
               if(this.currentTarget != null && (!this.currentTarget.isAlive() || !Unit(this.currentTarget).isTargetable()))
               {
                    minDistance = Number.POSITIVE_INFINITY;
                    this.currentTarget = null;
               }
               if(this.currentTarget != null)
               {
                    minDistance = this.unit.sqrDistanceToTarget(this.currentTarget);
               }
               if(this.currentTarget != null && this.isTargeted)
               {
                    return this.currentTarget;
               }
               this.isTargeted = false;
               for(var i:int = 0; i < 3; i++)
               {
                    rIndex = this.unit.team.game.random.nextInt() % this.unit.team.enemyTeam.units.length;
                    u = this.unit.team.enemyTeam.units[rIndex];
                    if(!(u.pz != 0 && !this.unit.canAttackAir()))
                    {
                         d = this.unit.sqrDistanceToTarget(u);
                         if(d * 1.3 < minDistance && Unit(this.unit.team.enemyTeam.units[rIndex]).isTargetable())
                         {
                              minDistance = d;
                              this.currentTarget = this.unit.team.enemyTeam.units[rIndex];
                         }
                    }
               }
               if(this.currentTarget == null)
               {
                    return this.unit.team.enemyTeam.statue;
               }
               return this.currentTarget;
          }
          
          public function getClosestTarget() : Unit
          {
               var w:Wall = null;
               if(this.lastCacheFrame == this.unit.team.game.frame)
               {
                    return this.cachedTarget;
               }
               var u:Unit = this.getClosestUnitTarget();
               for each(w in this.unit.team.enemyTeam.walls)
               {
                    if(this.unit.px < w.px && w.px < u.px)
                    {
                         u = w;
                    }
                    else if(this.unit.px > w.px && w.px > u.px)
                    {
                         u = w;
                    }
               }
               this.currentTarget = this.cachedTarget = u;
               this.lastCacheFrame = this.unit.team.game.frame;
               return u;
          }
          
          public function get commandQueue() : Queue
          {
               return this._commandQueue;
          }
          
          public function set commandQueue(value:Queue) : void
          {
               this._commandQueue = value;
          }
          
          public function cleanUp() : void
          {
               this.currentCommand = null;
               this.currentTarget = null;
          }
          
          public function get currentTarget() : Unit
          {
               return this._currentTarget;
          }
          
          public function set currentTarget(value:Unit) : void
          {
               this._currentTarget = value;
          }
          
          public function get mayAttack() : Boolean
          {
               return this._mayAttack;
          }
          
          public function set mayAttack(value:Boolean) : void
          {
               this._mayAttack = value;
          }
          
          public function get currentCommand() : UnitCommand
          {
               return this._currentCommand;
          }
          
          public function set currentCommand(value:UnitCommand) : void
          {
               this._currentCommand = value;
          }
          
          public function get mayMoveToAttack() : Boolean
          {
               return this._mayMoveToAttack;
          }
          
          public function set mayMoveToAttack(value:Boolean) : void
          {
               this._mayMoveToAttack = value;
          }
          
          public function get mayMove() : Boolean
          {
               return this._mayMove;
          }
          
          public function set mayMove(value:Boolean) : void
          {
               this._mayMove = value;
          }
     }
}
