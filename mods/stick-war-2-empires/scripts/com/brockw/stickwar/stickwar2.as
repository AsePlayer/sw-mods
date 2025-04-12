package com.brockw.stickwar
{
     import com.brockw.game.XMLLoader;
     import com.brockw.stickwar.campaign.Campaign;
     import com.brockw.stickwar.campaign.CampaignGameScreen;
     import com.brockw.stickwar.campaign.CampaignMenuScreen;
     import com.brockw.stickwar.campaign.CampaignScreen;
     import com.brockw.stickwar.campaign.CampaignUpgradeScreen;
     import com.brockw.stickwar.campaign.EndOfGameSummary;
     import com.brockw.stickwar.engine.multiplayer.PostGameScreen;
     import com.brockw.stickwar.market.*;
     import com.brockw.stickwar.singleplayer.*;
     import com.google.analytics.GATracker;
     import flash.display.Loader;
     import flash.display.LoaderInfo;
     import flash.events.Event;
     import flash.net.URLRequest;
     import flash.system.Security;
     
     public class stickwar2 extends BaseMain
     {
           
          
          private var campaignMenuScreen:CampaignMenuScreen;
          
          private var _postGameScreen:PostGameScreen;
          
          private var _singleplayerRaceSelectScreen:SingleplayerRaceSelect;
          
          private var _marketScreen:MarketScreen;
          
          private var _armourScreen:NewArmoryScreen;
          
          private var _marketItems:Array;
          
          private var _itemMap:ItemMap;
          
          private var _loadout1:Loadout;
          
          private var _loadout2:Loadout;
          
          private var comment:String;
          
          public function stickwar2()
          {
               super();
               var _loc1_:XMLLoader = new XMLLoader();
               this.xml = _loc1_;
               this._loadout1 = new Loadout();
               this._loadout2 = new Loadout();
               this._itemMap = new ItemMap();
               isCampaignDebug = _loc1_.xml.campaignDebug == 1;
               postGameScreen = new PostGameScreen(this);
               addScreen("postGame",postGameScreen);
               addScreen("campaignMap",new CampaignScreen(this));
               addScreen("campaignGameScreen",new CampaignGameScreen(this));
               addScreen("campaignUpgradeScreen",new CampaignUpgradeScreen(this));
               addScreen("summary",new EndOfGameSummary(this));
               addScreen("mainMenu",this.campaignMenuScreen = new CampaignMenuScreen(this));
               addScreen("singleplayerRaceSelect",this._singleplayerRaceSelectScreen = new SingleplayerRaceSelect(this));
               addScreen("armoury",this._armourScreen = new NewArmoryScreen(this));
               this.campaign = new Campaign(0,0);
               this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
               setMarketItems();
          }
          
          public function getMarketItems() : Array
          {
               return [[84,"Swordwrath","Default",0,"",0,"Long Sword"]];
          }
          
          private function setMarketItems() : void
          {
               var _loc4_:* = null;
               this.marketItems = [];
               var _loc3_:int = 0;
               var arr:Array = [[84,"Swordwrath","Default",0,"",0,"Long Sword"],[85,"Swordwrath","Club",0,"",25,"Club"],[86,"Spearton","Default",0,"",0,"Default"],[87,"Miner","Default",0,"",0,"Default"],[88,"Ninja","Default",2,"",0,"Default"],[89,"Ninja","Default",0,"",0,"Default"],[90,"FlyingCrossbowman","Default",0,"",0,"Default"],[91,"EnslavedGiant","Default",0,"",0,"Default"],[92,"Magikill","Default",0,"",0,"Default"],[93,"Monk","Default",0,"",0,"Default"],[94,"Archidon","Default",1,"",0,"Default"],[95,"Spearton","Default",2,"",0,"Default"],[96,"Spearton","Default",1,"",0,"Default"],[97,"Ninja","Default",1,"",0,"Default"],[98,"FlyingCrossbowman","Default",1,"",0,"Default"],[99,"Magikill","Default",1,"",0,"Default"],[100,"Archidon","Default",2,"",0,"Default"],[101,"Swordwrath","Bronze Sword",0,"",40,"Samurai Sword"],[102,"Swordwrath","Saladins Sword",0,"",60,"Saladins Sword"],[103,"Spearton","Trident",0,"",100,"Trident"],[104,"Spearton","Diamond",0,"",70,"Diamond"],[105,"Spearton","Bronze Jaged",0,"",50,"Bronze Jaged"],[106,"Spearton","Golden Jaged",0,"",120,"Golden Jaged"],[107,"EnslavedGiant","Wooden Bag",0,"",75,"Wooden Bag"],[108,"Magikill","Purple Staff",0,"",75,"Purple Staff"],[109,"Magikill","Crystal Staff",0,"",100,"Crystal Staff"],[110,"Monk","Golden Staff",0,"",200,"Golden Staff"],[111,"Monk","Crystal Staff",0,"",100,"Crystal Staff"],[112,"Spearton","Lion Sheild",2,"",400,"Lion Sheild"],[113,"Spearton","Spider Shield",2,"",175,"Spider Shield"],[114,"Spearton","Scorpion Shield",2,"",125,"Scorpion Shield"],[115,"Spearton","HedgeHog Helmet",1,"",75,"HedgeHog Helmet"],[116,"Spearton","Wing Helmet",1,"",50,"Wing Helmet"],[117,"Ninja","Tribal Ninja",1,"",200,"Tribal Ninja"],[118,"Ninja","Visor Ninja",1,"",150,"Visor Ninja"],[119,"Magikill","Gold Hat",1,"",100,"Gold Hat"],[120,"Magikill","Belt Hat",1,"",75,"Belt Hat"],[121,"Archidon","Silver Archidon",2,"",100,"Silver Archidon"],[122,"Miner","Sharp Bag",2,"",75,"Sharp Bag"],[123,"FlyingCrossbowman","Default",2,"",0,"Default"],[124,"Magikill","Grey Beard",2,"",50,"Grey Beard"],[125,"Cat","Default",0,"",0,"Default"],[126,"Cat","Blue Eyes",0,"",50,"Blue Eyes"],[127,"Cat","Evil Crawler",0,"",150,"Evil Crawler"],[128,"Bomber","Default",0,"",0,"Default"],[129,"Knight","Default",0,"",0,"Default"],[130,"Knight","Boot Axe",0,"",75,"Boot Axe"],[131,"Knight","Spikey Axe",0,"",125,"Spikey Axe"],[132,"Knight","Chain Axe",0,"",100,"Chain Axe"],[133,"Giant","Default",0,"",0,"Default"],[134,"Giant","Skull Mace",0,"",150,"Skull Mace"],[135,"SkelatalMage","Twig Staff",0,"",50,"Twig Staff"],[136,"Bomber","Default",1,"",0,"Default"],[137,"Dead","Default",1,"",0,"Default"],[138,"Knight","Default",1,"",0,"Default"],[139,"Knight","Default",2,"",0,"Default"],[140,"Knight","Skull Shield",2,"",300,"Skull Shield"],[141,"Wingadon","Default",1,"",0,"Default"],[142,"Medusa","Default",1,"",0,"Default"],[143,"Medusa","red cape",1,"",75,"red cape"],[144,"SkelatalMage","Default",1,"",0,"Default"],[145,"SkelatalMage","Dragon Head",1,"",100,"Dragon Head"],[146,"Wingadon","Default",2,"",0,"Default"],[147,"Medusa","More Crowny",2,"",200,"More Crowny"],[148,"Medusa","Default",2,"",0,"Default"],[149,"Miner","Default",2,"",0,"Default"],[150,"Spearton","Native Spaer",0,"",150,"Native Spaer"],[151,"Spearton","Samurai Spear",0,"",125,"Samurai Spear"],[152,"Ninja","Knifed Pole",0,"",200,"Knifed Pole"],[153,"Ninja","Blue Ninja",0,"",75,"Blue Ninja"],[154,"Ninja","Red Ninja",0,"",75,"Red Ninja"],[155,"Ninja","Grey Ninja",0,"",75,"Grey Ninja"],[156,"Ninja","Gold Ninja",0,"",100,"Gold Ninja"],[157,"Archidon","Basic Helmet",1,"",75,"Basic Helmet"],[158,"Spearton","Native Shield",2,"",200,"Native Shield"],[159,"Spearton","Native Spearton",1,"",200,"Native Spearton"],[160,"Spearton","Gold Wood Shield",2,"",150,"Gold Wood Shield"],[161,"Spearton","Samurai",1,"",150,"Samurai"],[162,"FlyingCrossbowman","Basic Helmet",1,"",75,"Basic Helmet"],[163,"FlyingCrossbowman","Dark Wing",2,"",150,"Dark Wing"],[164,"Knight","Skull Axe",0,"",300,"Skull Axe"],[165,"Knight","Orc Weapon",0,"",150,"Orc Weapon"],[166,"Giant","Mace",0,"",75,"Mace"],[167,"Giant","Hammer",0,"",100,"Hammer"],[168,"Bomber","Armored Helmet",1,"",75,"Armored Helmet"],[169,"Dead","Wrapped Helmet",1,"",75,"Wrapped Helmet"],[170,"Knight","Bone Shield",2,"",300,"Bone Shield"],[171,"Knight","Skull Helmet",1,"",300,"Skull Helmet"],[172,"Knight","Wooden Shield",2,"",150,"Wooden Shield"],[173,"Knight","Shard Helmet",1,"",175,"Shard Helmet"],[174,"Wingadon","Basic Helmet",1,"",150,"Basic Helmet"],[175,"Wingadon","Armored Sleve",2,"",150,"Armored Sleve"],[176,"SkelatalMage","Default",0,"",0,"Default"],[177,"Swordwrath","Elvish Sword",0,"",125,"Elvish Sword"],[178,"Spearton","Hockey Stick",0,"",350,"Hockey Stick"],[179,"Spearton","Dark Samurai Spear",0,"",150,"Dark Samurai Spear"],[180,"Archidon","Samurai Archer",1,"",150,"Samurai Archer"],[181,"Spearton","Goal Pads Shield",2,"",350,"Goal Pads Shield"],[182,"Spearton","Red Goalie",1,"",350,"Red Goalie"],[183,"Spearton","Goat Shield",2,"",200,"Goat Shield"],[184,"Spearton","Samurai Mask",1,"",225,"Samurai Mask"],[185,"Miner","Trolley",2,"",250,"Trolley"],[186,"Magikill","Default",2,"",0,"Default"],[187,"Swordwrath","Copper Sword",0,"",75,"Copper Sword"],[188,"Swordwrath","Steel Sword",0,"",50,"Steel Sword"],[189,"Cat","Xenomorph",0,"",600,"Xenomorph"],[190,"Knight","Cleaver",0,"",200,"Cleaver"],[191,"Knight","Rusted Axe",0,"",250,"Rusted Axe"],[192,"Knight","Rusted Shield",2,"",250,"Rusted Shield"],[193,"Knight","Pig Shield",2,"",350,"Pig Shield"],[194,"Bomber","Scientist",1,"",200,"Scientist"],[195,"Bomber","Round Bomb",1,"",300,"Round Bomb"],[196,"Knight","Rust Helmet",1,"",250,"Rust Helmet"],[197,"Knight","Chef Hat",1,"",300,"Chef Hat"],[198,"Knight","Football Helmet",1,"",400,"Football Helmet"],[199,"Spearton","Gladiator Helmet",1,"",600,"Gladiator Helmet"],[200,"Spearton","Roman Shield",2,"",450,"Roman Shield"],[201,"Spearton","Greek Shield",2,"",350,"Greek Shield"],[202,"Spearton","Gold Helmet",1,"",250,"Gold Helmet"],[203,"Magikill","Silly Beard",2,"",150,"Silly Beard"],[204,"Knight","Predator Axe",0,"",375,"Predator Axe"],[205,"Knight","Baton",0,"",300,"Baton"],[206,"Knight","Riot Shield",2,"",450,"Riot Shield"],[207,"Knight","Gas Mask",1,"",450,"Gas Mask"],[208,"Knight","Predator Helmet",1,"",550,"Predator Helmet"],[209,"Knight","Fireman Axe",0,"",250,"Fireman Axe"],[210,"Knight","Fireman Shield",2,"",375,"Fireman Shield"],[211,"Knight","Fireman",1,"",350,"Fireman"],[212,"Dead","Frankenstein",1,"",500,"Frankenstein"],[213,"Swordwrath","Frying Pan",0,"",250,"Frying Pan"],[214,"Swordwrath","Twin Blades",0,"",600,"Twin Blades"],[215,"Swordwrath","Chainsaw",0,"",550,"Chainsaw"],[216,"Miner","Chaos Pickaxev",0,"",100,"Chaos Pickaxev"],[217,"Miner","Hammer",0,"",75,"Hammer"],[218,"Archidon","Sniper Hat",1,"",250,"Sniper Hat"],[219,"Ninja","Blue Mask",1,"",300,"Blue Mask"],[220,"Ninja","Yellow Mask",1,"",300,"Yellow Mask"],[221,"Ninja","Green Dude Purple",1,"",400,"Green Dude Purple"],[222,"Ninja","Green Dude Blue",1,"",400,"Green Dude Blue"],[223,"Ninja","Green Dude Orange",1,"",400,"Green Dude Orange"],[224,"Ninja","Green Dude Red",1,"",400,"Green Dude Red"],[225,"EnslavedGiant","Bones Bag",0,"",300,"Bones Bag"],[226,"ChaosMiner","Default",0,"",0,"Default"],[227,"ChaosMiner","Default",2,"",0,"Default"],[228,"Archidon","Robin Hood Hat",1,"",300,"Robin Hood Hat"],[229,"Spearton","Marine Helmet",1,"",350,"Marine Helmet"],[230,"Spearton","Dark Wood Shield",2,"",150,"Dark Wood Shield"],[231,"Spearton","Medieval Helmet",1,"",350,"Medieval Helmet"],[232,"Spearton","Medieval Shield",2,"",175,"Medieval Shield"],[233,"Spearton","Brown Shield",2,"",100,"Brown Shield"],[234,"FlyingCrossbowman","Blue Wing",2,"",350,"Blue Wing"],[235,"Swordwrath","Pirate Sword",0,"",275,"Pirate Sword"],[236,"Swordwrath","Fantasy Sword",0,"",350,"Fantasy Sword"],[237,"Bomber","Red Bike Helmet",1,"",200,"Red Bike Helmet"],[238,"Knight","Top Hat",1,"",400,"Top Hat"],[239,"Wingadon","Brown Hat",1,"",75,"Brown Hat"],[240,"Swordwrath","Crowbar",0,"",300,"Crowbar"],[241,"Ninja","Katana",2,"",150,"Katana"],[242,"Ninja","Ninja Scythe",2,"",200,"Ninja Scythe"],[243,"Ninja","Ninja Claws",2,"",250,"Ninja Claws"],[244,"FlyingCrossbowman","Leather Quiver",0,"",250,"Leather Quiver"],[245,"EnslavedGiant","Stone Bag",0,"",150,"Stone Bag"],[246,"Magikill","Basic Wooden Staff",0,"",75,"Basic Wooden Staff"],[247,"Magikill","Metal Staff",0,"",100,"Metal Staff"],[248,"Magikill","Ice Staff",0,"",300,"Ice Staff"],[249,"Magikill","Dragon Staff",0,"",400,"Dragon Staff"],[250,"Monk","Spellbook",0,"",350,"Spellbook"],[251,"Spearton","Captain America Shield",2,"",350,"Captain America Shield"],[252,"FlyingCrossbowman","Old Pilot\'s Helmet",1,"",250,"Old Pilot\'s Helmet"],[253,"FlyingCrossbowman","Allbowtross Red Hat",1,"",75,"Allbowtross Red Hat"],[254,"FlyingCrossbowman","Allbowtross Blue Hat",1,"",75,"Allbowtross Blue Hat"],[255,"Magikill","Yoda",1,"",450,"Yoda"],[256,"Archidon","Robin Hood Quiver",2,"",75,"Robin Hood Quiver"],[257,"Miner","Wagon",2,"",300,"Wagon"],[258,"ChaosMiner","Skull Pickaxe",0,"",150,"Skull Pickaxe"],[259,"Knight","Thor Hammer",0,"",250,"Thor Hammer"],[260,"Knight","Viking Axe",0,"",150,"Viking Axe"],[261,"SkelatalMage","Scythe",0,"",200,"Scythe"],[262,"SkelatalMage","Bone Scythe",0,"",225,"Bone Scythe"],[263,"Bomber","Flash",1,"",150,"Flash"],[264,"Dead","Jason Mask",1,"",500,"Jason Mask"],[265,"Knight","Viking Shield",2,"",175,"Viking Shield"],[266,"Knight","Viking Helmet",1,"",175,"Viking Helmet"],[267,"Wingadon","Pilot\'s Helmet",1,"",250,"Pilot\'s Helmet"],[268,"Medusa","Dracula Cape",1,"",350,"Dracula Cape"],[269,"SkelatalMage","Horns",1,"",175,"Horns"],[270,"ChaosMiner","Bone Bag",2,"",250,"Bone Bag"],[271,"ChaosMiner","Bone Trolley",2,"",300,"Bone Trolley"],[272,"Medusa","Jewel Crown",2,"",75,"Jewel Crown"],[273,"Knight","Thor Helmet",1,"",400,"Thor Helmet"],[274,"Bomber","Flask",0,"",175,"Flask"],[275,"Bomber","C4",0,"",150,"C4"],[276,"Spearton","British Spear",0,"",400,"British Spear"],[277,"Ninja","Spike Staff",0,"",150,"Spike Staff"],[278,"FlyingCrossbowman","Double Wings",0,"",150,"Double Wings"],[279,"Miner","Ancient Pickaxe",0,"",175,"Ancient Pickaxe"],[280,"Archidon","Native Archer",1,"",150,"Native Archer"],[281,"Archidon","Roman Archer",1,"",350,"Roman Archer"],[282,"Spearton","British Shield",2,"",475,"British Shield"],[283,"FlyingCrossbowman","Inferno Helmet",1,"",125,"Inferno Helmet"],[284,"Archidon","Native Quiver",2,"",125,"Native Quiver"],[285,"FlyingCrossbowman","Feather Wings",2,"",400,"Feather Wings"],[286,"Bomber","Rocket",0,"",200,"Rocket"],[287,"ChaosMiner","Shell Pickaxe",0,"",125,"Shell Pickaxe"],[288,"Knight","Gold Axe",0,"",400,"Gold Axe"],[289,"Giant","Bone",0,"",75,"Bone"],[290,"SkelatalMage","Horns Staff",0,"",150,"Horns Staff"],[291,"Dead","Scream Mask",1,"",350,"Scream Mask"],[292,"Knight","Gold Helmet",1,"",375,"Gold Helmet"],[293,"Knight","Gold Shield",2,"",375,"Gold Shield"],[294,"Knight","Thor Shield",2,"",350,"Thor Shield"],[295,"Wingadon","Demon Quiver",2,"",200,"Demon Quiver"],[296,"Wingadon","Demon Mask",1,"",200,"Demon Mask"],[297,"SkelatalMage","Green Helmet",1,"",300,"Green Helmet"],[298,"FlyingCrossbowman","Inferno Wings",2,"",150,"Inferno Wings"],[299,"Spearton","Pitchfork",0,"",175,"Pitchfork"],[300,"Ninja","Double Edged Spear",0,"",175,"Double Edged Spear"],[301,"Spearton","British Helmet",1,"",400,"British Helmet"],[302,"Archidon","Leafy Helmet",1,"",175,"Leafy Helmet"],[303,"Archidon","Leafy Quiver",2,"",150,"Leafy Quiver"],[304,"ChaosMiner","Bent Pickaxe",0,"",100,"Bent Pickaxe"],[305,"Medusa","Snake Cape",1,"",200,"Snake Cape"],[306,"Wingadon","Red Quiver",2,"",250,"Red Quiver"],[307,"Spearton","Leaf Helmet",1,"",175,"Leaf Helmet"],[308,"Spearton","Leaf Shield",2,"",200,"Leaf Shield"],[309,"Ninja","Leaf Ninja",1,"",200,"Leaf Ninja"],[310,"Ninja","Japanese Mask",1,"",450,"Japanese Mask"],[311,"FlyingCrossbowman","Leaf Helmet",1,"",100,"Leaf Helmet"],[312,"Spearton","Leaf Spear",0,"",100,"Leaf Spear"],[313,"Ninja","Leaf Staff",0,"",75,"Leaf Staff"],[314,"Magikill","Leaf Wizard Staff",0,"",75,"Leaf Wizard Staff"],[315,"Monk","Roots Wand",0,"",75,"Roots Wand"],[316,"Swordwrath","Wooden Sword",0,"",100,"Wooden Sword"],[317,"Miner","Roots Pickaxe",0,"",100,"Roots Pickaxe"],[318,"Miner","Leaf Bag",2,"",125,"Leaf Bag"],[319,"FlyingCrossbowman","Leaf Wings",2,"",150,"Leaf Wings"],[320,"SkelatalMage","Demon Head",1,"",350,"Demon Head"],[321,"Cat","Wolf Head",0,"",200,"Wolf Head"],[322,"Dead","Scorpion",1,"",375,"Scorpion"],[323,"Archidon","Ice Helmet",1,"",150,"Ice Helmet"],[324,"Archidon","Ice Quiver",2,"",150,"Ice Quiver"],[325,"Knight","Lion Head",1,"",300,"Lion Head"],[326,"Knight","Fur Shield",2,"",350,"Fur Shield"],[327,"Knight","Claw Hammer",0,"",300,"Claw Hammer"],[328,"Wingadon","Vulture Sleeve",2,"",200,"Vulture Sleeve"],[329,"Wingadon","Vulture Head",1,"",250,"Vulture Head"],[330,"Bomber","Gazelle Mask",1,"",200,"Gazelle Mask"],[331,"Medusa","Red Cape",1,"",325,"Red Cape"],[332,"FlyingCrossbowman","Bolts",0,"",300,"Bolts"],[333,"Medusa","Leopard Cape",1,"",375,"Leopard Cape"],[334,"SkelatalMage","Spiked Staff",0,"",250,"Spiked Staff"],[335,"Cat","Shard Head",0,"",200,"Shard Head"],[336,"FlyingCrossbowman","Demon Sleeve",0,"",175,"Demon Sleeve"],[337,"FlyingCrossbowman","Demon Helmet",1,"",200,"Demon Helmet"],[338,"FlyingCrossbowman","Demon Wings",2,"",225,"Demon Wings"],[339,"Medusa","Ice Cape",1,"",175,"Ice Cape"],[340,"Ninja","Bamboo",0,"",100,"Bamboo"],[341,"ChaosMiner","Shard Pickaxe",0,"",50,"Shard Pickaxe"],[342,"Spearton","Ice Speartan Helmet",1,"",125,"Ice Speartan Helmet"],[343,"Spearton","Ice Shield",2,"",150,"Ice Shield"],[344,"Spearton","Ice Spear",0,"",100,"Ice Spear"],[345,"Swordwrath","Ice Sword",0,"",150,"Ice Sword"],[346,"Giant","Anglar Fish Club",0,"",175,"Anglar Fish Club"],[347,"Miner","Ice Pickaxe",0,"",100,"Ice Pickaxe"],[348,"Miner","Ice Bag",2,"",125,"Ice Bag"],[349,"Ninja","Ice Ninja Staff",0,"",100,"Ice Ninja Staff"],[350,"Ninja","Ice Ninja Head",1,"",125,"Ice Ninja Head"],[351,"Magikill","Ice Staff 2",0,"",100,"Ice Staff 2"],[352,"Magikill","Ice Beard",2,"",75,"Ice Beard"],[353,"Magikill","Ice Hat",1,"",125,"Ice Hat"],[354,"FlyingCrossbowman","Ice Wing",2,"",150,"Ice Wing"],[355,"Magikill","flame",0,"",700,"flame"],[356,"Fire Element","Red Baseball WaterHat",1,"",50,"Red Baseball WaterHat"],[357,"Fire Element","Default",1,"",0,"Default"],[358,"Earth Element","Default",1,"",0,"Default"],[359,"Water Element","Default",1,"",0,"Default"],[360,"Air Element","Default",1,"",0,"Default"],[361,"Hurricane Element","Default",1,"",0,"Default"],[362,"Lava Element","Default",0,"",0,"Default"],[363,"Scorpion Element","Default",0,"",0,"Default"],[364,"Hurricane Element","Default",0,"",0,"Default"],[365,"Chrome Element","Default",1,"",0,"Default"],[366,"Scorpion Element","Default",1,"",100,"Default"],[367,"Lava Element","Default",1,"",0,"Default"],[368,"Miner Element","Default",1,"",0,"Default"],[369,"Lava Element","Default",2,"",0,"Default"],[370,"Miner Element","Default",2,"",0,"Default"],[371,"Air Element","Balloons AirHat",1,"",500,"Balloons AirHat"],[372,"Miner Element","Digger Crabbody",1,"",250,"Digger Crabbody"],[373,"Miner Element","Digger Crabhead",2,"",150,"Digger Crabhead"],[374,"Chrome Element","White Shell ChromeHead",1,"",300,"White Shell ChromeHead"],[375,"Hurricane Element","Cyborg HurricaneHead",1,"",150,"Cyborg HurricaneHead"],[376,"Scorpion Element","Big Jaw ScorpionDress",1,"",200,"Big Jaw ScorpionDress"],[377,"Earth Element","Army EarthHat",1,"",125,"Army EarthHat"],[378,"Water Element","Captain WaterHat",1,"",125,"Captain WaterHat"],[379,"Hurricane Element","Wood",0,"",100,"Wood"],[380,"Scorpion Element","Big Jaw ScorpionStinger",0,"",125,"Big Jaw ScorpionStinger"],[381,"Miner Element","Wood Crabbody",1,"",200,"Wood Crabbody"],[382,"Miner Element","Wood Crabhead",2,"",125,"Wood Crabhead"],[383,"Fire Element","Fireman FireHat",1,"",100,"Fireman FireHat"],[384,"Earth Element","Viking EarthHat",1,"",100,"Viking EarthHat"],[385,"Earth Element","Branches EarthHat",1,"",75,"Branches EarthHat"],[386,"Water Element","Octopus WaterHat",1,"",600,"Octopus WaterHat"],[387,"Air Element","Tallhat AirHat",1,"",550,"Tallhat AirHat"],[388,"Hurricane Element","Dragon HurricaneHead",1,"",125,"Dragon HurricaneHead"],[389,"Hurricane Element","Dragon",0,"",50,"Dragon"],[390,"Chrome Element","Blue Samurail ChromeHead",1,"",200,"Blue Samurail ChromeHead"],[391,"Miner Element","Turtle Crabbody",1,"",125,"Turtle Crabbody"],[392,"Miner Element","Turtle Crabhead",2,"",100,"Turtle Crabhead"],[393,"EnslavedGiant","Ice Giant Bag",0,"",100,"Ice Giant Bag"],[394,"ChaosMiner","Red Chaos Miner Pickaxe",0,"",75,"Red Chaos Miner Pickaxe"],[395,"ChaosMiner","Red Chaos Miner Bag",2,"",100,"Red Chaos Miner Bag"],[396,"Fire Element","Sheriff FireHat",1,"",75,"Sheriff FireHat"],[397,"Earth Element","Venus EarthHat",1,"",175,"Venus EarthHat"],[398,"Water Element","Pirate WaterHat",1,"",60,"Pirate WaterHat"],[399,"Air Element","Green Baseball AirHat",1,"",50,"Green Baseball AirHat"],[400,"Chrome Element","Black Skull ChromeHead",1,"",200,"Black Skull ChromeHead"],[401,"Scorpion Element","Halo ScorpionStinger",0,"",100,"Halo ScorpionStinger"],[402,"Scorpion Element","Halo ScorpionDress",1,"",175,"Halo ScorpionDress"],[403,"Knight","Red Knight Helmet",1,"",200,"Red Knight Helmet"],[404,"Knight","Red Knight Shield",2,"",200,"Red Knight Shield"],[405,"Knight","Red Knight Axe",0,"",150,"Red Knight Axe"],[406,"Air Element","Marionette AirHat",1,"",600,"Marionette AirHat"],[407,"Chrome Element","Red Samurail Mask ChromeHead",1,"",325,"Red Samurail Mask ChromeHead"],[408,"Scorpion Element","Wood ScorpionDress",1,"",150,"Wood ScorpionDress"],[409,"Water Element","Diver WaterHat",1,"",275,"Diver WaterHat"],[410,"Scorpion Element","Wood ScorpionStinger",0,"",50,"Wood ScorpionStinger"],[411,"Miner Element","Rock Crabhead",2,"",125,"Rock Crabhead"],[412,"Miner Element","Rock Crabbody",1,"",175,"Rock Crabbody"],[413,"Cat","Red Crawler Head",0,"",125,"Red Crawler Head"],[414,"Wingadon","Bark Quiver",2,"",150,"Bark Quiver"],[415,"Giant","Red Bat",0,"",125,"Red Bat"],[416,"Air Element","Italian AirHat",1,"",250,"Italian AirHat"],[417,"Hurricane Element","Wood HurricaneHead",1,"",200,"Wood HurricaneHead"],[418,"Hurricane Element","Ball HurricaneHead",1,"",150,"Ball HurricaneHead"],[419,"Chrome Element","Red Shell ChromeHead",1,"",300,"Red Shell ChromeHead"],[420,"Chrome Element","Purple Skull ChromeHead",1,"",200,"Purple Skull ChromeHead"],[421,"Chrome Element","Gold Samurail ChromeHead",1,"",400,"Gold Samurail ChromeHead"],[422,"Water Element","Jester WaterHead",1,"",175,"Jester WaterHead"],[423,"Earth Element","Detective EarthHat",1,"",75,"Detective EarthHat"],[424,"Fire Element","Detective FireHat",1,"",75,"Detective FireHat"],[425,"Hurricane Element","Cyborg",0,"",60,"Cyborg"],[426,"Hurricane Element","Ball",0,"",70,"Ball"],[427,"Lava Element","Dragon",1,"",350,"Dragon"],[428,"Lava Element","Long",1,"",200,"Long"],[429,"Lava Element","Alien",1,"",125,"Alien"],[430,"Knight","Turtle Axe",0,"",150,"Turtle Axe"],[431,"Knight","Turtle Helmet",1,"",150,"Turtle Helmet"],[432,"Knight","Turtle Shield",2,"",200,"Turtle Shield"],[433,"Hurricane Element","Beast HurricaneHead",1,"",175,"Beast HurricaneHead"],[434,"Hurricane Element","Beast",0,"",50,"Beast"],[435,"Fire Element","Gas FireHat",1,"",150,"Gas FireHat"],[436,"Earth Element","Wooden Mask",1,"",200,"Wooden Mask"],[437,"Water Element","Snorkel WaterHat",1,"",175,"Snorkel WaterHat"],[438,"Chrome Element","Ice Crown ChromeHead",1,"",50,"Ice Crown ChromeHead"],[439,"Spearton","Marine Shield",2,"",350,"Marine Shield"],[440,"Firestorm Element","Default",2,"",0,"Default"],[441,"Firestorm Element","Default",1,"",0,"Default"],[442,"Air Element","Astronaut",1,"",200,"Astronaut"],[445,"Firestorm Element","Knight fireburnface",1,"",150,"Knight fireburnface"],[446,"Water Element","Blue Baseball WaterHat",1,"",100,"Blue Baseball WaterHat"],[447,"Firestorm Element","Sun fireburnface",1,"",75,"Sun fireburnface"],[448,"Firestorm Element","Dragon fireburnface",1,"",300,"Dragon fireburnface"],[449,"Firestorm Element","Knight bodyfireburn",2,"",75,"Knight bodyfireburn"],[450,"Firestorm Element","Sun bodyfireburn",2,"",125,"Sun bodyfireburn"],[451,"Firestorm Element","dragon bodyfireburn",2,"",300,"dragon bodyfireburn"],[452,"EnslavedGiant","Leaf Bag",0,"",150,"Leaf Bag"],[453,"Spearton","Lava Helmet",1,"",275,"Lava Helmet"],[454,"Spearton","Lava Shield",2,"",275,"Lava Shield"],[455,"Spearton","Lava Spear",0,"",150,"Lava Spear"],[456,"Magikill","Leaf Hat",1,"",125,"Leaf Hat"],[457,"Monk","Lava Cleric Staff",0,"",125,"Lava Cleric Staff"],[458,"FlyingCrossbowman","Lava Wing",2,"",250,"Lava Wing"],[459,"FlyingCrossbowman","Lava Allbowtross Helmet",1,"",175,"Lava Allbowtross Helmet"],[460,"FlyingCrossbowman","Lava Sleeve",0,"",200,"Lava Sleeve"],[461,"Magikill","Gold Staff",0,"",400,"Gold Staff"],[462,"Ninja","Lava Ninja Helmet",1,"",175,"Lava Ninja Helmet"],[463,"Ninja","Lava Ninja Katana",2,"",250,"Lava Ninja Katana"],[464,"Ninja","Lava Staff",0,"",225,"Lava Staff"],[465,"Ninja","Fiery Staff",0,"",175,"Fiery Staff"],[466,"Magikill","Lava Hat",1,"",150,"Lava Hat"],[467,"Magikill","Lava Beard",2,"",60,"Lava Beard"],[468,"Magikill","Gold Beard Long",2,"",200,"Gold Beard Long"],[469,"Magikill","Gold Beard",2,"",150,"Gold Beard"],[470,"Swordwrath","Flame Sword",0,"",300,"Flame Sword"],[471,"Swordwrath","Treasure Sword",0,"",750,"Treasure Sword"],[472,"EnslavedGiant","Lava Bag",0,"",250,"Lava Bag"],[473,"Magikill","Gold Cap",1,"",750,"Gold Cap"],[474,"Archidon","Gold Quiver",2,"",300,"Gold Quiver"],[476,"EnslavedGiant","Jewel Bag",0,"",600,"Jewel Bag"],[477,"ChaosMiner","Purple Miner Bag",2,"",325,"Purple Miner Bag"],[478,"ChaosMiner","Purple Pickaxe",0,"",200,"Purple Pickaxe"],[479,"Dead","Dead Clown",1,"",500,"Dead Clown"],[480,"Knight","Purple Axe",0,"",300,"Purple Axe"],[481,"Knight","Purple Shield",2,"",400,"Purple Shield"],[482,"Knight","Purple Helmet",1,"",225,"Purple Helmet"],[483,"Medusa","Purple Medusa Cape",1,"",350,"Purple Medusa Cape"],[484,"SkelatalMage","Purple Skeleton Head",1,"",300,"Purple Skeleton Head"],[485,"Wingadon","red_eclipsor_helmet",1,"",150,"red_eclipsor_helmet"],[486,"Bomber","Round Bomb",0,"",275,"Round Bomb"],[487,"Giant","Purple Club",0,"",200,"Purple Club"],[488,"Medusa","Purple Medusa Crown",2,"",350,"Purple Medusa Crown"],[489,"Knight","Flame Axe",0,"",250,"Flame Axe"],[490,"Knight","Flame Shield",2,"",275,"Flame Shield"],[491,"Knight","Flame Helmet",1,"",175,"Flame Helmet"],[492,"SkelatalMage","Purple Scythe",0,"",300,"Purple Scythe"],[493,"ChaosMiner","Lava Miner Bag",2,"",300,"Lava Miner Bag"],[494,"ChaosMiner","Lava Pickaxe",0,"",125,"Lava Pickaxe"],[495,"Cat","Purple Crawler",0,"",300,"Purple Crawler"],[496,"Archidon","Gold Archer Helmet",1,"",275,"Gold Archer Helmet"],[497,"Archidon","Gold Quiver 2",2,"",225,"Gold Quiver 2"],[498,"SkelatalMage","Roots Evil Staff",0,"",200,"Roots Evil Staff"],[499,"SkelatalMage","Roots Skeleton Head",1,"",200,"Roots Skeleton Head"],[500,"Chrome Element","Space ChromeHead",1,"",350,"Space ChromeHead"],[501,"Spearton","Stone Speartan Shield",2,"",225,"Stone Speartan Shield"],[502,"Spearton","Speartan Stone Helmet",1,"",225,"Speartan Stone Helmet"],[503,"Spearton","Dwarf Speartan Spear",0,"",175,"Dwarf Speartan Spear"],[504,"Dead","Roots Dead",1,"",300,"Roots Dead"],[505,"Scorpion Element","Cargo ScorpionDress",1,"",300,"Cargo ScorpionDress"],[506,"Scorpion Element","Cargo ScorpionStinger",0,"",125,"Cargo ScorpionStinger"],[507,"Swordwrath","Dwarf Sword",0,"",325,"Dwarf Sword"],[508,"Miner","Wooden Cart",2,"",300,"Wooden Cart"],[509,"Miner","Ancient Pickaxe 2",0,"",200,"Ancient Pickaxe 2"],[510,"Magikill","Moon Star Hat",1,"",200,"Moon Star Hat"],[511,"Monk","Star Wand",0,"",200,"Star Wand"],[512,"Magikill","Santa Beard",2,"",75,"Santa Beard"],[513,"Tree Element","leaves",2,"",250,"leaves"],[514,"Tree Element","birds",2,"",350,"birds"],[515,"Swordwrath","Default",1,"",0,"Default"],[516,"Tree Element","Default",2,"",0,"Default"],[517,"Swordwrath","Ice",1,"",125,"Ice"],[518,"Swordwrath","Leaf",1,"",300,"Leaf"],[519,"Swordwrath","Lava",1,"",325,"Lava"],[520,"EnslavedGiant","Ammo Bag",0,"",350,"Ammo Bag"],[521,"Swordwrath","Stone",1,"",175,"Stone"],[522,"Swordwrath","Stone Sword",0,"",125,"Stone Sword"],[523,"Monk","Goblet",0,"",100,"Goblet"],[524,"Miner Element","Lava Crabbody",1,"",225,"Lava Crabbody"],[525,"Miner Element","Lava Crabhead",2,"",125,"Lava Crabhead"],[526,"Lava Element","Spikes",2,"",125,"Spikes"],[527,"Lava Element","Spike",1,"",75,"Spike"],[528,"Lava Element","Alien 2",1,"",150,"Alien 2"],[529,"Lava Element","Spikes",0,"",125,"Spikes"],[530,"Air Element","Parachute",1,"",300,"Parachute"],[531,"Medusa","Roots Medusa Crown",2,"",50,"Roots Medusa Crown"],[532,"Medusa","Roots Medusa Cape",1,"",300,"Roots Medusa Cape"],[533,"Knight","Roots Helmet",1,"",200,"Roots Helmet"],[534,"Knight","Roots Shield",2,"",225,"Roots Shield"],[535,"ChaosMiner","Roots Miner Bag",2,"",200,"Roots Miner Bag"],[536,"ChaosMiner","Roots Pickaxe",0,"",75,"Roots Pickaxe"],[537,"Wingadon","roots_eclipsor_sleeve",2,"",175,"roots_eclipsor_sleeve"],[538,"Wingadon","roots_eclipsor_helmet",1,"",125,"roots_eclipsor_helmet"],[539,"Knight","Roots Axe",0,"",175,"Roots Axe"],[540,"Cat","Roots Crawler",0,"",175,"Roots Crawler"],[541,"Giant","Roots Club",0,"",175,"Roots Club"],[542,"Ninja","Stone Ninja",1,"",150,"Stone Ninja"],[543,"Ninja","Stone Staff",0,"",75,"Stone Staff"],[544,"Ninja","Stone Ninja Hands",2,"",50,"Stone Ninja Hands"],[545,"FlyingCrossbowman","Stone Wing",2,"",175,"Stone Wing"],[546,"Archidon","Stone Archer Helmet",1,"",125,"Stone Archer Helmet"],[547,"Archidon","Stone Archer Sleeve",2,"",100,"Stone Archer Sleeve"],[548,"Miner","Stone Cart",2,"",100,"Stone Cart"],[549,"Miner","Stone Pickaxe",0,"",50,"Stone Pickaxe"],[550,"Archidon","Ice Quiver 2",2,"",125,"Ice Quiver 2"],[551,"Magikill","Stone Hat",1,"",125,"Stone Hat"],[552,"Magikill","Stone Staff",0,"",50,"Stone Staff"],[553,"FlyingCrossbowman","Stone Allbowtross Helmet",1,"",50,"Stone Allbowtross Helmet"],[554,"Chrome Element","Blue Shell ChromeHead",1,"",300,"Blue Shell ChromeHead"],[555,"Fire Element","Volcanic FireHat",1,"",125,"Volcanic FireHat"],[556,"Firestorm Element","Lava fireburnface",1,"",350,"Lava fireburnface"],[557,"Firestorm Element","phoenix bodyfireburn",2,"",125,"phoenix bodyfireburn"],[558,"Hurricane Element","Chainsaw",0,"",150,"Chainsaw"],[559,"FlyingCrossbowman","Metal Wing",2,"",250,"Metal Wing"],[560,"FlyingCrossbowman","Metal Allbowtross Helmet",1,"",200,"Metal Allbowtross Helmet"],[561,"Swordwrath","He Sword",0,"",275,"He Sword"],[562,"Archidon","Ice Helmet Covered",1,"",175,"Ice Helmet Covered"],[563,"Magikill","Pearl Staff",0,"",175,"Pearl Staff"],[564,"Wingadon","Purple Sleeve",2,"",150,"Purple Sleeve"],[565,"Scorpion Element","Gold ScorpionStinger",0,"",100,"Gold ScorpionStinger"],[566,"Scorpion Element","Gold ScorpionDress",1,"",100,"Gold ScorpionDress"],[567,"Archidon","Lava Archer Helmet",1,"",175,"Lava Archer Helmet"]];
               while(_loc3_ < arr.length)
               {
                    _loc4_ = new MarketItem(arr[_loc3_]);
                    this.marketItems.push(_loc4_);
                    _loc3_++;
               }
               this.itemMap.loadItems(this);
               this.armourScreen.updateUnitCard();
          }
          
          public function get marketItems() : Array
          {
               return this._marketItems;
          }
          
          public function set marketItems(param1:Array) : void
          {
               this._marketItems = param1;
          }
          
          private function addedToStage(param1:Event) : void
          {
               var _loc2_:* = null;
               var _loc3_:* = null;
               var _loc4_:* = null;
               var _loc5_:* = null;
               showScreen("mainMenu");
               tracker = null;
               if(false)
               {
                    tracker = new GATracker(this,"UA-36522838-2","AS3",false);
                    tracker.trackPageview("/play");
                    tracker.trackEvent("hostname","url",stage.loaderInfo.url);
               }
               if(xml.xml.isKongregate == 1)
               {
                    _loc2_ = LoaderInfo(stage.root.loaderInfo).parameters;
                    _loc3_ = _loc2_.kongregate_api_path || true;
                    isKongregate = true;
                    Security.allowDomain(_loc3_);
                    _loc4_ = new URLRequest(_loc3_);
                    (_loc5_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadComplete);
                    _loc5_.load(_loc4_);
                    this.addChild(_loc5_);
               }
          }
          
          internal function loadComplete(param1:Event) : void
          {
               kongregate = param1.target.content;
               kongregate.services.connect();
          }
          
          public function get itemMap() : ItemMap
          {
               return this._itemMap;
          }
          
          public function set itemMap(param1:ItemMap) : void
          {
               this._itemMap = param1;
          }
          
          public function get loadout2() : Loadout
          {
               return this._loadout2;
          }
          
          public function set loadout2(param1:Loadout) : void
          {
               this._loadout2 = param1;
          }
          
          public function get loadout1() : Loadout
          {
               return this._loadout1;
          }
          
          public function set loadout1(param1:Loadout) : void
          {
               this._loadout1 = param1;
          }
          
          public function get armourScreen() : NewArmoryScreen
          {
               return this._armourScreen;
          }
          
          public function set armourScreen(param1:NewArmoryScreen) : void
          {
               this._armourScreen = param1;
          }
     }
}
