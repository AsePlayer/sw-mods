class Campaign
{
     var difficultyLevel = 1;
     var glowQuality = 1;
     function Campaign()
     {
          this.technology = new TechnologyManager(false,5000,1);
          this.technology.setMinerEnabled(true);
          this.technology.setSwordmanEnabled(true);
          this.technology.setIsNotClubman(true);
          this.level = 1;
          this.gold = 2 * (this.level - 1);
          this.isGlow = true;
          this.times = [];
          var _loc2_ = 0;
          while(_loc2_ < 13)
          {
               this.times.push(0);
               _loc2_ += 1;
          }
     }
     function setGlowQuality(n)
     {
          this.glowQuality = n;
     }
     function getGlowQuality()
     {
          return this.glowQuality;
     }
     function getGold()
     {
          return this.gold;
     }
     function setGold(g)
     {
          this.gold = g;
     }
     function getLevel()
     {
          return this.level;
     }
     function getTime(n)
     {
          return this.times[n];
     }
     function getTotalTime()
     {
          var _loc2_ = 0;
          var _loc3_ = 1;
          while(_loc3_ < 13)
          {
               _loc2_ += this.times[_loc3_];
               _loc3_ += 1;
          }
          return _loc2_;
     }
     function setLevelTime(time)
     {
          this.times[this.level] = time;
     }
     function levelUp()
     {
          this.level++;
          this.gold += 2;
          if(this.level == 1)
          {
               this.technology.setSwordmanEnabled(true);
               this.technology.setIsNotClubman(true);
          }
          else if(this.level == 2)
          {
               this.technology.setArcherEnabled(true);
          }
          else if(this.level == 5)
          {
               this.technology.setSpartanEnabled(true);
          }
          else if(this.level == 7)
          {
               this.technology.setWizardEnabled(true);
          }
          else if(this.level == 10)
          {
               this.technology.setGiantEnabled(true);
          }
     }
     function loadLevel()
     {
          this.technology.gold = 500;
          if(this.level == 0)
          {
               this.technology.gold = 250;
               this.loadLevel0();
          }
          else if(this.level == 1)
          {
               this.technology.gold = 2500;
               this.technology.statue = 9;
               this.technology.setMinerPickaxe(4);
               this.loadLevel1();
          }
          else if(this.level == 2)
          {
               this.loadLevel2();
          }
          else if(this.level == 3)
          {
               this.technology.setSpartanHelmet(3);
               this.technology.setSpartanShield(2);
               this.technology.setWizardHealing(2);
               this.technology.setWizardAttack(2);
               this.loadLevel3();
          }
          else if(this.level == 4)
          {
               this.technology.statue = 4;
               this.loadLevel4();
          }
          else if(this.level == 5)
          {
               this.loadLevel5();
          }
          else if(this.level == 6)
          {
               this.loadLevel6();
          }
          else if(this.level == 7)
          {
               this.loadLevel7();
          }
          else if(this.level == 8)
          {
               this.loadLevel8();
          }
          else if(this.level == 9)
          {
               this.loadLevel9();
          }
          else if(this.level == 10)
          {
               this.loadLevel10();
          }
          else if(this.level == 11)
          {
               this.loadLevel11();
          }
          else if(this.level == 12)
          {
               this.loadLevel12();
          }
          else if(this.level == 13)
          {
               this.loadLevel13();
          }
          else
          {
               this.loadLevel5();
          }
     }
     function loadLevel0()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.statue = 0;
          var _loc4_ = new AiLevel0();
          var _loc5_ = new Game(0,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,1,2,1);
          _root.game = _loc5_;
          _root.gotoAndPlay("game");
     }
     function loadLevel1()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setCastleArcherNumber(3);
          _loc3_.setMinerPickaxe(4);
          _loc3_.statue = 8;
          _loc3_.setSwordmanSword(3);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          var _loc4_ = new AiLevel1();
          var _loc5_ = new Game(1,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,7,3,3);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel2()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setMinerPickaxe(2);
          _loc3_.statue = 8;
          _loc3_.setCastleArcherNumber(3);
          _loc3_.gold = 2500;
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          var _loc4_ = new AiLevel2();
          var _loc5_ = new Game(2,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,3,4,4);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel3()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setMinerPickaxe(2);
          _loc3_.statue = 1;
          _loc3_.setCastleArcherNumber(1);
          _loc3_.setSwordmanSword(3);
          _loc3_.setArcherDamage(2);
          _loc3_.setSpartanHelmet(3);
          _loc3_.setSpartanShield(2);
          var _loc4_ = new AiLevel3();
          var _loc5_ = new Game(3,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,5,6,5);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel4()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setMinerPickaxe(2);
          _loc3_.statue = 4;
          _loc3_.setCastleArcherNumber(1);
          _loc3_.setArcherDamage(3);
          _loc3_.setSwordmanSword(2);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setSpartanHelmet(4);
               _loc3_.setSpartanShield(3);
          }
          else
          {
               _loc3_.setSpartanHelmet(2);
               _loc3_.setSpartanShield(2);
          }
          var _loc4_ = new AiLevel4();
          var _loc5_ = new Game(4,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,7,2,2);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel5()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setMinerPickaxe(2);
          _loc3_.setSwordmanSword(3);
          _loc3_.statue = 0;
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          var _loc4_ = new AiLevel5();
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,3,8,4);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel6()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setCastleHealth(2);
          _loc3_.setMinerPickaxe(3);
          _loc3_.setCastleArcherNumber(1);
          _loc3_.setCastleHealth(2);
          _loc3_.setWizardHealing(2);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          _loc3_.statue = 10;
          var _loc4_ = new AiLevel6();
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,5,3,3);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel7()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setCastleHealth(2);
          _loc3_.setMinerPickaxe(3);
          _loc3_.statue = 9;
          _loc3_.setSwordmanSword(3);
          _loc3_.setCastleArcherNumber(2);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          var _loc4_ = new AiLevel7();
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,7,5,2);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel8()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setCastleHealth(2);
          _loc3_.setMinerPickaxe(3);
          _loc3_.setSpartanHelmet(3);
          _loc3_.setSpartanShield(1);
          _loc3_.setArcherDamage(1);
          _loc3_.setCastleArcherNumber(2);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          _loc3_.statue = 4;
          var _loc4_ = new AiLevel8();
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,4,8,7);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel9()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setMinerPickaxe(3);
          _loc3_.setCastleHealth(3);
          var _loc4_ = new AiLevel9();
          _loc3_.statue = 8;
          _loc3_.setCastleArcherNumber(1);
          _loc3_.setGiantStrength(2);
          _loc3_.setGiantClub(3);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,7,9,8);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel10()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setCastleHealth(3);
          _loc3_.setMinerPickaxe(4);
          var _loc4_ = new AiLevel10();
          _loc3_.statue = 0;
          _loc3_.setCastleArcherNumber(2);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setGiantStrength(2);
               _loc3_.setGiantClub(3);
               _loc3_.setSwordmanSword(3);
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,3,4,4);
          _root.game = _loc5_;
          _loc3_.statue = 0;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel11()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setCastleHealth(2);
          _loc3_.setMinerPickaxe(4);
          _loc3_.setSwordmanSword(3);
          _loc3_.setSpartanShield(3);
          _loc3_.setWizardHealing(3);
          _loc3_.statue = 9;
          var _loc4_ = new AiLevel11();
          _loc3_.setCastleArcherNumber(3);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,5,10,9);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel12()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.setCastleHealth(2);
          _loc3_.setMinerPickaxe(4);
          _loc3_.setSwordmanSword(3);
          _loc3_.setSpartanShield(3);
          _loc3_.setWizardHealing(3);
          _loc3_.statue = 11;
          var _loc4_ = new AiLevel12();
          _loc3_.setCastleArcherNumber(3);
          if(this.difficultyLevel == 3)
          {
               _loc3_.setArcherDamage(4);
               _loc3_.setCastleArcherNumber(4);
          }
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,6,7,6);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadLevel13()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          _loc3_.statue = 3;
          var _loc4_ = new AiLevel13();
          var _loc5_ = new Game(5,_root.canvas,600,400,1,0,_loc3_,this.technology,_loc4_,7,9,8);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
     function loadTesting()
     {
          _root.createEmptyMovieClip("canvas",1);
          var _loc3_ = new TechnologyManager(true,500,this.difficultyLevel);
          var _loc4_ = new AiLevel6();
          var _loc5_ = new Game(1,_root.canvas,600,400,1,0,_loc3_,new TechnologyManager(true,4000),_loc4_,5,6,5);
          _root.game = _loc5_;
          _loc5_.getSquad1().addMiner();
          _root.gotoAndPlay("game");
     }
}
