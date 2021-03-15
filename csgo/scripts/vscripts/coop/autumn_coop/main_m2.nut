wave <- 0;
PLAYER_COUNT <- 2;			// overridden by debugmode
PLAYERS_ALIVE <- 0;

MISSION <- ScriptCoopMissionGetMissionNumber();

HARD_MODE <- false;

DEBUG <- false;

RESPAWN_ACTIVE <- false;
LASTSPAWN <- 0;
NEXTSPAWN <- 0;

BTN1 <- false;
BTN2 <- false;
BTN3 <- false;


SND_DEPLOY_APC <- "insertion.swat";
SND_VO_TEXT <- "Survival.BonusAward";
SND_COUNTDOWN_BEEP <- "UI.CounterBeep";



function Precache()
{
	self.PrecacheScriptSound( SND_DEPLOY_APC );
	self.PrecacheScriptSound( SND_VO_TEXT );
	self.PrecacheScriptSound( SND_COUNTDOWN_BEEP );
}

function debugPrint( text )
{
	if ( DEBUG == false )
		return;

	printl("========DEBUG PRINT======== " + text );
}



function RoundInit()
{

	
	wave = 0;
	
	HARD_MODE = false;
	
	FLICKER_BEAMGROUP1 = false;
	FLICKER_BEAMGROUP2 = false;
	
	SIMSUCCESS = false;
	
	RESPAWN_ACTIVE = false;

	SendToConsoleServer( "mp_coopmission_bot_difficulty_offset 2" );
	SendToConsoleServer( "bot_coop_idle_max_vision_distance 3000" );
	ScriptCoopSetBotQuotaAndRefreshSpawns( 0 );
	
	EnemyWaveSpawnsStop();		// stop wavespawning if previous attempt wiped on holdout
	
	
	EntFire ( "@tank.disable","Trigger", "", 1 );	// disable APC 

	
}

function HardModeToggle ( bool )
{

	HARD_MODE = bool;

	debugPrint ("Hard mode is currently: " + HARD_MODE);

}

function HardModeEnabled()
{

	debugPrint ("Hardmode unlocked");
	
	EntFire ( "@hardmode.success.snd","Playsound", "", 0 );
	EntFire ( "@hardmode.reveal.relay","Trigger", "", 2 );
	
	EntFire ( "@coopscript","RunScriptCode", "HardModeVO()", 2.5 );

}



function HardModeVO()		// play this line when player discovers hard mode button
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(9016)", 0 );
}

function OnPlayerDie()
{
	
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9001,9002,9003,9004,9005,0) )", 0 );

}

RANDOM_INT1 <- null;
RANDOM_INT2 <- null;
RANDOM_INT3 <- null;

FLICKER_BEAMGROUP1 <- false;	// beams in first room
FLICKER_BEAMGROUP2 <- false;	// beams by exit

function Think()
{
	local CurrentTime = Time();
	
	RespawnPlayerLoop();		// try respawning dead players, if allowed

	RANDOM_INT1 = RandomInt(170, 190);
	RANDOM_INT2 = RandomInt(180, 200);
	RANDOM_INT3 = RandomInt(190, 210);
	
	
	if (FLICKER_BEAMGROUP1)
	{
	EntFire( "@autogun1.beam", "Alpha", RANDOM_INT1, 0 );
	EntFire( "@autogun2.beam", "Alpha", RANDOM_INT2, 0 );
	EntFire( "@autogun3.beam", "Alpha", RANDOM_INT3, 0 );
	}
	
	if (FLICKER_BEAMGROUP2)
	{
	EntFire( "@barricade.beams1", "Alpha", RANDOM_INT1, 0 );
	EntFire( "@barricade.beams2", "Alpha", RANDOM_INT2, 0 );
	EntFire( "@barricade.beams3", "Alpha", RANDOM_INT3, 0 );
	EntFire( "@barricade.beams4", "Alpha", RANDOM_INT1, 0 );
	}
	
}


function DebugMode()
{
	DEBUG = true;
	PLAYER_COUNT = 1;
	EntFire( "@coopbutton_debugenable", "Trigger", "", 0 );
	EntFire( "@simbox.debug_alpha", "Trigger", "", 0 );		// set sim fadeout alpha to 100
	
	ScriptPrintMessageCenterAll( "Playing in DEBUG mode" );
}


function HardMode()		// modified settings for hard mode
{
	SendToConsoleServer( "mp_coopmission_bot_difficulty_offset 5" );
	SendToConsoleServer( "bot_coop_idle_max_vision_distance 4000" );
	EntFire( "@healthshot_hard", "Kill", "", 0 );
	debugPrint ("Starting in HARD mode");
}

function OnPostSpawn()
{
	SendToConsoleServer( "healthshot_allow_use_at_full 0" );
	SendToConsoleServer( "weapon_reticle_knife_show 1" );
	SendToConsoleServer( "mp_freezetime 1" );
	SendToConsoleServer( "bot_difficulty 2" );
	SendToConsoleServer( "mp_buytime 0" );
	SendToConsoleServer( "mp_startmoney 0" );

}


function TestFunction()		// this function is triggered by relay.test, use for testing random stuff
{

}



function HightlightLoot()
{

EntFire( "@coopscript", "RunScriptCode", "ToggleEntityOutlineHighlights(" + true + ")", 0 );

}

function ToggleEntityOutlineHighlights( bool )
{

ScriptCoopToggleEntityOutlineHighlights ( bool );

}

// =================================================================================
// === radio placeholder ===========================================================
// =================================================================================

TEMP_MSG <- null;

function TempRadioMessage( msg, delay )	// take a string and re-print it a couple of times so it'll stay on screen longer (~16 sec)
{
TEMP_MSG = msg;
EntFire( "@coopscript", "RunScriptCode", "TempRadioMessageSnd()", 0 + delay );
EntFire( "@coopscript", "RunScriptCode", "PrintRadioMessage()", 0 + delay );
EntFire( "@coopscript", "RunScriptCode", "PrintRadioMessage()", 4 + delay);
EntFire( "@coopscript", "RunScriptCode", "PrintRadioMessage()", 8 + delay);
EntFire( "@coopscript", "RunScriptCode", "PrintRadioMessage()", 12 + delay);
}

function TempRadioMessageSnd()	// have to split it into its own thing since emitsound can't be delayed..
{
self.EmitSound(SND_VO_TEXT);
}

function PrintRadioMessage()
{
ScriptPrintMessageCenterAll(TEMP_MSG);
}

// =================================================================================
// === puzzle script ===============================================================
// =================================================================================

//@simbox.timer.enable	
//@simbox.timer.disable

SIMSUCCESS <- false;

function SimOccupied( bool )
{

	if (bool == true)
	{
	EntFire( "@simbox.button.mdl", "SetGlowEnabled", "", 0 );
	EntFire( "@simbox.button", "Unlock", "", 0 );
	EntFire( "@simbox.button", "PressOut", "", 0.1 );
	EntFire( "@simbox.button.snd-unlock", "Playsound", "", 0 );
	}
	else if (bool == false)
		{
		EntFire( "@simbox.button.mdl", "SetGlowDisabled", "", 0 );
		EntFire( "@simbox.button", "Lock", "", 0 );
		}

}

function SimEnable()	// triggered when dudes outside ded
{

EntFire( "@simbox.door.entry", "Open", "", 0 );
EntFire( "@simbox.timer.centerspr", "Enable", "", 0 );	//blink center sprite

}

function SimBlindStart()
{

EntFire( "@simbox.snd.lights_on", "Playsound", "", 0 );
EntFire( "@simbox.light1.on", "Trigger", "", 0 );
EntFire( "@simbox.light2.on", "Trigger", "", 0.1 );
EntFire( "@simbox.light3.on", "Trigger", "", 0.2 );
EntFire( "@simbox.light4.on", "Trigger", "", 0.3 );

EntFire( "@simbox.snd.flash", "Playsound", "", 0.3 );
EntFire( "@simbox.light.toggle", "TurnOn", "", 0.3 );

EntFire( "@simbox.trigger.fade", "Enable", "", 0 );		//fade out player view

}

function SimBlindStop()
{

EntFire( "@simbox.lights.off", "Trigger", "", 0 );

EntFire( "@simbox.light.toggle", "TurnOff", "", 0 );

EntFire( "@simbox.snd.lights_off", "Playsound", "", 0 );

EntFire( "@simbox.trigger.fade", "Disable", "", 0 );		//remove fadeout

}

SIMFAILCOUNT <- 0;		// how many times the puzzle has been failed

function SimButtonPressed()
{

EntFire( "@simbox.button.snd-press", "Playsound", "", 0 );

EntFire( "@simbox.timer.reset", "Trigger", "", 0 );	// reset timer

EntFire( "@simbox.trigger.center", "Disable", "", 0 );
EntFire( "@simbox.timer.centerspr", "Disable", "", 0 );

EntFire( "@simbox.button.mdl", "SetGlowDisabled", "", 0 );

EntFire( "@coopscript", "RunScriptCode", "SimBlockPlayer()", 0 );	// capture player

EntFire( "@simbox.door.entry", "Close", "", 1 );

EntFire( "@coopscript", "RunScriptCode", "SimBlindStart()", 2 );	// blind player

	if (SIMFAILCOUNT < 8)
	{
		EntFire( "@simbox.path_select", "PickRandomShuffle", "", 3 );	// pick a path
	}
	else
		{
			EntFire( "@simbox.path4", "Trigger", "", 3 );		// sheesh
		}

EntFire( "@coopscript", "RunScriptCode", "SimBlockPlayerStop()", 4 );	// release player

EntFire( "@simbox.timer.enable", "Trigger", "", 4 );	// start 30 sec countdown

}

function SimSuccess()		// yay
{

SIMSUCCESS = true;

SimBlindStop();
EntFire( "@simbox.snd.success", "Playsound", "", 0 );
EntFire( "@simbox.paths.disable", "Trigger", "", 0 );	// disable all paths
EntFire( "@simbox.trigger.center", "Disable", "", 0 );	// disable player detector

EntFire( "@simbox.timer.disable", "Trigger", "", 0 );	// stop timer

EntFire( "@simbox.door.entry", "Open", "", 2 );
EntFire( "@simbox.door.exit", "Open", "", 2 );

EntFire( "@puzzleconf", "Trigger", "", 2 );		// well its here if you wanna use it

}

function SimFail()		// if timer expires, or player exits path
{

	if (SIMSUCCESS == false)
	{
		SimBlindStop();

		EntFire( "@simbox.snd.failure", "Playsound", "", 0 );
		EntFire( "@simbox.trigger.center", "Enable", "", 0 );
		EntFire( "@simbox.timer.centerspr", "Enable", "", 0 );
		EntFire( "@simbox.timer.disable", "Trigger", "", 0 );	// stop timer

		EntFire( "@simbox.paths.disable", "Trigger", "", 0 );		// disable all paths
		
		EntFire( "@simbox.door.entry", "Open", "", 0 );
		
		SIMFAILCOUNT++;
	}

}

function SimBlockPlayer()
{

EntFire( "@simbox.clipcage", "Enable", "", 0 );
EntFire( "@simbox.mover.railing", "Open", "", 0 );

}

function SimBlockPlayerStop()
{

EntFire( "@simbox.clipcage", "Disable", "", 0 );
EntFire( "@simbox.mover.railing", "Close", "", 0 );

}

// =================================================================================
// === game flow ===================================================================
// =================================================================================

function PlayersInReadyRoomDeployTrigger( amount )		
{
	local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if ( amount == PLAYER_COUNT && IsWarmupPeriod == false )
	{
	EntFire( "relay.mission_deploy", "Trigger", "", 0 );
	}
	else if ( amount < PLAYER_COUNT && IsWarmupPeriod == false )
	{
	EntFire( "relay.mission_deploy_abort", "Trigger", "", 0 );
	ReadyRoomDeploy( 5 )
	}

}

function ReadyRoomDeploy( input )
{
	switch ( input )
	{
		case 1: 
		{
		
		self.EmitSound( SND_COUNTDOWN_BEEP );
		
			if (HARD_MODE == true)
			{
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingHARDIn3" );
			}
			else
				{
					ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingIn3" );
				}

			break;
		}
		case 2:
		{
		
		self.EmitSound( SND_COUNTDOWN_BEEP );
		
			if (HARD_MODE == true)
			{
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingHARDIn2" );
			}
			else
				{
					ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingIn2" );
				}

			break;
		}
		case 3:
		{
		
		self.EmitSound( SND_COUNTDOWN_BEEP );
		
			if (HARD_MODE == true)
			{
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingHARDIn1" );
			}
			else
				{
					ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingIn1" );
				}

			break;
		}
		case 4:
		{
			ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_Deploying" );
			MissionStart();
			break;
		}
		case 5:
		{
			ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_WaitingDeploying" );

			break;
		}
	}
}



function ReadyRoomStart()		// triggered on map spawn via logic_auto
{
local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if (IsWarmupPeriod == false)
	{
		EntFire( "@charge.templ", "ForceSpawn", "", 0 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave01", "SetEnabled", "", 0 );	
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(200)", 2 );
	}
	
}

function ReadyRoomNagCharge()		// if player tries to deploy without breach charge
{
	
local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if (IsWarmupPeriod == false)
	{
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(201)", 2 );
	
	EntFire( "@breach.nag.extra", "Trigger", "", 0 );	// triggers extra nag after 30 sec
	
	EntFire( "@charge.startglow", "Trigger", "", 0 );
	}

}

function ReadyRoomNagChargeLong()		// if player still doesnt pick up charge
{
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(202)", 0 );

}

function ReadyRoomChargePickup()
{

EntFire( "@chargenag.trigger", "Disable", "", 0 );
EntFire( "@deploytrigger.trigger", "Enable", "", 0 );
EntFire( "@breach.nag.extra", "CancelPending", "", 0 );

}


function MissionStart()
{

	if (HARD_MODE == true)		// hard mode settings
	{
	HardMode();
	}
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_1", "SetEnabled", "", 0 );

		SpawnFirstEnemies(3);
		
		EntFire( "@apc.exhaust1", "Start", "", 0.25 );	
		EntFire( "@apc.exhaust2", "Start", "", 0.25 );	

		EntFire( "@deploytrigger.trigger", "Disable", "", 0 );	// disable deploy zone trigger so you can't trigger it multiple times
		EntFire( "counter.mission_deploy", "Disable", "", 0 );	// disable deploy zone counter
	
		EntFire( "@apc_start", "Trigger", "", 0.25 );	
		EntFire( "teleport.deploy", "Enable", "", 6 );
		
		EntFire( "@slideshow.cleanup", "Trigger", "", 6 );		// turn off slideshow + timer
		
}

function PlayerStatus( count )		// triggered from map via eventlisteners
{

	if (count == 3)		// default case, if its more than 2 or less than 0
	{
		debugPrint ("Players alive is in a funky state");
		PLAYERS_ALIVE = 1;
	}
	else
		{
			PLAYERS_ALIVE = count;
			debugPrint ("Players currently alive: " + PLAYERS_ALIVE);
		}

}

function PlayersInExitElevator( amount )		// both players have entered
{

	if ( amount == PLAYER_COUNT)
	{
	EntFire( "@exitelev_button", "Unlock", "", 0 );
	}
	else
	{
	EntFire( "@exitelev_button", "Lock", "", 0 );
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// MISSION 2 - POST-DOOR /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////



function APCRide()		// called from trigger inside APC when players are teleported
{

	EntFire ( "@apc_arrive", "Trigger", "", 0 );	// sound fadein, fade in screen after 8 sec
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(2)", 3 );
	
	EntFire( "@apc.exhaust2", "Start", "", 0 );	
	
	EntFire ( "@apc_door_open", "Trigger", "", 9 );		// open doors
}

function ExampleTempVO()
{
		//local msg = "CMDR - follow the riverbed, stay low and out of sight";
		//TempRadioMessage(msg, 3);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(3)", 2 );
}




function TestCamScript()
{
CameraSetCam( "@camera_default" );
}

function CameraSetCam( camera )		// name of camera as input
{
	EntFire( camera, "SetOnAndTurnOthersOff", "", 0 );

	EntFire( "@monitor_large", "SetCamera", camera, 0 );
	EntFire( "@monitor_small", "SetCamera", camera, 0 );

	EntFire( camera, "SetOff", "", 0.1 );
	
//	EntFire( "@monitor_large", "SetCamera", camera, 0 );
//	EntFire( "@monitor_small", "SetCamera", camera, 0 );
}

function ElevatorDownVO()
{

		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(203)", 0 );
		
		FLICKER_BEAMGROUP1 = true;
		
		EntFire( "@chainlinkdoor", "Open", "", 0 );

}


function LobbyAttack()
{

//EntFire( "@breachalarm", "FireUser2", "", 0 );	// turn off alarm and light in guard booth
EntFire( "@clip.security_roller", "Enable", "", 0 );

EntFire( "@security_roller.snd", "Playsound", "", 0 );		// close gate

EntFire( "@security_roller.mover", "Open", "", 1 );

EntFire( "@security_roller.snd", "Playsound", "", 1.25 );
EntFire( "@security_roller.snd", "Playsound", "", 2.5 );

//EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(205)", 4 );		// 10 sec

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(307)", 4 );		// 22 sec

EntFire( "@security_roller.snd", "Playsound", "", 27 );

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 27 );
EntFire( "@lobby.guarddoor", "Unlock", "", 28 );
EntFire( "@lobby.guarddoor", "Open", "", 28.5 );

}

function TunnelSpawn()
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 0 );

FLICKER_BEAMGROUP1 = false;

}

function TunnelMidSpawn()		// couple of extra dudes
{

EntFire( "@tunnels.mid.teleport", "Enable", "", 0 );

EntFire( "@tunnel.reinf_door", "Unlock", "", 0 );
EntFire( "@tunnel.reinf_door", "Open", "", 0.1 );

}

function TunnelEndSpawn()
{

EntFire( "@popupbox.busted.start", "Trigger", "", 0 );

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0 );

}

function TestMirageFight()
{

wave = 4;
OnWaveCompleted();
SendToConsole ( "setpos -836.063049 3895.548828 -218.673126;setang -2.164883 174.383728 0.000000" );

}

function TestTankFight()
{

EntFire( "@trigger_finale_spawn", "Enable", "", 1 );
SendToConsole ( "setpos -12.828970 734.094727 16.093811;setang 4.070004 -91.117645 0.000000" );

}


function MirageEntranceVO()
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(206)", 4 );
}

function MirageSpawnWaveOne()
{
EntFire( "@mirage.entrance_close", "Trigger", "", 0 );		// close entry door	

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(300)", 2 );

EntFire( "@popuptarget_forcedown", "Trigger", "", 3 );	// force down any standing targets

EntFire( "@mirage.wavesnd", "Playsound", "", 9 );	// annoying sound

	
EntFire( "@mirage.flash1", "Trigger", "", 10 );	// from cat
EntFire( "@mirage.flash3", "Trigger", "", 13 );	// from back apps
	
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 13 );

}

function MirageSpawnWaveTwo()
{

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(301)", 1 );

EntFire( "@mirage.wavesnd", "Playsound", "", 6 );	// annoying sound	
	
EntFire( "@mirage.flash1", "Trigger", "", 9 );	// from cat
EntFire( "@mirage.flash3", "Trigger", "", 12 );	// from back apps
EntFire( "@mirage.flash1", "Trigger", "", 16 );	// from cat

EntFire( "@mirage.smoke_van", "Trigger", "", 8 );	// van smoke
EntFire( "@mirage.smoke_bench", "Trigger", "", 10 );	// bench smoke


EntFire( "@eventlistener.botkill_mirage", "Enable", "", 0 );	// event listener enable
EntFire( "@mirage.deathcounter_wave2", "Enable", "", 0 );	// kill counter for heavy spawn (3)
	
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 14 );		


}

function MirageWaveTwoHeavySpawn()	// triggered when 3 bots from wave2 is killed
{

debugPrint ("Mirage wave 2 - heavy spawn");

EntFire( "@mirage.deathcounter_wave2", "Disable", "", 0 );	// kill counter for heavy spawn
EntFire( "@mirage.wave2.teleport", "Enable", "", 0 );

EntFire( "@mirage.smoke_arch", "Trigger", "", 1 );	// van smoke

}

function MirageSpawnWaveThree()
{

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(302)", 1 );
	
EntFire( "@mirage.wavesnd", "Playsound", "", 5 );	// annoying sound		
	
EntFire( "@mirage.deathcounter_wave3", "Enable", "", 0 );	// kill counter for apps spawn (5)
	
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 8 )", 7 );

EntFire( "@mirage.flash1", "Trigger", "", 7 );	
EntFire( "@mirage.flash2", "Trigger", "", 11 );	
EntFire( "@mirage.flash3", "Trigger", "", 16 );	


}

function MirageWaveThreeApps()
{

EntFire( "@mirage.apps.open", "Trigger", "", 1 );
EntFire( "@mirage.wave3.teleport", "Enable", "", 0 );

EntFire( "@clip.mirage_ceiling", "Disable", "", 0 );	// disable clip ceiling for arena

EntFire( "@mirage.flash1", "Trigger", "", 4 );	
EntFire( "@mirage.flash2", "Trigger", "", 9 );	


}

function MirageOverlookSpawn()
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0 );
EntFire( "@clip.mirage_backtrack_safety", "Disable", "", 0 );		// brush is enabled when arena coopbutton is triggered

}

function MainHallSpawn()
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 7 )", 0 );

EntFire( "@dustfall.timer", "Disable", "", 0 );

}


function MainHallOverlookSpawn()
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 0 );

}

function MainHallDoorCycle()
{

EntFire( "@halldoors.bell.snd", "Playsound", "", 0 );
EntFire( "@hall1.door*", "Close", "", 2 );		// 4 sec to fully open/close
EntFire( "@spinner1.on", "Trigger", "", 0 );
EntFire( "@spinner1.off", "Trigger", "", 7 );
EntFire( "@halldoors.bell.snd", "Stopsound", "", 2 );

EntFire( "@halldoors.bell.snd", "Playsound", "", 8 );
EntFire( "@hall2.door*", "Open", "", 10 );		// 4 sec to fully open/close
EntFire( "@spinner2.on", "Trigger", "", 8 );
EntFire( "@spinner2.off", "Trigger", "", 15 );
EntFire( "@halldoors.bell.snd", "Stopsound", "", 10 );


}

function SimSpawn()
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 4 )", 0 );

}


function AncientSpawnWaveOne()
{

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(211)", 1 );	// 9 sec

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(303)", 12 );	// 15 sec 
		
EntFire( "@ancient.wavesnd", "Playsound", "", 30 );
		
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 33 );

EntFire( "@ancient.flash1", "Trigger", "", 32 );
EntFire( "@ancient.flash2", "Trigger", "", 35 );

//EntFire( "@ancient.rampdoor1.open", "Trigger", "", 1 );

}

function AncientSpawnWaveTwo()
{

EntFire( "@ancient.wavesnd", "Playsound", "", 0 );

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 3 );

EntFire( "@teleport.ancient_wave2_delayed", "Enable", "", 12 );

EntFire( "@ancient.smoke_back", "Trigger", "", 1 );

EntFire( "@ancient.flash3", "Trigger", "", 2 );
EntFire( "@ancient.flash2", "Trigger", "", 11 );


//EntFire( "@ancient.ctdoor.open", "Trigger", "", 1 );

}

function AncientSpawnWaveThree()
{

EntFire( "@ancient.wavesnd", "Playsound", "", 0 );

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 3 );
//EntFire( "@ancient.innerdoor.open", "Trigger", "", 1 );

EntFire( "@teleport.ancient_wave3_delayed", "Enable", "", 12 );

EntFire( "@ancient.clip_boundry", "Disable", "", 0 );	// remove clip since players can get on catwalk
EntFire( "@ancient.clip_backtrack", "Disable", "", 0 );	

EntFire( "@ancient.smoke_middle", "Trigger", "", 0 );
EntFire( "@ancient.smoke_corner", "Trigger", "", 1 );

EntFire( "@ancient.flash1", "Trigger", "", 2 );
EntFire( "@ancient.flash2", "Trigger", "", 5 );
EntFire( "@ancient.flash3", "Trigger", "", 13 );

}

function AncientOverlookSpawn()
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 4 )", 0 );

}

function AncientOverlookIntelCollectedOld()
{

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(214)", 1 );

EntFire( "@ancientoverlook.klax", "Playsound", "", 4 );
	
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 5 );
EntFire( "@ancient.controlroom-exit", "Unlock", "", 6 );
EntFire( "@ancient.controlroom-exit", "Open", "", 6.1 );

}

function AncientOverlookIntelCollected()
{

EntFire( "@ancient.klaxtimer", "Enable", "", 0 );	// plays klax every 1.5 sec

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(305)", 3 );

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(214)", 8 );

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 6 );
EntFire( "@ancient.controlroom-exit", "Unlock", "", 6 );
EntFire( "@ancient.controlroom-exit", "Open", "", 6.5 );

}

function BacktrackSpawn()
{
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 10 )", 0 );
EntFire( "@backtrack-entry", "Unlock", "", 1 );
EntFire( "@backtrack-entry", "Open", "", 1.1 );

//EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(305)", 4 );

EntFire( "@trigger_backtrack_heavy_attack", "Enable", "", 0 );	

}

function BacktrackReinfSpawn()		
{

EntFire( "@eventlistener.botkill_backtrack", "Disable", "", 0 );

EntFire( "@teleport.backtrack_reinf", "Enable", "", 0 );

EntFire( "@backtrack-door1", "Unlock", "", 1 );
EntFire( "@backtrack-door1", "Open", "", 1.1 );

EntFire( "@backtrack.klax2", "Playsound", "", 0 );
}

function BacktrackHeavySquadSpawn()	
{
EntFire( "@eventlistener.botkill_backtrack", "Enable", "", 0 );		// triggers reinf on 2 kills

EntFire( "@teleport.backtrack_heavysquad", "Enable", "", 0 );

EntFire( "@backtrack-door2", "Unlock", "", 1 );
EntFire( "@backtrack-door2", "Open", "", 1.1 );

EntFire( "@backtrack.klax1", "Playsound", "", 0 );

}

function BacktrackMainHallAmbush()	
{
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 8 )", 0 );

EntFire( "@security_roller.mover", "Close", "", 0 );
EntFire( "@clip.security_roller", "Disable", "", 0 );
EntFire( "@clip.exit_dropdown", "Disable", "", 0 );

EntFire( "@exit-upperdoor*", "Unlock", "", 0 );
EntFire( "@exit-upperdoor*", "Open", "", 0.1 );

EntFire( "@chainlinkdoor", "Close", "", 0 );

EntFire( "@barricade.enable", "Trigger", "", 0.25 );	// turrets and barricade

FLICKER_BEAMGROUP2 = true;

EntFire( "@autoguns_kill", "Trigger", "", 0 );		// finale room turret cleanup 
EntFire( "@autogun1.beam", "TurnOff", "", 0 );
EntFire( "@autogun2.beam", "TurnOff", "", 0 );
EntFire( "@autogun3.beam", "TurnOff", "", 0 );
EntFire( "@emitter.startroom", "Kill", "", 0 );

}

function BacktrackSeeBarricade()
{

	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(216)", 0 );

	EntFire( "@coopscript", "RunScriptCode", "ExitRoomSpawn()", 4 );
	
	EntFire( "@backtrackklax.snd", "Playsound", "", 3.5 );
	
	
}

function ExitRoomSpawn()	
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );

EntFire( "@loop-upperdoor*", "Unlock", "", 0 );
EntFire( "@loop-upperdoor*", "Open", "", 0.1 );

}

function FinaleSpawnWaveOne()	
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );

EntFire( "@finale.closetdoor1", "Unlock", "", 0 );
EntFire( "@finale.closetdoor1", "Open", "", 0.1 );

}

function MolotovFoundVO()
{

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(218)", 0 );

EntFire ( "@tank.movetoposition2","Trigger", "", 1 );	// move up apc

EntFire( "@tanktrigger8", "Enable", "", 0 );

}

function FinaleSpawnWaveTwo()	
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 0 );

EntFire( "@finale.closetdoor3", "Unlock", "", 0 );
EntFire( "@finale.closetdoor3", "Open", "", 0.1 );

EntFire( "@mollycrate.startglow", "Trigger", "", 5 );

}

function FinaleSpawnWaveThree()	
{

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );

EntFire( "@finale.closetdoor2", "Unlock", "", 0 );
EntFire( "@finale.closetdoor2", "Open", "", 0.1 );

	

}

function PlayersInSimArea( amount )		// both players have entered
{

	if ( amount == PLAYER_COUNT)
	{
	DoorCleanup();
	EntFire( "@trigger_playercount_simarea", "Disable", "", 0 );
	}
}



function DoorCleanup()		// triggered when both players enter sim area
{

EntFire( "@hall2.door1", "Close", "", 0 );
EntFire( "@hall2.door2", "Close", "", 0 );

EntFire( "@clip.hall2_escape", "Enable", "", 0 );	// prevent players trying to escape

EntFire( "@lobby.guarddoor", "Close", "", 0 );
EntFire( "@lobby.guarddoor", "Lock", "", 0.1 );

EntFire( "@hall.staircase-door-upper", "Close", "", 0 );
EntFire( "@hall.staircase-door-upper", "Lock", "", 0.1 );

}

function TankSpawn()
{

EntFire ( "@tank.enable","Trigger", "", 0 );
EntFire ( "@tank.movetoposition","Trigger", "", 0.1 );

EntFire ( "@barrier.mdl","FireUser1", "", 0 );

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(217)", 1 );	// 7 sec

EntFire ( "@tankscript","RunScriptCode", "TankEnable()", 4 );

EntFire ( "@coopscript","RunScriptCode", "FinaleSpawnWaveOne()", 9 );

}


function SpawnTowerMonitor()
{
	EntFire( "@entmaker_monitor_large", "ForceSpawnAtEntityOrigin", "@monitor_rollupgate", 0 );
	
	CameraSetCam( "@camera_rollupgate" );

}




function PlayersInMirageArena( amount )		// both players have entered
{

	if ( amount == PLAYER_COUNT)
	{
	EntFire( "@coopscript", "RunScriptCode", "MirageSpawnWaveOne()", 1 );
	EntFire( "@trigger_mirage_players_entered", "Disable", "", 0 );
	EntFire( "@mirage.entry", "Close", "", 0 );
	EntFire( "@mirage.entry", "Lock", "", 0.1 );
	}
}

function PlayersInAncientArena( amount )		// both players have entered
{

	if ( amount == PLAYER_COUNT)
	{
	EntFire( "@coopscript", "RunScriptCode", "AncientSpawnWaveOne()", 1 );
	EntFire( "@trigger_ancient_players_entered", "Disable", "", 0 );
	EntFire( "@ancient.clip_backtrack", "Enable", "", 0 );	// prevent players jumping back into starting box
	
	}
}

function PlayersInAncientOverlook( amount )		// both players have entered
{

	if ( amount == PLAYER_COUNT)
	{
	EntFire( "@trigger_ancientoverlook_players_entered", "Disable", "", 0 );
	EntFire( "@ancient.controlroom-entry", "Close", "", 0 );	// Close door behind
	EntFire( "@ancient.controlroom-entry", "Lock", "", 0.1 );
	
	}
}

function PlayersInScissorLift( amount )		// both players have entered
{

	if ( amount == PLAYER_COUNT)
	{
	EntFire( "@scissorlift.button", "Unlock", "", 0 );
	}
	else
	{
	EntFire( "@scissorlift.button", "Lock", "", 0 );
	}
}



function TheEnd()		// this is the end
{

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(223)", 0 );	// 15 sec

EntFire ( "@slowfade_end_hold", "Fade", "", 1 );	// 10 sec
EntFire( "@coopscript", "RunScriptCode", "LevelEnd()", 16 );
}



function LevelEnd()		// scoreboard
{	

	EntFire( "@game_over", "EndRound_CounterTerroristsWin", "2", 0 );	
}



function EnemyWaveSpawnsStop()		// called in roundinit as well
{
	SendToConsoleServer( "mp_randomspawn_los 0" );
	SendToConsoleServer( "mp_use_respawn_waves 2" );
	SendToConsoleServer( "mp_respawnwavetime_t 5" );
}








// =================================================================================
// === game_coopmission_manager functions ( @coopmanager ) =========================
// =================================================================================

function OnMissionCompleted()
{

	
}

function OnRoundLostKilled()
{

	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9011,9012,9013,9015,0,0) )", 0 );
	
}

function OnRoundLostTime()
{

	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9006,9007,9008,9009,9010,0) )", 0 );
	
}

function OnRoundReset() 
{

	RoundInit();
}

function OnSpawnsReset()
{
	EntFire( "enemy.*", "SetDisabled", "", 0 );
	EntFire( "enemy.m2.wave01", "SetEnabled", "", 0 );
	EntFire( "CT_*", "SetDisabled", "", 0 );
	EntFire( "CT_0", "SetEnabled", "", 0 );
}


function OnWaveCompleted()
{	


	if ( wave == 1)
	{
		debugPrint ("Wave 1 defeated, finale room");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave02", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_1", "SetEnabled", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(204)", 2 );
		
		EntFire( "@breach-enable", "Trigger", "", 5 );		// enable breach charge on door
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
	}
	else if ( wave == 2)
	{
		debugPrint ("Wave 2 defeated, lobby");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave03", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_2", "SetEnabled", "", 0 );
		
		EntFire( "@tunnel.coopbutton_enable", "Trigger", "", 0 );		// enable tunnel coop button
		EntFire( "@coopbutton.glow_trigger", "Trigger", "", 0 );		// glows coop buttons after 30 seconds, event cancelled if buttons are used
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(208)", 5 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 3)
	{
		debugPrint ("Wave 3 defeated, tunnel");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave04", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_3", "SetEnabled", "", 0 );
		
		EntFire( "@tunnel.middoor", "SetGlowEnabled", "", 0 );		// unlock and glow door
		EntFire( "@tunnel.middoor", "Unlock", "", 1 );		
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 4)
	{
		debugPrint ("Wave 4 defeated, tunnel end room");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave05", "SetEnabled", "", 0 );
		
		EntFire( "@mirage.entry", "SetGlowEnabled", "", 0 );		// unlock and glow door
		EntFire( "@mirage.entry", "Unlock", "", 1 );		
		
		EntFire( "@dustfall.timer", "Enable", "", 0 );		
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 5)
	{
		debugPrint ("Wave 5 defeated, mirage wave one");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave06", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_4", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "MirageSpawnWaveTwo()", 3 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 6)
	{
		debugPrint ("Wave 6 defeated, mirage wave two");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave07", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "MirageSpawnWaveThree()", 1 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 7)
	{
		debugPrint ("Wave 7 defeated, mirage wave three");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave08", "SetEnabled", "", 0 );
		
		EntFire( "@mirage.overlook-entry", "SetGlowEnabled", "", 0 );
		EntFire( "@mirage.overlook-entry", "Unlock", "", 1 );
		
		EntFire( "@eventlistener.botkill_mirage", "Disable", "", 0 );	// event listener disable
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(207)", 2 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 8)
	{
		debugPrint ("Wave 8 defeated, mirage overlook");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave09", "SetEnabled", "", 0 );
		
		EntFire( "@hall1.coopbutton_enable", "Trigger", "", 0 );		// enable overlook coop button
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 9)
	{
		debugPrint ("Wave 9 defeated, main hall");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave10", "SetEnabled", "", 0 );
		
		EntFire( "@hall.staircase-door-upper", "SetGlowEnabled", "", 0 );		// glow and unlock door
		EntFire( "@hall.staircase-door-upper", "Unlock", "", 1 );		// glow and unlock door
		
		EntFire( "@trigger_mainhall_overlook_spawn", "Enable", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_5", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 10)
	{
		debugPrint ("Wave 10 defeated, main hall overlook");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave11", "SetEnabled", "", 0 );
		
		EntFire( "@hall2.coopbutton_enable", "Trigger", "", 0 );		// unlock coop button
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_6", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 11)
	{
		debugPrint ("Wave 11 defeated, simulator");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave12", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "SimEnable()", 3 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(209)", 3 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_7", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 12)
	{
		debugPrint ("Wave 12 defeated, ancient wave one");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave13", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "AncientSpawnWaveTwo()", 6 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_8", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 13)
	{
		debugPrint ("Wave 13 defeated, ancient wave two");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave14", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "AncientSpawnWaveThree()", 6 );
	
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 14)
	{
		debugPrint ("Wave 14 defeated, ancient wave three");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave15", "SetEnabled", "", 0 );
		
		EntFire( "@ancient.controlroom-entry", "SetGlowEnabled", "", 1 );
		EntFire( "@ancient.controlroom-entry", "Unlock", "", 2 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(212)", 1 );
		
		EntFire( "@trigger_ancient_overlook_spawn", "Enable", "", 0 );		// spawn trigger outside of door
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 15)
	{
		debugPrint ("Wave 15 defeated, ancient overlook");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave16", "SetEnabled", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(213)", 1 );
		
		EntFire( "@intel.enable", "Trigger", "", 3 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_9", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 16)
	{
		debugPrint ("Wave 16 defeated, ancient overlook attack");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave17", "SetEnabled", "", 0 );
		
		EntFire( "@trigger_backtrack_spawn", "Enable", "", 0 );
		
		EntFire( "@clip.ancient_breachskip", "Disable", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 17)
	{
		debugPrint ("Wave 17 defeated, backtrack guys");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave18", "SetEnabled", "", 0 );
		
		EntFire( "@hall.staircase-door-upper", "SetGlowEnabled", "", 0 );		// glow and unlock door
		EntFire( "@hall.staircase-door-upper", "Unlock", "", 1 );		// glow and unlock door
		
		EntFire( "@trigger_hall-exit-ambush", "Enable", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(215)", 3 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_6", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 18)
	{
		debugPrint ("Wave 18 defeated, mainhall and lobby backtrack");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave19", "SetEnabled", "", 0 );
		
		EntFire( "@trigger_backtrack_exitspawn", "Enable", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_5", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 19)
	{
		debugPrint ("Wave 19 defeated, exit room");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave20", "SetEnabled", "", 0 );
		
		EntFire( "@exitroom-door", "SetGlowEnabled", "", 0 );		// glow and unlock door
		EntFire( "@exitroom-door", "Unlock", "", 1 );		// glow and unlock door
		
		EntFire( "@trigger_finale_spawn", "Enable", "", 0 );		// finale spawn trigger
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_2", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 20)
	{
		debugPrint ("Wave 20 defeated, finale group 1");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2.wave21", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "FinaleSpawnWaveTwo()", 6 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_10", "SetEnabled", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	
}

// =================================================================================
// === spawning functions ==========================================================
// =================================================================================

function SpawnFirstEnemies( amount )
{
	ScriptCoopMissionSpawnFirstEnemies( amount );	
	ScriptCoopResetRoundStartTime();
	wave++;
}

function SpawnNextWave( amount )
{
	ScriptCoopMissionSpawnNextWave( amount );
	wave++;
	
	EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( false )", 1 );		// always turn off player spawning when spawning new enemies
}

function CoopSetBotQuotaAndRefreshSpawns( nQuota )
{
	ScriptCoopSetBotQuotaAndRefreshSpawns( nQuota );
}

function CoopMissionSetNextRespawnIn( flSeconds )
{
	ScriptCoopMissionSetNextRespawnIn( flSeconds, false );
}

function RespawnPlayerState( state )
{
	if (state == true)
	{
	debugPrint ("PLAYER RESPAWNING ACTIVE");
	RESPAWN_ACTIVE = true;
	
	ToggleEntityOutlineHighlights( true );		// highlight dropped guns
	}
	if (state == false)
	{
	debugPrint ("PLAYER RESPAWNING DISABLED");
	RESPAWN_ACTIVE = false;
	
	ToggleEntityOutlineHighlights( false );		// don't highlight dropped guns
	}
}

function RespawnPlayerLoop()
{
local time = Time();

	if (RESPAWN_ACTIVE == true && time > NEXTSPAWN)
	{
	LASTSPAWN = Time();
	NEXTSPAWN = LASTSPAWN + 1;
	debugPrint ("Respawning friendly player at " + LASTSPAWN + ", will try again at " + NEXTSPAWN + " sec");
	ScriptCoopMissionRespawnDeadPlayers();
	
	}
}