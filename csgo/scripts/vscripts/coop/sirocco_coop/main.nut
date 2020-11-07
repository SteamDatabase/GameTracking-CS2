
wave <- 0;
PLAYER_COUNT <- 2;			// overridden by debugmode
PLAYERS_ALIVE <- 0;			// how many players are currently alive 

MISSION <- ScriptCoopMissionGetMissionNumber();

HARD_MODE <- false;

DEBUG <- false;

RESPAWN_ACTIVE <- false;
LASTSPAWN <- 0;
NEXTSPAWN <- 0;

EXTRACTION_COUNT <- 0;			// how many players are in extraction trigger 
EXTRACTION_SUCCESS <- false;	// bool to make sure end script only plays once

MAX_C4 <- 2;
C4_REMAINING <- MAX_C4;
STORAGE_SQUAD_DEAD <- false;
STORAGE_EXIT_TRIGGERED <- false;

PlantedC4DetectorActive <- false;

PlayerInteractedWithFireValve <- false;

SND_DEPLOY_BOAT <- "coop_deploy.boat";
SND_VO_TEXT <- "Survival.BonusAward";
SND_MISSILE_LAUNCH <- "weapons/smokegrenade/sg_explode_distant.wav";
SND_COUNTDOWN_BEEP <- "UI.CounterBeep";
SND_C4_WARNING <- "C4.ExplodeWarning";
SND_C4_EXPLODE <- "c4.explode";
SND_DEBRIS_1 <- "physics/metal/metal_large_debris1.wav";
SND_DEBRIS_2 <- "physics/metal/metal_large_debris2.wav";
SND_ELEVATORDOOR_1 <- "doors/sugarcane_lift_gate_close_01.wav";
SND_ELEVATORDOOR_2 <- "doors/sugarcane_lift_gate_open_01.wav";
SND_AIRLOCK_DONE <- "buttons/bell1.wav";
SND_METAL_RATTLE_1 <- "ambient/materials/metal_stress4.wav";
SND_METAL_RATTLE_2 <- "ambient/materials/metal_stress5.wav";
SND_DOOR_FRANZ_SQUEAK <- "doors/door_squeek1.wav";




function Precache()
{
	self.PrecacheScriptSound( SND_DEPLOY_BOAT );
	self.PrecacheScriptSound( SND_VO_TEXT );
	self.PrecacheScriptSound( SND_MISSILE_LAUNCH );
	self.PrecacheScriptSound( SND_COUNTDOWN_BEEP );
	
	self.PrecacheScriptSound( SND_C4_WARNING );
	self.PrecacheScriptSound( SND_C4_EXPLODE );
	
	self.PrecacheScriptSound( SND_DEBRIS_1 );
	self.PrecacheScriptSound( SND_DEBRIS_2 );
	
	self.PrecacheScriptSound( SND_ELEVATORDOOR_1 );
	self.PrecacheScriptSound( SND_ELEVATORDOOR_2 );
	
	self.PrecacheScriptSound( SND_AIRLOCK_DONE );
	
	self.PrecacheScriptSound( SND_METAL_RATTLE_1 );
	self.PrecacheScriptSound( SND_METAL_RATTLE_2 );
	
	self.PrecacheScriptSound( SND_DOOR_FRANZ_SQUEAK );
	
	self.PrecacheModel ("models/props_survival/dronegun/dronegun.mdl");			// DZ turret isnt precached outside of DZ
	self.PrecacheModel ("models/props_survival/dronegun/dronegun_gib1.mdl");
	self.PrecacheModel ("models/props_survival/dronegun/dronegun_gib2.mdl");
	self.PrecacheModel ("models/props_survival/dronegun/dronegun_gib3.mdl");
	self.PrecacheModel ("models/props_survival/dronegun/dronegun_gib4.mdl");
	self.PrecacheModel ("models/props_survival/dronegun/dronegun_gib5.mdl");
	self.PrecacheModel ("models/props_survival/dronegun/dronegun_gib6.mdl");
	self.PrecacheModel ("models/props_survival/dronegun/dronegun_gib7.mdl");
	self.PrecacheModel ("models/props_survival/dronegun/dronegun_gib8.mdl");

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
	
	EXTRACTION_SUCCESS = false;
	
	HARD_MODE = false;
	
	RESPAWN_ACTIVE = false;
	
	C4_REMAINING = MAX_C4;

	SendToConsoleServer( "mp_coopmission_bot_difficulty_offset 2" );
	SendToConsoleServer( "bot_coop_idle_max_vision_distance 3000" );
	ScriptCoopSetBotQuotaAndRefreshSpawns( 0 );
	
	EntFire( "@cellblock_entdoor_state-toggle", "Trigger", "", 0 );		// toggle initial state of door indicator
	EntFire( "@skybox_island", "Enable", "", 0 );		// show skybox island visible from readyroom
	
	EnemyWaveSpawnsStop();		// stop wavespawning if previous attempt wiped on holdout
	
}

function HardModeToggle ( bool )
{

	HARD_MODE = bool;

	debugPrint ("Hard mode is currently: " + HARD_MODE);

}

function HardModeVO()		// play this line when player discovers hard mode button
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(9016)", 0 );
}

function OnPlayerDie()
{
	
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9001,9002,9003,9004,9005,0) )", 0 );
	
	if (MISSION == 2)
	{
		EntFire( "@coopscript", "RunScriptCode", "CoopGiveC4sToCTs()", 0.1 );
	}

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


function CoopThink()
{
	local CurrentTime = Time();

	RespawnPlayerLoop();		// try respawning dead players, if allowed
	
	ExtractionTriggerCheck();	// looping check for extraction trigger
	
	ExtractionM2TriggerCheck();
	
	FindAndDeleteC4();				// mission 2, delete planted C4s
	
	FranzCountDown();				// mission 2, timer for franz boat
	
	StorageExitOpen();

}


function DebugMode()
{
	DEBUG = true;
	PLAYER_COUNT = 1;
	EntFire( "@coopbutton_debugenable", "Trigger", "", 0 );
	debugPrint("Mission number is: " + MISSION);
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
	
	SendToConsoleServer( "mp_anyone_can_pickup_c4 1" );
	SendToConsoleServer( "mp_death_drop_c4 0" );
	SendToConsoleServer( "mp_c4_cannot_be_defused 1" );
	SendToConsoleServer( "mp_c4timer 9999" );

}


function TestFunction()		// this function is triggered by relay.test, use for testing random stuff
{
			
//EntFire( "@startelevator_reset", "Trigger", "", 1 );	// reset entrance elevator
//FranzBoatExplode();

//FindAndDeleteC4();

EntFire( "missile1-*", "Kill", "", 0 );
EntFire( "missile1b-*", "Kill", "", 0 );
EntFire( "missile2-*", "Kill", "", 0 );
EntFire( "missile3-*", "Kill", "", 0 );
EntFire( "missile4-*", "Kill", "", 0 );
EntFire( "missile6-*", "Kill", "", 0 );
EntFire( "missile7-*", "Kill", "", 0 );
printl ("Deleting missiles");

}

function RemoveMissiles()	// missile setups are expensive, freeing up some space
{
EntFire( "missile1-*", "Kill", "", 0 );
EntFire( "missile1b-*", "Kill", "", 0 );
EntFire( "missile2-*", "Kill", "", 0 );
EntFire( "missile3-*", "Kill", "", 0 );
EntFire( "missile4-*", "Kill", "", 0 );
EntFire( "missile6-*", "Kill", "", 0 );
EntFire( "missile7-*", "Kill", "", 0 );
}

function FinaleDebugTest()
{
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave18", "SetEnabled", "", 0 );
		
		ClearZones();
		
		FranzFinaleWaveSpawn();			// starts spawning guys on beach after 5 sec
		
		
}


function FindAndDeleteC4()
{

	if (PlantedC4DetectorActive == true)
	{
		local bomb = null;

		while((bomb = Entities.FindByClassname(bomb,"planted_c4")) != null)
		{
			debugPrint ("Found a planted C4");
			bomb.Destroy();
		}
	}
}

function FindPlayerMovementTriggers( state )
{

		local trigger = null;

		while((trigger = Entities.FindByClassname(trigger,"trigger_playermovement")) != null)
		{
			
			
			if (state == 0)
			{
			debugPrint ("Disabling a player movement trigger");
			EntFireByHandle( trigger, "Disable", "", 0, self, self );
			}
				if (state == 1)
				{
				debugPrint ("Enabling a player movement trigger");
				EntFireByHandle( trigger, "Enable", "", 0, self, self );
				}
		}

}

CountDownPaused <- false;	// if the timer is paused
CountDownActive <- false;	// if the timer is enabled
CountDownResume <- 0;		// when the timer should resume, current time + 2 seconds when set
CountDownTotalTicks <- 300;	// total ticks to count down (think function runs 10 times per second)

function FranzCountDown()
{

	if (CountDownActive == true && CountDownPaused == false)
	{
	
		debugPrint ("Counting down");
		CountDownTotalTicks--;
		debugPrint (CountDownTotalTicks);
		
		if (CountDownTotalTicks == 280)
		{
		EntFire( "enginesound.start", "Trigger", "", 0 );
		}
		else if (CountDownTotalTicks == 200)
			{
			FranzBoatHint();
			}
			else if (CountDownTotalTicks == 150)
				{
				EntFire( "enginesound.revloop", "Trigger", "", 0 );
				}
				else if (CountDownTotalTicks == 100)
					{
					FranzBoatFinalHint();
					}
					else if (CountDownTotalTicks == 0)
						{
						CountDownActive = false;
						debugPrint ("Mission failed!")
						FranzBoatEscape();
						}
		
	
	}
	else if (CountDownActive == true && CountDownPaused == true)
		{
		debugPrint ("Paused, resumes at: " + CountDownResume)
		
			if (Time() >= CountDownResume)
			{
			CountDownPaused = false;
			}
		}

}

function FranzCountDownStart()
{
debugPrint ("Starting Franz countdown timer");
CountDownActive = true;
}

function FranzCountDownPause()
{
	if (CountDownPaused == false)
	{
	CountDownResume = Time() + 2;
	CountDownPaused = true;
	debugPrint ("Pausing countdown!");
	}
	else
		{
		debugPrint ("Countdown is already paused, not doing anything..");
		}
}

function ClearZones()
{
ScriptMissionResetDangerZones();
debugPrint("CLEARING ZONES");
}


function HightlightLoot()
{

EntFire( "@coopscript", "RunScriptCode", "ToggleEntityOutlineHighlights(" + true + ")", 0 );

}

function ToggleEntityOutlineHighlights( bool )
{

ScriptCoopToggleEntityOutlineHighlights ( bool );

}

function PlayersInCellblockTrigger( amount )
{
	local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if ( amount == PLAYER_COUNT && IsWarmupPeriod == false )
	{
	CellBlockAmbushStart();
	}
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



function ReadyRoomStart()		// triggered on map spawn, plays when both players are in ready room
{
local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if (IsWarmupPeriod == false && MISSION != 2)
	{
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(1)", 3 );	// Felix - Hello Sunshine, I know you've missed me but we don't have time to catch up. bla bla briefing
		EntFire( "@missionbrief_01", "Enable", "", 0 );		// briefing card on whiteboard
		
	}
	
		if (IsWarmupPeriod == false && MISSION == 2)
		{
		local TeleportTrigger = Entities.FindByName(null, "teleport.deploy");

		debugPrint ("Changing deploy teleport destination");
		debugPrint (TeleportTrigger);

		TeleportTrigger.__KeyValueFromString ("target", "teleport.deploy_destination_m2");
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(100)", 3 );	// Felix - Briefing 41 sec
		
		EntFire( "@missionbrief_02", "Enable", "", 0 );		// briefing card on whiteboard
		
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave01", "SetEnabled", "", 0 );			// gotta make sure the m2 spawns are active
		
		CreateM2Zones();		// create DZ circles in outdoor area
		
		SendToConsoleServer( "mp_coopmission_bot_difficulty_offset 3" );
		
		}
	
	EntFire( "@pfx_readyroom", "Start", "", 0 );

}



function MissionStart()
{

	if (HARD_MODE == true)		// hard mode settings
	{
	HardMode();
	}
	
	EntFire( "@pfx_readyroom", "Stop", "", 1 );		// stop readyroom particle fx

	self.EmitSound( SND_DEPLOY_BOAT );

	EntFire( "@skybox_island", "Disable", "", 1 );		// hide skybox island visible from readyroom

	EntFire( "deploytrigger.trigger", "Disable", "", 0 );	// disable deploy zone trigger so you can't trigger it multiple times
	EntFire( "counter.mission_deploy", "Disable", "", 0 );	// disable deploy zone counter
	
	EntFire ( "@screenfade", "Fade", "", 0 );
	EntFire ( "@screenfade", "FadeReverse", "", 1.5 );
	EntFire( "teleport.deploy", "Enable", "", 1.1 );

	
	
	
	if (MISSION != 2)
	{
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_2", "SetEnabled", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(2)", 5 );	// Felix - My source says the samples are being held in the tunnels beneath the kasbah.  Get in there, take a sample, and get out before anyone knows we were here.
		
		SpawnFirstEnemies(4);
		
		EntFire( "mission1_weaponpickups_templ", "ForceSpawn", "", 0 );		// spawn weapon pickups for mission 1
		
	}
		
	if (MISSION == 2)
	{
	
		EntFire( "droneguns", "spawn", "", 0 );
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_2_M2", "SetEnabled", "", 0 );
		
		EntFire( "lightpole.spark1", "StartSpark", "", 0 );		// sparks from tower
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(101)", 5 );	// Felix - Stay close 12 sec 
		
		EntFire( "@coopscript", "RunScriptCode", "CoopGiveC4sToCTs()", 2 );		// give out C4
		
		EntFire( "airlock1-door", "Open", "", 0 );		// open outer airlock door
		EntFire( "pfx.airlock_centersmoke", "Start", "", 0 );		// Center smoke fx for airlock
		EntFire( "lightpole.timer", "Enable", "", 0 );		// light tower next to spawn blinking
		EntFire( "@templ_ashrain", "ForceSpawn", "", 0 );		// ash rain in beginning area
	
		EntFire( "@m2_coin_jail_spawn", "ForceSpawn", "", 0 );		// spawn coin in jailcell cubby
		
		SpawnFirstEnemies(2);
		
		EntFire( "block1-celldoor1", "Open", "", 3 );		// open celldoors
		EntFire( "block2-celldoor1", "Open", "", 3 );
		EntFire( "block3-celldoor1", "Open", "", 3 );
		EntFire( "block4-celldoor1", "Open", "", 3 );
		EntFire( "block5-celldoor1", "Open", "", 3 );
		
		EntFire( "heathaze", "turnon", "", 0 );		// heat haze from vents
		
		EntFire( "@coopscript", "RunScriptCode", "RemoveMissiles()", 0 );		// clean up missiles 
		
		
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// MISSION 1 - VIRUS OUTBREAK ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

function BeachCleared()		// when player presses button on beach, after clearing first wave
{

	EntFire( "gate_spark01", "SparkOnce", "", 1 );
	EntFire( "gate_spark01.snd", "PlaySound", "", 1 );
	EntFire( "gate_spark02", "SparkOnce", "", 1.5 );
	EntFire( "gate_spark02.snd", "PlaySound", "", 1.5 );
	EntFire( "gate_spark02", "SparkOnce", "", 2 );
	EntFire( "gate_spark02.snd", "PlaySound", "", 2 );
	EntFire( "@gate_stairs_open", "Trigger", "", 2 );

}

function DroneFlyBy()
{
	EntFire( "drone1-start", "Trigger", "", 0 );
	EntFire( "drone2-start", "Trigger", "", 0.2 );
	EntFire( "drone3-start", "Trigger", "", 0.3 );
	
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 8 )", 1 );
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(3)", 0 );	// Felix - Alright, there's the kasbah.  Secure the area and find a way into the underground tunnels.
}

function KasbahFenceGateOpen()	// when player opens gate to inner kasbah
{

	EntFire( "@relay.kasbah_fence_open", "Trigger", "", 1 );
	EntFire( "@trigger_innerkasbah_spawn", "Enable", "", 1 );		// triggers KasbahInnerEntered() when entered
	
}

function KasbahInnerEntered()	// when player enters kasbah
{

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 4 )", 1 );
	
}

function FoundTunnelsVO()
{

	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(5)", 0 );	// Felix - There's the entrance!  We don't know what sort of opposition is down there, so stay alert.

}

function CheckpointGuardSpawn()	// when player enters underground tunnels
{

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );

	EntFire( "@pfx_underground", "Start", "", 0 );
	
}

function CellBlockAmbushStart()		// triggered when players are in cellblock
{

EntFire( "@cellblock_doors_first", "Close", "", 0 );
EntFire( "@cellblock_doors_first", "Lock", "", 0.5 );
EntFire( "@cellblock_entdoor_state-toggle", "Trigger", "", 0 );

ToggleEntityOutlineHighlights( false );

EntFire( "@cellblock_playertrigger", "Disable", "", 0 );



EntFire ( "@franz","RunScriptCode", "PlayVcd(16)", 1 );	// Franz - Well hello… now this is a fascinating situation. bla bla totally not a baddie

EntFire( "@coopscript", "RunScriptCode", "CellBlockAmbush()", 30 );



}

function CellBlockAmbush()
{

	EntFire( "@relay.cell_lights_off", "Trigger", "", 0 );		// lights are fully off after 1 second
	
	EntFire ( "@franz","RunScriptCode", "PlayVcd(17)", 0.5 );	//Franz - Attention! Whomever brings me the head of these intruders will be granted their freedom.

	EntFire( "block1-relay.open", "Trigger", "", 1 );		// each block takes 1.5 sec to  open
	EntFire( "block2-relay.open", "Trigger", "", 3 );
	EntFire( "block3-relay.open", "Trigger", "", 5 );
	EntFire( "block4-relay.open", "Trigger", "", 7 );
	EntFire( "block5-relay.open", "Trigger", "", 9 );

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 12 )", 10.5 );
	EntFire( "@cellblock_clipbrush", "Disable", "", 10.5 );

	EntFire( "@relay.warning_light.on", "Trigger", "", 11 );
	EntFire( "prisonalarm.snd", "PlaySound", "", 11 );

}


function CellBlockAmbushEnd()		// triggered when players have killed a bunch of dudes
{

EntFire ( "@franz","RunScriptCode", "PlayVcd(18)", 3 );	//Franz - Let's see who the lucky winnner is..

EntFire( "prisonalarm.snd", "FadeOut", "1", 1 );
EntFire( "@relay.warning_light.off", "Trigger", "", 3 );
EntFire( "@relay.cell_lights_on", "Trigger", "", 5 );

EntFire( "@coopscript", "RunScriptCode", "CellBlockReinforcementsCat()", 10 );
}

function CellBlockReinforcementsCat()	// triggered after knife fight
{
EntFire ( "@franz","RunScriptCode", "PlayVcd(19)", 0 );	//Franz - Hm. Impressive.  Your talents are wasted by serving Felix, you have so much more potentional.  If you survive, perhaps I can show you what you're really capable of.

EntFire( "@flash_cellblock", "Trigger", "", 12 );		// flashbang cellblock

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 14 );

EntFire( "@clip_underground_backtrack", "Disable", "", 0 );
}

function CellBlockReinforcements()	// triggered after catwalk guys are dead
{
EntFire( "@cellblock_doors_second", "Unlock", "", 3 );
EntFire( "@cellblock_doors_second", "Open", "", 4 );
EntFire( "@cellblock_exitdoor_state-toggle", "Trigger", "", 2 );
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 3 );
}

function MedicalAreaOpened()		// triggered when players have unlocked medical area with coop buttons
{

EntFire( "@meddoor_state-toggle", "Trigger", "", 0 );
EntFire( "@macguffin_enable", "Trigger", "", 0 );

EntFire( "@cellblock_doors_second", "Close", "", 0 );
EntFire( "@cellblock_doors_second", "Lock", "", 0 );

EntFire( "@clip_underground_backtrack", "Enable", "", 0 );

EntFire( "@prop_viruscase", "SetGlowEnabled", "", 1 );

ToggleEntityOutlineHighlights( false );
}

function MacGuffinFound()	// when player has found mcguffin, start breach charge ambush
{

	EntFire ( "@franz","RunScriptCode", "PlayVcd(20)", 1 );	//Franz - And so you've found what you were looking for.  But consider this: Why do you think Felix knows so much about this place?  Perhaps you don't have the whole story.  Perhaps I am not the demon he is making me out to be.  

	EntFire( "@coopscript", "RunScriptCode", "MedicalAreaBreach()", 19 );
	
}

function MedicalAreaBreach()
{
	EntFire( "@chainlinkdoor_postbreach", "Unlock", "", 0 );
	EntFire( "@chainlinkdoor_postbreach", "Open", "", 1 );
	
	EntFire( "@snd.prebreach_ready", "PlaySound", "", 2.5 );		// "In position" VO 
	
	EntFire( "breach1-relay.breach", "Trigger", "", 5 );
	EntFire( "@pfx_underground_breach1", "Start", "", 11 );
	
	EntFire( "breach2-relay.breach", "Trigger", "", 6 );		// these take 6 seconds to go off
	EntFire( "@pfx_underground_breach1", "Start", "", 12 );
	
	EntFire( "@breachwalls_clip", "Disable", "", 12 );
	
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 11.5 );		// 1 heavy
}

function PlayersExitTunnels()	// when player exits tunnels
{
	
	EntFire( "drone4-start", "Trigger", "", 0 );
	EntFire( "drone5-start", "Trigger", "", 0.15 );

	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(8)", 3 );	//Felix - Glad you made it out of there in one piece! We have a helicopter standing by for extraction, get down to the coast and secure a landing zone!

	EntFire( "@trigger_falldamage", "Enable", "", 0 );
	EntFire( "@pfx_underground", "Stop", "", 8 );
	
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0 );
	
}

function RadarCleared()	// when player has cleared radar station exterior
{
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(9)", 1 );	//Felix - There's a helipad nearby, secure it and we'll get you out of there!
	
	EntFire( "@helipad_lights", "Trigger", "", 0 );
	EntFire( "@relay_radar_blinkydo", "Trigger", "", 0 );		// buncha repeating timers
	
	EntFire( "@pfx_radarconn", "Start", "", 0 );
	
	EntFire( "@radar_frontdoor", "SetGlowEnabled", "", 1 );
	EntFire( "@radar_frontdoor", "Unlock", "", 1.5 );
	
}

function RadarTunnelsEntered()	// when player has entered radio station stairs
{

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 4 )", 1 );
	EntFire( "@trigger_falldamage", "Disable", "", 1 );
	EntFire( "@chainlinkdoor_radarconn", "Unlock", "", 1 );
	
}

function EnemyWaveSpawns()		// helipad fight
{

	EntFire( "@pfx_radarconn", "Stop", "", 0 );		// stop particle fx for connector

	SendToConsoleServer( "mp_randomspawn_los 1" );
	SendToConsoleServer( "mp_randomspawn_dist 2400" );
	SendToConsoleServer( "mp_use_respawn_waves 1" );
	SendToConsoleServer( "mp_respawnwavetime_t 4" ); 
	
	EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( false )", 1 );		// players should not respawn
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(10)", 1 );	//Felix - Great work! The helicopter has been dispatched, ETA one minute.

	
	EntFire ( "@franz","RunScriptCode", "PlayVcd(23)", 10 );	//Franz - Attention! Stop these intruders, or find yourself in the next round of experiments.
	
	EntFire( "@snd.finale_music", "PlaySound", "", 16 );		// music

	EntFire( "@coopscript", "RunScriptCode", "CoopSetBotQuotaAndRefreshSpawns( 4 )", 0.5 );
	EntFire( "@coopscript", "RunScriptCode", "CoopMissionSetNextRespawnIn( 6 )", 14 );
	
	EntFire( "@coopscript", "RunScriptCode", "HelipadMissileAttack()", 60 );

	EntFire( "@coopscript", "RunScriptCode", "EnemyWaveSpawnsStop()", 65 );		// stop wave respawning as helicopter flies in

	wave++;  // up the wave number manually

}

function FinaleShortcut()		// shortcut to finale fight
{

// setpos 6674.558105 5778.740723 480.093811;setang 3.717988 -76.385696 0.000000

	SendToConsole( "setpos 6674.558105 5778.740723 480.093811;setang 3.717988 -76.385696 0.000000" );

	wave = 11;

		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave06", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_10", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		EntFire( "@coopscript", "RunScriptCode", "HelipadExitOpen()", 1 );

}

function HelipadMissileAttack()
{
	EntFire( "@trigger_mollybox", "Disable", "", 0 );

	EntFire ( "@franz","RunScriptCode", "PlayVcd(24)", 0 );	//Franz - Maybe I’m not motivating you properly. This should help.

	EntFire( "@coopscript", "RunScriptCode", "MissileLaunchSound(" + 1 + ")", 3 );		// play launch sound
	EntFire( "missile1b-launch", "Trigger", "", 10 );
	EntFire( "@coopscript", "RunScriptCode", "MissileImpact(5)", 13 );		// spawn DZ zone on impact

	EntFire( "@coopscript", "RunScriptCode", "MissileLaunchSound(" + 1 + ")", 5 );		// play launch sound
	EntFire( "missile1-launch", "Trigger", "", 12 );
	EntFire( "@coopscript", "RunScriptCode", "MissileImpact(1)", 15 );		// spawn DZ zone on impact


	EntFire( "helicopter3.animated", "Enable", "", 1 );
	EntFire( "helicopter3.animated", "SetAnimation", "coop_flyby1", 1 );
	EntFire( "helisoundsync", "Trigger", "", 1 );
	EntFire( "helicopter3.animated", "Disable", "", 30 );

	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(11)", 11 );	//Felix - Incoming missile!
}

function HelipadExitOpenSimple()
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(12)", 8 );	//Felix - We’re re-routing the helicopter to a new landing zone. Follow the coast and get out of there!

	EntFire( "@rollup_door", "Open", "", 1 );
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 1 );
}

function HelipadExitOpen()		// triggered when helipad fight is over
{

EntFire( "@trigger_mollybox", "Disable", "", 0 );

EntFire ( "@franz","RunScriptCode", "PlayVcd(24)", 0 );	//Franz - Maybe I’m not motivating you properly. This should help.

EntFire( "@coopscript", "RunScriptCode", "MissileLaunchSound(" + 1 + ")", 3 );		// play launch sound
EntFire( "missile1b-launch", "Trigger", "", 10 );
EntFire( "@coopscript", "RunScriptCode", "MissileImpact(5)", 13 );		// spawn DZ zone on impact

EntFire( "@coopscript", "RunScriptCode", "MissileLaunchSound(" + 1 + ")", 5 );		// play launch sound
EntFire( "missile1-launch", "Trigger", "", 12 );
EntFire( "@coopscript", "RunScriptCode", "MissileImpact(1)", 15 );		// spawn DZ zone on impact


EntFire( "helicopter3.animated", "Enable", "", 1 );
EntFire( "helicopter3.animated", "SetAnimation", "coop_flyby1", 1 );
EntFire( "helisoundsync", "Trigger", "", 1 );
EntFire( "helicopter3.animated", "Disable", "", 30 );

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(11)", 11 );	//Felix - Incoming missile!

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(12)", 24 );	//Felix - We’re re-routing the helicopter to a new landing zone. Follow the coast and get out of there!

EntFire( "@rollup_door", "Open", "", 13 );
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 13 );



}


function BeachFinaleEntered()
{

	EntFire( "helicopter3.animated", "Disable", "", 0 );		// disable prev heli
	EntFire( "helicopter2.animated", "Enable", "", 0 );		// hovering helicopter
//	EntFire( "helidust.timer", "Enable", "", 0 );		// hovering helicopter particle effects - triggered via map trigger instead
	EntFire( "@trigger.beach_helipfx_start", "Enable", "", 0 );		// helicopter particle fx trigger

	EntFire( "extractchopper.snd", "PlaySound", "", 0 );		// hovering helicopter sound

	EntFire( "missile2-launch", "Trigger", "", 0 );
	EntFire( "@coopscript", "RunScriptCode", "MissileImpact(2)", 3 );		// spawn DZ zone on impact

	EntFire( "missile6-launch", "Trigger", "", 2 );
	EntFire( "@coopscript", "RunScriptCode", "MissileLaunchSound(" + 6 + ")", 0 );		// play launch sound
	EntFire( "@coopscript", "RunScriptCode", "MissileImpact(6)", 5 );		// spawn DZ zone on impact
	
	EntFire( "trigger.extraction_actual", "Enable", "", 0 );	
	
	EntFire( "@trigger.beach_bunker_spawn", "Enable", "", 0 );		
	EntFire( "@trigger.beach_bunker_spawn_cancel", "Enable", "", 0 );		
	
	EntFire( "@trigger.missile3_launch", "Enable", "", 0 );		
	
	EntFire( "@trigger.beach_hill_spawn", "Enable", "", 0 );	
	EntFire( "@trigger.beach_hill_spawn_cancel", "Enable", "", 0 );	

	EntFire( "@trigger.missile4_launch", "Enable", "", 0 );		

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );	
	
	DZoneBridge();		// create a zona de peligro by the bridge
	DZoneHeliCliff();	// create a kjempefarlig sone by the bridge
	
	EntFire( "@sound_beachbunker_alarm", "PlaySound", "", 2 );
	
}

function DZoneBridge()
{

		local Position = Entities.FindByName(null, "missile_bridge_dummy-end.position");
		local Vector = Position.GetCenter();
			
		debugPrint (Position);
		debugPrint (Vector);

		ScriptMissionCreateAndDetonateDangerZone( Vector, Vector );

}

function DZoneHeliCliff()
{

		local Position = Entities.FindByName(null, "missile_helicliff_dummy-end.position");
		local Vector = Position.GetCenter();
			
		debugPrint (Position);
		debugPrint (Vector);

		ScriptMissionCreateAndDetonateDangerZone( Vector, Vector );

}

function MissileLaunchSound( number )
{

	local name = "missile" + number + "-missile.mdl"
	local emitter = Entities.FindByName(null, name);

	emitter.EmitSound( SND_MISSILE_LAUNCH );

}

function MissileImpact( missile )
{
local Position = null;
local Vector = null;

local StartPosition = null;
local StartVector = null;
local EndPosition = null;
local EndVector = null;

	switch ( missile )
	{
		case 1: 
		{	
			StartPosition = Entities.FindByName(null, "missile1-impact.position");
			StartVector = StartPosition.GetCenter();
			
			EndPosition = Entities.FindByName(null, "missile1-impact.position");
			EndVector = EndPosition.GetCenter();
			
			debugPrint (StartPosition);
			debugPrint (StartVector);
			debugPrint (EndPosition);
			debugPrint (EndVector);
			
			break;
		}
		case 2:
		{
			StartPosition = Entities.FindByName(null, "missile2-impact.position");
			StartVector = StartPosition.GetCenter();
			
			EndPosition = Entities.FindByName(null, "missile2-impact.position");
			EndVector = EndPosition.GetCenter();
			
			debugPrint (StartPosition);
			debugPrint (StartVector);
			debugPrint (EndPosition);
			debugPrint (EndVector);
			
			break;
		}
		case 3:
		{
			StartPosition = Entities.FindByName(null, "missile3-impact.position");
			StartVector = StartPosition.GetCenter();
			
			EndPosition = Entities.FindByName(null, "missile3-end.position");
			EndVector = EndPosition.GetCenter();
			
			debugPrint (StartPosition);
			debugPrint (StartVector);
			debugPrint (EndPosition);
			debugPrint (EndVector);
			
			break;
		}
		case 4:
		{
			StartPosition = Entities.FindByName(null, "missile4-impact.position");
			StartVector = StartPosition.GetCenter();
			
			EndPosition = Entities.FindByName(null, "missile4-end.position");
			EndVector = EndPosition.GetCenter();
			
			debugPrint (StartPosition);
			debugPrint (StartVector);
			debugPrint (EndPosition);
			debugPrint (EndVector);
			
			break;
		}
		case 5:
		{
			StartPosition = Entities.FindByName(null, "missile1b-impact.position");
			StartVector = StartPosition.GetCenter();
			
			EndPosition = Entities.FindByName(null, "missile1b-impact.position");
			EndVector = EndPosition.GetCenter();
			
			debugPrint (StartPosition);
			debugPrint (StartVector);
			debugPrint (EndPosition);
			debugPrint (EndVector);
			
			break;
		}
		case 6:
		{
			StartPosition = Entities.FindByName(null, "missile6-impact.position");
			StartVector = StartPosition.GetCenter();
			
			EndPosition = Entities.FindByName(null, "missile6-impact.position");
			EndVector = EndPosition.GetCenter();
			
			debugPrint (StartPosition);
			debugPrint (StartVector);
			debugPrint (EndPosition);
			debugPrint (EndVector);
			
			break;
		}
		case 7:
		{
			StartPosition = Entities.FindByName(null, "missile7-impact.position");
			StartVector = StartPosition.GetCenter();
			
			EndPosition = Entities.FindByName(null, "missile7-end.position");
			EndVector = EndPosition.GetCenter();
			
			debugPrint (StartPosition);
			debugPrint (StartVector);
			debugPrint (EndPosition);
			debugPrint (EndVector);
			
			break;
		}
	}
	
			debugPrint (StartPosition);
			debugPrint (StartVector);
			debugPrint (EndPosition);
			debugPrint (EndVector);
			
			ScriptMissionCreateAndDetonateDangerZone( StartVector, EndVector );
	
}


function BeachBunkerSpawn()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 1 );

	EntFire ( "@franz","RunScriptCode", "PlayVcd(25)", 2 );	//Franz - Stop them!
}

function BeachHillSpawn()	
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 0 );
}

function VoExtractionNag()		// triggered from map 
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(14)", 0 );	//Felix - Pick it up! You need get out of there, now!
}



function EnemyWaveSpawnsStop()		// called in roundinit as well
{
	SendToConsoleServer( "mp_randomspawn_los 0" );
	SendToConsoleServer( "mp_use_respawn_waves 2" );
	SendToConsoleServer( "mp_respawnwavetime_t 5" );
}


function ExtractionTriggerCount ( count )
{
EXTRACTION_COUNT = count;

debugPrint("Players in extraction trigger: " + EXTRACTION_COUNT)
}

function ExtractionTriggerCheck()
{
	if (EXTRACTION_COUNT == PLAYERS_ALIVE && EXTRACTION_COUNT > 0 && EXTRACTION_SUCCESS == false && MISSION != 2)
	{
	PlayerReachedHelicopter();
	}
}

function PlayerReachedHelicopter()		// game over
{
	EXTRACTION_SUCCESS = true;
	
	EntFire( "@relay.outrom_cam", "Trigger", "", 0 );
	EntFire( "relay.extract_nag_final", "CancelPending", "", 0 );
	
	EntFire ( "@screenfade_hold", "Fade", "", 3 );
	
//	SendToConsole( "cheer" );		// make player character play a cheer line
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(28)", 1 );	//Felix - Once you get home that sample is going to the lab straight away… time to find out what Kreigeld is up to.
	
	EntFire( "@game_over", "EndRound_CounterTerroristsWin", "2", 0 );	
	
	
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// MISSION 2 - VIRUS BREAKIN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

function CoopGiveC4sToCTs()
{
	ScriptCoopGiveC4sToCTs( C4_REMAINING );
}

function CreateM2Zones()
{
	local pos1 = Entities.FindByName(null, "zone1-pos").GetCenter();
	local pos2 = Entities.FindByName(null, "zone2-pos").GetCenter();
	local pos3 = Entities.FindByName(null, "zone3-pos").GetCenter();
	local pos4 = Entities.FindByName(null, "zone4-pos").GetCenter();
			
	ScriptMissionCreateAndDetonateDangerZone( pos1, pos1 );
	ScriptMissionCreateAndDetonateDangerZone( pos2, pos2 );
	ScriptMissionCreateAndDetonateDangerZone( pos3, pos3 );	
	ScriptMissionCreateAndDetonateDangerZone( pos4, pos4 );			

}

function VirusBad()		// triggered when players leave starting area
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(102)", 0 );	// Felix - Virus bad 6 sec 
}

function AirLockHint()		// triggered when players are near entrance
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(103)", 0 );	// Felix - Entrance found 5 sec 
}

function AirLockCycle()
{
	
	EntFire( "@airlock_playertrigger", "Disable", "", 0 );
	
	EntFire( "airlock1-door", "Close", "", 0 );		// close rear door
	EntFire( "m2_ashrain", "Kill", "", 0 );			// kill ash rain precip brush 
	
	EntFire( "lightpole.spark1", "StopSpark", "", 0 );		// sparks from tower
	
	EntFire( "@coopscript", "RunScriptCode", "ClearZones()", 2 );		// clear zones
	
	EntFire( "teleport.m2_firstbaddies", "Enable", "", 3 );		// teleport in baddies from their summer house 
	
	
	EntFire( "pfx.airlock_vents", "Start", "", 2 );		// Start airvent particle fx
	EntFire( "airlockspew", "TurnOn", "", 4 );		// Start airvent particle fx
	EntFire( "@snd-airlock-loop", "Playsound", "", 2 );		// Start airvent looping sound 
	EntFire( "pfx.airlock_centersmoke", "Stop", "", 4 );		// Stop center fx
	
	EntFire( "airlockspew", "TurnOff", "", 11 );		// Start airvent particle fx
	EntFire( "pfx.airlock_vents", "Stop", "", 11 );		// Stop airvent particle fx
	EntFire( "@snd-airlock-loop", "Stopsound", "", 11 );	
	EntFire( "@snd-airlock-end", "Playsound", "", 11 );		
	
	EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_AIRLOCK_DONE" + ")", 12 );	
	
	EntFire( "airlocklight-toggle", "Trigger", "", 13 );		
	EntFire( "airlock2-door", "Open", "", 14 );		// open inner door
	
	EntFire( "@pfx_entelev", "Start", "", 2 );		// Start entrance area particlefx
	
	EntFire( "heathaze", "turnoff", "", 0 );		// heat haze from vents
	
	EntFire( "lightblinker.hint", "Disable", "", 0 );		// blippy blinker
	
	
}

function PlayersInAirlockTrigger( amount )
{
	local IsWarmupPeriod = ScriptIsWarmupPeriod();

//	if ( amount == PLAYER_COUNT && IsWarmupPeriod == false )
	if ( amount == PLAYERS_ALIVE && IsWarmupPeriod == false )	// trigger based on how many players are alive
	{
	AirLockCycle();
	}
}

function PlayersInEntranceElevatorDown( amount )
{
	local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if ( amount == PLAYER_COUNT && IsWarmupPeriod == false )
	{
	EntranceElevatorDown();
	}
}

function EntranceElevatorDown()
{

	EntFire( "@entranceelev_playertrigger", "Disable", "", 0 );			// coop trigger

	EntFire( "startelevator.topdoor", "SetAnimation", "close", 0 );		
	
	EntFire( "@startelevup-blocker", "Enable", "close", 0 );		
	
	EntFire( "startelevator.topdoor.snd", "PlaySound", "", 0 );	
	
	EntFire( "startelevator-door2", "SetAnimation", "close", 0 );	


	EntFire( "startelevator-mover", "StartForward", "", 5 );	
	
	EntFire( "@shake.global.medium", "Startshake", "", 5 );	
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(104)", 8 );	// Felix - Quite the operation 
	
	EntFire( "@shake.global.mild", "Startshake", "", 9 );	
	EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_METAL_RATTLE_2" + ")", 9 );	
	
	EntFire( "@shake.global.mild", "Startshake", "", 14 );	
	EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_METAL_RATTLE_1" + ")", 14 );	
}

function EntranceElevatorArrived()
{
	EntFire( "@shake.global.medium", "Startshake", "", 0 );	

	EntFire( "startelevator.bottomdoor", "SetAnimation", "open", 2 );	
	
	EntFire( "startelevator.bottomdoor.snd", "PlaySound", "", 2 );	
	
	EntFire( "startelevator-door1", "SetAnimation", "open", 2 );
	
	EntFire( "@startelevdown-blocker", "Disable", "", 2 );		


	EntFire( "@coopscript", "RunScriptCode", "EntranceElevatorAmbush()", 2 );	
	
}

function EntranceElevatorAmbush()
{

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0 );

}

function FactoryEntered()		// triggered by coop button
{

EntFire( "@door_factory_entrance", "Unlock", "", 0 );		// open doors
EntFire( "@door_factory_entrance", "Open", "", 1 );	

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 0 );	

EntFire( "@bomb1-mdl", "SetGlowEnabled", "", 1 );

EntFire( "@startelevator_reset", "Trigger", "", 1 );	// reset entrance elevator

}

function FactoryEnteredVO()
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(105)", 0 );	// Felix - Im no expert, but that looks important
}

function FactoryC4Planted()
{
EntFire( "bombnag-relay", "CancelPending", "", 0 );
EntFire( "bombnag-relay", "Disable", "", 0 );
EntFire ( "@bomb1-mdl","SetGlowDisabled", "", 0.25 );	

C4_REMAINING = 1;

EntFire( "@door_factory_exit", "Unlock", "", 0 );		// open doors for reinforcements
EntFire( "@door_factory_exit", "Open", "", 1 );		

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0 );
}

function C4PlantNag()
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(109)", 0 );	// Felix - C4 nag 
}

function StorageEntered()		// triggered by coop button
{

EntFire( "bombnag-relay", "Enable", "", 0 );

EntFire( "@door_factory_entrance", "Close", "", 1 );		// close doors behind
EntFire( "@door_factory_entrance", "Lock", "", 2 );	

EntFire( "@door_storage_entrance", "Unlock", "", 0 );		// open doors
EntFire( "@door_storage_entrance", "Open", "", 1 );	

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 7 )", 0 );	

EntFire( "@bomb2-mdl", "SetGlowEnabled", "", 1 );

}

function StorageEnteredVO()
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(107)", 2 );	// Felix - this must be the main storage area
}

function StorageC4Planted()
{
EntFire( "bombnag-relay", "CancelPending", "", 0 );
EntFire( "bombnag-relay", "Disable", "", 0 );
EntFire ( "@bomb2-mdl","SetGlowDisabled", "", 0.25 );	

C4_REMAINING = 0;

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(108)", 2 );	// Felix - lets get out of here

}


function StorageSpawnExitSquad()		// called from trigger_once, enabled by onwavecomplete
{
debugPrint("Spawning second squad");
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );	
}

function StorageExitOpen()		// once the c4 is planted and the secondary squad is dead, open exit and spawn baddies. this loops in the think function.
{

if (STORAGE_SQUAD_DEAD == true && C4_REMAINING == 0 && STORAGE_EXIT_TRIGGERED == false)
	{
	STORAGE_EXIT_TRIGGERED = true;
	
	EntFire( "@door_storage_exit", "Unlock", "", 5 );		// open doors
	EntFire( "@door_storage_exit", "Open", "", 6 );	

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 5 );	
	}

}

function EscapeElevatorStart()		// called from coop button by elevator
{

	EntFire( "@door_storage_exit", "Close", "", 0 );		// close doors
	EntFire( "@door_storage_exit", "Lock", "", 1 );	

	EntFire( "startelevator-mover", "StartForward", "", 1 );	

	EntFire( "@trigger_disable_corridor_spawns", "Enable", "", 1 );		// trigger to disable spawngroup in corridor if player gets too close
	
	EntFire( "@coopscript", "RunScriptCode", "WaveSpawningStart()", 2 );	

	EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( false )", 2 );		// players should not respawn

	EntFire( "@coopscript", "RunScriptCode", "CoopSetBotQuotaAndRefreshSpawns( 4 )", 3 );
	EntFire( "@coopscript", "RunScriptCode", "CoopMissionSetNextRespawnIn( 6 )", 4 );
	
	wave++;  // up the wave number manually
	
	EntFire( "@trigger_escape_denied", "Enable", "", 0 );		// triggers EscapeElevatorEnd 
	EntFire( "@entranceelevup_playertrigger", "Enable", "", 0 );			// elevator up coop trigger
	
	EntFire( "startelevator.bottomdoor", "SetAnimation", "open", 22 );	
	
	EntFire( "startelevator.bottomdoor.snd", "PlaySound", "", 22 );	
	
	EntFire( "startelevator-door1", "SetAnimation", "open", 22 );
}

function WaveSpawningStart()
{
	SendToConsoleServer( "mp_randomspawn_los 1" );
	SendToConsoleServer( "mp_randomspawn_dist 4000" );
	SendToConsoleServer( "mp_use_respawn_waves 1" );
	SendToConsoleServer( "mp_respawnwavetime_t 4" ); 
}

function PlayersInEntranceElevatorUp( amount )
{
	local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if ( amount == PLAYERS_ALIVE && IsWarmupPeriod == false )
	{
	EntranceElevatorUp();
	}
}

function EntranceElevatorUp()
{
EntFire( "@entranceelevup_playertrigger", "Disable", "", 0 );

EntFire( "startelevator-door1", "SetAnimation", "close", 0 );

EntFire( "@startelevdown-blocker", "Enable", "", 0 );		

EntFire( "startelevator.bottomdoor.snd", "PlaySound", "", 0 );	

EntFire( "startelevator.bottomdoor", "SetAnimation", "close", 0 );


EntFire( "startelevator-mover", "StartBackward", "", 3 );			// starts elevator back up 

EnemyWaveSpawnsStop();
}

function EscapeElevatorEnd()
{

EntFire( "startelevator-mover", "Stop", "", 0 );

FindPlayerMovementTriggers(0);	// disable player movement triggers

EntFire( "beepscript", "RunScriptCode", "Enable()", 0 );	// this one beeps for 22 seconds	

EntFire ( "@franz","RunScriptCode", "PlayVcd(52)", 5 );	//Franz - You didn't think you were escaping? 12 sec

EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_C4_WARNING" + ")", 22 );	
EntFire( "@coopscript", "RunScriptCode", "FacilityExplosion()", 21.5 );	
}

function FacilityExplosion()
{
EntFire( "@pfx_c4_expl_1", "Start", "", 0 );
EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_C4_EXPLODE" + ")", 0 );	
EntFire( "@pfx_c4_expl_2", "Start", "", 0.75 );	
EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_C4_EXPLODE" + ")", 0.75 );	

EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_DEBRIS_1" + ")", 1.1 );	
EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_DEBRIS_2" + ")", 2.2 );	

EntFire( "@pfx_c4_expl_3", "Start", "", 0.9 );	

EntFire( "@viewpunch", "ViewPunch", "", 1 );
EntFire( "@screenfade_hold_quick", "Fade", "", 0.8 );

EntFire( "@trigger_hurt_bots", "Enable", "", 1 );
EntFire( "@trigger_hurt_bots", "Disable", "", 5 );		// kill any remaining bots

EntFire( "@coopscript", "RunScriptCode", "TransitionToDestroyed()", 5 );	

EntFire( "@destr.pfx", "Start", "", 0 );
EntFire( "@destr.fire", "StartFire", "", 0 );

}

function TransitionToDestroyed()
{

	PlantedC4DetectorActive = true;

	EntFire( "@teleport_to_destroyed", "Enable", "", 0 );
	EntFire( "@screenfade_hold_quick", "FadeReverse", "", 3 );		// 10 seconds to fully fade in
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(111)", 5 );	// Felix - wake up! 2 sec 
	
	EntFire( "@shake.global.mild", "Startshake", "", 7 );	
	
	//rumble sound

	EntFire( "rumble.timer", "Enable", "", 5 );
	
	EntFire( "wakeup.anim1", "SetAnimation", "exit1", 12 );
	EntFire( "wakeup.anim2", "SetAnimation", "exit1", 12 );
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(112)", 15 );	// Felix - thank god youre awake 3 sec 
	
	EntFire( "@pfx_entelev", "Stop", "", 2 );		// Stop entrance area particlefx
	EntFire( "elevdestr.timer", "Enable", "", 2 );		// Start blinking light timer
	EntFire( "@brkstm_timer", "Enable", "", 2 );		// Start steam burst timer
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(113)", 21 );	// Felix - elevator out of service 3 sec 

}

function WakeUpComplete()		// triggered by OnAnimationDone wakeup anim
{
	debugPrint("Disabling wakeup sequence triggers, respawning players");

	EntFire( "wakeup.teleporter1", "Disable", "", 0 );
	EntFire( "wakeup.teleporter2", "Disable", "", 0 );
	EntFire( "@trigger_wakeup_start", "Disable", "", 0 );
	EntFire( "wakeup.anim1", "Kill", "", 0 );
	EntFire( "wakeup.anim2", "Kill", "", 0 );

	EntFire( "CT_*", "SetDisabled", "", 0 );
	EntFire( "CT_7_m2", "SetEnabled", "", 0 );
	
	EntFire( "@coopscript", "RunScriptCode", "ScriptCoopMissionRespawnDeadPlayers()", 2 );	
	
	PlantedC4DetectorActive = false;		// disable C4 delete loop

	EntFire( "fire_wakeup1.detector", "RunScriptCode", "Enable()", 2 );	
	EntFire( "fire_wakeup2.detector", "RunScriptCode", "Enable()", 2 );	
	
	FindPlayerMovementTriggers(1);
}

function CrawlSpaceFranzSpeech()
{
EntFire ( "@franz","RunScriptCode", "PlayVcd(50)", 0 );	//Franz - Attention.  Our pest problem has been dealt with.
}

function FireValveBypass()		// called when main smoke detector triggers
{

	if (PlayerInteractedWithFireValve == false)
	{
		debugPrint("Player bypassed fire valve scenario");
	
		wave++;
		
		EntFire( "fire.relay_stage2", "Disable", "", 0 );		// disable relay that spawns smoke grenade guy
		
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave09", "SetEnabled", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(117)", 4 );	// Felix - excellent, good thinking!
	}
	else
		{
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(118)", 4 );	// Felix - excellent, but not as excellent as the other one!
		}
}

function FireFound()
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(114)", 2 );	// Felix - find a way to put that out
}


function FireValveUsedVO()
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(115)", 0 );	// Felix - that should do it! 2 sec 
}

function FireValveSpawn()		// called by player using valve
{
PlayerInteractedWithFireValve = true;

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 1 )", 13 );	
EntFire( "@snd.phoenix_hello", "PlaySound", "", 13 );				//"what is happening?"
EntFire( "@door_valvepuz", "Unlock", "", 13 );
EntFire( "@door_valvepuz", "Open", "", 14 );

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(116)", 4 );	// Felix - hmm no now its worse 5 sec 

}

function FanTunnelsSpawn()		// called by trigger in pipetunnel
{
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 6 )", 0 );	

EntFire( "@postdestr.pfx", "Start", "", 0 );		// Start pfx for this area

}

function FanTunnelsReinfSpawn()		// called by trigger in main room
{

	EntFire( "@venttunnel_doors", "Unlock", "", 0 );		// open doors
	EntFire( "@venttunnel_doors", "Open", "", 1 );	

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 0 );	
}

function ControlroomExteriorSpawn()		// called by trigger in vent tunnel
{

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 0 );	
}

function ControlroomSpawn()		// called by trigger outside of door
{

	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );	
	
	EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
}

function FanEnteredVO()
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(119)", 2 );	// Felix - youll have to cross tunnel
}

function FanTunnelFanDisable()
{
	EntFire( "fanbuttons", "Lock", "", 0 );

	EntFire( "fan1-limpmode", "Trigger", "", 1.5 );
	EntFire( "fan2-limpmode", "Trigger", "", 1.5 );
	EntFire( "fan3-limpmode", "Trigger", "", 1.5 );
	
	EntFire( "sscape.windtunnel1", "Disable", "", 0 );		// change soundscapes so windtunnel isnt loud anymore
	EntFire( "sscape.windtunnel2", "Enable", "", 0 );
	
	EntFire( "@fan.masterswitch", "SetGlowDisabled", "", 0 );	
	
	EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( false )", 1 );
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(120)", 1 );	// Felix - that should shut it off 1 sec 
	
	EntFire ( "@franz","RunScriptCode", "PlayVcd(53)", 5 );	//Franz - Mein Gott, who disabled the ventilation purge?
	
}

function PostFanSpawn()		// called by trigger after player has crossed fans
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 2 )", 0 );	
	
	EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 2 );		// make sure respawning is enabled
}

function ExitElevatorCalled()		// called when players use coop button for elevator
{
EntFire( "exitelev-mover", "StartBackward", "", 2 );	

EntFire( "snd.squad_warning", "PlaySound", "", 9 );				// warning for squad attack
EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 10 );	
EntFire( "@exitelev_reinfdoor", "Unlock", "", 10 );	
EntFire( "@exitelev_reinfdoor", "Open", "", 11 );	

EntFire( "@destr.fire", "Extinguish", "1", 0 );


// play some VO line
}

function ExitElevatorArrivedDown()
{

	EntFire( "exitelev.bottomdoor", "SetAnimation", "open", 1 );

	EntFire( "exitelev-door1", "SetAnimation", "open", 1 );
	
	EntFire( "exitelev.bottomdoor.snd", "PlaySound", "", 1 );

}

function PlayersInExitElevatorUp( amount )
{
	local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if ( amount == PLAYER_COUNT && IsWarmupPeriod == false )
	{
	ExitElevatorUp();
	}
}

function ExitElevatorUp()
{
EntFire( "@exitelevup_playertrigger", "Disable", "", 0 );

EntFire( "exitelev-door1", "SetAnimation", "close", 0 );

EntFire( "exitelev.bottomdoor.snd", "PlaySound", "", 0 );

EntFire( "exitelev.bottomdoor", "SetAnimation", "close", 0 );
EntFire( "@exitelev-blocker", "Enable", "", 0 );



EntFire( "exitelev-mover", "StartForward", "", 3 );	

	EntFire( "@shake.global.medium", "Startshake", "", 3 );	
	
	EntFire( "@shake.global.mild", "Startshake", "", 9 );	
	EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_METAL_RATTLE_1" + ")", 9 );	
	
	
	EntFire( "@shake.global.mild", "Startshake", "", 14 );	
	EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_METAL_RATTLE_2" + ")", 14 );	
}

function ExitElevatorArrived()		// once elevator arrives
{
EntFire( "exitelev-door1", "SetAnimation", "open", 0 );
//EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_ELEVATORDOOR_1" + ")", 0 );	

EntFire( "exitelev.topdoor", "SetAnimation", "open", 0 );

EntFire( "exitelev.topdoor.snd", "PlaySound", "", 0 );

//EntFire( "@coopscript", "RunScriptCode", "SoundEmitter(" + "SND_ELEVATORDOOR_2" + ")", 0.25 );	

EntFire( "@shake.global.medium", "Startshake", "", 0 );	

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 1 );	

}

function FranzExteriorTest()
{
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave16", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "FranzExteriorSpeech()", 1 );
}

function FranzExteriorSpeech()		// once player clears first group of dudes, and are in the big room
{

EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(121)", 1 );	// Felix - that must be boss office! 3 sec 

EntFire ( "@franz","RunScriptCode", "PlayVcd(54)", 8 );	//Franz - Well look what crawled out of the basement. 15 sec

EntFire( "@coopscript", "RunScriptCode", "FranzExteriorReinf()", 23 );		// spawn guys

EntFire( "@franz_remaining_enemies", "Enable", "", 22 );	

}

FranzExteriorRemainingEnemies <- 0;

function EnemiesAdd()
{
FranzExteriorRemainingEnemies++;
EnemiesRemaining();
}

function EnemiesSubtract()
{
FranzExteriorRemainingEnemies--;
EnemiesRemaining();
}

function EnemiesRemaining()
{

debugPrint("Enemies remaining: " + FranzExteriorRemainingEnemies);

	if (FranzExteriorRemainingEnemies == 0)
		{
		
		debugPrint("Outer guys dead, unblock path forward");
		EntFire( "@franz_pipeclimb_block", "Disable", "", 0 );	
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		}

}

function FranzExteriorReinf()
{
EntFire( "@door_franz_reinf", "Unlock", "", 0 );
EntFire( "@door_franz_reinf", "Open", "", 1 );

EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 9 )", 0 );	

}

function PlayersInFranzCorridor( amount )
{
	local IsWarmupPeriod = ScriptIsWarmupPeriod();

	if ( amount == PLAYER_COUNT && IsWarmupPeriod == false )
	{
	FranzCorridor();
	}
}

function FranzCorridor()		// once both players are in final hallway to franz office, enemies cleared
{
EntFire ( "@franz","RunScriptCode", "PlayVcd(51)", 3 );	//Franz - Felix truly has trained you well, but in the end it's all for naught. 8 sec

EntFire( "@franzcorr_playertrigger", "Disable", "", 0 );	// disable trigger

EntFire( "@trigger_franz_roller", "Enable", "", 0 );		// enable trigger near exit doors for roller

//EntFire( "@relay_franz_office_enter", "Trigger", "", 6 );	// open doors

//a whole huncha buncha door action
EntFire( "@door_franz_reinf", "Close", "", 6 );		// entrance to franz corridor
EntFire( "@door_franz_reinf", "Lock", "", 7 );	

EntFire( "@door_franz_exit", "Unlock", "", 5 );		// exit from panic room
EntFire( "@door_franz_exit", "Open", "", 6 );	

EntFire( "@boat_exit_doors", "Open", "", 0 );		// door leading to outside

EntFire( "@franz_doors_unlock_blip", "PlaySound", "", 13 );	

EntFire( "@door_franz_dummy", "SetGlowEnabled", "", 13 );	// dummy glow doors
EntFire( "@door_franz_inner1", "Unlock", "", 13.5 );		// franz doors
EntFire( "@door_franz_inner2", "Unlock", "", 13.5 );		
	

EntFire( "slide_show_projector_timer", "Enable", "", 1 );	// turn on projector in office

}

function FranzOfficeEntered()
{
	EntFire ( "@franz","RunScriptCode", "PlayVcd(55)", 0 );	//Franz - Oh it's been fun…but it's time for me to say good bye. 5 sec
	
	
	EntFire( "@franz_walkie_blinker", "Enable", "", 0 );
	EntFire( "@franz_walkie_blinker", "Disable", "", 5 );
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(122)", 6 );	// Felix - where did he go 6 sec 
	
	EntFire( "templ.franzdummy_break", "ForceSpawn", "", 0 );	// spawn breakable for cutout
	
	// TODO blinking sprite from walkie talkie
}

function FranzSecretExitVO()
{
EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(123)", 3 );	// Felix - thats it, get after him
}



function FranzFirstEscape()		// when a player reaches the open exit doors and roller closes
{

	//EntFire( "@relay_franz_roller", "Trigger", "", 0.75 );			// close roller 
	
	EntFire( "@door_surfacc", "Unlock", "", 0 );			// unlock and open ladder door 
	EntFire( "@door_surfacc", "Open", "", 1 );
	
	EntFire( "@trigger_m2_finale", "Enable", "", 1 );		// trigger at top of ladder
	
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 0.25 );		// ladder and surface guys

}

FranzBoatHit <- 0;

function FranzBoatDebug()
{
FranzBoatHit++;
FranzCountDownPause();

printl("Boat hit : " + FranzBoatHit);
}

function FranzFinaleStart()		// when players reach top of ladder
{
	ScriptCoopMissionSetDeadPlayerRespawnEnabled( false );		// no more respawning

	EntFire( "@relay_heli_spotlight", "Trigger", "", 0 );		// parent spotlight to helicopter, start helicopter fly-in
	EntFire( "@franz_boat_hitbutton", "Unlock", "", 10 );		// func_button used to detect hits on boat
	
	EntFire( "slide_show_projector_timer", "Disable", "", 0 );	// turn off projector in office
	EntFire( "slideshow_projector_image*", "TurnOff", "", 1 );	// turn off projector in office
	EntFire( "slideshow_projector_sprite*", "LightOff", "", 1 );	// turn off projector in office
	
	
	EntFire( "@pfx_heli_hover", "Start", "", 12 );
	
	EntFire( "@heli_spotlight.light", "TurnOn", "", 15 );		// turn on spotlight
	EntFire( "@heli_spotlight.spr", "ShowSprite", "", 15 );		// turn on spotlight sprite
	EntFire( "@heli_spotlight.snd", "PlaySound", "", 15 );		// sound
	
	EntFire( "@button_friendlyfire", "Unlock", "", 17 );		// unlock friendly fire button over helicopter
	
	EntFire( "@franz_budget_yacht", "SetGlowEnabled", "", 15 );	
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(124)", 12 );	// Felix - he must be in that boat!
	
	EntFire ( "@coopscript","RunScriptCode", "FranzCountDownStart()", 10 );	// start countdown for fail
	
	
	EntFire( "@m249_glowmdl", "SetGlowEnabled", "", 13 );		// highlight M249s
	
	EntFire( "enemy.*", "SetDisabled", "", 0 );
	EntFire( "enemy.m2_wave18", "SetEnabled", "", 0 );
	
	EntFire( "CT_*", "SetDisabled", "", 0 );
	EntFire( "CT_13_m2", "SetEnabled", "", 0 );
		
	FranzFinaleWaveSpawn();			// starts spawning guys on beach after 5 sec

}

function FranzFinaleWaveSpawn()		// spawn guys near boat
{
	EntFire( "@coopscript", "RunScriptCode", "CoopSetBotQuotaAndRefreshSpawns( 2 )", 1 );
	EntFire( "@coopscript", "RunScriptCode", "CoopMissionSetNextRespawnIn( 4 )", 2 );

	EntFire( "@coopscript", "RunScriptCode", "WaveSpawningStart()", 5 );

}

function FranzBoatFriendlyFire()		// hint if players shoot at friendly heli
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(127)", 0 );	// Felix - dont shoot at chopper, shoot at boat TODO have variation of this line, use it 
}

function FranzBoatHint()		// hint if players havent opened fire on boat
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(125)", 0 );	// Felix - shoot the boat
}

function FranzBoatFinalHint()		// hint if players havent opened fire on boat
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(126)", 0 );	// Felix - shoot the boat please
}

function FranzBoatDead()		// when boat has been hit enough times 
{
	EntFire( "@m249_glowmdl", "SetGlowDisabled", "", 0 );		// stop highlighting M249s

	EntFire( "@franz_budget_yacht", "SetGlowDisabled", "", 0 );	
	EntFire( "@franz_boat_hitbutton", "Lock", "", 0 );				// func_button used to detect hits on boat
	
	FranzBoatExplode();		// effects 
	
	EnemyWaveSpawnsStop();	// stop wave spawning
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(130)", 3 );	// Felix - good job shooting boat, go to chopper
	
	EntFire( "@coopscript", "RunScriptCode", "M2StartExtraction()", 5 );	// start extraction
	
	CountDownActive = false;		// stop countdown timer
}

function FranzBoatEscape()
{

	EntFire( "@m249_glowmdl", "SetGlowDisabled", "", 0 );		// stop highlighting M249s

	EntFire( "@franz_budget_yacht", "SetGlowDisabled", "", 0 );	
	EntFire( "@franz_boat_hitbutton", "Lock", "", 0 );		// disable func_button used to detect hits on boat
	
	EnemyWaveSpawnsStop();	// stop wave spawning
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(129)", 3 );	// Felix - damn, he got away
	
//	EntFire( "boattrain", "StartForward", "", 0 );		// start boat escape

	EntFire( "wishywashy1", "SetParent", "@franz_budget_yacht", 0 );		// set pfx parent
	EntFire( "wishywashy1", "SetParentAttachmentMaintainOffset", "boat_pos", 0.1 );		// set pfx parent
	EntFire( "wishywashy2", "SetParent", "@franz_budget_yacht", 0 );		// set pfx parent
	EntFire( "wishywashy2", "SetParentAttachmentMaintainOffset", "boat_pos", 0.1 );		// set pfx parent
	EntFire( "wishywashy3", "SetParent", "@franz_budget_yacht", 0 );		// set pfx parent
	EntFire( "wishywashy3", "SetParentAttachmentMaintainOffset", "boat_pos", 0.1 );		// set pfx parent
	EntFire( "wishywashy4", "SetParent", "@franz_budget_yacht", 0 );		// set pfx parent
	EntFire( "wishywashy4", "SetParentAttachmentMaintainOffset", "boat_pos", 0.1 );		// set pfx parent
	EntFire( "wishywashy5", "SetParent", "@franz_budget_yacht", 0 );		// set pfx parent
	EntFire( "wishywashy5", "SetParentAttachmentMaintainOffset", "boat_pos", 0.1 );		// set pfx parent
	EntFire( "wishywashy6", "SetParent", "@franz_budget_yacht", 0 );		// set pfx parent
	EntFire( "wishywashy6", "SetParentAttachmentMaintainOffset", "boat_pos", 0.1 );		// set pfx parent

	EntFire( "enginesound.takeoff", "Trigger", "", 1.5 );		// start boat escape
	EntFire( "enginesound.stop", "Trigger", "", 6.5 );		// stop boat sounds
	
	EntFire( "@franz_budget_yacht", "SetAnimation", "escape", 0.5 );		// set escape animation
	EntFire( "wwweee", "Trigger", "", 0.5 );		// water splash from behind boat
	
	EntFire ( "@screenfade_hold", "Fade", "", 5.5 );
	
	EntFire( "@game_over", "endround_terroristswin", "8", 5 );	
	
	// VO for franz, so long suckerssssssssss
	// if hard mode, do a jump
}

function AFewMore()
{
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 3 )", 0 );		// ladder and surface guys
}

function FranzBoatExplode()		// bunch of sounds and pfx
{

	EntFire( "enginesound.stop", "Trigger", "", 0.6 );

	EntFire( "@boat_expl_snd1", "PlaySound", "", 0 );	// molly burst snd
	EntFire( "@pfx_boat_expl1", "Start", "", 0 );		// molly burst pfx
	
	EntFire( "@boat_expl_snd2", "PlaySound", "", 0.6 );
	EntFire( "@pfx_boat_expl2", "Start", "", 0.6 );
	
	EntFire( "@franz_budget_yacht", "Disable", "", 0.7 );	// swap models on first explosion
	EntFire( "@franz_boat_ded", "Enable", "", 0.7 );	

	EntFire( "@shake.franzboat", "Startshake", "", 0.7 );	
	
	EntFire( "@boat_expl_snd3", "PlaySound", "", 1 );		// molly water burst snd
	EntFire( "@pfx_boat_expl_w", "Start", "", 0.6 );		// water explosion pfx
	
	EntFire( "@debris_shooter1", "Shoot", "", 0.5 );
	EntFire( "@debris_shooter1", "Shoot", "", 2 );
	EntFire( "@debris_shooter2", "Shoot", "", 1 );
	EntFire( "@debris_shooter2", "Shoot", "", 1.4 );
	EntFire( "@debris_shooter2", "Shoot", "", 2.2 );
	

	EntFire( "@boatexpl1", "Explode", "", 0.9 );
	EntFire( "@boat_expl_snd2", "PlaySound", "", 0.9 );
	
	EntFire( "@boatexpl2", "Explode", "", 1.3 );
	EntFire( "@boat_expl_snd2", "PlaySound", "", 1.3 );
	
	EntFire( "@boatexpl3", "Explode", "", 2.2 );
	EntFire( "@boat_expl_snd2", "PlaySound", "", 2.2 );
	
	EntFire( "@boatgib1", "Shoot", "", 0.6 );
	EntFire( "@boatgib2", "Shoot", "", 0.9 );
	EntFire( "@boatgib3", "Shoot", "", 1.3 );
	EntFire( "@boatgib4", "Shoot", "", 1.5 );
	EntFire( "@boatgib5", "Shoot", "", 1.9 );
	EntFire( "@boatgib6", "Shoot", "", 2.2 );
	
	EntFire( "@boat_expl_snd4", "PlaySound", "", 1.5 );		// debris noise
	
	
	EntFire( "@pfx.lingeringsmoke", "Start", "", 1 );
	
	
}

function M2StartExtraction()
{

	EntFire( "@heli_spotlight.light", "TurnOff", "", 0 );		// turn off spotlight
	EntFire( "@heli_spotlight.spr", "HideSprite", "", 0 );		// turn off spotlight sprite

	EntFire( "heli.extract_relay", "Trigger", "", 0 );		// heli move to cliff

	EntFire( "trigger.extraction_m2", "Enable", "", 1 );		// trigger near heli

	EntFire( "enemy.*", "SetDisabled", "", 0 );
	EntFire( "enemy.m2_wave19", "SetEnabled", "", 0 );
	
	EntFire( "@coopscript", "RunScriptCode", "SpawnNextWave( 5 )", 1 );	
	
	EntFire( "@door_extract", "Unlock", "", 0 );
	EntFire( "@door_extract", "Open", "", 0 );

}

function ExtractionM2TriggerCount ( count )
{
EXTRACTION_COUNT = count;

debugPrint("Players in extraction trigger: " + EXTRACTION_COUNT)
}

function ExtractionM2TriggerCheck()
{
	if (EXTRACTION_COUNT == PLAYERS_ALIVE && EXTRACTION_COUNT > 0 && EXTRACTION_SUCCESS == false && MISSION == 2)
	{
	PlayerReachedHelicopterM2();
	}
}

function PlayerReachedHelicopterM2()		// game over m2
{
	EXTRACTION_SUCCESS = true;
	
	EntFire( "@relay.outrom_cam_m2", "Trigger", "", 0 );
	
	EntFire ( "@screenfade_hold", "Fade", "", 3 );
	
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(131)", 2 );	// Felix - mission success
	
	EntFire( "@game_over", "EndRound_CounterTerroristsWin", "2", 0 );	
	
}


function SoundEmitter( sound )		// member 2 precache
{
self.EmitSound( sound );
}

// =================================================================================
// === game_coopmission_manager functions ( @coopmanager ) =========================
// =================================================================================

function OnMissionCompleted()
{

	
}

function OnRoundLostKilled()
{

	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9011,9012,9013,9015,0) )", 0 );
	
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
	EntFire( "CT_1", "SetEnabled", "", 0 );
}


function OnWaveCompleted()
{	


	if ( wave == 1 && MISSION != 2)		// beach cleared
	{
		debugPrint ("Wave 1 defeated, beach squad");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave02", "SetEnabled", "", 0 );
		
		EntFire( "beachbutton-button_enable", "Trigger", "", 1 );

		
		EntFire( "eventlisten.spot01", "Enable", "", 1 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_2", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
	}
	else if ( wave == 2 && MISSION != 2)		// kasbah exterior cleared
	{
		debugPrint ("Wave 2 defeated, kasbah exterior");
	
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave02_inner", "SetEnabled", "", 0 );

		EntFire( "spot01-relay.off", "Trigger", "", 2 );
		
		EntFire( "kasbahfencegatebutton-button_enable", "Trigger", "", 1 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(4)", 1 );	// Felix - You don't put this many guards around something that doesn't need defending.  The way in has to be around here somewhere.
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_3", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 3 && MISSION != 2)		// kasbah interior cleared
	{
		debugPrint ("Wave 3 defeated, kasbah courtyard");
	
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.checkpoint_guards", "SetEnabled", "", 0 );
		
		EntFire( "@chainlinkdoor_innerkasbah", "Unlock", "", 0 );
		EntFire( "@chainlinkdoor_innerkasbah", "SetGlowEnabled", "", 0 );
		
		EntFire( "@trigger.checkpoint_spawn", "Enable", "", 0 );
		
		EntFire( "@container_unlock", "Trigger", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_4", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 4 && MISSION != 2)		// checkpoint guards cleared
	{
		debugPrint ("Wave 4 defeated, checkpoint guards");
	
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.cellblock", "SetEnabled", "", 0 );
		
		
		EntFire( "@checkpoint_button.func", "Unlock", "", 1 );
		EntFire( "@checkpoint_button.mdl", "SetGlowEnabled", "", 1 );
		
		EntFire( "@cellblock_playertrigger", "Enable", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_5", "SetEnabled", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(6)", 2 );	// Felix - The tunnels are causing a lot of interference, I'm going to have to go dark until you're back out.
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );

	}
	else if ( wave == 5 && MISSION != 2)		// cellblock knifefight done
	{
		debugPrint ("Wave 5 defeated, knife fight");
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_6", "SetEnabled", "", 0 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.cellblock_postbrawl_cat", "SetEnabled", "", 0 );

		EntFire( "@coopscript", "RunScriptCode", "CellBlockAmbushEnd()", 1 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 6 && MISSION != 2)		// cellblock catwalk guards dead
	{
		debugPrint ("Wave 6 defeated, catwalk guards");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.cellblock_postbrawl", "SetEnabled", "", 0 );

		EntFire( "@coopscript", "RunScriptCode", "CellBlockReinforcements()", 1 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 7 && MISSION != 2)		// cellblock reinforcements cleared
	{
		debugPrint ("Wave 7 defeated, cellblock reinforcements");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.breachattack", "SetEnabled", "", 0 );
		EntFire( "@medical_doors_button_unlock", "Trigger", "", 1 );
		EntFire( "@steamburst_timer", "Enable", "", 1 );				// hint steam for climb route, disabled again via map trigger
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 8 && MISSION != 2)		// breach charge guys cleared
	{
		debugPrint ("Wave 8 defeated, breach attack");
	
		
		EntFire ( "@franz","RunScriptCode", "PlayVcd(21)", 1 );	//Franz - It's really not in your best interest to leave.  Stay.  Return the sample.  Join my experiments, and if you emerge victorious I will show you how the world truly works.  You could be so much more than Felix's catspaw.
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave03", "SetEnabled", "", 0 );

		EntFire( "@trigger_radarspawn", "Enable", "", 0 );
		
		EntFire( "@door_to_pipetunnels", "Unlock", "", 0 );
		EntFire( "@door_to_pipetunnels", "SetGlowEnabled", "", 0 );
		
		EntFire( "@clip_underground_backtrack", "Disable", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_7", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 9 && MISSION != 2)		// radar station cleared
	{
		debugPrint ("Wave 9 defeated, radar squad");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave04", "SetEnabled", "", 0 );

		EntFire( "@trigger_radarstairs", "Enable", "", 0 );

		RadarCleared();
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_8", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
	}
	else if ( wave == 10 && MISSION != 2)
	{
		debugPrint ("Wave 10 defeated, radar underground squad");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave05", "SetEnabled", "", 0 );
		
		EntFire( "trigger.extraction", "Enable", "", 1 );
		EntFire( "@radartunnelexit_enable", "Trigger", "", 1 );
		EntFire( "@relay_radar_blinkydont", "Trigger", "", 0 );		// disable buncha repeating timers
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_9", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 11 && MISSION != 2)
	{
		debugPrint ("Wave 11 defeated, holdout fight");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave06", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_10", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		//EntFire( "@coopscript", "RunScriptCode", "HelipadExitOpen()", 1 );
		
		EntFire( "@coopscript", "RunScriptCode", "HelipadExitOpenSimple()", 1 );
		
	}
	else if ( wave == 12 && MISSION != 2)
	{
		debugPrint ("Wave 12 defeated, rollup door guys");
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_11", "SetEnabled", "", 0 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave07_init", "SetEnabled", "", 0 );
	
		EntFire( "@helipad_exitdoor", "Unlock", "", 0 );
		EntFire( "@helipad_exitdoor", "SetGlowEnabled", "", 0 );
		
	}
	else if ( wave == 13 && MISSION != 2)
	{
		debugPrint ("Wave 13 defeated, beach mini squad");
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_12", "SetEnabled", "", 0 );
	
		EntFire( "@trigger.beach_bunker_spawn_cancel", "Disable", "", 0 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave07", "SetEnabled", "", 0 );
	}
	else if ( wave == 14 && MISSION != 2)
	{
		debugPrint ("Wave 14 defeated, beach bunker squad");
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_13", "SetEnabled", "", 0 );
	
		EntFire( "@trigger.beach_hill_spawn_cancel", "Disable", "", 0 );
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.wave08", "SetEnabled", "", 0 );
	}


	if ( wave == 1 && MISSION == 2)		// airlock welcome
	{
		debugPrint ("Wave 1 defeated, welcome party");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave02", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_3_m2", "SetEnabled", "", 0 );
		
		EntFire( "@entranceelev_playertrigger", "Enable", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
	}
	else if ( wave == 2 && MISSION == 2)		// elevator dudes
	{
		debugPrint ("Wave 2 defeated, elevator dudes");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave03", "SetEnabled", "", 0 );

		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_4_m2", "SetEnabled", "", 0 );
		
		EntFire( "@factory_entrance_button", "Trigger", "", 1 );		// enable coop buttons for factory 
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 3 && MISSION == 2)		// factory dudes
	{
		debugPrint ("Wave 3 defeated, factory guys");
		
		EntFire( "bombnag-relay", "Trigger", "", 0 );		// nag for C4 plant, cancels out on bomb planted
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_5_m2", "SetEnabled", "", 0 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave04", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 4 && MISSION == 2)		// factory reinf
	{
		debugPrint ("Wave 4 defeated, factory reinforcements");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave05", "SetEnabled", "", 0 );
		
		EntFire( "@storage_entrance_button", "Trigger", "", 1 );		// enable coop buttons for factory 
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 5 && MISSION == 2)		// storage initial
	{
		EntFire( "bombnag-relay", "Trigger", "", 0 );
	
		debugPrint ("Wave 5 defeated, storage initial");
	
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_6_m2", "SetEnabled", "", 0 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave06", "SetEnabled", "", 0 );
		
		EntFire( "@door_storage_reinf", "Unlock", "", 1 );
		EntFire( "@door_storage_reinf", "Open", "", 2 );
		
		EntFire( "@trigger_exit_squad", "Enable", "", 1 );		// triggers function StorageSpawnExitSquad
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 6 && MISSION == 2)		// storage reinf
	{
		debugPrint ("Wave 6 defeated, storage second");
		
		STORAGE_SQUAD_DEAD = true;
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave07", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 7 && MISSION == 2)		// storage exit squad
	{
		debugPrint ("Wave 7 defeated, storage exit");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave08", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		EntFire( "@door_storage_exit_actual", "SetGlowEnabled", "", 0 );
		EntFire( "@door_storage_exit_actual", "Unlock", "", 1 );	
		
		EntFire( "@return_elevator_button", "Trigger", "", 1 );	
	}
	else if ( wave == 8 && MISSION == 2)		// escape elevator wavespawn
	{
		debugPrint ("Wave 8 defeated, elevator holdout");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave08b", "SetEnabled", "", 0 );
	}
	else if ( wave == 9 && MISSION == 2)		// escape elevator wavespawn
	{
		debugPrint ("Wave 9 defeated, smokegrenade guy");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave09", "SetEnabled", "", 0 );
		
		EntFire( "@smokgren_box_fire", "SetGlowEnabled", "", 1.5 );		// glow box
		EntFire( "@smokegren_button", "Unlock", "", 2 );		// let players pick up smoke grenades
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 10 && MISSION == 2)		// destroyed tunnels
	{
		debugPrint ("Wave 10 defeated, destroyed tunnels");
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_8_m2", "SetEnabled", "", 0 );
	
		EntFire( "@trigger_destr_tun_reinf", "Enable", "", 2 );		// spawns next wave
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave10", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 11 && MISSION == 2)		// destroyed tunnels reinf
	{
		debugPrint ("Wave 11 defeated, destroyed tunnels reinf");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave11", "SetEnabled", "", 0 );
		
		EntFire( "@door_venttunnel", "SetGlowEnabled", "", 0 );
		EntFire( "@door_venttunnel", "Unlock", "", 1 );	
		
		EntFire( "@trigger_ctrlroom_ext_spawn", "Enable", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 12 && MISSION == 2)		// destroyed tunnels reinf
	{
		debugPrint ("Wave 12 defeated, vent tunnels");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave12", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_9_m2", "SetEnabled", "", 0 );
		
		EntFire( "@door_ventcontrols", "SetGlowEnabled", "", 0 );
		EntFire( "@door_ventcontrols", "Unlock", "", 1 );	
		
		EntFire( "@trigger_ctrlroom_spawn", "Enable", "", 0 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 13 && MISSION == 2)		// control room guys
	{
		debugPrint ("Wave 13 defeated, control room");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave13", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_10_m2", "SetEnabled", "", 0 );
		
		EntFire( "@door_fanaccess", "SetGlowEnabled", "", 0 );
		EntFire( "@door_fanaccess", "Unlock", "", 1 );	
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		EntFire( "@trigger_postfan_spawn", "Enable", "", 0 );	
		EntFire( "@trigger_fan_hint_vo", "Enable", "", 0 );	
		
	}
	else if ( wave == 14 && MISSION == 2)		// post fan
	{
		debugPrint ("Wave 14 defeated, post fan");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave14", "SetEnabled", "", 0 );
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_11_m2", "SetEnabled", "", 0 );

		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		EntFire( "@exitelev_coopbutton", "Trigger", "", 0 );		// enable coop button for elevator
	}
	else if ( wave == 15 && MISSION == 2)		// elevator
	{
		debugPrint ("Wave 15 defeated, elevator");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave15", "SetEnabled", "", 0 );
		
		EntFire( "@exitelevup_playertrigger", "Enable", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
	}
	else if ( wave == 16 && MISSION == 2)		// franz exterior
	{
		debugPrint ("Wave 16 defeated, franz exterior 1");
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_12_m2", "SetEnabled", "", 0 );
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave16", "SetEnabled", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
		EntFire( "@franz_exterior_speech", "Enable", "", 1 );
		
	}
	else if ( wave == 17 && MISSION == 2)		// heavies and corridor guys
	{
		debugPrint ("Wave 17 defeated, franz exterior 2");
	
		EntFire( "enemy.*", "SetDisabled", "", 0 );
		EntFire( "enemy.m2_wave17", "SetEnabled", "", 0 );
		
		EntFire( "@franzcorr_playertrigger", "Enable", "", 0 );
		
		EntFire( "@coopscript", "RunScriptCode", "RespawnPlayerState( true )", 1 );
		
	}
	else if ( wave == 18 && MISSION == 2)		// ladder guy and overlook
	{
		debugPrint ("Wave 18 defeated, franz final fight");
		
		EntFire( "CT_*", "SetDisabled", "", 0 );
		EntFire( "CT_13_m2", "SetEnabled", "", 0 );
	
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
	
	if (MISSION == 2)
	{
		EntFire( "@coopscript", "RunScriptCode", "CoopGiveC4sToCTs()", 0.1 );
	}
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