package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.graphics.frames.FlxAtlasFrames;

class Stage extends MusicBeatState
{
    var curStage:String = PlayState.curStage; // borrowing kade engine code, i hope you guys dont mind :)
    public var addSprite:Array<Dynamic> = [];
    public var addBackLayer:Map<String, Dynamic> = [];
    public var addGroup:Map<String, FlxTypedGroup<Dynamic>> = []; 

	var halloweenBG:BGSprite;
	var halloweenWhite:BGSprite;

	var phillyLightsColors:Array<FlxColor>;
	var phillyWindow:BGSprite;
	var phillyStreet:BGSprite;
	var phillyTrain:BGSprite;
	var blammedLightsBlack:FlxSprite;
	var phillyWindowEvent:BGSprite;
	var trainSound:FlxSound;

	var phillyGlowGradient:PhillyGlow.PhillyGlowGradient;
	var phillyGlowParticles:FlxTypedGroup<PhillyGlow.PhillyGlowParticle>;

	var limoKillingState:Int = 0;
	var limo:BGSprite;
	var limoMetalPole:BGSprite;
	var limoLight:BGSprite;
	var limoCorpse:BGSprite;
	var limoCorpseTwo:BGSprite;
	var bgLimo:BGSprite;
	var grpLimoParticles:FlxTypedGroup<BGSprite>;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:BGSprite;

	var upperBoppers:BGSprite;
	var bottomBoppers:BGSprite;
	var santa:BGSprite;
	var heyTimer:Float;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();
	var bgGhouls:BGSprite;

	var tankWatchtower:BGSprite;
	var tankGround:BGSprite;
	var tankmanRun:FlxTypedGroup<TankmenBG>;
	var foregroundSprites:FlxTypedGroup<BGSprite>;

    var MAINLIGHT:FlxSprite;

    public function new(stageName:String)
    {
        super();
        this.curStage = stageName;

        switch (stageName)
        {
            case 'stage': //Week 1
				var bg:BGSprite = new BGSprite('stageback', -600, -200, 0.9, 0.9);
				addSprite.push(bg);

				var stageFront:BGSprite = new BGSprite('stagefront', -650, 600, 0.9, 0.9);
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				addSprite.push(stageFront);
				if(!ClientPrefs.lowQuality) {
					var stageLight:BGSprite = new BGSprite('stage_light', -125, -100, 0.9, 0.9);
					stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
					stageLight.updateHitbox();
					addSprite.push(stageLight);
					var stageLight:BGSprite = new BGSprite('stage_light', 1225, -100, 0.9, 0.9);
					stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
					stageLight.updateHitbox();
					stageLight.flipX = true;
					addSprite.push(stageLight);

					var stageCurtains:BGSprite = new BGSprite('stagecurtains', -500, -300, 1.3, 1.3);
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					addSprite.push(stageCurtains);
				}

			case 'spooky': //Week 2
				if(!ClientPrefs.lowQuality) {
					halloweenBG = new BGSprite('halloween_bg', -200, -100, ['halloweem bg0', 'halloweem bg lightning strike']);
				} else {
					halloweenBG = new BGSprite('halloween_bg_low', -200, -100);
				}
				addSprite.push(halloweenBG);

				halloweenWhite = new BGSprite(null, -800, -400, 0, 0);
				halloweenWhite.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.WHITE);
				halloweenWhite.alpha = 0;
				halloweenWhite.blend = ADD;

			case 'philly': //Week 3
				if(!ClientPrefs.lowQuality) {
					var bg:BGSprite = new BGSprite('philly/sky', -100, 0, 0.1, 0.1);
					addSprite.push(bg);
				}

				var city:BGSprite = new BGSprite('philly/city', -10, 0, 0.3, 0.3);
				city.setGraphicSize(Std.int(city.width * 0.85));
				city.updateHitbox();
				addSprite.push(city);

				phillyLightsColors = [0xFF31A2FD, 0xFF31FD8C, 0xFFFB33F5, 0xFFFD4531, 0xFFFBA633];
				phillyWindow = new BGSprite('philly/window', city.x, city.y, 0.3, 0.3);
				phillyWindow.setGraphicSize(Std.int(phillyWindow.width * 0.85));
				phillyWindow.updateHitbox();
				addSprite.push(phillyWindow);
				phillyWindow.alpha = 0;

				if(!ClientPrefs.lowQuality) {
					var streetBehind:BGSprite = new BGSprite('philly/behindTrain', -40, 50);
					addSprite.push(streetBehind);
				}

				phillyStreet = new BGSprite('philly/street', -40, 50);
				addSprite.push(phillyStreet);

			case 'limo': //Week 4
				var skyBG:BGSprite = new BGSprite('limo/limoSunset', -120, -50, 0.1, 0.1);
				addSprite.push(skyBG);

			case 'mall': //Week 5 - Cocoa, Eggnog
				var bg:BGSprite = new BGSprite('christmas/bgWalls', -1000, -500, 0.2, 0.2);
				bg.setGraphicSize(Std.int(bg.width * 0.8));
				bg.updateHitbox();
				addSprite.push(bg);

				var bgEscalator:BGSprite = new BGSprite('christmas/bgEscalator', -1100, -600, 0.3, 0.3);
				bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
				bgEscalator.updateHitbox();
				addSprite.push(bgEscalator);

				var tree:BGSprite = new BGSprite('christmas/christmasTree', 370, -250, 0.40, 0.40);
				addSprite.push(tree);

				var fgSnow:BGSprite = new BGSprite('christmas/fgSnow', -600, 700);
				addSprite.push(fgSnow);

			case 'mallEvil': //Week 5 - Winter Horrorland
				var bg:BGSprite = new BGSprite('christmas/evilBG', -400, -500, 0.2, 0.2);
				bg.setGraphicSize(Std.int(bg.width * 0.8));
				bg.updateHitbox();
				addSprite.push(bg);

				var evilTree:BGSprite = new BGSprite('christmas/evilTree', 300, -300, 0.2, 0.2);
				addSprite.push(evilTree);

				var evilSnow:BGSprite = new BGSprite('christmas/evilSnow', -200, 700);
				addSprite.push(evilSnow);

			case 'school': //Week 6 - Senpai, Roses
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel';
				GameOverSubstate.loopSoundName = 'gameOver-pixel';
				GameOverSubstate.endSoundName = 'gameOverEnd-pixel';
				GameOverSubstate.characterName = 'bf-pixel-dead';

				var bgSky:BGSprite = new BGSprite('weeb/weebSky', 0, 0, 0.1, 0.1);
				addSprite.push(bgSky);
				bgSky.antialiasing = false;

				var repositionShit = -200;

				var bgSchool:BGSprite = new BGSprite('weeb/weebSchool', repositionShit, 0, 0.6, 0.90);
				addSprite.push(bgSchool);
				bgSchool.antialiasing = false;

				var bgStreet:BGSprite = new BGSprite('weeb/weebStreet', repositionShit, 0, 0.95, 0.95);
				addSprite.push(bgStreet);
				bgStreet.antialiasing = false;

				var widShit = Std.int(bgSky.width * 6);
				if(!ClientPrefs.lowQuality) {
					var fgTrees:BGSprite = new BGSprite('weeb/weebTreesBack', repositionShit + 170, 130, 0.9, 0.9);
					fgTrees.setGraphicSize(Std.int(widShit * 0.8));
					fgTrees.updateHitbox();
					addSprite.push(fgTrees);
					fgTrees.antialiasing = false;
				}

				var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
				bgTrees.frames = Paths.getPackerAtlas('weeb/weebTrees');
				bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
				bgTrees.animation.play('treeLoop');
				bgTrees.scrollFactor.set(0.85, 0.85);
				addSprite.push(bgTrees);
				bgTrees.antialiasing = false;

				if(!ClientPrefs.lowQuality) {
					var treeLeaves:BGSprite = new BGSprite('weeb/petals', repositionShit, -40, 0.85, 0.85, ['PETALS ALL'], true);
					treeLeaves.setGraphicSize(widShit);
					treeLeaves.updateHitbox();
					addSprite.push(treeLeaves);
					treeLeaves.antialiasing = false;
				}

				bgSky.setGraphicSize(widShit);
				bgSchool.setGraphicSize(widShit);
				bgStreet.setGraphicSize(widShit);
				bgTrees.setGraphicSize(Std.int(widShit * 1.4));

				bgSky.updateHitbox();
				bgSchool.updateHitbox();
				bgStreet.updateHitbox();
				bgTrees.updateHitbox();

			case 'schoolEvil': //Week 6 - Thorns
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel';
				GameOverSubstate.loopSoundName = 'gameOver-pixel';
				GameOverSubstate.endSoundName = 'gameOverEnd-pixel';
				GameOverSubstate.characterName = 'bf-pixel-dead';

				/*if(!ClientPrefs.lowQuality) { //Does this even do something?
					var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
					var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);
				}*/
				var posX = 400;
				var posY = 200;

				if(!ClientPrefs.lowQuality) {
					var bg:BGSprite = new BGSprite('weeb/animatedEvilSchool', posX, posY, 0.8, 0.9, ['background 2'], true);
					bg.scale.set(6, 6);
					bg.antialiasing = false;
					addSprite.push(bg);

					bgGhouls = new BGSprite('weeb/bgGhouls', -100, 190, 0.9, 0.9, ['BG freaks glitch instance'], false);
					bgGhouls.setGraphicSize(Std.int(bgGhouls.width * PlayState.daPixelZoom));
					bgGhouls.updateHitbox();
					bgGhouls.visible = false;
					bgGhouls.antialiasing = false;
					addSprite.push(bgGhouls);
				} else {
					var bg:BGSprite = new BGSprite('weeb/animatedEvilSchool_low', posX, posY, 0.8, 0.9);
					bg.scale.set(6, 6);
					bg.antialiasing = false;
					addSprite.push(bg);
				}


			case 'tank': //Week 7 - Ugh, Guns, Stress
				var sky:BGSprite = new BGSprite('tankSky', -400, -400, 0, 0);
				addSprite.push(sky);

				var ruins:BGSprite = new BGSprite('tankRuins',-200,0,.35,.35);
				ruins.setGraphicSize(Std.int(1.1 * ruins.width));
				ruins.updateHitbox();
				addSprite.push(ruins);

				var ground:BGSprite = new BGSprite('tankGround', -420, -150);
				ground.setGraphicSize(Std.int(1.15 * ground.width));
				ground.updateHitbox();
				addSprite.push(ground);

			case 'alley':

		      	var wBg:FlxSprite;

				wBg = new FlxSprite(-500, -300).loadGraphic(Paths.image('backgrounds/whitty/whittyBack'));
				addSprite.push(wBg);

			case 'ballisticAlley':

		     	var nwBg:FlxSprite;
		    	var waBg = Paths.getSparrowAtlas('backgrounds/whitty/BallisticBackground');

		    	nwBg = new FlxSprite(-600, -200);
		    	nwBg.frames = waBg;

		     	nwBg.animation.addByPrefix('gameButMove', 'Background Whitty Moving', 16, true);
                nwBg.animation.play('gameButMove');

			addSprite.push(nwBg);

		    case 'nevada':

			    var bg:FlxSprite = new FlxSprite(-350, -300).loadGraphic(Paths.image('backgrounds/clown/red'));

		    	bg.antialiasing = true;
		    	bg.scrollFactor.set(0.9, 0.9);

		    	var stageFront:FlxSprite;
		    	if (Paths.formatToSongPath(PlayState.SONG.song) != 'madness')
		    	{
				    addSprite.push(bg);
				    stageFront = new FlxSprite(-1100, -460).loadGraphic(Paths.image('backgrounds/clown/island_but_dumb'));
			    }
			    else
			    {
			    	stageFront = new FlxSprite(-1100, -460).loadGraphic(Paths.image('backgrounds/clown/island_but_rocks_float'));
			    }

		    	stageFront.setGraphicSize(Std.int(stageFront.width * 1.4));
		    	stageFront.antialiasing = true;
		     	stageFront.scrollFactor.set(0.9, 0.9);
		    	stageFront.active = false;
		    	addSprite.push(stageFront);
			
		    	MAINLIGHT = new FlxSprite(-470, -150).loadGraphic(Paths.image('backgrounds/clown/hue'));
		     	MAINLIGHT.alpha - 0.3;
		    	MAINLIGHT.setGraphicSize(Std.int(MAINLIGHT.width * 0.9));
		    	MAINLIGHT.blend = "screen";
		    	MAINLIGHT.updateHitbox();
		    	MAINLIGHT.antialiasing = true;
		    	MAINLIGHT.scrollFactor.set(1.2, 1.2);
				addSprite.push(MAINLIGHT);
        }
    }
}