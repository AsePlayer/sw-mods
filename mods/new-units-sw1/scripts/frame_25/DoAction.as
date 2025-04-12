domain_parts = _url.split("://");
real_domain = domain_parts[1].split("/");
domain = real_domain[0];
trace(domain);
if(domain != "74.52.169.210" && domain != "www.maxgames.com" && domain != "www.stickpage.com" && domain != "farm.stickpage.com")
{
}
_root.campaignData = new Campaign();
_root.soundManager = new SoundManager();
_root.soundManager.playBackgroundMusic("menu_Theme");
