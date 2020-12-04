wave <- 0;
PLAYER_COUNT <- 2;			// overridden by debugmode
PLAYERS_ALIVE <- 0;

MISSION <- ScriptCoopMissionGetMissionNumber();

HARD_MODE <- false;

DEBUG <- false;

RESPAWN_ACTIVE <- false;
LASTSPAWN <- 0;
NEXTSPAWN <- 0;

MOLOTOV_TRIGGERED <- false;
FARMHOUSE_KILLS <- 0;

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

	EntFire ( "@skybox.station","Enable", "", 0 );
	
	EntFire ( "@navblock_fakewall","BlockNav", "", 0 );
	EntFire ( "@navblock_barndoor","BlockNav", "", 0 );
	
	wave = 0;
	
	HARD_MODE = false;
	
	RESPAWN_ACTIVE = false;

	SendToConsoleServer( "mp_coopmission_bot_difficulty_offset 2" );
	SendToConsoleServer( "bot_coop_idle_max_vision_distance 3000" );
	ScriptCoopSetBotQuotaAndRefreshSpawns( 0 );
	
	EnemyWaveSpawnsStop();		// stop wavespawning if previous attempt wiped on holdout
	
	
//	EntFire ( "@areaportal_finale_front","Close", "", 0 );
//	EntFire ( "@areaportal_finale_rear","Open", "", 0 );
	
}

function HardModeToggle ( bool )
{

	HARD_MODE = bool;

	debugPrint ("Hard mode is currently: " + HARD_MODE);

}

function HardModeEnabledCheck()
{

	if (BTN1 && !BTN2 && BTN3 )
	{
	debugPrint ("Hardmode unlocked");
	
	EntFire ( "podium-success","Playsound", "", 0 );
	EntFire ( "@hardmode.reveal.relay","Trigger", "", 2 );
	
	EntFire ( "@coopscript","RunScriptCode", "HardModeVO()", 2.5 );
	
	EntFire ( "podium-buttons","Kill", "", 0 );
	EntFire ( "podium-spr*","HideSprite", "", 1 );
	}
	else
	{
	debugPrint ("nah");
	}

}

function SetButtonVar( input )
{
	
	switch ( input )
	{
		case 1: 
		{	
			BTN1 = true;
			break;
		}
		case 2: 
		{	
			BTN1 = false;
			break;
		}
		case 3: 
		{	
			BTN2 = true;
			break;
		}
		case 4: 
		{	
			BTN2 = false;
			break;
		}
		case 5: 
		{	
			BTN3 = true;
			break;
		}
		case 6: 
		{	
			BTN3 = false;
			break;
		}
	}
	
	HardModeEnabledCheck();
	
}

function HardModeVO()		// play this line when player discovers hard mode button
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(9016)", 0 );
}

function VoTest()
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(1)", 0 );
}

function OnPlayerDie()
{
	
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9001,9002,9003,9004,9005,0) )", 0 );

}




function Think()
{
	local CurrentTime = Time();

//	printl ("Var status :");
//	printl (BTN1);
//	printl (BTN2);
//	printl (BTN3);
//	printl ("===========");
	
	RespawnPlayerLoop();		// try respawning dead players, if allowed

}


function DebugMode()
{
	DEBUG = true;
	PLAYER_COUNT = 1;
	EntFire( "@coopbutton_debugenable", "Trigger", "", 0 );
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
	local skycam = Entities.FindByClassname(null, "sky_camera");
	printl (skycam);
	
	local csment = Entities.FindByClassname(null, "sky_camera");
	printl (skycam);

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
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave01", "SetEnabled", "", 0 );	
		
		//local msg = "CMDR - investigate an old farm we suspect of serving as a phoenix facility";
		//TempRadioMessage(msg, 2);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(1)", 2 );
	}
	
}



function MissionStart()
{

	if (HARD_MODE == true)		// hard mode settings
	{
	HardMode();
	}
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_1", "SetEnabled", "", 0 );

		SpawnFirstEnemies(4);
		
		//self.EmitSound( SND_DEPLOY_APC );
	//	EntFire( "@apc.ignition_snd", "PlaySound", "", 0 );	
		EntFire( "@apc.exhaust1", "Start", "", 0.25 );	

		EntFire( "deploytrigger.trigger", "Disable", "", 0 );	// disable deploy zone trigger so you can't trigger it multiple times
		EntFire( "counter.mission_deploy", "Disable", "", 0 );	// disable deploy zone counter
		
	//	EntFire ( "@screenfade_hold", "Fade", "", 0 );
	
		EntFire( "@apc_start", "Trigger", "", 0.25 );	
		EntFire( "teleport.deploy", "Enable", "", 6 );
		
		EntFire( "@slideshow.cleanup", "Trigger", "", 6 );		// turn off slideshow + timer
		
		
		//EntFire ( "@screenfade_hold", "FadeReverse", "", 2.5 );
		
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// MISSION 1 - SOMEWHERE IN EUROPE ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

function ReadyroomFlyBy()
{
	local IsWarmupPeriod = ScriptIsWarmupPeriod();
	
//	if (IsWarmupPeriod == false)
//	{
//	EntFire ( "@snd.helipass.readyroom", "PlaySound", "", 1 );
//	EntFire ( "@readyroom.flyby", "SetAnimation", "helicopter_aztec", 0 );
//	}
}

function APCRide()		// called from trigger inside APC when players are teleported
{
	EntFire ( "@readyroom.flyby", "Disable", "", 0 );	// safety first

	EntFire ( "@apc_arrive", "Trigger", "", 0 );	// sound fadein, fade in screen after 8 sec
	
	//todo: add shaking
//	EntFire ( "@screenfade_hold", "FadeReverse", "", 2.5 );
	
	//local msg = "CMDR - coming up on the location now, get ready to dismount";
	//TempRadioMessage(msg, 1);
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(2)", 3 );
	
//	EntFire( "@apc.stoploop_snd", "PlaySound", "", 0 );	
	EntFire( "@apc.exhaust2", "Start", "", 0 );	
	
	EntFire ( "@apc_door_open", "Trigger", "", 9 );		// open doors
}

function FollowRiverVO()
{
		//local msg = "CMDR - follow the riverbed, stay low and out of sight";
		//TempRadioMessage(msg, 3);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(3)", 2 );
}

function ShootTrucks()
{
		//local msg = "CMDR - hope they dont notice the extra speedholes";
		//TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(4)", 2 );
}

function NearFarm()
{
		//local msg = "CMDR - coming up on the farm now, stay alert";
		//TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(6)", 2 );
}

function FieldAmbush()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 8 )", 0 );
	
	EntFire ( "@teleport_firstbarn", "Enable", "", 5 );
}

function CourtyardSpawn()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 0 );
	
	EntFire ( "@farmtruck.exhaust", "Start", "", 0 );	// pfx for truck
	
	
}

function SeeFirstTruckVO()
{
	//	local msg = "CMDR - theres one of the trucks. where did the other go?";
	//	TempRadioMessage(msg, 1);
}

function SeeElevatorDoors()
{
	//	local msg = "CMDR - im no expert, but that does not look like regular farm equipment";
	//	TempRadioMessage(msg, 1);
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(9)", 2 );
}

function SidepathSpawn()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0 );
	
	EntFire( "@trigger_elevatordoor_vo", "Disable", "", 0 );	// disable VO trigger if players have moved on to next area
	
}

function FarmhouseCourtyard()
{

	EntFire( "eventlistener.kills_courtyard", "Enable", "", 0 );	// enable event listener for player_death, T team
	EntFire( "@physcans_enable_damage", "Trigger", "", 0 );		// enable propane tanks to take damage
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 7 )", 0 );	

}

function FarmHouseBotsKilled()
{
FARMHOUSE_KILLS++;

	if (FARMHOUSE_KILLS == 3)
	{
	FarmHouseMolotovSpawn();
	}
}

function FarmHouseMolotovSpawn()		// either triggered by killing grunts or moving too far forward in arena
{
	debugPrint("Spawning molotov");

	if (MOLOTOV_TRIGGERED == false)
	{
	EntFire( "@seq_whoopsie", "Trigger", "", 0 );
	MOLOTOV_TRIGGERED = true;
	EntFire( "eventlistener.kills_courtyard", "Disable", "", 0 );	// dont need this anymore
	
	EntFire( "@physican.brk", "Break", "", 2.5 );		// if molly fails to ignite any cans
	}
}

function FoundGenerator()
{
	//	local msg = "CMDR - looks like this is supposed to power the place";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(8)", 1 );
		
		EntFire( "@generator.sparkonce", "Trigger", "", 0 );
		EntFire( "gen.button", "SetGlowEnabled", "", 1 );
}

GENERATOR_BUTTON_SUCCESS <- false;	// set to true if player has pressed button

// idleoff
// idleOn
// turn_ON

function GeneratorOn()
{
	EntFire( "gen.snd.startloop", "PlaySound", "", 0 );
	EntFire( "gen.button", "SetDefaultAnimation", "idleOn", 0 );
	EntFire( "gen.button", "SetAnimation", "turn_ON", 0 );
	EntFire( "gen.button", "SetGlowDisabled", "", 0 );
	EntFire( "gen.button.func", "Lock", "", 0 );
	EntFire( "gen.exhaust1", "Start", "", 0.6 );
	EntFire( "gen.exhaust2", "Start", "", 1 );
	EntFire( "@barnlight.on", "Trigger", "", 1 );
//	CameraSetCam( "@camera_elevator_doors" );
	EntFire( "@coopscript", "RunScriptCode", "SetCamElev()", 1 );
	EntFire( "gen.blinkinglights", "Enable", "", 1 );
	EntFire( "gen.shaker", "StartShake", "", 1 );
	EntFire( "@houselights_on", "Trigger", "", 1 );
	EntFire( "gen.exhaust3", "Start", "", 1.2 );
	EntFire( "@farmcon_on", "Trigger", "", 1.3 );
	
	if (GENERATOR_BUTTON_SUCCESS == false)	// only enable button if sequence hasnt been done
	{
		EntFire( "@bunkerdoor.button", "Unlock", "", 1.3 );
		EntFire( "@bunkerdoorbtn_turnon.snd", "PlaySound", "", 1 );
	}
	
	EntFire( "@coopscript", "RunScriptCode", "GeneratorStateCheck()", 5 );	

}

function SetCamElev()
{
CameraSetCam( "@camera_elevator_doors" );
}

function GeneratorStateCheck()
{

	if (GENERATOR_BUTTON_SUCCESS == true)
	{
		EntFire( "@coopscript", "RunScriptCode", "GeneratorOff()", 8 );		// if sequence is active, give it some extra time before cutting power
	}
	else
		{
			EntFire( "@coopscript", "RunScriptCode", "GeneratorOff()", 0 );		// otherwise just turn it off
		}

}

function GeneratorOff()
{
	EntFire( "@bunkerdoor.button", "Lock", "", 0 );
	EntFire( "@houselights_off", "Trigger", "", 0 );
	EntFire( "@farmcon_off", "Trigger", "", 0 );
	CameraSetCam( "@camera_default" );
	EntFire( "gen.snd.startloop", "StopSound", "", 0 );
	EntFire( "gen.snd.sputter", "PlaySound", "", 0 );
	EntFire( "gen.blinkinglights", "Disable", "", 2 );
	EntFire( "gen.snd.stop", "PlaySound", "", 3 );
	EntFire( "gen.snd.sputter", "StopSound", "", 3 );
	EntFire( "@barnlight.off", "Trigger", "", 3 );
	EntFire( "gen.button", "SetDefaultAnimation", "idleoff", 3 );
	EntFire( "gen.button", "SetAnimation", "idleoff", 3 );
	EntFire( "gen.exhaust1", "Stop", "", 3.5 );
	EntFire( "gen.exhaust2", "Stop", "", 3.5 );
	EntFire( "gen.exhaust3", "Stop", "", 3.5 );
	EntFire( "gen.button.func", "Unlock", "", 3.6 );
	EntFire( "gen.button.func", "PressOut", "", 3.6 );
	
	if (GENERATOR_BUTTON_SUCCESS == false)	// glow button if seq isnt complete
	{
		EntFire( "gen.button", "SetGlowEnabled", "", 3.5 );
	}
}

function FarmHouseInnerDoorOpen()
{
	EntFire( "@doorcontrol-door1", "Unlock", "", 1 );
	EntFire( "@doorcontrol-door1", "SetGlowEnabled", "", 1 );
	EntFire( "@doorcontrol-door2", "Unlock", "", 1 );
	EntFire( "@doorcontrol-door2", "SetGlowEnabled", "", 1 );
	
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );
}

function SpawnBunkerButtonMonitors()
{
//@monitor_elevdoor_large
//@monitor_elevdoor_small
//@camera_elevator_doors
//@monitor_small
//@monitor_large

	EntFire( "@entmaker_monitor_large", "ForceSpawnAtEntityOrigin", "@monitor_elevdoor_large", 0 );
	EntFire( "@entmaker_monitor_small", "ForceSpawnAtEntityOrigin", "@monitor_elevdoor_small", 0 );
	
	CameraSetCam( "@camera_default" );
	
//	EntFire( "@camera_elevator_doors", "SetOnAndTurnOthersOff", "", 0 );
//	EntFire( "@camera_elevator_doors", "SetOff", "", 0.1 );
	
//	EntFire( "@monitor_large", "SetCamera", "@camera_elevator_doors", 0 );
//	EntFire( "@monitor_small", "SetCamera", "@camera_elevator_doors", 0 );
	
	
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

function FoundBunkerButton()
{
	//	local msg = "CMDR - that looks important";
	//	TempRadioMessage(msg, 1);
	
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(10)", 2 );
		
}

function BunkerDoorsForceOpen()
{
	if (DEBUG == true)
	{
	debugPrint("Forcing open bunker doors");
	BunkerDoorsOpened();
	}
}

CONSOLEBUTTONTIMENEXT <- 0;
CONSOLEBUTTONUSEAMOUNT <- 0;

function BunkerDoorsButtonNoPower()
{

local CurrentTime = Time();

	if (GENERATOR_BUTTON_SUCCESS == false && CurrentTime > CONSOLEBUTTONTIMENEXT)
	{
	CONSOLEBUTTONTIMENEXT = Time() + 5;

	if (CONSOLEBUTTONUSEAMOUNT < 5)
	{
	CONSOLEBUTTONUSEAMOUNT++;
	}
	
	switch ( CONSOLEBUTTONUSEAMOUNT )
	{
		case 1: 
		{	
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(11)", 0 );
			break;
		}
		case 2: 
		{	
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(12)", 0 );
			break;
		}
		case 3: 
		{	
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(13)", 0 );
			break;
		}
		case 4: 
		{	
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(14)", 0 );
			break;
		}
		case 5: 
		{	
			EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(11,12,13,0,0,0) )", 0 );
			break;
		}
	}
	}
}


function BunkerDoorsOpened()
{
	GENERATOR_BUTTON_SUCCESS = true;

	EntFire( "@barn1-door", "Close", "", 1 );
	EntFire( "@barn1-door", "Lock", "", 2 );
	
	EntFire( "@house2-door", "Close", "", 1 );
	EntFire( "@house2-door", "Lock", "", 2 );
	
	EntFire( "@spark.bunkerdoor", "StartSpark", "", 0.3 );
	EntFire( "@spark.bunkerdoor", "StopSpark", "", 1 );
	
	EntFire( "@camera_elevator_doors", "SetOn", "", 1.9 );
	
	EntFire( "@bunkerdoor.relay", "Trigger", "", 2 );
	
	EntFire( "@camera_elevator_doors", "SetOff", "", 8 );	// stop updating camera once doors are opened
	
//	EntFire( "@trigger_backtrack_spawn", "Enable", "", 0 );
	EntFire( "@trigger_backtrack_vo", "Enable", "", 3 );
	
	EntFire( "@coopscript", "RunScriptCode", "BunkerDoorsOpenedVO()", 1.5 );
	
}

function BunkerDoorsOpenedVO()
{
	//	local msg = "CMDR - guess we are going underground";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(15)", 1 );
}

function PlayersInGeneratorCourtyard( amount )		// both players have entered
{

	if ( amount == PLAYER_COUNT)
	{
	LockGeneratorCourtyard();
	EntFire( "@trigger_playercount_gencourtyard", "Disable", "", 0 );
	}
}

function LockGeneratorCourtyard()
{

EntFire ( "@house3-door","Close", "", 0 );
EntFire ( "@house3-door","Lock", "", 1 );

}

function BacktrackInstruction()
{
	//	local msg = "CMDR - investigate that big door thing";
	//	TempRadioMessage(msg, 1);
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(31)", 1 );
}

function BackTrackSpawn()
{
	
	EntFire ( "@house3-door","Unlock", "", 0.5 );

	EntFire ( "@barndoor.sliding","Open", "", 1 );
	EntFire ( "@navblock_barndoor","UnblockNav", "", 0 );
	
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0.25 );
}


function ElevatorUp()
{
	EntFire( "@clip.elevatordoors", "Disable", "", 0 );	// disable topside clipbrush
//	EntFire( "@elevator_blockbullets", "Enable", "", 0 );	// block bullets	note: fingers crossed

	EntFire( "@elevator_clipcage", "Enable", "", 0 );
	
	EntFire( "ugliest_hack_this_side_of_the_missisispsip", "Enable", "", 0 );	// whoooo boy
	
	EntFire( "@elevator_mover", "teleporttopathnode", "@elevator1-1", 0 );	// teleport to position

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0.1 );	// spawn dudes 
	
	EntFire( "@elevator_startforward", "Trigger", "", 0.2 );	// move elevator, stops at top
}

function ElevatorArrivedUp()		// triggered from path_track at top
{
	EntFire( "@elevator_blockbullets", "Disable", "", 0.5 );
	EntFire( "@elevator_clipcage", "Disable", "", 0.25 );
}

function ElevatorDown()
{
	EntFire( "ugliest_hack_this_side_of_the_missisispsip", "Disable", "", 0 );	// never speak of it again
	EntFire( "@timer.cleanup", "Trigger", "", 0 );
	
	EntFire( "@pfx.tunnels_initial", "Start", "", 0 );
	
	
	EntFire( "@elevator_startforward", "Trigger", "", 0.5 );	// move elevator, stops at bottom
	EntFire( "@trigger_elevatorarrival_spawn", "Enable", "", 0 );
	EntFire( "@elevator_clipcage", "Enable", "", 0 );		// clip cage so player doesnt escape. disabled by trigger at bottom of shaft
	
	EntFire( "@bunkerdoor_close.relay", "Trigger", "", 5 );		// close overhead doors
	
	EntFire( "@ragdoll_remover", "RunScriptCode", "Enable()", 0 );	// remove any ragdolls resting on elevator, otherwise they float in midair
	EntFire( "@ragdoll_remover", "RunScriptCode", "Disable()", 1 );
}

function ElevatorDownVO()
{
	//	local msg = "CMDR - this is a bit more fancy than i expected";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(32)", 1 );
}

function ElevatorArrivalSpawn()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 0 );
	
	EntFire ( "chickengroup*", "Kill", "", 0 );		//chicken cleanup
	
	EntFire ( "@pfx.pssh", "Start", "", 0 );		//psssh
	EntFire ( "@pfx.pssh", "Stop", "", 2 );		
	EntFire ( "@snd.psssh", "PlaySound", "", 0 );		
	
}

function FakewallOpen()
{

	EntFire( "@fakewall.relay", "Trigger", "", 1.5 );
	EntFire( "@trigger_fakedoor_spawn", "Enable", "", 0 );	
	EntFire ( "@navblock_fakewall","UnblockNav", "", 0 );
	
	EntFire( "@pfx.tunnels", "Start", "", 0 );		// smoke pfx in tunnel
	
	//local msg = "CMDR - alright..";
	//TempRadioMessage(msg, 2);
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(100)", 5 );
	
}

function FakewallAttack()
{

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 1 );
	
//	EntFire( "@flash_spawner", "ForceSpawn", "", 3 );		// give the guys flashes instead
	
}

function TunnelAttack()
{
	EntFire( "@tunnelgate.alarm.snd", "Playsound", "", 0 );

	EntFire( "@stoplight-red_on", "Trigger", "", 0 );
	EntFire( "@stoplight_rollup1-red_on", "Trigger", "", 0 );	// set up the other one at the same time
	
	EntFire( "@tunnel_gate_close", "Trigger", "", 0.75 );
}

function TunnelAttackSpawn()	// split this out in case players run past dudes, triggered by @trigger_tunnelattack_spawn
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 0 );
	
	EntFire( "@door_tunnel_attack", "Unlock", "", 0 );
	EntFire( "@door_tunnel_attack", "Open", "", 0.5 );
	EntFire( "@door_tunnel_attack", "Lock", "", 1.5 );
	
}

function TunnelGateOpen()
{
	EntFire( "@stoplight-green_on", "Trigger", "", 0 );
	EntFire( "@tunnel_gate_open", "Trigger", "", 1.5 );
}

function BunkerAttackSpawn()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 8 )", 0 );
}

function BunkerAttackDoorReinf()
{

	EntFire( "@stoplight_rollup1-green_on", "Trigger", "", 0 );

	EntFire( "@bunker.rollup1", "Open", "", 0 );
	EntFire( "@bunker.rollupdoor.blocker", "Disable", "", 1 );	// prevent bots from hugging door
	EntFire( "@bunker.rollup1", "Close", "", 4 );
	
	EntFire( "@stoplight_rollup1-red_on", "Trigger", "", 7 );
	
	EntFire( "@rollupdoor.softbarrier", "Disable", "", 7 );		// disable barrier once door is closed
	EntFire( "@teleport_rollupdoor1", "Enable", "", 7 );		// teleport baddies out if everything goes wrong

}

function LooksExpensiveVO()
{
		//local msg = "CMDR - how can they afford this stuff";
		//TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(102)", 1 );
}

function BunkerInteriorSpawn()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 4 )", 0 );
	
	EntFire( "@pfx.bunker.ventsteam1", "Start", "", 0 );
	
	EntFire( "@teleport_rollupdoor1", "Disable", "", 0 );	// disable teleport trigger
}

function BunkerCoopbuttonUsed()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0 );
	
	EntFire( "@tunnel_gate_close", "Trigger", "", 0 );
	
	EntFire( "@bunker.coopdoor.1", "Unlock", "", 1 );
	EntFire( "@bunker.coopdoor.1", "Open", "", 1.25 );
	
	EntFire( "@bunker.coopdoor.2", "Unlock", "", 1 );
	EntFire( "@bunker.coopdoor.2", "Open", "", 1.25 );
	
	
}

function AlottaSodaVO()
{
		//local msg = "CMDR - nice, that will really annoy them if they want a drink later";
		//TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(104)", 1 );
}

function BunkerCatwalkEntered()
{
	EntFire( "@teleport_rollupdoor1", "Disable", "", 0 );	// disable teleport trigger
	EntFire( "@clip.catwalk_safety", "Disable", "", 0 );
	EntFire( "@tunnel_catwalk_button", "Trigger", "", 0 );
	SpawnTowerMonitor();
	EntFire( "@trigger_cam_rollupgate_toggle", "Enable", "", 0 );
	
}

function SpawnTowerMonitor()
{
	EntFire( "@entmaker_monitor_large", "ForceSpawnAtEntityOrigin", "@monitor_rollupgate", 0 );
	
	CameraSetCam( "@camera_rollupgate" );

}


function BunkerCatwalkTowerButton()		// tower button used
{
EntFire( "@stoplight_rollup1-green_on", "Trigger", "", 0 );
EntFire( "@bunker.rollup1", "Open", "", 1 );
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 1 );
}

function BunkerRollupOpen()		// coop button used
{

		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_11", "SetEnabled", "", 0 );

EntFire( "@trigger_finale_reinf_emptydoor", "Enable", "", 0 );	// close trigger

EntFire( "@bunker.rollup1", "Close", "", 0 );
EntFire( "@bunker.rollup2", "Open", "", 0 );

EntFire( "@timer.blinkseq1", "Disable", "", 0 );

EntFire( "@areaportal_finale_front", "Open", "", 0 );	// open areaportal

EntFire( "@bunker.rollupdoor.blocker", "Enable", "", 0 );	// enable blocker on rear door
}

function TrucksFoundVO()
{
	//	local msg = "CMDR - end of the line. theres the trucks..";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(106)", 2 );
}

function PlayersInFinaleRoom( amount )		// both players have entered
{

	if ( amount == PLAYER_COUNT)
	{
	FinaleStart();
	EntFire( "@trigger_finale_playercount", "Disable", "", 0 );
	}
}

function FinaleCloseRollupDoor()	// trigger onendtouchall @trigger_finale_reinf_emptydoor
{
debugPrint("Closing rollup door");

EntFire( "@bunker.rollup2", "Close", "", 0 );
EntFire( "@bunker.rollupdoor2.blocker", "Enable", "", 0 );		// clip brush

EntFire( "@timer.breachsound", "Disable", "", 0 );		// disable breach sound timer

EntFire( "@areaportal_finale_rear", "Close", "", 5 );	// close areaportal once door is closed

EntFire( "@trigger_finale_reinf_emptydoor", "Disable", "", 0 );
}

function FinaleStart()		// final fight
{

EntFire( "@trigger_cam_rollupgate_toggle", "Disable", "", 0 );

EntFire( "@snd.alarm_finale", "PlaySound", "", 0 );
EntFire( "@bunker.rollup2", "Close", "", 0 );

	//	local msg = "CMDR - uh oh, thats not good..";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(107)", 2 );

EntFire( "@areaportal_finale_rear", "Close", "", 5 );	// close areaportal once door is closed

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 6 );

EntFire( "@finale.generator_room_door", "Unlock", "", 6 );
EntFire( "@finale.generator_room_door", "Open", "", 6.5 );
}

function SpawnControlroomMonitor()
{
	EntFire( "@finale.catwalk.door", "Close", "", 0 );
	EntFire( "@finale.catwalk.door", "Lock", "", 1 );

	EntFire( "@entmaker_monitor_small", "ForceSpawnAtEntityOrigin", "@monitor_controlroom_sm_01", 0 );
	EntFire( "@entmaker_monitor_small", "ForceSpawnAtEntityOrigin", "@monitor_controlroom_sm_02", 0 );
	
	//CameraSetCam( "@camera_finale_blastdoor" );
	EntFire( "@coopscript", "RunScriptCode", "SetCamBlastDoor()", 1 );
	
	EntFire( "@camera_finale_blastdoor", "SetOnAndTurnOthersOff", "", 2 );
	EntFire( "@camera_finale_blastdoor", "SetOff", "", 3 );

}

function SetCamBlastDoor()
{
CameraSetCam( "@camera_finale_blastdoor" );
}

function FinaleCoopButtonUsed()		// triggered with 1 second delay from map
{
EntFire( "@finale.snd.rollup_warning", "PlaySound", "", 0 );
//EntFire( "@trigger_cam_rollupfinale_toggle", "Enable", "", 0 );


CameraSetCam( "@camera_finale_msg_lockdown" );		// display lockdown screen

EntFire( "@coopscript", "RunScriptCode", "FinaleBreachVO()", 1 );

EntFire( "@coopscript", "RunScriptCode", "FinaleRollupGuys()", 7 );		// spawn dudes

EntFire( "@finale.catwalk.door", "Unlock", "", 1 );
EntFire( "@finale.catwalk.door", "SetGlowEnabled", "", 1.25 );
}

function FinaleBreachVO()
{
	//	local msg = "CMDR - we will have to breach. did you bring any thermite charges with you?";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(110)", 2 );
}

function FinaleRollupGuys()
{

EntFire( "@clip_finale_fence", "Disable", "", 0 );

EntFire( "@trigger_finale_reinf_emptydoor", "Enable", "", 0 );

EntFire( "@finale.snd.rollup_warning", "PlaySound", "", 0 );
EntFire( "@finale.snd.rollup_warning", "PlaySound", "", 1 );

//CameraSetCam( "@camera_finale_rollup" );		// show door

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 4 )", 0 );

EntFire( "@bunker.rollupdoor2.blocker", "Disable", "", 0.5 );
EntFire( "@bunker.rollup2", "Open", "", 0.5 );
EntFire( "@areaportal_finale_rear", "Open", "", 0.5 );

EntFire( "@coopscript", "RunScriptCode", "FinaleGetOutVO()", 8 );	// get out line

//EntFire( "@timer.steam_exitpipe", "Enable", "", 5 );	// exitpipe steam hint		note: moved to onwavefinished instead
//EntFire( "@arrowsign.relay", "Trigger", "", 30 );	// let them bumble around for 30 sec, disabled if players get up before time

EntFire( "@trigger_exit_elev_counter", "Enable", "", 0 );	// player count trigger on elevator
EntFire( "@trigger_finale_found_elevator", "Enable", "", 0 );

EntFire ( "@skybox.station","Disable", "", 0 );		// disable skybox prop

}

function FinaleRollupCamToggle( bool )	// triggered from @trigger_cam_rollupfinale_toggle
{
	if (bool == 1)
	{
	debugPrint("rollup cam active");
	EntFire( "@camera_finale_rollup", "SetOn", "", 0 );
	}
	else
		{
		debugPrint("rollup cam inactive");
		EntFire( "@camera_finale_rollup", "SetOff", "", 0 );
		}
}

function FinaleGetDoorOpenVO()
{
	//	local msg = "CMDR - lets get that door opened";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(108)", 2 );
}

function FinaleGetOutVO()
{
	//	local msg = "CMDR - nevermind, get out of there and back to the truck, we need to rethink this";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(111)", 2 );
}


function FinaleFoundElevatorVO()		// triggered by @trigger_finale_found_elevator
{
	//	local msg = "CMDR - excellent! cross your fingers it leads to an exit";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(112)", 1 );
		
		EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 1 )", 0 );
}

function FinaleFingersCrossedVO()
{
	//	local msg = "CMDR - keep those fingers crossed";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(113)", 1 );
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

function TheEnd()		// reached surface and exited building
{

//EntFire( "@coopscript", "RunScriptCode", "ReachedSurfaceVO1()", 0 );
//EntFire( "@coopscript", "RunScriptCode", "ReachedSurfaceVO2()", 8 );
//EntFire( "@coopscript", "RunScriptCode", "ReachedSurfaceVO3()", 16 );
//EntFire( "@coopscript", "RunScriptCode", "ReachedSurfaceVO4()", 24 );

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(116)", 1 );

EntFire ( "@slowfade_end_hold", "Fade", "", 8 );	// 10 sec
EntFire( "@coopscript", "RunScriptCode", "LevelEnd()", 18 );

}

function ReachedSurfaceVO1()
{
		local msg = "CMDR - oh my god we could have saved so much time!";
		TempRadioMessage(msg, 0);
}

function ReachedSurfaceVO2()
{
		local msg = "CMDR - wait here while i get the truck to your position.";
		TempRadioMessage(msg, 0);
}

function ReachedSurfaceVO3()
{
		local msg = "CMDR - once you're back, we'll find a way to crack that door.";
		TempRadioMessage(msg, 0);
}

function ReachedSurfaceVO4()
{
		local msg = "CMDR - if youll excuse me, i have some urgent feedback to the reconnaissance team";
		TempRadioMessage(msg, 0);
}

function LevelEnd()		// game over
{	
	//EntFire ( "@screenfade_hold", "Fade", "", 3 );
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
	EntFire( "enemy.wave01", "SetEnabled", "", 0 );
	EntFire( "CT_*", "SetDisabled", "", 0 );
	EntFire( "CT_0", "SetEnabled", "", 0 );
}


function OnWaveCompleted()
{	


	if ( wave == 1)
	{
		debugPrint ("Wave 1 defeated, tractor shack");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave02", "SetEnabled", "", 0 );
		
		EntFire( "@house1-door", "Unlock", "", 1 );
		EntFire( "@house1-door", "SetGlowEnabled", "", 1 );
		
		EntFire( "@trigger_field_spawn", "Enable", "", 0 );
		
		EntFire( "@clip.tractor_bridge", "Disable", "", 0 );		// boost clipping, re-enabled on map reset
		
	//	local msg = "CMDR - so much for the quiet approach. move quickly on the farm";
	//	TempRadioMessage(msg, 1);
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(7)", 1 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_2", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
	}
	else if ( wave == 2)
	{
		debugPrint ("Wave 2 defeated, field");
	
		EntFire( "@barn1-door", "Unlock", "", 1 );
		EntFire( "@barn1-door", "SetGlowEnabled", "", 1 );
		
		EntFire( "@trigger_courtyard_spawn", "Enable", "", 1 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave03", "SetEnabled", "", 0 );
		
	//	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(4)", 1 );	// Felix - You don't put this many guards around something that doesn't need defending.  The way in has to be around here somewhere.
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_3", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 3)
	{
		debugPrint ("Wave 3 defeated, courtyard");
	
		EntFire( "@house2-door", "Unlock", "", 1 );
		EntFire( "@house2-door", "SetGlowEnabled", "", 1 );
		
		EntFire( "@trigger_sidepath_spawn", "Enable", "", 1 );
		
//		EntFire( "@trigger_elevatordoor_vo", "Enable", "", 1 );
		
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave04", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_4", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 4)
	{
		debugPrint ("Wave 4 defeated, sidepath");
	
		EntFire( "@house3-door", "Unlock", "", 1 );
		EntFire( "@house3-door", "SetGlowEnabled", "", 1 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave05", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_5", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 5)
	{
		debugPrint ("Wave 5 defeated, farmhouse courtyard");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave06", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_6", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "FarmHouseInnerDoorOpen()", 2 );	// open up barn, spawn next guys
	}
	else if ( wave == 6)
	{
		debugPrint ("Wave 6 defeated, barn guys");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave07", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		// enable generator sequence buttons
	}
	else if ( wave == 7)
	{
		debugPrint ("Wave 7 defeated, backtrack guys");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave08", "SetEnabled", "", 0 );
		
		EntFire( "@house2-door", "Unlock", "", 1 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_7", "SetEnabled", "", 0 );
		
		BacktrackInstruction();
		
		EntFire( "@trigger_elevator_up", "Enable", "", 0 );
		
	}
	else if ( wave == 8)
	{
		debugPrint ("Wave 8 defeated, elevator top guys");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave09", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_8", "SetEnabled", "", 0 );
		
		EntFire( "@coopbutton_elevator_enable", "Trigger", "", 1 );
		EntFire( "button.mover", "Close", "", 1 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		
	}
	else if ( wave == 9)
	{
		debugPrint ("Wave 9 defeated, elevator arrival");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave09b", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_9", "SetEnabled", "", 0 );
		
		EntFire( "@coopbutton_gatecontrol_enable", "Trigger", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 10)
	{
		debugPrint ("Wave 9b defeated, fakewall attack");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave10", "SetEnabled", "", 0 );
		
		EntFire( "@trigger_tunnelattack_spawn", "Enable", "", 0 );
		
	}
	else if ( wave == 11)
	{
		debugPrint ("Wave 10 defeated, tunnel attack");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave11", "SetEnabled", "", 0 );
		
		EntFire( "@tunnel.gate_button", "Trigger", "", 0 );
		
	}
	else if ( wave == 12)
	{
		debugPrint ("Wave 11 defeated, bunker exterior");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave12", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_10", "SetEnabled", "", 0 );
		
		EntFire( "@trigger_interior_spawn", "Enable", "", 0 );
		
		EntFire( "@door_bunker_entrance", "Unlock", "", 1 );
		EntFire( "@door_bunker_entrance", "SetGlowEnabled", "", 1 );
		
		//EntFire( "@teleport_rollupdoor1", "Disable", "", 0 );	
		
	}
	else if ( wave == 13)
	{
		debugPrint ("Wave 12 defeated, bunker interior");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave13", "SetEnabled", "", 0 );
		
		EntFire( "@coopbutton_interior_enable", "Trigger", "", 1 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 14)
	{
		debugPrint ("Wave 13 defeated, bunker interior");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave14", "SetEnabled", "", 0 );
		
		EntFire( "@door_bunker_catwalk", "Unlock", "", 1 );
		EntFire( "@door_bunker_catwalk", "SetGlowEnabled", "", 1 );
		
		EntFire( "@trigger_catwalk_entered", "Enable", "", 0 );
	}
	else if ( wave == 15)
	{
		debugPrint ("Wave 14 defeated, bunker rollup reinf");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave15*", "SetEnabled", "", 0 );	//wildcard
		
		EntFire( "@coopbutton_rollup_enable", "Trigger", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 16)
	{
		debugPrint ("Wave 15 defeated, finale #1");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave16*", "SetEnabled", "", 0 );		//wildcard
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_11", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 8 )", 3 );
		EntFire( "@bunker.rollup2", "Open", "", 3.25 );	
		EntFire( "@bunker.rollupdoor2.blocker", "Disable", "", 3.25 );
		
		EntFire( "@finale.left_room_door", "Unlock", "", 4 );	
		EntFire( "@finale.left_room_door", "Open", "", 4.5 );	
		
		EntFire( "@areaportal_finale_rear", "Open", "", 3.25 );	// open areaportal once door is closed
		
		EntFire( "@trigger_finale_reinf_emptydoor", "Enable", "", 3 );	// triggers door close when room is empty of bots and players
	
	
	}
	else if ( wave == 17)
	{
		debugPrint ("Wave 16 defeated, finale #2");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave17*", "SetEnabled", "", 0 );		//wildcard
		
		EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 3 );
		
		EntFire( "@finale.controlroom.doors", "Unlock", "", 3 );
		EntFire( "@finale.controlroom.doors", "Open", "", 3.25 );
		
		EntFire( "@trigger_finale_controlroom_spawnmonitors", "Enable", "", 0 );	// enable monitor spawn trigger
		
		EntFire( "@clip_finale_catwalk", "Disable", "", 3 );	// disable clipbrush on catwalk and windows
	
	}
	else if ( wave == 18)
	{
		debugPrint ("Wave 17 defeated, finale #3");
		
		EntFire( "@coopbutton_finale_enable", "Trigger", "", 1 );	// enable button in controlroom
		
		FinaleGetDoorOpenVO();
		
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave18", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );

	}
	else if ( wave == 19)
	{
		debugPrint ("Wave 18 defeated, rollup guys");
		
		//EntFire( "@timer.steam_exitpipe", "Enable", "", 5 );	// exitpipe steam hint		
		EntFire( "@flashlight.timer", "Enable", "", 5 );	// exitpipe flashlight hint		
		EntFire( "@arrowsign.relay", "Trigger", "", 30 );	// let them bumble around for 30 sec, disabled if players get up before time
		
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave19", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );

	}
	else if ( wave == 20)
	{
		debugPrint ("Wave 19 defeated, exit elevator guys");
		
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave20", "SetEnabled", "", 0 );
		
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
	
		if (MISSION == 2)
		{
			EntFire( "@coopscript", "RunScriptCode", "CoopGiveC4sToCTs()", 0.1 );
		}
	}
}