class TechnologyManager
{
     var BASE_HEALTH = 100;
     var BASE_ATTACK = TechnologyManager.prototype.BASE_HEALTH / 10;
     var DIFFICULTY_INCREASE = 0.2;
     function TechnologyManager(defaultEnabled, startGold, dif)
     {
          this.castleType = "oldTower1";
          this.castleHealth = 1;
          this.castleArcherNumber = 0;
          this.gold = startGold;
          this.difficulty = dif;
          this.difficultyMultiplier = 1;
          if(this.difficulty == 2)
          {
               this.difficultyMultiplier = 1.2;
          }
          if(this.difficulty == 3)
          {
               this.difficultyMultiplier = 1.35;
          }
          this.statue = 2;
          this.minerEnabled = defaultEnabled;
          this.spartanEnabled = defaultEnabled;
          this.archerEnabled = defaultEnabled;
          this.swordmanEnabled = defaultEnabled;
          this.giantEnabled = defaultEnabled;
          this.wizardEnabled = defaultEnabled;
          this.isNotClubman = defaultEnabled;
          this.isNotSpartan = false;
          this.minerBagsize = 1;
          this.minerPickaxe = 1;
          this.archerDamage = 1;
          this.archerAccuracy = 1;
          this.spartanHelmet = 1;
          this.spartanShield = 1;
          this.spartanSpear = 1;
          this.swordmanSword = 1;
          this.swordmanSpeed = 1;
          this.giantStrength = 1;
          this.giantClub = 1;
          this.wizardHealing = 1;
          this.wizardAttack = 1;
          this.castleArcherNumber = 1;
          this.castleIncome = 0;
     }
     function getIsNotSpartan()
     {
          return this.isNotSpartan;
     }
     function setIsNotSpartan(b)
     {
          this.isNotSpartan = b;
     }
     function getIsNotClubman()
     {
          return this.isNotClubman;
     }
     function setIsNotClubman(num)
     {
          this.isNotClubman = num;
     }
     function setMinerEnabled(isEnabled)
     {
          this.minerEnabled = isEnabled;
     }
     function getMinerEnabled(isEnabled)
     {
          return this.minerEnabled;
     }
     function setMinerBagsize(num)
     {
          this.minerBagsize = num;
     }
     function setMinerPickaxe(num)
     {
          this.minerPickaxe = num;
          return num;
     }
     function getMinerBag()
     {
          return this.minerBagsize;
     }
     function getMinerPickaxe()
     {
          return this.minerPickaxe;
     }
     function getMinerHealth()
     {
          return this.difficultyMultiplier * this.BASE_HEALTH / 2;
     }
     function setSpartanEnabled(isEnabled)
     {
          this.spartanEnabled = isEnabled;
     }
     function getSpartanEnabled(isEnabled)
     {
          return this.spartanEnabled;
     }
     function setSpartanSpear(num)
     {
          this.spartanSpear = num;
     }
     function setSpartanHelmet(num)
     {
          this.spartanHelmet = num;
     }
     function getSpartanHeadShotReduction()
     {
          return 1 - this.spartanHelmet * 0.1;
     }
     function getSpartanBlockChance()
     {
          return this.compound(0.4,-0.1,this.spartanShield);
     }
     function setSpartanShield(num)
     {
          this.spartanShield = num;
     }
     function getSpartanSpear()
     {
          return this.spartanSpear;
     }
     function getSpartanHelmet()
     {
          if(this.isNotSpartan)
          {
               return this.spartanHelmet;
          }
          return this.spartanHelmet + 1;
     }
     function getSpartanShield()
     {
          if(this.isNotSpartan)
          {
               return this.spartanShield;
          }
          return this.spartanShield + 2;
     }
     function getSpartanHealth()
     {
          if(this.isNotSpartan)
          {
               return this.difficultyMultiplier * this.BASE_HEALTH / 1.5;
          }
          return this.difficultyMultiplier * this.compound(this.BASE_HEALTH / 2,0.1,this.spartanHelmet + this.spartanShield / 2);
     }
     function getSpartanAttack()
     {
          if(this.isNotSpartan)
          {
               return this.difficultyMultiplier * this.BASE_ATTACK;
          }
          return this.difficultyMultiplier * this.compound(this.BASE_ATTACK,0.2,this.spartanSpear);
     }
     function setSwordmanEnabled(isEnabled)
     {
          this.swordmanEnabled = isEnabled;
     }
     function getSwordmanEnabled(isEnabled)
     {
          return this.swordmanEnabled;
     }
     function setSwordmanSword(num)
     {
          this.swordmanSword = num;
     }
     function setSwordmanSpeed(num)
     {
          this.swordmanSpeed = num;
     }
     function getSwordmanSword()
     {
          return this.swordmanSword;
     }
     function getSwordmanSpeed()
     {
          return this.swordmanSpeed;
     }
     function getSwordmanAttack()
     {
          return this.difficultyMultiplier * this.compound(this.BASE_ATTACK,0.2,this.swordmanSword - 1);
     }
     function getSwordmanHealth()
     {
          return this.difficultyMultiplier * this.BASE_HEALTH / 2;
     }
     function setArcherEnabled(isEnabled)
     {
          this.archerEnabled = isEnabled;
     }
     function getArcherEnabled(isEnabled)
     {
          return this.archerEnabled;
     }
     function setArcherDamage(num)
     {
          this.archerDamage = num;
     }
     function setArcherAccuracy(num)
     {
          this.archerAccuracy = num;
     }
     function getArcherAccuracy()
     {
          return this.archerAccuracy;
     }
     function getArcherDamage()
     {
          return this.archerDamage;
     }
     function getArcherAttack()
     {
          return this.difficultyMultiplier * this.compound(this.BASE_ATTACK / 4,0.5,this.archerDamage);
     }
     function getArcherHealth()
     {
          return this.difficultyMultiplier * this.compound(this.BASE_HEALTH * 0.1,0.2,this.archerAccuracy);
     }
     function setGiantEnabled(isEnabled)
     {
          this.giantEnabled = isEnabled;
     }
     function getGiantEnabled(isEnabled)
     {
          return this.giantEnabled;
     }
     function setGiantStrength(num)
     {
          this.giantStrength = num;
     }
     function setGiantClub(num)
     {
          this.giantClub = num;
     }
     function getGiantStrength()
     {
          return this.giantStrength;
     }
     function getGiantClub()
     {
          return this.giantClub;
     }
     function getGiantHealth()
     {
          return this.difficultyMultiplier * this.compound(this.BASE_HEALTH * 12,0.2,this.giantStrength);
     }
     function getGiantAttack()
     {
          return this.difficultyMultiplier * this.compound(this.BASE_ATTACK,0.2,this.giantClub);
     }
     function setWizardEnabled(isEnabled)
     {
          this.wizardEnabled = isEnabled;
     }
     function getWizardEnabled(isEnabled)
     {
          return this.wizardEnabled;
     }
     function setWizardAttack(num)
     {
          this.wizardAttack = num;
     }
     function setWizardHealing(num)
     {
          this.wizardHealing = num;
     }
     function getWizardAttack()
     {
          return this.wizardAttack;
     }
     function getWizardAttackPower()
     {
          return this.difficultyMultiplier * this.compound(this.BASE_ATTACK / 2,0.2,this.wizardAttack);
     }
     function getWizardHealth()
     {
          return this.difficultyMultiplier * this.BASE_HEALTH;
     }
     function getWizardStunTime()
     {
          return this.compound(1500,0.4,this.wizardAttack - 1);
     }
     function getWizardHealing()
     {
          return this.wizardHealing;
     }
     function getCastleHealth()
     {
          return this.difficultyMultiplier * this.compound(this.BASE_HEALTH * 3,1,this.castleHealth);
     }
     function getCastleHealthLevel()
     {
          return this.castleHealth;
     }
     function setCastleHealth(health)
     {
          this.castleHealth = health;
     }
     function getCastleArcherNumber()
     {
          return this.castleArcherNumber;
     }
     function setCastleArcherNumber(num)
     {
          this.castleArcherNumber = num;
     }
     function getCastleIncome()
     {
          return this.difficultyMultiplier * this.castleIncome;
     }
     function setCastleIncome(num)
     {
          this.castleIncome = num;
     }
     function compound(base, rate, level)
     {
          return Math.pow(1 + rate,level) * base;
     }
}
