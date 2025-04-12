_root.createEmptyMovieClip("canvas",1);
blueTechnology = new TechnologyManager();
redTechnology = new TechnologyManager();
ai = new AiScenario();
var game = new Game(1,canvas,600,400,1,0,redTechnology,blueTechnology,ai);
gotoAndStop("game");
play();
