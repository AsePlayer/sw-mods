package com.brockw.stickwar.singleplayer
{
     import com.brockw.stickwar.BaseMain;
     import com.brockw.stickwar.campaign.*;
     import com.brockw.stickwar.engine.Ai.*;
     import com.brockw.stickwar.engine.Ai.command.*;
     import com.brockw.stickwar.engine.StickWar;
     import com.brockw.stickwar.engine.Team.Team;
     import com.brockw.stickwar.engine.Team.Tech;
     import com.brockw.stickwar.engine.Team.TechItem;
     import com.brockw.stickwar.engine.units.*;
     import flash.utils.Dictionary;
     
     public class EnemyChaosTeamAi extends EnemyTeamAi
     {
           
          
          private var buildOrder:Array;
          
          private var fistAttackSpell:FistAttackCommand;
          
          private var reaperSpell:ReaperCommand;
          
          private var poisonPoolSpell:PoisonPoolCommand;
          
          private var stoneSpell:StoneCommand;
          
          public function EnemyChaosTeamAi(team:Team, main:BaseMain, game:StickWar, isCreatingUnits:* = true)
          {
               var key:int = 0;
               this.fistAttackSpell = new FistAttackCommand(game);
               this.reaperSpell = new ReaperCommand(game);
               this.poisonPoolSpell = new PoisonPoolCommand(game);
               this.stoneSpell = new StoneCommand(game);
               unitComposition = new Dictionary();
               unitComposition[Unit.U_CHAOS_MINER] = main.campaign.xml.Chaos.UnitComposition.ChaosMiner;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.ChaosMiner) != "")
               {
                    unitComposition[Unit.U_CHAOS_MINER] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.ChaosMiner);
               }
               unitComposition[Unit.U_BOMBER] = main.campaign.xml.Chaos.UnitComposition.Bomber;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Bomber) != "")
               {
                    unitComposition[Unit.U_BOMBER] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Bomber);
               }
               unitComposition[Unit.U_WINGIDON] = main.campaign.xml.Chaos.UnitComposition.Wingadon;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Wingadon) != "")
               {
                    unitComposition[Unit.U_WINGIDON] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Wingadon);
               }
               unitComposition[Unit.U_SKELATOR] = main.campaign.xml.Chaos.UnitComposition.SkelatalMage;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.SkelatalMage) != "")
               {
                    unitComposition[Unit.U_SKELATOR] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.SkelatalMage);
               }
               unitComposition[Unit.U_DEAD] = main.campaign.xml.Chaos.UnitComposition.Dead;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Dead) != "")
               {
                    unitComposition[Unit.U_DEAD] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Dead);
               }
               unitComposition[Unit.U_CAT] = main.campaign.xml.Chaos.UnitComposition.Cat;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Cat) != "")
               {
                    unitComposition[Unit.U_CAT] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Cat);
               }
               unitComposition[Unit.U_KNIGHT] = main.campaign.xml.Chaos.UnitComposition.Knight;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Knight) != "")
               {
                    unitComposition[Unit.U_KNIGHT] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Knight);
               }
               unitComposition[Unit.U_MEDUSA] = main.campaign.xml.Chaos.UnitComposition.Medusa;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Medusa) != "")
               {
                    unitComposition[Unit.U_MEDUSA] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Medusa);
               }
               unitComposition[Unit.U_GIANT] = main.campaign.xml.Chaos.UnitComposition.Giant;
               if(String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Giant) != "")
               {
                    unitComposition[Unit.U_GIANT] = String(main.campaign.getCurrentLevel().levelXml.oponent.UnitComposition.Giant);
               }
               var theoriticalBuildOrder:* = [Unit.U_GIANT,Unit.U_MEDUSA,Unit.U_KNIGHT,Unit.U_CAT,Unit.U_DEAD,Unit.U_SKELATOR,Unit.U_WINGIDON,Unit.U_BOMBER];
               this.buildOrder = [];
               for each(key in theoriticalBuildOrder)
               {
                    if(team.unitsAvailable == null || key in team.unitsAvailable)
                    {
                         this.buildOrder.push(key);
                    }
               }
               super(team,main,game,isCreatingUnits);
          }
          
          override public function update(game:StickWar) : void
          {
               super.update(game);
          }
          
          override protected function updateUnitCreation(game:StickWar) : void
          {
               var i:int = 0;
               var numOfUnit:int = 0;
               var t:TechItem = null;
               if(!enemyIsAttacking() && (team.population < 6 || this.enemyAtHome()))
               {
                    numOfUnit = int(team.unitGroups[Unit.U_CHAOS_MINER].length);
                    if(numOfUnit < unitComposition[Unit.U_CHAOS_MINER] && team.unitProductionQueue[team.unitInfo[Unit.U_CHAOS_MINER][2]].length == 0)
                    {
                         game.requestToSpawn(team.id,Unit.U_CHAOS_MINER);
                    }
               }
               var overCompCount:int = 0;
               for(i = 0; i < this.buildOrder.length; i++)
               {
                    numOfUnit = int(team.unitGroups[this.buildOrder[i]].length);
                    if(!(this.buildOrder[i] == Unit.U_BOMBER && team.attackingForcePopulation < 6))
                    {
                         if(numOfUnit >= unitComposition[this.buildOrder[i]])
                         {
                              overCompCount++;
                         }
                         else if(team.unitProductionQueue[team.unitInfo[this.buildOrder[i]][2]].length == 0)
                         {
                              game.requestToSpawn(team.id,this.buildOrder[i]);
                         }
                    }
               }
               if(overCompCount >= this.buildOrder.length)
               {
                    for(i = 0; i < this.buildOrder.length; i++)
                    {
                         numOfUnit = int(team.unitGroups[this.buildOrder[i]].length);
                         if(team.unitProductionQueue[team.unitInfo[this.buildOrder[i]][2]].length == 0)
                         {
                              game.requestToSpawn(team.id,this.buildOrder[i]);
                         }
                    }
               }
               if(!team.tech.isResearched(Tech.CASTLE_ARCHER_1))
               {
                    t = team.tech.upgrades[Tech.CASTLE_ARCHER_1];
                    if(t == null)
                    {
                         return;
                    }
                    if(t.cost < team.gold && t.mana < team.mana)
                    {
                         team.tech.startResearching(Tech.CASTLE_ARCHER_1);
                    }
               }
               else if(!team.tech.isResearched(Tech.CASTLE_ARCHER_2) && team.game.main.campaign.difficultyLevel > Campaign.D_NORMAL)
               {
                    t = team.tech.upgrades[Tech.CASTLE_ARCHER_2];
                    if(t == null)
                    {
                         return;
                    }
                    if(t.cost < team.gold && t.mana < team.mana)
                    {
                         team.tech.startResearching(Tech.CASTLE_ARCHER_2);
                    }
               }
          }
          
          override protected function updateSpellCasters(game:StickWar) : void
          {
               var manaBefore:Number = team.mana;
               team.mana = 1000;
               this.updateDeads(game);
               this.updateSkelator(game);
               this.updateMedusa(game);
               if(game.main.campaign.difficultyLevel == Campaign.D_INSANE)
               {
                    team.tech.isResearchedMap[Tech.CAT_SPEED] = true;
                    team.tech.isResearchedMap[Tech.CAT_PACK] = true;
               }
               team.mana = manaBefore;
          }
          
          private function updateDeads(game:StickWar) : void
          {
               var dead:Dead = null;
               team.tech.isResearchedMap[Tech.DEAD_POISON] = true;
               for each(dead in team.unitGroups[Unit.U_DEAD])
               {
                    if(!dead.isPoisonedToggled)
                    {
                         dead.togglePoison();
                    }
                    if(dead.ai.currentTarget != null)
                    {
                         RangedAi(dead.ai).mayKite = true;
                    }
               }
          }
          
          private function updateGiants(game:StickWar) : void
          {
               var giant:Giant = null;
               for each(giant in team.unitGroups[Unit.U_GIANT])
               {
                    if(giant.ai.currentTarget != null)
                    {
                         if(Math.abs(team.enemyTeam.statue.px - giant.px) < 200)
                         {
                              giant.ai.currentTarget = team.enemyTeam.statue;
                         }
                         else if(team.direction * giant.ai.currentTarget.px < team.direction * (giant.px + -team.direction * 150))
                         {
                              giant.ai.currentTarget = null;
                              giant.walk(team.direction,0,team.direction);
                         }
                    }
               }
          }
          
          private function updateMedusa(game:StickWar) : void
          {
               var medusa:Medusa = null;
               var target:Unit = null;
               team.tech.isResearchedMap[Tech.MEDUSA_POISON] = true;
               for each(medusa in team.unitGroups[Unit.U_MEDUSA])
               {
                    target = medusa.ai.getClosestTarget();
                    if(Boolean(target))
                    {
                         if(medusa.stoneCooldown() == 0)
                         {
                              this.stoneSpell.realX = target.px;
                              this.stoneSpell.realY = target.py;
                              this.stoneSpell.targetId = target.id;
                              if(this.stoneSpell.inRange(medusa))
                              {
                                   medusa.stone(target);
                              }
                         }
                         else if(medusa.poisonPoolCooldown() == 0)
                         {
                              this.poisonPoolSpell.realX = target.px;
                              this.poisonPoolSpell.realY = target.py;
                              if(this.poisonPoolSpell.inRange(medusa))
                              {
                                   medusa.poisonSpray();
                              }
                         }
                    }
               }
          }
          
          private function updateSkelator(game:StickWar) : void
          {
               var skelator:Skelator = null;
               var target:Unit = null;
               team.tech.isResearchedMap[Tech.SKELETON_FIST_ATTACK] = true;
               for each(skelator in team.unitGroups[Unit.U_SKELATOR])
               {
                    target = skelator.ai.getClosestTarget();
                    if(Boolean(target))
                    {
                         if(skelator.fistAttackCooldown() == 0)
                         {
                              this.fistAttackSpell.realX = target.px;
                              this.fistAttackSpell.realY = target.py;
                              if(this.fistAttackSpell.inRange(skelator))
                              {
                                   skelator.fistAttack(target.px,target.py);
                              }
                         }
                         else if(skelator.reaperCooldown() == 0)
                         {
                              this.reaperSpell.targetId = target.id;
                              this.reaperSpell.realX = target.px;
                              this.reaperSpell.realY = target.py;
                              if(this.reaperSpell.inRange(skelator))
                              {
                                   skelator.reaperAttack(target);
                              }
                         }
                    }
               }
          }
     }
}
