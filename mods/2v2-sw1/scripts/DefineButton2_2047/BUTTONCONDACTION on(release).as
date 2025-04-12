on(release){
     _root.removeMovieClip(_root.game.screen);
     _root.removeMovieClip(_root.game.HUD);
     _root.soundManager.stopBackgroundMusic();
     _root.game = undefined;
     _root.campaignData.loadLevel();
}
