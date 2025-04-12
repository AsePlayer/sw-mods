on(release){
     _root.levelDescription.removeMovieClip();
     _root.tips.removeMovieClip();
     _root.game.screen.removeMovieClip();
     _root.game.HUD.removeMovieClip();
     _root.soundManager.stopBackgroundMusic();
     _root.canvas._visible = false;
     _root.game = undefined;
     _root.gotoAndPlay("mainMenu");
     _root.gameMenu.removeMovieClip();
}
