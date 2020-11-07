DEBUG <- false;

TOTAL_PLAYERS_PLAYING <- 2;

m_nWaveNumber <- 0;
m_MissionManager <- EntityGroup[0];

MAX_C4S_FOR_MISSION_3 <- 2;
m_nMission3C4sNotPlanted <- MAX_C4S_FOR_MISSION_3;

MAX_COLLECTABLE_COINS <- 3;
m_nCoinsCollected <- 0;

m_nPlayersWantMission1 <- 0;
m_nPlayersWantMission2 <- 0;
m_nPlayersWantMission3 <- 0;

m_nPlayersReadyInReadyRoom <- 0;
m_nPlayersReadyInReadyRoomHARD <- 0;
m_nPlayersInPCRoomM2 <- 0;
m_nPlayersInElevatorM2 <- 0;
m_bReadyRoomStartCheckDeploy <- false;
m_fReadyRoomDeployRequestTime <- -1;
m_bReadyRoomPlayersDeployed <- false;
m_bMissionSelected <- false;
m_flMissionStartSelectTime <- -1;
m_fNextCheckWaitingAtGateMission2 <- -1;
m_bCanNagWaitingAtGateM3 <- false;
m_fNextRespawnPlayersActive <- -1;
m_flNextLockHostageDoorUseTime <- 0;
m_fDoNextEndNagM3 <- -1;
m_flApcGarageNextNag <- -1;
m_flPlantFirstBombNag <- -1;

m_flNextM3Explosion <- -1;
m_flBothM3BombWentOff <- false;

m_nTimesComputerPressed <- 0;

m_nPlayersInApcGarage <- 0;

m_hKincaideHostageHandle <- null;
m_nextNoKincaideNag <- 0;

m_hComputerHandle <- null;

SND_PC_PRESS <- "coop_cementplant.mission2_computer_press";
SND_PC_WAITING_FOR_PRESS <- "coop_cementplant.mission2_computer_waiting";
SND_PC_INSERT_STICK <- "Weapon_Nova.Insertshell";
SND_PC_REMOVE_STICK <- "Player.PickupWeapon";

SND_DEPLOY_CHOPPER <- "insertion.helicopter";
SND_DEPLOY_APC <- "insertion.swat";
SND_DEPLOY_BOAT <- "insertion.boat";

missionSelectConfirmAudio <- [
	 "seal.radio_locknload14",
	 "seal.radio_locknload15",
	 "seal.radio_locknload01",
	 "seal.radio_locknload03",
	 "seal.radio_locknload04"
]

function debugPrint( text )
{
	if ( DEBUG == false )
		return;

	printl( text );
}

function Precache()
{
	self.PrecacheScriptSound( SND_PC_PRESS );
	self.PrecacheScriptSound( SND_PC_WAITING_FOR_PRESS );
	self.PrecacheScriptSound( SND_PC_INSERT_STICK );
	self.PrecacheScriptSound( SND_PC_REMOVE_STICK );

	self.PrecacheScriptSound( SND_DEPLOY_CHOPPER );
	self.PrecacheScriptSound( SND_DEPLOY_APC );
	self.PrecacheScriptSound( SND_DEPLOY_BOAT );

	for (local index = 0; index < missionSelectConfirmAudio.len(); index += 1)
	{
 		self.PrecacheScriptSound( missionSelectConfirmAudio[index] );
	}
}

function OnPostSpawn()
{
	SendToConsoleServer( "weapon_reticle_knife_show 1" );
	SendToConsoleServer( "mp_freezetime 1" );
	SendToConsoleServer( "bot_difficulty 2" );
	SendToConsoleServer( "mp_buytime 0" );
	SendToConsoleServer( "mp_startmoney 0" );

	EntFire( "matmod_m1", "SetMaterialVar", "1", 0 );
	EntFire( "matmod_m2", "SetMaterialVar", "2", 0 );
	EntFire( "matmod_m3", "SetMaterialVar", "3", 0 );
}

function CoopThink()
{
	if ( m_bMissionSelected == false )
	{
		//debugPrint( "m_nPlayersWantMission3 = "+m_nPlayersWantMission3 );

		if ( m_nPlayersWantMission1 >= TOTAL_PLAYERS_PLAYING || 
			m_nPlayersWantMission2 >= TOTAL_PLAYERS_PLAYING || 
			m_nPlayersWantMission3 >= TOTAL_PLAYERS_PLAYING )
		{
			if ( m_flMissionStartSelectTime == -1 )
			{
				m_flMissionStartSelectTime = Time() + 5.0;
				//debugPrint( "m_flMissionStartSelectTime" );
			}		
		}
		else
		{
			// if the needed players aren't standing in a mission area, reset this bool
			if ( m_flMissionStartSelectTime != -1 )
				m_flMissionStartSelectTime = -1;
		}

		if ( m_flMissionStartSelectTime != -1 )
		{
			local flTimeLeft = -1 * (Time()-m_flMissionStartSelectTime);	

			local sMission = ""+1;
			if ( m_nPlayersWantMission2 >= TOTAL_PLAYERS_PLAYING )
				sMission = ""+2;
			else if ( m_nPlayersWantMission3 >= TOTAL_PLAYERS_PLAYING )
				sMission = ""+3;

			local sTimeLeft = ""+ceil( flTimeLeft );
			//if ( flTimeLeft > 4 )
			//	ScriptPrintMessageCenterAllWithParams( "#SFUIHUD_InfoPanel_Coop_StartingMissionIn", sMission, 5, null );
			//else if ( flTimeLeft > 3 )
			//	ScriptPrintMessageCenterAllWithParams( "#SFUIHUD_InfoPanel_Coop_StartingMissionIn", sMission, 4, null );
			//else if ( flTimeLeft > 2 )
			//	ScriptPrintMessageCenterAllWithParams( "#SFUIHUD_InfoPanel_Coop_StartingMissionIn", sMission, 3, null );;
			//else if ( flTimeLeft > 1 )
			//	ScriptPrintMessageCenterAllWithParams( "#SFUIHUD_InfoPanel_Coop_StartingMissionIn", sMission, 2, null );
			
			if ( flTimeLeft > 0 )
				ScriptPrintMessageCenterAllWithParams( "#SFUIHUD_InfoPanel_Coop_StartingMissionIn", sMission, sTimeLeft, "" );
			else
			{
				ScriptPrintMessageCenterAllWithParams( "#SFUIHUD_InfoPanel_Coop_StartingMissionNow", sMission, "", "" );

				m_bMissionSelected = true;
				if ( m_nPlayersWantMission1 >= TOTAL_PLAYERS_PLAYING )
					Pick_Mission1();
				else if ( m_nPlayersWantMission2 >= TOTAL_PLAYERS_PLAYING )
					Pick_Mission2();
				else if ( m_nPlayersWantMission3 >= TOTAL_PLAYERS_PLAYING )
					Pick_Mission3();
			}
		}
	}
	else if ( m_bReadyRoomStartCheckDeploy == true && m_bReadyRoomPlayersDeployed == false )
	{
		// I don't know how to format numbers to truncate and make the time whole, so working around it....
		local flTimeLeft = -1 * (Time()-m_fReadyRoomDeployRequestTime);
		if ( flTimeLeft > 2 )
			flTimeLeft = 3;
		else if ( flTimeLeft > 1 )
			flTimeLeft = 2;
		else 
			flTimeLeft = 1;

		if ( m_nPlayersReadyInReadyRoomHARD == TOTAL_PLAYERS_PLAYING )
		{
			if ( flTimeLeft >= 3 )
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingHARDIn3" );
			else if ( flTimeLeft >= 2 )
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingHARDIn2" );
			else 
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingHARDIn1" );

			//ScriptPrintMessageCenterAll( "Deploying on HARD in "+flTimeLeft );
			//ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingIn" );
		}
		else if ( m_nPlayersReadyInReadyRoom == TOTAL_PLAYERS_PLAYING )
		{
			if ( flTimeLeft >= 3 )
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingIn3" );
			else if ( flTimeLeft >= 2 )
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingIn2" );
			else 
				ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingIn1" );

			//ScriptPrintMessageCenterAll( "Deploying in "+flTimeLeft );
			//ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingIn" );
		}

		if ( m_fReadyRoomDeployRequestTime <= Time() )
			ReadyRoomDeployPlayers( );
	}
	else if ( m_bReadyRoomPlayersDeployed == false )
	{
		if ( m_nPlayersReadyInReadyRoomHARD > 0 || m_nPlayersReadyInReadyRoom > 0 )
			ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_WaitingDeploying" );

		//else if ( m_nPlayersReadyInReadyRoom > 0 )
		//	ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployingHARDIn1" );
	}	

	if ( m_fNextCheckWaitingAtGateMission2 != -1 && m_fNextCheckWaitingAtGateMission2 <= Time() )
	{
	
	}

	if ( m_fDoNextEndNagM3 != -1 && m_fDoNextEndNagM3 <= Time() )
	{
		EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(367,368,380,0,0,0) )", 0 );
		m_fDoNextEndNagM3 = Time() + 10;
	}

	if ( m_nPlayersInApcGarage < TOTAL_PLAYERS_PLAYING 
		&& m_flApcGarageNextNag != -1 && m_flApcGarageNextNag <= Time() )
	{
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(322)", 0 );
		m_flApcGarageNextNag = Time() + 16;
	}

	if ( m_flPlantFirstBombNag != -1 && m_flPlantFirstBombNag <= Time() )
	{
		ImogenCalloutBomb01();
	}

	if ( m_flNextM3Explosion != -1 && m_flNextM3Explosion <= Time() )
	{
		local nMin = 3;
		local nMax = 8;
		if ( m_flBothM3BombWentOff )
		{
			nMin = 0.5;
			nMax = 4;		
		}

		local nBoomNum = 1;
		if ( m_flBothM3BombWentOff )
			nBoomNum = RandomInt(1,4);
		else
			nBoomNum = RandomInt(3,4);

		EntFire ( "snd_explde_far_"+RandomInt(1,2),"PlaySound", "", 0.1 );
		EntFire( "prt_skyboom_"+nBoomNum, "Stop", "", 0 );
		EntFire( "prt_skyboom_"+nBoomNum, "Start", "", 0.1 );

		m_flNextM3Explosion = Time() + RandomFloat(nMin,nMax);
	}

	RespawnPlayersThink();
}

function RespawnPlayersStart()
{
	m_fNextRespawnPlayersActive = Time();
}

function RespawnPlayersStop()
{
	m_fNextRespawnPlayersActive = -1;
}

function RespawnPlayersThink()
{
	if ( m_fNextRespawnPlayersActive != -1 && m_fNextRespawnPlayersActive <= Time() )
	{
		m_fNextRespawnPlayersActive = Time() + 1;
		RespawnPlayers();
	}
}

function ResetSpawnWaves()
{
	SendToConsoleServer( "mp_randomspawn_los 0" );
	SendToConsoleServer( "mp_use_respawn_waves 2" );
	SendToConsoleServer( "mp_respawnwavetime_t 5" );
}

function OnPlayerDie()
{
	// event that fires when a player dies
	
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9001,9002,9003,9004,9005,0) )", 0 );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "CoopGiveC4sToCTs()", 0.1 );
}

function RoundInitialize()
{
	ResetSpawnWaves();

	m_hComputerHandle <- Entities.FindByName(null, "@computer");

	m_fReadyRoomDeployRequestTime = -1;
	m_bReadyRoomStartCheckDeploy = false;
	m_bReadyRoomPlayersDeployed = false;

	m_bMissionSelected = false;
	m_flMissionStartSelectTime = -1;

	m_nCoinsCollected = 0;
	m_fDoNextEndNagM3 = -1;
	m_fNextCheckWaitingAtGateMission2 = -1;

	m_flNextM3Explosion = -1;
	m_flBothM3BombWentOff = false;
	m_flPlantFirstBombNag = -1;
}

// fired when the mission is lost due to both players dying
function OnRoundLostKilled()
{
	RoundInitialize();

	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9011,9012,9013,9014,9015,0) )", 0 );
}

// fired when the mission is lost due to running out of time
function OnRoundLostTime()
{
	RoundInitialize();

	EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9006,9007,9008,9009,9010,0) )", 0 );
}

// fired when the mission succeeds
function OnMissionSucceeded()
{
	m_fDoNextEndNagM3 = -1;

	local nMission = ScriptCoopMissionGetMissionNumber( );
	switch ( nMission )
	{
		case 1: 
			EntFire( "@radiovoice","RunScriptCode", "PlayVcd(13)", 1 );		
			break;
		case 2:
			EntFire( "@radiovoice","RunScriptCode", "PlayVcd(216)", 1 );
			break;
		case 3:
		{
			EntFire( "@radiovoice","RunScriptCode", "PlayVcd(349)", 1 );	
		
			EntFire( "relay_tonemap_flash", "Trigger", "", 0.3 );	
			EntFire( "snd_explode_1_a", "PlaySound", "", 0 );
			EntFire( "snd_explode_2_a", "PlaySound", "", 0 );
			EntFire( "shk_explode_1_a", "StartShake", "", 0 );	
			EntFire( "snd_explode_2_b", "PlaySound", "", 1 );
			break;
		}
	}
}

function OnWaveCompleted()
{
	local nMission = ScriptCoopMissionGetMissionNumber( );

	m_nWaveNumber = m_MissionManager.GetWaveNumber();

	// fire an output based on the wave number
	EntFire( "@case_completewave_"+nMission, "InValue", m_nWaveNumber+"", 0 ); 

	if ( nMission == 1 )
	{
		if ( m_nWaveNumber == 4 )
		{
			EntFire( "door_wave_01b", "Close", "", 0 );
			EntFire( "door_wave_01b", "Lock", "", 0 );
			EntFire( "door_wave_01", "Close", "", 0 );
			EntFire( "door_wave_01", "Lock", "", 0 );
			//EntFire( "gate01-rl_gate01_close", "Trigger", "", 0 );
			EntFire( "mission01_hostage_rescue_zone", "Enable", "", 0 );	
		}
	}
}

function SpawnNextWave( nEnemiesToSpawnNextWave )
{
	// this calls the function in gamerules to set the next wave to spawn on teh next check
	ScriptCoopMissionSpawnNextWave( nEnemiesToSpawnNextWave.tointeger() );

	debugPrint( "-->  SpawnNextWave: nEnemiesToSpawnNextWave = "+nEnemiesToSpawnNextWave );
	debugPrint( "!!!!!!!!SpawnNextWave" );	

	local nMission = ScriptCoopMissionGetMissionNumber( );
	if ( nMission == 3 )
	{
		EntFire( "@coopmission_manager_script", "RunScriptCode", "CoopGiveC4sToCTs()", 0.5 );
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

function RespawnPlayers()
{
	ScriptCoopMissionRespawnDeadPlayers();
	local nMission = ScriptCoopMissionGetMissionNumber( );
	if ( nMission == 3 && ScriptIsWarmupPeriod() == false && m_bReadyRoomPlayersDeployed == true )
	{
		EntFire( "@coopmission_manager_script", "RunScriptCode", "CoopGiveC4sToCTs()", 0.5 );
	}
}

function CoopGiveC4sToCTs()
{
	ScriptCoopGiveC4sToCTs( m_nMission3C4sNotPlanted );
}

// this is called right before the round resets, so the spawns can be set up properly
function OnResetSpawns() 
{	
//	if ( ScriptIsWarmupPeriod() )
//		return;

	local nMission = ScriptCoopMissionGetMissionNumber( );
	debugPrint( "!!!!!!!!OnResetSpawns: Mission = "+nMission );

	switch ( nMission )
	{
		case 1: 
			InitSpawnsMission01();			
			break;
		case 2:
			InitSpawnsMission02();	
			break;
		case 3:
			InitSpawnsMission03();	
			break;
	} 
}
// this is called when the round resets
function OnLevelReset() 
{
	RoundInitialize();

	local nMission = ScriptCoopMissionGetMissionNumber( );
	debugPrint( "!!!!!!!!OnLevelReset: Mission = "+nMission );
	//debugPrint( "m_nMissionNumberPicked = "+m_nMissionNumberPicked);
	// InitLevelMission();

	ScriptCoopSetBotQuotaAndRefreshSpawns( 0 );
}

function InitLevelMission() 
{
	local nMission = ScriptCoopMissionGetMissionNumber( );

	debugPrint( "!!!!!!!!InitLevelMission: Mission = "+nMission );

	switch ( nMission )
	{
		case 1: 
			InitLevelMission01();			
			break;
		case 2:
			InitLevelMission02();			
			break;
		case 3:
			InitLevelMission03();			
			break;
	}

	m_bMissionSelected = true;
	m_flMissionStartSelectTime = Time();

	EntFire( "fog", "turnon", "", 0 );
	EntFire( "@spawn_ct_*", "SetDisabled", "", 0 );
	EntFire( "@spawn_ct_deploy", "SetEnabled", "", 0.1 );
	EntFire( "@mission_select_box", "Kill", "", 0 );
}

function CollectCoin()
{
	m_nCoinsCollected++;
	ScriptCoopCollectBonusCoin();
}

function PlayDeployRoomIntroScene()
{
	if ( ScriptIsWarmupPeriod() == true )
		return;

	local nRound = ScriptGetRoundsPlayed( );
	debugPrint( "!!----- Rounds Played (nRound) = "+nRound );

	if ( nRound > 6 )
		return;

	if ( nRound >= 3 )
	{
		// play some hints/encouragement
		EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(9017,9018,9019,9020,9021,21) )", 4 );
		return;
	}

	local nMission = ScriptCoopMissionGetMissionNumber( );

	switch ( nMission )
	{
		case 1: 
			EntFire( "@radiovoice","RunScriptCode", "PlayVcd(1)", 5 );		
			break;
		case 2:
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(201)", 4 );	
			break;
		case 3:
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(301)", 4 );		
			break;
	}		
}

function PlayDeployedScene()
{
	local nRound = ScriptGetRoundsPlayed( );
	debugPrint( "!!----- Rounds Played (nRound) = "+nRound );

	if ( nRound > 6 )
		return;

	if ( nRound >= 3 )
	{
		// play some hints/encouragement
		EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(41,42,9023,9024,43,0) )", 8 );
		return;
	}

	local nMission = ScriptCoopMissionGetMissionNumber( );

	switch ( nMission )
	{
		case 1: 
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(2)", 12 );
			break;
		case 2:
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(202)", 9 );
			break;
		case 3:
			EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(302)", 5 );	
			break;
	}		
}

///////////////////////////////
/////// MISSION 1
///////////////////////////////
function InitSpawnsMission01()
{
	EntFire( "enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "enemygroup_01", "SetEnabled", "", 0.1 );

	EntFire( "@spawn_ct_*", "SetDisabled", "", 0 );
	EntFire( "@spawn_ct_deploy", "SetEnabled", "", 0.1 );

	EntFire( "mission01_spawns_template", "ForceSpawn", "", 0.1 );

	EntFire( "worldspawn", "AddContext", "coopmission:1", 1 );	
}
function InitLevelMission01()
{
	debugPrint( "!!!!InitMission:  01" );
	EntFire( "@relay_night_deploy_room", "Trigger", "", 0 );

	EntFire( "helicopter_start_sound", "PlaySound", "", 0 );

	EntFire( "func_bomb_target", "Kill", "", 0 );
	EntFire( "rain", "Kill", "", 0 );
	EntFire( "puddle_models", "Kill", "", 0 );
	EntFire( "@vent_exit_blocker", "Kill", "", 0 );
	EntFire( "cc_night_clear", "Disable", "", 0 );
	
	EntFire( "door_wave_01", "Lock", "", 1 );	
	EntFire( "gate01-rl_gate01_open", "Trigger", "", 1 );
	EntFire( "mission01_entities_template", "ForceSpawn", "", 1 );
	
	EntFire( "mission01_hostage_rescue_zone", "Disable", "", 1.25 );

	// soundscapes init
	EntFire( "ss_for_dawn", "Disable", "", 1 );	
	EntFire( "ss_sniperalley_m2", "Disable", "", 1 );
	EntFire( "ss_m2", "Disable", "", 1 );		

	//EntFire( "prop_apc_ready", "Kill", "", 0 );	

	// weapons not allowed
	EntFire( "pr_bizon", "Kill", "", 0 ) ;
	EntFire( "pr_famas", "Kill", "", 0 );
	EntFire( "pr_galilar", "Kill", "", 0 );
	EntFire( "pr_xm1014", "Kill", "", 0 );
	EntFire( "pr_mag7", "Kill", "", 0 );
	EntFire( "pr_deagle", "Kill", "", 0 );
	EntFire( "pr_revolver", "Kill", "", 0 );
	EntFire( "pr_p250", "Kill", "", 0 );

	EntFire( "pr_revolver", "Disable", "", 0 );

	PlayDeployRoomIntroScene();

	EntFire( "@coopmission_manager_script", "RunScriptCode", "GetKincaideHostageHandle()", 2 );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 4 );
}
function GetKincaideHostageHandle()
{
	// get the hostage here
	m_hKincaideHostageHandle <- Entities.FindByName(null, "mission01_hostage");
}
function WaveCompleted1( nWaveNum )
{
	debugPrint( "!!!!WaveCompleted1:  nWaveNum = "+nWaveNum );

	if ( nWaveNum == 1 )
	{
		EntFire( "enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "enemygroup_02", "SetEnabled", "", 0.1 );

		EntFire( "@spawn_ct_startingpoint", "SetEnabled", "", 0 );

		// we reroute it because we get a built in delay system
		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 1 );

		EntFire( "door_wave_01", "Unlock", "", 2 );
		EntFire( "door_wave_01b", "Unlock", "", 2 );
		EntFire( "door_wave_01b", "SetGlowEnabled", "", 2.1 );
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(3)", 1 );

		// disable the hostage zone until later
		EntFire( "hostagezone_m1", "Disable", "", 0 );		
	}
	else if ( nWaveNum == 2 )
	{
		EntFire( "enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "enemygroup_03", "SetEnabled", "", 0.1 );

		EntFire( "@spawn_ct_startingpoint", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_maingate", "SetEnabled", "", 0.1 );

		// we reroute it because we get a built in delay system
		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 1 );

		EntFire( "door_silo_L", "Unlock", "", 2 );
		EntFire( "door_silo_R", "Unlock", "", 2 );
		EntFire( "door_silo_Main", "Unlock", "", 2 );
		EntFire( "door_silo_Main", "SetGlowEnabled", "", 2.1 );	
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(4)", 1 );
	}
	else if ( nWaveNum == 3 )
	{
		EntFire( "enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "enemygroup_04", "SetEnabled", "", 0.1 );

		EntFire( "@spawn_ct_maingate", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_entranceroom", "SetEnabled", "", 0.1 );

		EntFire( "door_hostage_01", "Unlock", "", 2 );
		EntFire( "door_hostage_01", "SetGlowEnabled", "", 2.1 );
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(5)", 1 );	

		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );
	}
	else if ( nWaveNum == 4 )
	{
		EntFire( "enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "enemygroup_05", "SetEnabled", "", 0.1 );

		EntFire( "@spawn_ct_hostageroom", "SetDisabled", "", 0 );	
		EntFire( "@spawn_ct_entranceroom", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_clinkerroom", "SetEnabled", "", 0.1 );

		// we reroute it because we get a built in delay system
		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 1 );

		EntFire( "door_sniperalley_01", "Unlock", "", 2 );
		EntFire( "door_sniperalley_01", "SetGlowEnabled", "", 2.1 );	

		EntFire( "ss_for_night", "Disable", "", 1 );
		EntFire( "ss_for_dawn", "Enable", "", 1 );
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(7)", 1 );
	}
	else if ( nWaveNum == 5 )
	{
		EntFire( "enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "enemygroup_06", "SetEnabled", "", 0.1 );
		// kick two bots to prepare for the 3 spawning when the gate opens

		EntFire( "@spawn_ct_clinkerroom", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_sniperend", "SetEnabled", "", 0 ); 

		EntFire( "gate02-rl_gate_enable_coop_buttons", "Trigger", "", 0 );

		// respawn the CTs
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(8)", 1 );
	}
	else if ( nWaveNum == 6 )
	{
		EntFire( "enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "enemygroup_forest_hunt", "SetEnabled", "", 0.1 );

		EntFire( "@spawn_ct_sniperend", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_maingate", "SetEnabled", "", 0 ); 

		EntFire( "tr_callchopper_m1", "Enable", "", 0.1 );

		// respawn the CTs
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );
 
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(9)", 0 );
	}
}

function LookAtTrainPlans()
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(24)", 0 );
}

function LookAtTents()
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(23)", 0 );
}

function FirstEnterHostageRoom()
{
	local nMission = ScriptCoopMissionGetMissionNumber( );
	if ( nMission != 1 )
		return;

	EntFire( "@spawn_ct_*", "SetDisabled", "", 0 );
	EntFire( "@spawn_ct_entranceroom", "SetDisabled", "", 0 );
	EntFire( "@spawn_ct_hostageroom", "SetEnabled", "", 0.1 ); 

	// this refreses the CT spawn points so they don't accidentally spawn in a spawn point that is not in the hostage room
	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayers()", 0.5 );

	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(26)", 0 );
}

function PickedUpHostageMission01()
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(14)", 0 );
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(6)", 2 );	

	EntFire( "worldspawn", "AddContext", "gothostage:1", 1 );
}

function UseExitDoorToHostageRoom()
{
	if ( m_flNextLockHostageDoorUseTime <= Time() )
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(39)", 1.5 );

	m_flNextLockHostageDoorUseTime = Time() + 10;
}

function EnterVentMission01()
{
	local nMission = ScriptCoopMissionGetMissionNumber( );
	if ( nMission != 1 )
		return;

	// when one of the players enters the vent for the first time
	EntFire( "@relay_early_morning", "Trigger", "", 2 );
	
	if ( m_hKincaideHostageHandle.GetScriptScope().CheckIsBeingCarried() )
	{
		EntFire( "mission01_hostage","RunScriptCode", "StartStory01()", 0 );
		EntFire( "tgr_host_vent","Kill", "", 0 );	
	}
	else
	{
		NagForKincaide( 0, 30 );
	}

	// we reroute it because we get a built in delay system
	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 1 );
	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 1 );
}

function NagForKincaide( flLineDelay, flNextNagDelay )
{
	if ( m_nextNoKincaideNag < Time() )
	{
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(10)", flLineDelay );	
		m_nextNoKincaideNag = Time() + flNextNagDelay;
	}
}

function OpenedLastCoopGateMission01()
{
	local nMission = ScriptCoopMissionGetMissionNumber( );
	if ( nMission != 1 )
		return;

	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 3 )", 0 );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 0 );
}

function OpenedCoopGate1()
{

//	if ( m_nWaveNumber < 5 )
//		return;
}

function CallChopperTriggerM01()
{
	local nMission = ScriptCoopMissionGetMissionNumber( );
	if ( nMission != 1 )
		return;

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 0 );

	if ( m_hKincaideHostageHandle.GetScriptScope().CheckIsBeingCarried() )
	{
		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 1 );
		SendToConsoleServer( "mp_randomspawn_los 1" );
		SendToConsoleServer( "mp_randomspawn_dist 1000" );
		ScriptCoopSetBotQuotaAndRefreshSpawns( 5 );
		SendToConsoleServer( "mp_use_respawn_waves 1" );
		SendToConsoleServer( "mp_respawnwavetime_t 3" ); 

		EntFire( "@coopmission_manager_script", "RunScriptCode", "CallChopperM01()", 30 );

		// sixty seconds!
		EntFire( "@radiovoice","RunScriptCode", "PlayVcd(31)", 6 );

		// kill trigger
		EntFire( "tr_callchopper_m1", "Kill", "", 0 );	
	}
	else
	{
		NagForKincaide( 0, 10 );
	}
}

function CallChopperM01()
{
	// 30 seconds!
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd(32)", 1 );
	// 15 seconds!
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd(33)", 31 );
	// 5 seconds!
	//EntFire( "@radiovoice","RunScriptCode", "PlayVcd(34)", 45 );
	// chopper here!
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd(12)", 46 );

	EntFire( "trk_fake_chopper_1", "StartForward", "", 35 );	
	EntFire( "hostagezone_m1", "Enable", "", 54 );	
	EntFire( "Chopper_arrive_m1", "Enable", "", 36 );
	EntFire( "Chopper_arrive_m1", "SetAnimation", "helicopter_coop_hostagepickup_flyin", 35 );			
	EntFire( "Chopper_arrive_m1", "SetDefaultAnimation", "helicopter_coop_hostagepickup_idle", 49 );
	EntFire( "prt_copterroto_pickup_m1", "Start", "", 47 );	
	 
	EntFire( "helicopter_sound_pickup", "SetParent", "trn_fake_chopper_m1", 0 );
	//EntFire( "helicopter_sound_pickup", "SetParentAttachment", "strobe_red", 1 ); 
	EntFire( "helicopter_pickup_sound", "PlaySound", "", 33 );
	EntFire( "trn_fake_chopper_m1", "StartForward", "", 35 );
}

///////////////////////////////
/////// MISSION 2
///////////////////////////////
function InitSpawnsMission02()
{
	EntFire( "enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );

	EntFire( "@spawn_ct_*", "SetDisabled", "", 0 );
	EntFire( "m2_enemygroup_01", "SetEnabled", "", 0.1 );
	EntFire( "@spawn_ct_deploy", "SetEnabled", "", 0 );

	EntFire( "mission02_spawns_template", "ForceSpawn", "", 0.1 );

	EntFire( "worldspawn", "AddContext", "coopmission:2", 1 );	
	EntFire( "worldspawn", "AddContext", "completed_office:0", 1 );
}
function InitLevelMission02()
{
	EntFire( "func_bomb_target", "Kill", "", 0 );
	
	m_nPlayersInPCRoomM2 = 0;
	m_nPlayersInElevatorM2 = 0;

	debugPrint( "!!!!InitMission:  02" );
	 
	EntFire( "@relay_night_deploy_room", "Trigger", "", 0 );

	// we put the coin in here
	EntFire( "door_bomb01", "Unlock", "", 0 );
	
	EntFire( "mission01_hostage_rescue_zone", "Kill", "", 0 );
	EntFire( "br_brush_blockers", "UnblockNav", "", 1 );
	EntFire( "@sniperalley_gate_navblocker", "UnblockNav", "", 1 );

	EntFire( "cc_night_clear", "Kill", "", 0 );

	 // soundscapes init
	EntFire( "ss_m2_r_heavy", "Disable", "", 1 );	
	EntFire( "ss_sniperalley_m1", "Disable", "", 1 );	
	EntFire( "ss_m3", "Disable", "", 1 );	

	//EntFire( "prop_chop_ready", "Kill", "", 0 );

	// weapons not allowed
	// NONE

	EntFire( "mission02_entities_template", "ForceSpawn", "", 1 );

	PlayDeployRoomIntroScene();

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 4 );
}
function WaveCompleted2( nWaveNum )
{
	debugPrint( "-------WaveCompleted2( "+nWaveNum+")" );
	if ( nWaveNum == 1 )
	{
		EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m2_enemygroup_02", "SetEnabled", "", 0.1 );
		
		EntFire( "@spawn_ct_sewerentrance", "SetEnabled", "", 0 );

		//EntFire( "sewer_exitdoor_01", "Unlock", "", 2 );
		//EntFire( "sewer_exitdoor_01", "SetGlowEnabled", "", 2.1 );

		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );

		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(204)", 0 );	
	}
	else if ( nWaveNum == 2 )
	{
		EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m2_enemygroup_03", "SetEnabled", "", 0.1 );

		EntFire( "@spawn_ct_sewerentrance", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_drain_up", "SetEnabled", "", 0.1 );

		EntFire( "rain", "alpha", "20", 0 );
		EntFire( "relay_storm_stage_1", "Trigger", "", 0 );

		// we reroute it because we get a built in delay system
		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 1 );
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 2 );

		EntFire( "sewer_exitdoor_01", "Unlock", "", 2 );
		EntFire( "sewer_exitdoor_01", "SetGlowEnabled", "", 2.1 );	
	}
	else if ( nWaveNum == 3 )
	{
		EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m2_enemygroup_04", "SetEnabled", "", 0.1 );

		// we reroute it because we get a built in delay system
		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 2 )", 1 );

		EntFire( "sniperalley_fencedoor01-door", "Unlock", "", 2 );
		EntFire( "sniperalley_fencedoor01-fenceprop", "SetGlowEnabled", "", 2.1 );	
	
		EntFire( "relay_storm_stage_2", "Trigger", "", 0 );
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(219)", 0 );
	}
	else if ( nWaveNum == 4 )
	{
		EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m2_enemygroup_04b", "SetEnabled", "", 0.1 );
				 
		EntFire( "@spawn_ct_drain_up", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_clinkerroom", "SetEnabled", "", 0.1 );

		EntFire( "@buttonprop_gate_alley_m2", "SetGlowEnabled", "", 1 ); 
		EntFire( "@button_gate_alley_m2", "Unlock", "", 1 ); 

		EntFire( "@radiovoice","RunScriptCode", "PlayVcd(220)", 1 );

		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );

		EntFire( "relay_storm_stage_4", "Trigger", "", 6 );
	}
	else if ( nWaveNum == 5 )
	{
		EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m2_enemygroup_05", "SetEnabled", "", 0.1 );

		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(206)", 1 );
				 
		// we reroute it because we get a built in delay system
		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 6 )", 1 );

		EntFire( "gate04-rl_gate_enable_coop_buttons", "Trigger", "", 1 );
	}
	else if ( nWaveNum == 6 )
	{
		EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m2_enemygroup_06", "SetEnabled", "", 0.1 );

		EntFire( "PCHouseFenceDoor-door", "Unlock", "", 2 );
		EntFire( "PCHouseFenceDoor-fenceprop", "SetGlowEnabled", "", 2.1 );	
		
		// this enables the trigger that detects whether both players are in the room
		// if both players are not in the room, the computer is not enabled for use
		// maybe have a line about this letting the players knbow what theyre supposed to do?
		EntFire( "@trg_pc_coop", "Enable", "", 0 );
		
		// we reroute it because we get a built in delay system
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );

		EntFire( "@matmod_PC_screen", "StartAnimSequence", "014 014 1 0", 0.0 );
	}	
	else if ( nWaveNum == 7 )
	{		
		EntFire( "@computer", "SetGlowEnabled", "", 0.0 );		 
		EntFire( "@computer_button", "Unlock", "", 0.0 );	
		m_hComputerHandle.EmitSound( SND_PC_WAITING_FOR_PRESS );

		EntFire( "@matmod_PC_screen", "StartAnimSequence", "013 013 1 0", 0.0 );
		ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_Thumb2Ready" );

		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(213)", 0 );

		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayers()", 1 );
	}
	else if ( nWaveNum == 8 )
	{
		// relay
		//EntFire( "@rl_resume_ele", "Disabled", "", 0 );
	 
		//EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
		//EntFire( "m2_enemygroup_08", "SetEnabled", "", 0.1 );

		EntFire( "@rl_enable_ele_button", "Trigger", "", 0 );

		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayers()", 1 );

		//You're almost out of there…the choppers waiting for you on the roof.
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(218)", 1 );	
	}
	else if ( nWaveNum == 9 )
	{

	}
	else if ( nWaveNum == 10 ) 
	{ 
		// ?????
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(216)", 0 );
	}
}

function SpawnSewerUpperMission2()
{
	// we reroute it because we get a built in delay system
	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 4 )", 0.5 );
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(203)", 0.0 );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 0 );
}

function OpenBothSewerDoorsMission2()
{
	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 0.5 );
}

function PressAlleyGateButtonM2()
{
	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 1 );
	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 1.5 );
}

function OpenGateM2()
{
	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 0 );
}

function EnterPCBuildingMission02()
{
	// when the first player first enters the PC building
	//Once we start downloading their data they'll know exactly where you are: stay close and watch each other's backs.  Good luck.
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(217)", 0 );
}

function PressedComputerMission02()
{
	m_nTimesComputerPressed++;
	EntFire( "@computer", "SetGlowDisabled", "", 0 );
	EntFire( "@computer_button", "Lock", "", 0.0 );		

	if ( m_nTimesComputerPressed == 1 )
		PressedComputerMission02_1();
	else if ( m_nTimesComputerPressed == 2 )
		PressedComputerMission02_2();
	if ( m_nTimesComputerPressed == 3 )
		PressedComputerMission02_3();

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 0 );
}

function PressedComputerMission02_1()
{
	EntFire( "@spawn_ct_clinkerroom", "SetDisabled", "", 0 );
	EntFire( "@spawn_ct_pcroom", "SetEnabled", "", 0 );
	 
	EntFire( "rain", "alpha", "0", 0 );

	EntFire( "@trg_pc_coop", "Kill", "", 0 );
	EntFire( "gate04-rl_gate01_close", "Trigger", "", 0 );
	EntFire( "PCHouseFenceDoor-door", "Close", "", 0 );
	EntFire( "PCHouseFenceDoor-door", "Lock", "", 0.1 );

	m_hComputerHandle.EmitSound( SND_PC_INSERT_STICK );
	m_hComputerHandle.EmitSound( SND_PC_PRESS );

	ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_ThumbInsert"	 );

	EntFire ( "@radiovoice", "RunScriptCode", "PlayVcd(210)", 0.25 );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "PressedComputerMission02_1_StartHoldout()", 2.0 );	
}

function PressedComputerMission02_1_StartHoldout()
{
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "000 000 1 0", 0.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "001 001 1 0", 2.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "002 002 1 0", 5.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "003 003 1 0", 9.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "004 004 1 0", 11.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "005 005 1 0", 14.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "006 006 1 0", 17.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "007 007 1 0", 19.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "008 008 1 0", 22.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "009 009 1 0", 24.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "010 010 1 0", 26.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "011 011 1 0", 29.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "012 012 1 0", 35.0 );
	
	EntFire( "@coopmission_manager_script", "RunScriptCode", "PressedComputerMission02_2_Ready()", 35.0 );	

	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 3 )", 0.35 );
	SendToConsoleServer( "mp_randomspawn_los 1" );
	SendToConsoleServer( "mp_randomspawn_dist 200" );
	SendToConsoleServer( "mp_use_respawn_waves 1" );
	SendToConsoleServer( "mp_respawnwavetime_t 4" );
}

function PressedComputerMission02_2_Ready()
{
	EntFire( "@computer", "SetGlowEnabled", "", 0.0 );		 
	EntFire( "@computer_button", "Unlock", "", 0.0 );	
	m_hComputerHandle.EmitSound( SND_PC_WAITING_FOR_PRESS );	

	ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_ThumbReady" );
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(211)", 0 );
}

function PressedComputerMission02_2()
{
	m_hComputerHandle.EmitSound( SND_PC_REMOVE_STICK );	
	m_hComputerHandle.EmitSound( SND_PC_PRESS );

	ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_Thumb2Insert" );
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(212)", 0 );

	EntFire( "@matmod_PC_screen", "StartAnimSequence", "000 000 1 0", 0.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "001 001 1 0", 3.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "002 002 1 0", 7.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "003 003 1 0", 12.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "004 004 1 0", 15.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "005 005 1 0", 18.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "006 006 1 0", 21.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "007 007 1 0", 24.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "008 008 1 0", 27.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "009 009 1 0", 29.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "010 010 1 0", 32.0 );
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "011 011 1 0", 35.0 );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "PressedComputerMission02_3_Ready()", 35.0 );	
}

function PressedComputerMission02_3_Ready()
{
	SendToConsoleServer( "mp_randomspawn_los 0" );
	SendToConsoleServer( "mp_use_respawn_waves 2" );
	SendToConsoleServer( "mp_respawnwavetime_t 5" );
}

function PressedComputerMission02_3()
{
	EntFire( "@matmod_PC_screen", "StartAnimSequence", "014 014 1 0", 0.0 );

	ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_Thumb2Retrieved" );

	EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m2_enemygroup_07", "SetEnabled", "", 0.1 );

	EntFire( "computerhouse_exitdoor01", "Unlock", "", 1 );
	EntFire( "computerhouse_exitdoor01", "SetGlowEnabled", "", 1.0 );	
 
	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 1 );	
		
	EntFire( "ss_m2_r_heavy", "Enable", "", 2 );	
	EntFire( "ss_m2_r_med", "Disable", "", 2 );	 

	//You got what we needed.  Make your way to a rooftop, we'll extact you hot.
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(208)", 1 );

	EntFire( "worldspawn", "AddContext", "completed_office:1", 1 );
}

function EnterPCRoomM2() 
{
	m_nPlayersInPCRoomM2++;

	if ( m_nPlayersInPCRoomM2 >= TOTAL_PLAYERS_PLAYING )
	{
		EntFire( "@computer", "SetGlowEnabled", "", 0.0 );		 
		EntFire( "@computer_button", "Unlock", "", 0.0 );	
	}
}

function ExitPCRoomM2() 
{
	m_nPlayersInPCRoomM2--; 

	if ( m_nPlayersInPCRoomM2+1 >= TOTAL_PLAYERS_PLAYING && m_nPlayersInPCRoomM2 < TOTAL_PLAYERS_PLAYING )
	{
		EntFire( "@computer", "SetGlowDisabled", "", 0.0 );		 
		EntFire( "@computer_button", "Lock", "", 0.0 );	
	}
}

function OpenExitPCDoor()
{
	EntFire( "relay_storm_stage_7", "Trigger", "", 0 );	
	EntFire( "@relay_stormy", "Trigger", "", 0 );

	EntFire( "@chopper_mission2", "EnableDraw", "", 0 );
	EntFire( "@chopper_mission2", "SetAnimation", "helicopter_coop_towerhover_idle", 1 ); 
	EntFire( "snd_chopper_tower", "PlaySound", "", 0 );
}

function ReachedEndMission02()
{
	EntFire( "@game_round_end", "EndRound_CounterTerroristsWin", "0", 0.0 );	
}

function EnterTowerElevatorM2() 
{
	m_nPlayersInElevatorM2++; 

	if ( m_nPlayersInElevatorM2 >= TOTAL_PLAYERS_PLAYING )
	{
		EntFire( "@rl_tower_ele_start", "Trigger", "", 0 );	
		EntFire( "rain", "alpha", "0", 0 );

		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(222)", 12 );
	}
}

function ExitTowerElevatorM2() 
{
	m_nPlayersInElevatorM2--; 
}

function StopElevatorM2()
{
	EntFire( "@ele_tower_m2", "Stop", "", 0 );

	EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m2_enemygroup_08", "SetEnabled", "", 0.1 );

	EntFire( "@snd_voice_revenge_m2", "PlaySound", "", 1.5 );
	
	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 5 )", 2.5 );	

	EntFire( "@rl_ele_end", "Trigger", "", 4.5 );	
 
	//EntFire( "@rl_resume_ele", "Trigger", "", 1.0 );

	EntFire( "rain", "alpha", "200", 0 );
}

//////////////////////////////////////////////////////////////////////////////////////
/////// MISSION 3
//////////////////////////////////////////////////////////////////////////////////////
//
//                   ,~.
//                ,-'__ `-,
//               {,-'  `. }              ,')
//              ,( a )   `-.__         ,',')~,
//             <=.) (         `-.__,==' ' ' '}
//               (   )                      /
//                `-'\   ,                  )
//                    |  \        `~.      /
//                    \   `._        \    /
//                     \     `._____,'   /
//                      `-.            ,'
//                         `-.      ,-'
//                            `~~~~'
//                            //_||
//                         __//--'/`          hjw
//                       ,--'/`  '
//                          '
//
//////////////////////////////////////////////////////////////////////////////////////

function InitSpawnsMission03()
{
	EntFire( "enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m2_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m4_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m3_forest_spawn_end", "SetDisabled", "", 0 );

	EntFire( "br_brush_blockers", "Enable", "", 0 );

	EntFire( "@spawn_ct_*", "SetDisabled", "", 0 );
	EntFire( "m3_enemygroup_01", "SetEnabled", "", 0.01 );
	EntFire( "@spawn_ct_deploy", "SetEnabled", "", 0.01 )

	EntFire( "mission03_spawns_template", "ForceSpawn", "", 0.1 );

	EntFire( "worldspawn", "AddContext", "coopmission:3", 1 );	
}
function InitLevelMission03()
{
	m_nPlayersInApcGarage = 0;
	m_nMission3C4sNotPlanted = MAX_C4S_FOR_MISSION_3;

	// weapons
	// ALL

	debugPrint( "!!!!InitMission:  03" );
	EntFire( "@relay_night_deploy_room", "Trigger", "", 0 );
	EntFire( "mission01_hostage_rescue_zone", "Kill", "", 0 );	

	EntFire( "rain", "alpha", "0", 0 );
	EntFire( "cc_night_clear", "Kill", "", 0 );

	EntFire( "ss_m2_*", "Disable", "", 0 );	
	EntFire( "ss_for_night", "Disable", "", 0 );
	EntFire( "ss_sniperalley_m2", "Disable", "", 1 );
	EntFire( "ss_m3", "Enable", "", 1 );	

	// seagulls!
	EntFire( "m3_seagulls", "Enable", "", 1 );	

	EntFire( "tower_ladderdoors", "Lock", "", 1 );	
	EntFire( "tower_ladderdoors2", "Lock", "", 1 );		 

	EntFire( "br_brush_blockers", "BlockNav", "", 1 );

	EntFire( "mission03_entities_template", "ForceSpawn", "", 1 );

	PlayDeployRoomIntroScene();

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 4 );
}
function WaveCompleted3( nWaveNum )
{
	if ( nWaveNum == 1 )
	{
		//EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
		//EntFire( "m3_enemygroup_02", "SetEnabled", "", 0.1 );

		EntFire( "@spawn_ct_raft", "SetEnabled", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(308)", 0 );

		EntFire( "door_apc_garage_m3", "Unlock", "", 1 );
		EntFire( "door_apc_garage_m3", "SetGlowEnabled", "", 1 );

		// respawn the CTs
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );	
	}
	else if ( nWaveNum == 2 )
	{
		EntFire( "gate05-rl_gate_enable_coop_buttons", "Trigger", "", 1 ); 
		EntFire( "TowerGateM3-door", "Unlock", "", 1 );
		EntFire( "TowerGateM3-fenceprop", "SetGlowEnabled", "", 1 );	

		EntFire( "@spawn_ct_raft", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_apc", "SetEnabled", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(318)", 0 );
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(325)", 5 );
		EntFire ( "@valeria","RunScriptCode", "PlayVcd(350)", 30 );

		// respawn the CTs
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );	

		SetCanNagWaitingAtGateM3( true );

		ResetSpawnWaves();
	}
	else if ( nWaveNum == 3 )
	{
		EntFire( "gate04-rl_gate_enable_coop_buttons", "Trigger", "", 1 ); 

		// respawn the CTs
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );	

		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(335)", 2 );

		SetCanNagWaitingAtGateM3( true );

		ResetSpawnWaves();
	}
	else if ( nWaveNum == 4 )
	{
		EntFire( "gate03-rl_gate_enable_coop_buttons", "Trigger", "", 1 ); 		

		// respawn the CTs
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );
		
		SetCanNagWaitingAtGateM3( true );
		
		ResetSpawnWaves();	
	}
	else if ( nWaveNum == 5 )
	{
		EntFire( "gate01-rl_gate_enable_coop_buttons", "Trigger", "", 1 ); 
		EntFire ( "@valeria","RunScriptCode", "PlayVcd(352)", 0 );

		SetCanNagWaitingAtGateM3( true );

		EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
		//EntFire( "m3_enemygroup_06", "SetEnabled", "", 0.1 );
		// we reroute it because we get a built in delay system
		//EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 3 )", 2  );

		// respawn the CTs
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStart()", 1 );

		ResetSpawnWaves();
	}
	else if ( nWaveNum == 6 )
	{
		// respawn the CTs
		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayers()", 2 );	

		SetCanNagWaitingAtGateM3( true );
	}
}

function SetCanNagWaitingAtGateM3( bCanNag )
{
	EntFire ( "script_APC","RunScriptCode", "SetNextgateNagDelay(10)", 0 );
	m_bCanNagWaitingAtGateM3 = bCanNag;
}

function CanNagWaitingAtGateM3()
{
	return m_bCanNagWaitingAtGateM3;
}

function ReachedEndMission03()
{
	EntFire( "@game_round_end", "EndRound_CounterTerroristsWin", "2", 0.0 );	
}

function ApcGaragePlayerEnter()
{
	m_nPlayersInApcGarage = m_nPlayersInApcGarage + 1;
	if ( m_nPlayersInApcGarage >= TOTAL_PLAYERS_PLAYING )
	{
		EntFire( "@tr_apcgarage", "Kill", "", 0 );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(309)", 0 );
		EntFire ( "@valeria","RunScriptCode", "PlayVcd(351)", 23 );

		EntFire( "door_apc_garage_m3", "Close", "", 0 );
		EntFire( "door_apc_garage_m3", "Lock", "", 0 );	
		
		m_flApcGarageNextNag = -1;	

		EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 0 );
	}
	else
	{
		m_flApcGarageNextNag = Time() + 6;
	}
}

function ApcGarageDoorOpen()
{
	EntFire( "@door_apcgarage", "Open", "", 0.5 );

	EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
	EntFire( "m3_enemygroup_02", "SetEnabled", "", 0.1 );
	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 6 )", 0.5 );

	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(359)", 1 );

	EntFire ( "script_APC","RunScriptCode", "PlayEngineStartSound()", 0 );

	EntFire( "@rl_start_apc", "Trigger", "", 3.5 );	
	// TODO slowly speed up APC here

	EntFire ( "@valeria","RunScriptCode", "PlayVcd(355)", 23 );
}

function ApcGaragePlayerExit()
{
	m_nPlayersInApcGarage = m_nPlayersInApcGarage - 1;

	//EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(322)", 0 );
}

function StartHoldoutGate5()
{

}

function OpenBombDoor1()
{
	// open
	EntFire( "door_bomb01", "Unlock", "", 1 );
	
	// glow the c4
	//EntFire( "@bomb_barrel1", "SetGlowEnabled", "", 0.5 );
	EntFire( "@c4plant_1", "SetGlowEnabled", "", 0.5 );

	EntFire( "@spawn_ct_apc", "SetDisabled", "", 0 );
	EntFire( "@spawn_ct_gate05", "SetEnabled", "", 0.1 );	
}

function OpenBombDoor2()
{
	// open
	EntFire( "door_bomb02", "Kill", "", 0 );
	//EntFire( "door_bomb02", "Unlock", "", 1 );
	//EntFire( "door_bomb02", "SetGlowEnabled", "", 1 );
	// glow the c4
	EntFire( "@c4plant_2", "SetGlowEnabled", "", 0.1 );

	EntFire( "@spawn_ct_apc", "SetDisabled", "", 0 );
	EntFire( "@spawn_ct_gate05", "SetEnabled", "", 0.1 );	
}

function PlantedMission3Bomb1()
{
	m_nMission3C4sNotPlanted = m_nMission3C4sNotPlanted-1;

	EntFire ( "@valeria","RunScriptCode", "PlayVcd(353)", 3 );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayers()", 1 );	

	SendToConsoleServer( "mp_use_respawn_waves 2" );
	SendToConsoleServer( "mp_respawnwavetime_t 5" );

	EntFire ( "@c4plant_1","SetGlowDisabled", "", 2 );	
	
	m_flPlantFirstBombNag = -1;	
}

function PlantedMission3Bomb2()
{
	m_nMission3C4sNotPlanted = m_nMission3C4sNotPlanted-1;

	EntFire ( "@valeria","RunScriptCode", "PlayVcd(320)", 7 );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayers()", 1 );	

	SendToConsoleServer( "mp_use_respawn_waves 2" );
	SendToConsoleServer( "mp_respawnwavetime_t 5" );

	EntFire ( "@c4plant_2","SetGlowDisabled", "", 2 );	
}

function EnableSecondSpawnsBomb1M3()
{
	// enable a second subset slightly after the initial set has spawned
	EntFire( "m3_enemygroup_03h", "SetDisabled", "", 0 );
	EntFire( "m3_enemygroup_03b", "SetEnabled", "", 0 );	

	SendToConsoleServer( "mp_randomspawn_los 1" );
	SendToConsoleServer( "mp_randomspawn_dist 1400" );
	SendToConsoleServer( "mp_use_respawn_waves 1" );
	SendToConsoleServer( "mp_respawnwavetime_t 14" );

	EntFire( "@coopmission_manager_script", "RunScriptCode", "CoopSetBotQuotaAndRefreshSpawns( 3 )", 0.5 );
	EntFire( "@coopmission_manager_script", "RunScriptCode", "CoopMissionSetNextRespawnIn( 14 )", 0.6 );
}

function EnableSecondSpawnsBomb2M3()
{
	// enable a second subset slightly after the initial set has spawned
	EntFire( "m3_enemygroup_04u", "SetDisabled", "", 0 );
	EntFire( "m3_enemygroup_04", "SetEnabled", "", 0 );

	SendToConsoleServer( "mp_randomspawn_los 1" );
	SendToConsoleServer( "mp_randomspawn_dist 1400" );
	SendToConsoleServer( "mp_use_respawn_waves 1" );
	SendToConsoleServer( "mp_respawnwavetime_t 14" );	

	EntFire( "@coopmission_manager_script", "RunScriptCode", "CoopSetBotQuotaAndRefreshSpawns( 4 )", 0.5 );
	EntFire( "@coopmission_manager_script", "RunScriptCode", "CoopMissionSetNextRespawnIn( 14 )", 0.6 );
}

function ImogenCalloutBomb01()
{
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(332)", 0 );
	
	m_flPlantFirstBombNag = Time() + RandomInt(24, 30);
}

function SpawnEnemiesM3( nGate )
{
	// STOP CTs from respawning here always!
	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 0 );

	if ( nGate == 5 )
	{
		EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m3_enemygroup_03", "SetEnabled", "", 0.1 );
		EntFire( "m3_enemygroup_03h", "SetEnabled", "", 0.1 );

		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 3 )", 0.2  );
		EntFire( "@coopmission_manager_script", "RunScriptCode", "EnableSecondSpawnsBomb1M3()", 2  );	

		EntFire( "@coopmission_manager_script", "RunScriptCode", "OpenBombDoor1()", 0.5 );
		//

		SetCanNagWaitingAtGateM3( false );

		EntFire( "TowerGateM3-door", "Close", "", 0 );
		EntFire( "TowerGateM3-door", "Lock", "", 0.1 );
		EntFire( "TowerGateM3-fenceprop", "SetGlowDisabled", "", 0.1 );	

		EntFire( "tower_ladderdoors", "Unlock", "", 0 );	
		EntFire( "tower_ladderdoors", "Open", "", 0.1 );	
		EntFire( "tower_ladderdoors2", "Unlock", "", 0 );	
		EntFire( "tower_ladderdoors2", "Open", "", 0.1 );	
	}
	else if ( nGate == 4 )
	{
		EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m3_enemygroup_04u", "SetEnabled", "", 0.1 );
		// we reroute it because we get a built in delay system

		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 4 )", 0.2  );
		EntFire( "@coopmission_manager_script", "RunScriptCode", "EnableSecondSpawnsBomb2M3()", 5  );

		EntFire( "@coopmission_manager_script", "RunScriptCode", "OpenBombDoor2()", 0.5 );
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(334)", 12 );

		EntFire( "mic_v_2", "Enable", "", 0 );	

		SetCanNagWaitingAtGateM3( false );

		EntFire ( "@c4plant_1","SetGlowDisabled", "", 0 );		
	}
	else if ( nGate == 3 )
	{
		EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m3_enemygroup_05", "SetEnabled", "", 0.1 );
		EntFire( "m3_enemygroup_05h", "SetEnabled", "", 0.1 );
		
		// we reroute it because we get a built in delay system
		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 6 )", 0.2 );

		EntFire( "m3_enemygroup_05h", "SetDisabled", "", 0.5 );

		EntFire( "mic_v_1", "Disable", "", 0 );	
		EntFire( "mic_v_3", "Enable", "", 0 );	

		EntFire( "gate05-rl_gate01_close", "Trigger", "", 0.5 );

		//ent_fire gate01-rl_gate01_close trigger

		EntFire( "@spawn_ct_*", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_sniperend", "SetEnabled", "", 0.1 );
		
		EntFire ( "door_wave_01b", "Unlock", "", 0 );
		EntFire ( "door_wave_01", "Unlock", "", 0 );
		EntFire ( "door_sniperalley_01", "Unlock", "", 0 );	

		SetCanNagWaitingAtGateM3( false );	

		EntFire ( "@c4plant_2","SetGlowDisabled", "", 0 );		
	}
	else if ( nGate == 2 )
	{
		

		//SetCanNagWaitingAtGateM3( false );
	}
	else if ( nGate == 1 )
	{
		EntFire( "gate03-rl_gate01_close", "Trigger", "", 0 );
		EntFire ( "door_sniperalley_01", "Lock", "", 0 );	
		EntFire ( "door_sniperalley_01", "Close", "", 0.1 );	

		EntFire( "m3_enemygroup_*", "SetDisabled", "", 0 );
		EntFire( "m3_forest_spawn_end", "SetEnabled", "", 0.1 );

		EntFire( "@spawn_ct_sniperend", "SetDisabled", "", 0 );
		EntFire( "@spawn_ct_maingate", "SetEnabled", "", 0 ); 

		// BOOM
		EntFire( "@coopmission_manager_script", "RunScriptCode", "BombExplode1M03()", 5 );	

		EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnNextWave( 6 )", 12 );

		EntFire( "@spawn_ct_maingate", "SetDisabled", "", 10 ); 
		EntFire( "@spawn_ct_m3_forest_1", "SetEnabled", "", 11 );  

		SendToConsoleServer( "mp_randomspawn_los 1" );
		SendToConsoleServer( "mp_randomspawn_dist 1600" );
		SendToConsoleServer( "mp_use_respawn_waves 1" );
		SendToConsoleServer( "mp_respawnwavetime_t 12" ); 

		EntFire( "mic_v_2", "Disable", "", 0 );	

		SetCanNagWaitingAtGateM3( false );
		
		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(354)", 32 );	
	}
}

function ClearedCompound()
{
	// cutting these lines
	//EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(360)", 1 );	 
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(368)", 2 );		

	EntFire( "@spawn_ct_maingate", "SetDisabled", "", 0 ); 
	EntFire( "@spawn_ct_m3_forest_1", "SetEnabled", "", 0.1 );  

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayers()", 1 );	
}	

function CallChopperM03()
{
	EntFire( "trk_fake_chopper_1", "StartForward", "", 20 );		
	EntFire( "Chopper_arrive_m1", "Enable", "", 21 );
	EntFire( "Chopper_arrive_m1", "SetAnimation", "helicopter_coop_hostagepickup_flyin", 20 );			
	EntFire( "Chopper_arrive_m1", "SetDefaultAnimation", "helicopter_coop_hostagepickup_idle", 35 );

	// 30 seconds!
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd(32)", 5 );
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(370)", 7.5 );	

	// 15 seconds!
	EntFire( "@radiovoice","RunScriptCode", "PlayVcd(33)", 18 );
	// 5 seconds!
	//EntFire( "@radiovoice","RunScriptCode", "PlayVcd(34)", 28 );

	EntFire( "prt_copterroto_pickup_m1", "Stop", "", 32 );	
	EntFire( "prt_copterroto_pickup_m1", "Start", "", 32 );	
	 
	EntFire( "helicopter_sound_pickup", "SetParent", "trn_fake_chopper_m1", 0 );
	//EntFire( "helicopter_sound_pickup", "SetParentAttachment", "strobe_red", 1 ); 
	EntFire( "helicopter_pickup_sound", "PlaySound", "", 18 );
	EntFire( "trn_fake_chopper_m1", "StartForward", "", 20 );

	EntFire( "@spawn_ct_m3_forest_1", "SetDisabled", "", 0 ); 
	EntFire( "@spawn_ct_m3_forest_2", "SetEnabled", "", 0.1 );  

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayers()", 1 );	

	EntFire( "tg_exit_m3", "Enable", "", 38 );
}

function BombExplode1M03()
{
	EntFire( "snd_explode_1_a", "PlaySound", "", 0.1 );
	EntFire( "shk_explode_1_a", "StartShake", "", 0.1 );	
	EntFire( "prt_explosion_1", "Stop", "", 0 );
	EntFire( "prt_explosion_1", "Start", "", 0.2 );

	EntFire( "relay_tonemap_flash", "Trigger", "", 0.3 );
	EntFire( "snd_explode_1_b", "PlaySound", "", 1 );
	
	EntFire( "prt_skyboom_4", "Stop", "", 0 );
	EntFire( "prt_skyboom_4", "Start", "", 0.1 );

	EntFire( "prt_skysmoke_1", "Stop", "", 2 );
	EntFire( "prt_skysmoke_1", "Start", "", 2.1 );	

	m_flNextM3Explosion = Time() + 9;
	m_flBothM3BombWentOff = false;

	// why did that goes off?!
	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(345)", 3.25 );	
}

function BombExplode2M03()
{
	// BOOM
	EntFire( "relay_tonemap_flash", "Trigger", "", 0.3 );	
	EntFire( "snd_explode_1_a", "PlaySound", "", 0.1 );
	EntFire( "snd_explode_2_a", "PlaySound", "", 0.1 );
	EntFire( "shk_explode_1_a", "StartShake", "", 0.1 );	
	EntFire( "snd_explode_2_b", "PlaySound", "", 1 );
	EntFire( "prt_explosion_2", "Stop", "", 0 );
	EntFire( "prt_explosion_2", "Start", "", 0.1 );
	
	EntFire( "prt_skyboom_1", "Stop", "", 0 );
	EntFire( "prt_skyboom_1", "Start", "", 0.1 );

	EntFire( "prt_skysmoke_2", "Stop", "", 2 );
	EntFire( "prt_skysmoke_2", "Start", "", 2.1 );

	EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(373)", 6 );	

	m_flNextM3Explosion = Time() + 2;
	m_flBothM3BombWentOff = true;
}

function LeaveCompoundLastStretch()
{

}

function APCReachedEndM3()
{
	m_fDoNextEndNagM3 = Time() + 30.0;
}
//////////////////////////////////////////////////////////////////////////////////////
/////// MISSION 3
//////////////////////////////////////////////////////////////////////////////////////


///////////////////////
// PRE READY ROOM
///////////////////////

function PickMission()
{
	EntFire ( "@fade_pick_mission","Fade", "", 0 );
	EntFire ( "@fade_pick_mission","FadeReverse", "", 1.0 );
	EntFire ( "door_mission_start_room","Unlock", "", 0.5 );
	EntFire ( "door_mission_start_room","Close", "", 0.51 );
	EntFire ( "door_mission_start_room","Lock", "", 0.52 );
	EntFire ( "door_mission_start_room_2","Unlock", "", 1.9  );
	EntFire ( "door_mission_start_room_2","Open", "", 2.0  );
	EntFire ( "door_mission_start_room_2","Lock", "", 2.1  );

	EntFire ( "teleport_room_m1","Enable", "", 0.52 ); 

	// "seal.radio_locknload14"
	// "seal.radio_locknload15"
	// "seal.radio_locknload01"
	// "seal.radio_locknload03"
	// "seal.radio_locknload04"

	m_bMissionSelected = true;

	self.EmitSound( missionSelectConfirmAudio[ RandomInt(0,missionSelectConfirmAudio.len()-1) ] );
}

// mission 1
function Player_Enter_Mission1( ) 
{
	if ( ScriptIsWarmupPeriod() )
		return;
		 
	m_nPlayersWantMission1++;

	//if ( m_nPlayersWantMission1 >= TOTAL_PLAYERS_PLAYING )
	//	Pick_Mission1();
}

function Pick_Mission1()
{
	PickMission();
	EntFire ( "@trigger_enter_mission1","Disable", "", 0 );
	//EntFire ( "teleport_room_m1","Enable", "", 0.52 ); 
	SendToConsoleServer( "mp_coopmission_mission_number 1" );
}

function Player_Leave_Mission1( )
{
	if ( ScriptIsWarmupPeriod() )
		return;

	if ( m_nPlayersWantMission1 > 0 )
		m_nPlayersWantMission1--;

	//if ( m_flMissionStartSelectTime)
} 

// mission 2
function Player_Enter_Mission2( ) 
{
	if ( ScriptIsWarmupPeriod() )
		return;

	m_nPlayersWantMission2++;

	//if ( m_nPlayersWantMission2 >= TOTAL_PLAYERS_PLAYING )
	//	Pick_Mission2();
}

function Pick_Mission2()
{
	PickMission();
	EntFire ( "@trigger_enter_mission2","Disable", "", 0 );
	//EntFire ( "teleport_room_m2","Enable", "", 0.52 );
	SendToConsoleServer( "mp_coopmission_mission_number 2" );
}

function Player_Leave_Mission2( )
{
	if ( ScriptIsWarmupPeriod() )
		return;

	if ( m_nPlayersWantMission2 > 0 )
		m_nPlayersWantMission2--;
} 

// mission 3
function Player_Enter_Mission3( ) 
{
	if ( ScriptIsWarmupPeriod() )
		return;

	m_nPlayersWantMission3++;

	//if ( m_nPlayersWantMission3 >= TOTAL_PLAYERS_PLAYING )
	//	Pick_Mission3();
}

function Pick_Mission3()
{
	PickMission();
	EntFire ( "@trigger_enter_mission3","Disable", "", 0 );
	//EntFire ( "teleport_room_m3","Enable", "", 0.52 );	
	SendToConsoleServer( "mp_coopmission_mission_number 3" );
}

function Player_Leave_Mission3( )
{
	if ( ScriptIsWarmupPeriod() )
		return;

	if ( m_nPlayersWantMission3 > 0 )
		m_nPlayersWantMission3--;
} 

///////////////////////
// READY ROOM
///////////////////////

function ReadyRoomPlayerEnterReady( ) 
{
	if ( ScriptIsWarmupPeriod() )
		return;

	m_nPlayersReadyInReadyRoom++;

	if ( m_nPlayersReadyInReadyRoom >= TOTAL_PLAYERS_PLAYING )
	{
		m_bReadyRoomStartCheckDeploy = true;
		m_fReadyRoomDeployRequestTime = Time() + 3.0;
	}
}

function ReadyRoomPlayerLeaveReady( )
{
	if ( ScriptIsWarmupPeriod() )
		return;

	if ( m_nPlayersReadyInReadyRoom > 0 )
		m_nPlayersReadyInReadyRoom--;

	if ( m_nPlayersReadyInReadyRoom < TOTAL_PLAYERS_PLAYING && m_bReadyRoomPlayersDeployed == false )
	{
		if ( m_bReadyRoomStartCheckDeploy == true )
			ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployCancelled" );

		m_bReadyRoomStartCheckDeploy = false;
		m_fReadyRoomDeployRequestTime = -1;	
	}
} 

function ReadyRoomPlayerEnterReadyHARD( ) 
{
	if ( ScriptIsWarmupPeriod() || m_bReadyRoomPlayersDeployed )
		return;

	m_nPlayersReadyInReadyRoomHARD++;

	if ( m_nPlayersReadyInReadyRoomHARD >= TOTAL_PLAYERS_PLAYING )
	{
		m_bReadyRoomStartCheckDeploy = true;
		m_fReadyRoomDeployRequestTime = Time() + 3.0;

		EntFire ( "@radiovoice","RunScriptCode", "PlayVcd(9016)", 0 );
	}
}

function ReadyRoomPlayerLeaveReadyHARD( )
{
	if ( ScriptIsWarmupPeriod() )
		return;

	if ( m_nPlayersReadyInReadyRoomHARD > 0 )
		m_nPlayersReadyInReadyRoomHARD--;

	if ( m_nPlayersReadyInReadyRoomHARD < TOTAL_PLAYERS_PLAYING && m_bReadyRoomPlayersDeployed == false )
	{
		if ( m_bReadyRoomStartCheckDeploy == true )
			ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_DeployCancelled" );

		m_bReadyRoomStartCheckDeploy = false;
		m_fReadyRoomDeployRequestTime = -1;	
	}
} 

function ReadyRoomDeployPlayers( )
{ 
	if ( ScriptIsWarmupPeriod() || m_bReadyRoomPlayersDeployed == true )
		return;

	debugPrint( "ReadyRoomDeployPlayers: m_nPlayersReadyInReadyRoomHARD = "+m_nPlayersReadyInReadyRoomHARD );
	local nMission = ScriptCoopMissionGetMissionNumber( );

	local bIsHardMode = ( m_nPlayersReadyInReadyRoomHARD == TOTAL_PLAYERS_PLAYING );

	if ( bIsHardMode )
	{
		SendToConsoleServer( "mp_coopmission_bot_difficulty_offset 5" );
	}
	else
	{
		SendToConsoleServer( "mp_coopmission_bot_difficulty_offset 1" );
	}

	EntFire( "@coopmission_manager_script", "RunScriptCode", "StartMissionTimer()", 2.25 );

	if ( nMission == 1 )
	{
		EntFire( "@relay_night_clear", "Trigger", "", 1 );
		EntFire( "helicopter_start_sound", "StopSound", "", 0 );

		EntFire( "teleport_apc_mission", "SetRemoteDestination", "Dest_D", 0 );
		EntFire( "@rl_readyroom_teleport", "Trigger", "", 0 );

		self.EmitSound( SND_DEPLOY_CHOPPER );	

		EntFire( "Chopper_leave_m1", "SetAnimationNoReset", "helicopter_coop_dropoff", 2.25 ); 
		EntFire( "prt_copterroto_m1", "Stop", "", 2 );	
		EntFire( "prt_copterroto_m1", "Start", "", 2.25 );	
		EntFire( "Chopper_leave_m1", "Disable", "", 17 );

		EntFire( "helicopter_sound", "SetParent", "Chopper_leave_m1", 0 );
		EntFire( "helicopter_sound", "SetParentAttachment", "strobe_red", 1 ); 
		EntFire( "helicopter_dropoff_sound", "PlaySound", "", 2 );
		EntFire( "helicopter_dropoff_sound", "FadeOut", "12", 10 );
		
		PlayDeployedScene();

		if ( bIsHardMode )
			SendToConsoleServer( "bot_coop_idle_max_vision_distance 4000" );
		else
			SendToConsoleServer( "bot_coop_idle_max_vision_distance 2600" );

		SendToConsoleServer( "hostage_is_silent 1" );

		// bot_quota needs to be called BEFORE any change in bot number happens
		// this gets around non optimal spawning code
		EntFire( "enemygroup_01", "SetEnabled", "", 0.0 );
		//ScriptCoopSetBotQuotaAndRefreshSpawns( 5 );
		EntFire( "@coopmission_manager_script", "RunScriptCode", "ScriptCoopMissionSpawnFirstEnemies( 5 )", 1 );
	}
	else if ( nMission == 2 )
	{
		EntFire( "@relay_stormy_start", "Trigger", "", 1 );

		EntFire( "teleport_apc_mission", "SetRemoteDestination", "Dest_Mission_2", 0 );
		EntFire( "@rl_readyroom_teleport", "Trigger", "", 0 );

		self.EmitSound( SND_DEPLOY_APC );	
	
		PlayDeployedScene();

		SendToConsoleServer( "bot_coop_idle_max_vision_distance 4000" );

		// bot_quota needs to be called BEFORE any change in bot number happens
		// this gets around non optimal spawning code
		EntFire( "m2_enemygroup_01", "SetEnabled", "", 0.0 );
		EntFire( "@coopmission_manager_script", "RunScriptCode", "ScriptCoopMissionSpawnFirstEnemies( 4 )", 1 );
	}
	else if ( nMission == 3 ) 
	{
		EntFire( "Chopper_leave_m1", "Kill", "", 0 );
		EntFire( "@coopmission_manager_script", "RunScriptCode", "CoopGiveC4sToCTs()", 2.5 );

		EntFire( "@relay_early_morning_apc", "Trigger", "", 1 );
		EntFire( "@sniperalley_gate_blocker", "Open", "", 2 );
		EntFire( "gate02-rl_gate01_open", "Trigger", "", 2 );

		EntFire( "mic_v_1", "Enable", "", 2 );	

		EntFire( "door_silo_R", "Lock", "", 2 );
		EntFire( "door_silo_L", "Lock", "", 2 );	
		EntFire( "door_silo_Main", "Unlock", "", 3 );	
		
		EntFire( "teleport_apc_mission", "SetRemoteDestination", "Dest_Mission_3", 0 );
		EntFire( "@rl_readyroom_teleport", "Trigger", "", 0 );

		self.EmitSound( SND_DEPLOY_BOAT );	

		PlayDeployedScene();

		EntFire ( "@valeria","RunScriptCode", "PlayVcd(307)", 23 );
		
		// my configs aren't being executed....
		SendToConsoleServer( "bot_coop_idle_max_vision_distance 5000" );
		SendToConsoleServer( "mp_buytime 0" );
		SendToConsoleServer( "mp_anyone_can_pickup_c4 1" );
		SendToConsoleServer( "mp_death_drop_c4 0" );
		SendToConsoleServer( "mp_c4_cannot_be_defused 1" );
		SendToConsoleServer( "mp_c4timer 9999" );

		// bot_quota needs to be called BEFORE any change in bot number happens
		// this gets around the current spawning code
		EntFire( "m3_enemygroup_01", "SetEnabled", "", 0.0 );
		EntFire( "@coopmission_manager_script", "RunScriptCode", "ScriptCoopMissionSpawnFirstEnemies( 6 )", 1 );
	}

	EntFire( "@spawn_ct_deploy", "SetDisabled", "", 0 );
	m_fReadyRoomDeployRequestTime = -1;
	m_bReadyRoomStartCheckDeploy = false;
	ScriptPrintMessageCenterAll( "#SFUIHUD_InfoPanel_Coop_Deploying" );
	m_bReadyRoomPlayersDeployed = true;

	EntFire( "@coopmission_manager_script", "RunScriptCode", "RespawnPlayersStop()", 1 );
}

function StartMissionTimer()
{
	ScriptCoopResetRoundStartTime();
}

