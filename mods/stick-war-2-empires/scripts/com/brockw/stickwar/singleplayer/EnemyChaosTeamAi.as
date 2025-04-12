package com.brockw.stickwar.singleplayer
{
     import com.brockw.stickwar.BaseMain;
     import com.brockw.stickwar.campaign.Campaign;
     import com.brockw.stickwar.engine.Ai.RangedAi;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.Team.TechItem;
     import com.brockw.stickwar.engine.units.Unit;
     import flash.utils.Dictionary;
     
     public class EnemyChaosTeamAi extends EnemyTeamAi
     {
           
          
          private var buildOrder:Array;
          
          private var convertEnemySpell:ConvertCommand;
          
          private var hurricaneTornadoSpell:HurricaneCommand;
          
          private var fistAttackSpell:FistAttackCommand;
          
          private var burrowSpell:BurrowCommand;
          
          private var reaperSpell:ReaperCommand;
          
          private var flowerSpell:FlowerCommand;
          
          private var root:TreeRootCommand;
          
          private var poisonPoolSpell:PoisonPoolCommand;
          
          private var stoneSpell:StoneCommand;
          
          private var nukeSpell:NukeCommand;
          
          private var electricWallSpell:StunCommand;
          
          private var poisonSpell:PoisonDartCommand;
          
          private var fireBreathSpell:FireBreathCommand;
          
          private var firestormSpell:FirestormCommand;
          
          private var teleportVSpell:TeleportCommand;
          
          public function EnemyChaosTeamAi(param1:Team, param2:BaseMain, param3:StickWar, param4:* = true)
          {
               var _loc6_:int = 0;
               this.fistAttackSpell = new FistAttackCommand(param3);
               this.reaperSpell = new ReaperCommand(param3);
               this.convertEnemySpell = new ConvertCommand(param3);
               this.teleportVSpell = new TeleportCommand(param3);
               this.poisonPoolSpell = new PoisonPoolCommand(param3);
               this.stoneSpell = new StoneCommand(param3);
               this.nukeSpell = new NukeCommand(param3);
               this.electricWallSpell = new StunCommand(param3);
               this.poisonSpell = new PoisonDartCommand(param3);
               this.burrowSpell = new BurrowCommand(param3);
               this.fireBreathSpell = new FireBreathCommand(param3);
               this.firestormSpell = new FirestormCommand(param3);
               this.flowerSpell = new FlowerCommand(param3);
               this.root = new TreeRootCommand(param3);
               this.hurricaneTornadoSpell = new HurricaneCommand(param3);
               unitComposition = new Dictionary();
               unitComposition[Unit.U_CHAOS_MINER] = param2.campaign.xml.Chaos.UnitComposition.ChaosMiner;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.ChaosMiner) != "")
               {
                    unitComposition[Unit.U_CHAOS_MINER] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.ChaosMiner);
               }
               unitComposition[Unit.U_BOMBER] = param2.campaign.xml.Chaos.UnitComposition.Bomber;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Bomber) != "")
               {
                    unitComposition[Unit.U_BOMBER] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Bomber);
               }
               unitComposition[Unit.U_WINGIDON] = param2.campaign.xml.Chaos.UnitComposition.Wingadon;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Wingadon) != "")
               {
                    unitComposition[Unit.U_WINGIDON] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Wingadon);
               }
               unitComposition[Unit.U_SKELATOR] = param2.campaign.xml.Chaos.UnitComposition.SkelatalMage;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.SkelatalMage) != "")
               {
                    unitComposition[Unit.U_SKELATOR] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.SkelatalMage);
               }
               unitComposition[Unit.U_DEAD] = param2.campaign.xml.Chaos.UnitComposition.Dead;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Dead) != "")
               {
                    unitComposition[Unit.U_DEAD] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Dead);
               }
               unitComposition[Unit.U_CAT] = param2.campaign.xml.Chaos.UnitComposition.Cat;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Cat) != "")
               {
                    unitComposition[Unit.U_CAT] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Cat);
               }
               unitComposition[Unit.U_KNIGHT] = param2.campaign.xml.Chaos.UnitComposition.Knight;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Knight) != "")
               {
                    unitComposition[Unit.U_KNIGHT] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Knight);
               }
               unitComposition[Unit.U_MEDUSA] = param2.campaign.xml.Chaos.UnitComposition.Medusa;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Medusa) != "")
               {
                    unitComposition[Unit.U_MEDUSA] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Medusa);
               }
               unitComposition[Unit.U_GIANT] = param2.campaign.xml.Chaos.UnitComposition.Giant;
               if(String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Giant) != "")
               {
                    unitComposition[Unit.U_GIANT] = String(param2.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Giant);
               }
               var _loc5_:* = [Unit.U_GIANT,Unit.U_MEDUSA,Unit.U_KNIGHT,Unit.U_CAT,Unit.U_DEAD,Unit.U_SKELATOR,Unit.U_WINGIDON,Unit.U_BOMBER];
               this.buildOrder = [];
               for each(_loc6_ in _loc5_)
               {
                    if(param1.unitsAvailable == null || _loc6_ in param1.unitsAvailable)
                    {
                         this.buildOrder.push(_loc6_);
                    }
               }
               super(param1,param2,param3,param4);
          }
          
          override public function update(param1:StickWar) : void
          {
               super.update(param1);
          }
          
          override protected function updateUnitCreation(param1:StickWar) : void
          {
               var _loc3_:int = 0;
               var _loc4_:int = 0;
               var _loc5_:TechItem = null;
               if(!enemyIsAttacking() && (team.population < 6 || Boolean(this.enemyAtHome())))
               {
                    if((_loc4_ = int(team.unitGroups[Unit.U_CHAOS_MINER].length)) < unitComposition[Unit.U_CHAOS_MINER] && team.unitProductionQueue[team.unitInfo[Unit.U_CHAOS_MINER][2]].length == 0)
                    {
                         param1.requestToSpawn(team.id,Unit.U_CHAOS_MINER);
                    }
               }
               var _loc2_:int = 0;
               _loc3_ = 0;
               while(_loc3_ < this.buildOrder.length)
               {
                    _loc4_ = int(team.unitGroups[this.buildOrder[_loc3_]].length);
                    if(!(this.buildOrder[_loc3_] == Unit.U_BOMBER && team.attackingForcePopulation < 6))
                    {
                         if(_loc4_ >= unitComposition[this.buildOrder[_loc3_]])
                         {
                              _loc2_++;
                         }
                         else if(team.unitProductionQueue[team.unitInfo[this.buildOrder[_loc3_]][2]].length == 0)
                         {
                              param1.requestToSpawn(team.id,this.buildOrder[_loc3_]);
                         }
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
               if(!team.tech.isResearched(Tech.CASTLE_ARCHER_1))
               {
                    if((_loc5_ = team.tech.upgrades[Tech.CASTLE_ARCHER_1]) == null)
                    {
                         return;
                    }
                    if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                    {
                         team.tech.startResearching(Tech.CASTLE_ARCHER_1);
                    }
               }
               else if(!team.tech.isResearched(Tech.CASTLE_ARCHER_2) && team.game.main.campaign.difficultyLevel > Campaign.D_NORMAL)
               {
                    if((_loc5_ = team.tech.upgrades[Tech.CASTLE_ARCHER_2]) == null)
                    {
                         return;
                    }
                    if(_loc5_.cost < team.gold && _loc5_.mana < team.mana)
                    {
                         team.tech.startResearching(Tech.CASTLE_ARCHER_2);
                    }
               }
          }
          
          override protected function updateSpellCasters(param1:StickWar) : void
          {
               var _loc2_:Number = team.mana;
               team.mana = 1000;
               this.updateDeads(param1);
               this.updateSkelator(param1);
               this.updateMedusa(param1);
               this.updateChromeElement(param1);
               this.updateMagikill(param1);
               this.updateHurricaneElement(param1);
               this.updateTreeElement(param1);
               this.updateFireElement(param1);
               this.updateLavaElement(param1);
               this.updateFirestormElement(param1);
               if(param1.main.campaign.difficultyLevel == Campaign.D_INSANE)
               {
                    team.tech.isResearchedMap[Tech.CAT_SPEED] = true;
                    team.tech.isResearchedMap[Tech.CAT_PACK] = true;
               }
               if(team.enemyTeam.type == 2)
               {
                    if(team.game.main.campaign.currentLevel >= 6)
                    {
                         team.tech.isResearchedMap[Tech.CASTLE_ARCHER_2] = true;
                    }
                    team.tech.isResearchedMap[Tech.CASTLE_ARCHER_2] = true;
               }
               team.mana = _loc2_;
          }
          
          private function updateDeads(param1:StickWar) : void
          {
               var _loc2_:* = null;
               team.tech.isResearchedMap[Tech.DEAD_POISON] = true;
               for each(_loc2_ in team.unitGroups[Unit.U_DEAD])
               {
                    if(!_loc2_.isPoisonedToggled)
                    {
                         _loc2_.togglePoison();
                    }
                    if(_loc2_.ai.currentTarget != null)
                    {
                         RangedAi(_loc2_.ai).mayKite = true;
                    }
               }
          }
          
          private function updateGiants(param1:StickWar) : void
          {
               var _loc2_:* = null;
               for each(_loc2_ in team.unitGroups[Unit.U_GIANT])
               {
                    if(_loc2_.ai.currentTarget != null)
                    {
                         if(Math.abs(team.enemyTeam.statue.px - _loc2_.px) < 200)
                         {
                              _loc2_.ai.currentTarget = team.enemyTeam.statue;
                         }
                         else if(0 * _loc2_.ai.currentTarget.px < 0 * (_loc2_.px + 0))
                         {
                              _loc2_.ai.currentTarget = null;
                              _loc2_.walk(team.direction,0,team.direction);
                         }
                    }
               }
          }
          
          private function updateMedusa(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               team.tech.isResearchedMap[Tech.MEDUSA_POISON] = true;
               for each(_loc2_ in team.unitGroups[Unit.U_MEDUSA])
               {
                    _loc3_ = _loc2_.ai.getClosestSpellableTarget();
                    if(_loc3_)
                    {
                         if(_loc2_.stoneCooldown() == 0)
                         {
                              this.stoneSpell.realX = _loc3_.px;
                              this.stoneSpell.realY = _loc3_.py;
                              this.stoneSpell.targetId = _loc3_.id;
                              if(this.stoneSpell.inRange(_loc2_))
                              {
                                   _loc2_.stone(_loc3_);
                              }
                         }
                         else if(_loc2_.poisonPoolCooldown() == 0)
                         {
                              this.poisonPoolSpell.realX = _loc3_.px;
                              this.poisonPoolSpell.realY = _loc3_.py;
                              if(this.poisonPoolSpell.inRange(_loc2_))
                              {
                                   _loc2_.poisonSpray();
                              }
                         }
                    }
               }
          }
          
          private function updateSkelator(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               team.tech.isResearchedMap[Tech.SKELETON_FIST_ATTACK] = true;
               for each(_loc2_ in team.unitGroups[Unit.U_SKELATOR])
               {
                    _loc3_ = _loc2_.ai.getClosestSpellableTarget();
                    if(_loc3_)
                    {
                         if(_loc2_.fistAttackCooldown() == 0)
                         {
                              this.fistAttackSpell.realX = _loc3_.px;
                              this.fistAttackSpell.realY = _loc3_.py;
                              if(this.fistAttackSpell.inRange(_loc2_))
                              {
                                   _loc2_.fistAttack(_loc3_.px,_loc3_.py);
                              }
                         }
                         else if(_loc2_.reaperCooldown() == 0)
                         {
                              this.reaperSpell.targetId = _loc3_.id;
                              this.reaperSpell.realX = _loc3_.px;
                              this.reaperSpell.realY = _loc3_.py;
                              if(this.reaperSpell.inRange(_loc2_))
                              {
                                   _loc2_.reaperAttack(_loc3_);
                              }
                         }
                    }
               }
          }
          
          private function updateChromeElement(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               var _loc4_:Unit = null;
               var _loc5_:* = null;
               team.tech.isResearchedMap[Tech.CHROME_SPLIT_1] = true;
               team.tech.isResearchedMap[Tech.CHROME_SPLIT_2] = true;
               for each(_loc2_ in team.unitGroups[Unit.U_CHROME_ELEMENT])
               {
                    _loc5_ = _loc2_.ai.getClosestTarget();
                    _loc4_ = _loc2_.ai.getBestPossessTarget();
                    _loc3_ = _loc2_.ai.getBestTeleportTarget();
                    if(_loc3_ != null)
                    {
                         if(Math.abs(_loc3_.px - _loc2_.px) < 700)
                         {
                              _loc2_.split();
                         }
                         if(_loc2_.teleportCooldown() == 0)
                         {
                              this.teleportVSpell.realX = _loc2_.px + 600;
                              this.teleportVSpell.realY = _loc2_.py;
                              if(_loc2_.convertedUnit != null)
                              {
                                   if(this.teleportVSpell.inRange(_loc2_) && Math.abs(_loc2_.convertedUnit.px - _loc2_.px) < 500)
                                   {
                                        _loc2_.teleportSpell(_loc2_.px + 600,_loc2_.py);
                                   }
                              }
                              if(_loc2_.convertedUnit == null)
                              {
                                   if(Math.abs(_loc5_.px - _loc2_.px) < 50)
                                   {
                                        this.teleportVSpell.realX = _loc2_.px + 600;
                                        this.teleportVSpell.realY = _loc2_.py;
                                        if(this.teleportVSpell.inRange(_loc2_))
                                        {
                                             _loc2_.teleportSpell(_loc2_.px + 600,_loc2_.py);
                                        }
                                   }
                                   else if(_loc2_.health / _loc2_.maxHealth < 0.2)
                                   {
                                        this.teleportVSpell.realX = _loc2_.px + 600;
                                        this.teleportVSpell.realY = _loc2_.py;
                                        if(this.teleportVSpell.inRange(_loc2_))
                                        {
                                             _loc2_.teleportSpell(_loc2_.px + 600,_loc2_.py);
                                        }
                                   }
                                   else
                                   {
                                        this.teleportVSpell.realX = _loc3_.px;
                                        this.teleportVSpell.realY = _loc3_.py;
                                        if(this.teleportVSpell.inRange(_loc2_))
                                        {
                                             _loc2_.teleportSpell(_loc3_.px,_loc3_.py);
                                        }
                                   }
                              }
                              this.teleportVSpell.realX = _loc3_.px;
                              this.teleportVSpell.realY = _loc3_.py;
                              if(this.teleportVSpell.inRange(_loc2_))
                              {
                                   _loc2_.teleportSpell(_loc3_.px,_loc3_.py);
                              }
                         }
                    }
                    if(_loc4_ != null && _loc4_.isAlive())
                    {
                         if(_loc2_.convertCooldown() == 0)
                         {
                              this.convertEnemySpell.targetId = _loc4_.id;
                              this.convertEnemySpell.realX = _loc4_.px;
                              this.convertEnemySpell.realY = _loc4_.py;
                              if(this.convertEnemySpell.inRange(_loc2_))
                              {
                                   _loc2_.convertSpell(_loc4_);
                              }
                         }
                    }
                    else
                    {
                         _loc4_ = _loc2_.ai.getBestPossessTarget();
                    }
               }
          }
          
          private function updateMagikill(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               team.tech.isResearchedMap[Tech.MAGIKILL_NUKE] = true;
               team.tech.isResearchedMap[Tech.MAGIKILL_POISON] = true;
               team.tech.isResearchedMap[Tech.MAGIKILL_WALL] = true;
               for each(_loc2_ in team.unitGroups[Unit.U_MAGIKILL])
               {
                    _loc3_ = _loc2_.ai.getClosestSpellableTarget();
                    if(_loc3_)
                    {
                         if(_loc2_.poisonDartCooldown() == 0)
                         {
                              this.poisonSpell.realX = _loc3_.px;
                              this.poisonSpell.realY = _loc3_.py;
                              if(this.poisonSpell.inRange(_loc2_))
                              {
                                   _loc2_.poisonDartSpell(_loc3_.px,_loc3_.py);
                              }
                         }
                         else if(_loc2_.nukeCooldown() == 0)
                         {
                              this.nukeSpell.realX = _loc3_.px;
                              this.nukeSpell.realY = _loc3_.py;
                              if(this.nukeSpell.inRange(_loc2_))
                              {
                                   _loc2_.nukeSpell(_loc3_.px,_loc3_.py);
                              }
                         }
                         else if(_loc2_.stunCooldown() == 0)
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
          
          private function updateHurricaneElement(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               team.tech.isResearchedMap[Tech.TORNADO] = true;
               for each(_loc2_ in team.unitGroups[Unit.U_HURRICANE_ELEMENT])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc3_)
                    {
                         if(_loc2_.hurricaneCooldown() == 0)
                         {
                              this.hurricaneTornadoSpell.realX = _loc3_.px;
                              this.hurricaneTornadoSpell.realY = _loc3_.py;
                              if(this.hurricaneTornadoSpell.inRange(_loc2_))
                              {
                                   _loc2_.hurricaneSpell(_loc3_.px,_loc3_.py);
                              }
                         }
                    }
               }
          }
          
          private function updateTreeElement(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               team.tech.isResearchedMap[Tech.TREE_POISON] = true;
               team.tech.isResearchedMap[Tech.TREE_POISON_2] = true;
               for each(_loc2_ in team.unitGroups[Unit.U_TREE_ELEMENT])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc3_)
                    {
                         if(_loc2_.flowerCooldown() == 0)
                         {
                              this.flowerSpell.targetId = _loc3_.id;
                              this.flowerSpell.realX = _loc3_.px;
                              this.flowerSpell.realY = _loc3_.py;
                              if(this.flowerSpell.inRange(_loc2_))
                              {
                                   _loc2_.flowerSpell(_loc3_);
                              }
                         }
                    }
               }
          }
          
          private function updateLavaElement(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               for each(_loc2_ in team.unitGroups[Unit.U_LAVA_ELEMENT])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc3_ != null && _loc3_.isAlive())
                    {
                         if(Math.abs(_loc3_.px - _loc2_.px) < 300 && _loc2_.health < 170)
                         {
                              _loc2_.burrow();
                         }
                    }
                    if(Math.abs(_loc3_.px - _loc2_.px) < 500)
                    {
                         _loc2_.toggleRadiant();
                    }
               }
          }
          
          private function updateFireElement(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               team.mana = 500;
               for each(_loc2_ in team.unitGroups[Unit.U_FIRE_ELEMENT])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc2_.ai.currentTarget != null)
                    {
                         RangedAi(_loc2_.ai).mayKite = true;
                    }
               }
          }
          
          private function updateFirestormElement(param1:StickWar) : void
          {
               var _loc2_:* = null;
               var _loc3_:Unit = null;
               team.tech.isResearchedMap[Tech.LAVA_POOL] = true;
               for each(_loc2_ in team.unitGroups[Unit.U_FIRESTORM_ELEMENT])
               {
                    _loc3_ = _loc2_.ai.getClosestTarget();
                    if(_loc3_)
                    {
                         if(_loc2_.firebreathNukeCooldown() == 0)
                         {
                              this.fireBreathSpell.realX = _loc3_.px;
                              this.fireBreathSpell.realY = _loc3_.py;
                              if(this.fireBreathSpell.inRange(_loc2_))
                              {
                                   _loc2_.firebreathNuke(_loc3_.px,_loc3_.py);
                              }
                         }
                         else if(_loc2_.firestormNukeCooldown() == 0)
                         {
                              this.firestormSpell.realX = _loc3_.px;
                              this.firestormSpell.realY = _loc3_.py;
                              if(this.firestormSpell.inRange(_loc2_))
                              {
                                   _loc2_.firestormNuke(_loc3_.px,_loc3_.py);
                              }
                         }
                    }
               }
          }
     }
}
