package com.brockw.stickwar.singleplayer
{
     import com.brockw.stickwar.BaseMain;
     import com.brockw.stickwar.campaign.Campaign;
     import com.brockw.stickwar.campaign.CampaignGameScreen;
     import com.brockw.stickwar.engine.Ai.RangedAi;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.Team.TechItem;
     import com.brockw.stickwar.engine.multiplayer.moves.*;
     import com.brockw.stickwar.engine.units.*;
     import flash.utils.Dictionary;
     
     public class EnemyGoodTeamAi extends EnemyTeamAi
     {
           
          
          private var buildOrder:Array;
          
          private var nukeSpell:NukeCommand;
          
          private var electricWallSpell:StunCommand;
          
          private var rage:SwordwrathRageCommand;
          
          private var poisonSpell:PoisonDartCommand;
          
          private var freezingSpell:FreezingCommand;
          
          private var ArcherTargeter:Ninja;
          
          internal var unitMove:UnitMove = null;
          
          public function EnemyGoodTeamAi(param1:Team, param2:BaseMain, param3:StickWar, param4:* = true)
          {
               var _loc6_:int = 0;
               unitComposition = new Dictionary();
               unitComposition[Unit.U_MINER] = param2.campaign.xml.Order.UnitComposition.Miner;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Miner) != "")
               {
                    unitComposition[Unit.U_MINER] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Miner);
               }
               unitComposition[Unit.U_SWORDWRATH] = param2.campaign.xml.Order.UnitComposition.Swordwrath;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Swordwrath) != "")
               {
                    unitComposition[Unit.U_SWORDWRATH] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Swordwrath);
               }
               unitComposition[Unit.U_ARCHER] = param2.campaign.xml.Order.UnitComposition.Archidon;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Archidon) != "")
               {
                    unitComposition[Unit.U_ARCHER] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Archidon);
               }
               unitComposition[Unit.U_SPEARTON] = param2.campaign.xml.Order.UnitComposition.Spearton;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Spearton) != "")
               {
                    unitComposition[Unit.U_SPEARTON] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Spearton);
               }
               unitComposition[Unit.U_NINJA] = param2.campaign.xml.Order.UnitComposition.Ninja;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Ninja) != "")
               {
                    unitComposition[Unit.U_NINJA] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Ninja);
               }
               unitComposition[Unit.U_FLYING_CROSSBOWMAN] = param2.campaign.xml.Order.UnitComposition.FlyingCrossbowman;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.FlyingCrossbowman) != "")
               {
                    unitComposition[Unit.U_FLYING_CROSSBOWMAN] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.FlyingCrossbowman);
               }
               unitComposition[Unit.U_MONK] = param2.campaign.xml.Order.UnitComposition.Monk;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Monk) != "")
               {
                    unitComposition[Unit.U_MONK] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Monk);
               }
               unitComposition[Unit.U_MAGIKILL] = param2.campaign.xml.Order.UnitComposition.Magikill;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Magikill) != "")
               {
                    unitComposition[Unit.U_MAGIKILL] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Magikill);
               }
               unitComposition[Unit.U_ENSLAVED_GIANT] = param2.campaign.xml.Order.UnitComposition.EnslavedGiant;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.EnslavedGiant) != "")
               {
                    unitComposition[Unit.U_ENSLAVED_GIANT] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.EnslavedGiant);
               }
               var _loc5_:* = [Unit.U_ENSLAVED_GIANT,Unit.U_MAGIKILL,Unit.U_FLYING_CROSSBOWMAN,Unit.U_SPEARTON,Unit.U_SWORDWRATH,Unit.U_ARCHER,Unit.U_MONK,Unit.U_NINJA];
               this.buildOrder = [];
               for each(_loc6_ in _loc5_)
               {
                    if(param1.unitsAvailable == null || _loc6_ in param1.unitsAvailable)
                    {
                         this.buildOrder.push(_loc6_);
                    }
               }
               this.nukeSpell = new NukeCommand(param3);
               this.electricWallSpell = new StunCommand(param3);
               this.poisonSpell = new PoisonDartCommand(param3);
               this.freezingSpell = new FreezingCommand(param3);
               super(param1,param2,param3,param4);
          }
          
          override public function update(param1:StickWar) : void
          {
               super.update(param1);
          }
          
          override protected function isArmyHealers() : Boolean
          {
               var _loc1_:int = 0;
               if(Unit.U_MONK in unitComposition)
               {
                    _loc1_ = int(unitComposition[Unit.U_MONK]);
               }
               if(_loc1_ * Number(team.game.xml.xml.Order.Units.monk.population) == team.attackingForcePopulation)
               {
                    return true;
               }
               return false;
          }
          
          override protected function updateUnitCreation(param1:StickWar) : void
          {
               var _loc3_:int = 0;
               var _loc4_:int = 0;
               var _loc5_:TechItem = null;
               if(!enemyIsAttacking() && (team.population < 6 || enemyIsWeak()))
               {
                    _loc4_ = int(team.unitGroups[Unit.U_MINER].length);
                    if(_loc4_ < unitComposition[Unit.U_MINER] && team.unitProductionQueue[team.unitInfo[Unit.U_MINER][2]].length == 0)
                    {
                         param1.requestToSpawn(team.id,Unit.U_MINER);
                    }
               }
               var _loc2_:int = 0;
               _loc3_ = 0;
               while(_loc3_ < this.buildOrder.length)
               {
                    _loc4_ = int(team.unitGroups[this.buildOrder[_loc3_]].length);
                    if(_loc4_ >= unitComposition[this.buildOrder[_loc3_]])
                    {
                         _loc2_++;
                    }
                    else if(team.unitProductionQueue[team.unitInfo[this.buildOrder[_loc3_]][2]].length == 0)
                    {
                         param1.requestToSpawn(team.id,this.buildOrder[_loc3_]);
                    }
                    _loc3_++;
               }
               if(_loc2_ >= this.buildOrder.length)
               {
                    _loc3_ = 0;
                    while(_loc3_ < this.buildOrder.length)
                    {
                         _loc4_ = int(team.unitGroups[this.buildOrder[_loc3_]].length);
                         if(team.unitProductionQueue[team.unitInfo[this.buildOrder[_loc3_]][2]].length == 0)
                         {
                              param1.requestToSpawn(team.id,this.buildOrder[_loc3_]);
                         }
                         _loc3_++;
                    }
               }
               if(!(this.team.game.gameScreen is CampaignGameScreen) || team.game.main.campaign.currentLevel != 0)
               {
                    if(!team.tech.isResearched(Tech.CASTLE_ARCHER_1))
                    {
                         _loc5_ = team.tech.upgrades[Tech.CASTLE_ARCHER_1];
                         if(_loc5_ == null)
                         {
                              return;
                         }
                         if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                         {
                              team.tech.startResearching(Tech.CASTLE_ARCHER_1);
                         }
                    }
                    else if(!team.tech.isResearched(Tech.MINER_SPEED))
                    {
                         _loc5_ = team.tech.upgrades[Tech.MINER_SPEED];
                         if(_loc5_ == null)
                         {
                              return;
                         }
                         if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                         {
                              team.tech.startResearching(Tech.MINER_SPEED);
                         }
                    }
                    else if(!team.tech.isResearched(Tech.CASTLE_ARCHER_2) && team.game.main.campaign.difficultyLevel > Campaign.D_NORMAL)
                    {
                         _loc5_ = team.tech.upgrades[Tech.CASTLE_ARCHER_2];
                         if(_loc5_ == null)
                         {
                              return;
                         }
                         if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                         {
                              team.tech.startResearching(Tech.CASTLE_ARCHER_2);
                         }
                    }
                    else if(!team.tech.isResearched(Tech.CASTLE_ARCHER_3) && team.game.main.campaign.difficultyLevel > Campaign.D_HARD)
                    {
                         _loc5_ = team.tech.upgrades[Tech.CASTLE_ARCHER_3];
                         if(_loc5_ == null)
                         {
                              return;
                         }
                         if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                         {
                              team.tech.startResearching(Tech.CASTLE_ARCHER_3);
                         }
                    }
                    else if(!team.tech.isResearched(Tech.TOWER_SPAWN_I) && team.population > 50 && team.game.main.campaign.difficultyLevel > Campaign.D_NORMAL)
                    {
                         _loc5_ = team.tech.upgrades[Tech.TOWER_SPAWN_I];
                         if(_loc5_ == null)
                         {
                              return;
                         }
                         if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                         {
                              team.tech.startResearching(Tech.TOWER_SPAWN_I);
                         }
                    }
                    else if(!team.tech.isResearched(Tech.TOWER_SPAWN_II) && team.game.main.campaign.difficultyLevel > Campaign.D_HARD)
                    {
                         _loc5_ = team.tech.upgrades[Tech.TOWER_SPAWN_II];
                         if(_loc5_ == null)
                         {
                              return;
                         }
                         if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                         {
                              team.tech.startResearching(Tech.TOWER_SPAWN_II);
                         }
                    }
                    else if(!team.tech.isResearched(Tech.CLOAK_II) && team.game.main.campaign.difficultyLevel > Campaign.D_HARD)
                    {
                         _loc5_ = team.tech.upgrades[Tech.CLOAK_II];
                         if(_loc5_ == null)
                         {
                              return;
                         }
                         if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                         {
                              team.tech.startResearching(Tech.CLOAK_II);
                         }
                    }
               }
          }
          
          override protected function updateSpellCasters(param1:StickWar) : void
          {
               var _loc2_:* = team.mana;
               team.mana = 500;
               this.updateMagikill(param1);
               this.updateMiners(param1);
               this.updateArchers(param1);
               this.updateNinjas(param1);
               this.updateSwordwraths(param1);
               this.updateSpeartons(param1);
               this.updateMerics(param1);
               this.updateGoodTech(param1);
               team.mana = _loc2_;
          }
          
          private function updateGoodTech(param1:StickWar) : void
          {
               team.tech.isResearchedMap[Tech.MAGIKILL_NUKE] = true;
               team.tech.isResearchedMap[Tech.MAGIKILL_POISON] = true;
               if(param1.main.campaign.difficultyLevel == Campaign.D_INSANE)
               {
                    team.tech.isResearchedMap[Tech.SWORDWRATH_RAGE] = true;
                    team.tech.isResearchedMap[Tech.CLOAK_II] = true;
                    team.tech.isResearchedMap[Tech.ARCHIDON_FIRE] = true;
                    team.tech.isResearchedMap[Tech.MAGIKILL_WALL] = true;
                    team.tech.isResearchedMap[Tech.BLOCK] = true;
                    team.tech.isResearchedMap[Tech.SHIELD_BASH] = true;
                    team.tech.isResearchedMap[Tech.TOWER_SPAWN_I] = true;
                    if(param1.frame >= 30 * 60 * 6)
                    {
                         team.tech.isResearchedMap[Tech.TOWER_SPAWN_II] = true;
                    }
               }
               else if(param1.main.campaign.difficultyLevel == Campaign.D_HARD)
               {
                    team.tech.isResearchedMap[Tech.SWORDWRATH_RAGE] = true;
                    team.tech.isResearchedMap[Tech.MAGIKILL_WALL] = true;
                    team.tech.isResearchedMap[Tech.BLOCK] = true;
                    team.tech.isResearchedMap[Tech.SHIELD_BASH] = true;
                    if(param1.frame >= 30 * 60 * 6)
                    {
                         team.tech.isResearchedMap[Tech.TOWER_SPAWN_I] = true;
                    }
               }
          }
          
          private function updateMerics(param1:StickWar) : void
          {
               var _loc2_:Monk = null;
               var _loc3_:Unit = null;
               var unitNeedHeal:Unit = null;
               unitNeedHeal = team.unitGroups[Unit.U_ENSLAVED_GIANT][0] || team.unitGroups[Unit.U_SPEARTON][0] || team.unitGroups[Unit.U_MAGIKILL][0];
               for each(_loc2_ in team.unitGroups[Unit.U_MONK])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc2_ && unitNeedHeal && !unitNeedHeal.isTowerSpawned)
                    {
                         target = _loc3_;
                         targetX = unitNeedHeal.px + 150;
                         targetY = unitNeedHeal.py;
                         this.unitMove = new UnitMove();
                         this.unitMove.owner = team.id;
                         this.unitMove.moveType = UnitCommand.ATTACK_MOVE;
                         if(_loc2_.px == unitNeedHeal + 150)
                         {
                              this.unitMove = new UnitMove();
                              this.unitMove.owner = team.id;
                              this.unitMove.moveType = UnitCommand.HOLD;
                              this.unitMove.arg0 = targetX;
                              this.unitMove.arg1 = targetY;
                              this.unitMove.units.push(_loc2_.id);
                              this.unitMove.execute(param1);
                         }
                         this.unitMove.arg0 = targetX;
                         this.unitMove.arg1 = targetY;
                         this.unitMove.units.push(_loc2_.id);
                         this.unitMove.execute(param1);
                    }
               }
          }
          
          private function updateSpeartons(param1:StickWar) : void
          {
               var _loc2_:Spearton = null;
               var _loc3_:Unit = null;
               var isBlocking:Boolean = false;
               var unitToDefend:Unit = null;
               var unitSpell:Unit = null;
               unitToDefend = team.unitGroups[Unit.U_ENSLAVED_GIANT][0] || team.unitGroups[Unit.U_ARCHER][0] || team.unitGroups[Unit.U_MONK][0] || team.unitGroups[Unit.U_MAGIKILL][0];
               team.mana = 500;
               for each(_loc2_ in team.unitGroups[Unit.U_SPEARTON])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc2_.ai.currentTarget != null && !_loc2_.isTowerSpawned)
                    {
                         if(Math.abs(_loc3_.px - _loc2_.px) < 100 && team.tech.isResearched(Tech.BLOCK))
                         {
                              if(_loc2_.shieldBashCooldown() == 0 && !_loc2_.inBlock)
                              {
                                   _loc2_.startBlocking();
                                   isBlocking = true;
                                   if(_loc2_.inBlock && team.tech.isResearched(Tech.SHIELD_BASH))
                                   {
                                        _loc2_.shieldBash();
                                        if(isBlocking && _loc2_.shieldBashCooldown() != 0)
                                        {
                                             _loc2_.stopBlocking();
                                             isBlocking = false;
                                        }
                                   }
                              }
                         }
                    }
               }
          }
          
          private function updateArchers(param1:StickWar) : void
          {
               var _loc2_:Archer = null;
               var _loc3_:Unit = null;
               for each(_loc2_ in team.unitGroups[Unit.U_ARCHER])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(team.unitGroups[Unit.U_ARCHER].length <= 0)
                    {
                         return;
                    }
                    if(_loc2_.ai.currentTarget != null)
                    {
                         RangedAi(_loc2_.ai).mayKite = true;
                    }
                    if(_loc3_)
                    {
                         if(Math.abs(_loc3_.px - _loc2_.px) < 650)
                         {
                              _loc2_.archerFireArrow();
                              RangedAi(_loc2_.ai).mayKite = true;
                         }
                         if(team.game.main.campaign.difficultyLevel > Campaign.D_NORMAL && enemyAtHome())
                         {
                              if(!_loc3_.isGarrisoned && _loc3_.px <= this.team.enemyTeam.statue.x && Math.abs(_loc3_.px - _loc2_.px) > 450)
                              {
                                   this.unitMove = new UnitMove();
                                   this.unitMove.owner = team.id;
                                   this.unitMove.moveType = UnitCommand.ATTACK_MOVE;
                                   this.unitMove.arg0 = _loc3_.px + 850;
                                   this.unitMove.arg1 = _loc2_.py;
                                   this.unitMove.units.push(_loc2_.id);
                                   this.unitMove.execute(param1);
                              }
                         }
                    }
               }
          }
          
          private function updateMiners(param1:StickWar) : void
          {
               if(team.unitGroups[Unit.U_MINER].length <= 0)
               {
                    return;
               }
               var magikill:Magikill = null;
               var monk:Monk = null;
               var target:Unit = null;
               if(team.population > 20)
               {
                    team.tech.isResearchedMap[Tech.MINER_WALL] = true;
               }
               if(team.walls.length == 0 && !enemyIsAttacking() && team.unitGroups[Unit.U_MINER][0].constructCooldown() <= 0 && !team.tech.isResearched(Tech.MINER_WALL) && team.game.main.campaign.difficultyLevel > Campaign.D_NORMAL)
               {
                    this.unitMove = new UnitMove();
                    this.unitMove.owner = team.id;
                    this.unitMove.moveType = UnitCommand.CONSTRUCT_WALL;
                    this.unitMove.arg0 = team.statue.px - 1000;
                    this.unitMove.arg1 = team.statue.py;
                    this.unitMove.units.push(team.unitGroups[Unit.U_MINER][0].id);
                    this.unitMove.execute(param1);
               }
               else if(team.walls.length != 0 && enemyAtHome() && !enemyAtMiddle() && !enemyIsAttacking() && team.unitGroups[Unit.U_MINER][0].constructCooldown() <= 0 && !team.tech.isResearched(Tech.MINER_WALL) && team.game.main.campaign.difficultyLevel > Campaign.D_HARD)
               {
                    this.unitMove = new UnitMove();
                    this.unitMove.owner = team.id;
                    this.unitMove.moveType = UnitCommand.CONSTRUCT_WALL;
                    this.unitMove.arg0 = team.statue.px - 1500;
                    this.unitMove.arg1 = team.statue.py;
                    this.unitMove.units.push(team.unitGroups[Unit.U_MINER][0].id);
                    this.unitMove.execute(param1);
               }
          }
          
          private function updateSwordwraths(param1:StickWar) : void
          {
               var _loc2_:Swordwrath = null;
               var _loc3_:Unit = null;
               team.mana = 0;
               for each(_loc2_ in team.unitGroups[Unit.U_SWORDWRATH])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc2_.ai.currentTarget != null)
                    {
                         if(Math.abs(_loc3_.px - _loc2_.px) < 150)
                         {
                              _loc2_.rage();
                         }
                    }
               }
          }
          
          private function updateNinjas(param1:StickWar) : void
          {
               var _loc2_:Ninja = null;
               var _loc3_:Unit = null;
               team.tech.isResearchedMap[Tech.CLOAK] = true;
               team.mana = 150;
               for each(_loc2_ in team.unitGroups[Unit.U_NINJA])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc3_ != null && _loc3_.isAlive())
                    {
                         if(Math.abs(_loc3_.px - _loc2_.px) < 300)
                         {
                              _loc2_.stealth();
                         }
                    }
               }
          }
          
          private function updateMagikill(param1:StickWar) : void
          {
               var _loc2_:Magikill = null;
               var _loc3_:Unit = null;
               for each(_loc2_ in team.unitGroups[Unit.U_MAGIKILL])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc2_.freezingCooldown() == 0)
                    {
                         this.freezingSpell.realX = _loc2_.px;
                         this.freezingSpell.realY = _loc2_.py;
                         if(this.freezingSpell.inRange(_loc2_))
                         {
                              _loc2_.freezingSpell(_loc2_.px + team.direction,_loc2_.py);
                         }
                    }
                    if(_loc3_)
                    {
                         if(_loc2_.nukeCooldown() == 0)
                         {
                              this.nukeSpell.realX = _loc3_.px;
                              this.nukeSpell.realY = _loc3_.py;
                              if(this.nukeSpell.inRange(_loc2_))
                              {
                                   _loc2_.nukeSpell(_loc3_.px,_loc3_.py);
                              }
                         }
                         if(_loc2_.poisonDartCooldown() == 0)
                         {
                              this.poisonSpell.realX = _loc3_.px;
                              this.poisonSpell.realY = _loc3_.py;
                              if(this.poisonSpell.inRange(_loc2_))
                              {
                                   _loc2_.poisonDartSpell(_loc3_.px,_loc3_.py);
                              }
                         }
                         if(_loc2_.stunCooldown() == 0)
                         {
                              this.electricWallSpell.realX = _loc3_.px;
                              this.electricWallSpell.realY = _loc3_.py;
                              if(this.electricWallSpell.inRange(_loc2_))
                              {
                                   _loc2_.stunSpell(_loc3_.px,_loc3_.py);
                              }
                         }
                    }
               }
          }
     }
}
