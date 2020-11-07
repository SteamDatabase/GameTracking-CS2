DEBUG <- false;

wave <- 0;

NEXTFLOOR <- 0;						// the next floor to travel to
FASTTRAVEL1 <- false;				// has player unlocked fast travel stage 1?  these vars persist on "@script_varcontainer"
FASTTRAVEL2 <- false;				// has player unlocked fast travel stage 2? 
FASTTRAVEL3 <- false;				// has player unlocked fast travel stage 3? 

PLAYER_AMOUNT <- 0;					// how many players are playing?

PERSISTENTCONTAINER <- Entities.FindByName (null, "@script_varcontainer");
ISWARMUP <- ScriptIsWarmupPeriod();

// Floor list
// Floor 0 - Starting area
// Floor 1 - combat arena, group 1
// Floor 2 - combat arena, group 1
// Floor 3 - Combat arena, group 1
// Floor 4 - Combat arena, group 1
//
// Floor 5 - Combat arena, group 2
// Floor 6 - Combat arena, group 2
// Floor 7 - Combat arena, group 2
// Floor 8 - Combat arena, group 2
//
// Floor 9 - Shortcut fight
//
// Floor 10 - Combat arena, group 3
// Floor 11 - Combat arena, group 3
// Floor 12 - Combat arena, group 3
// Floor 13 - Combat arena, group 3
//
// Floor 14 - Combat arena, group 4
// Floor 15 - Combat arena, group 4

// Floor 16 - End fight

CURRENTDIFFICULTY <- 0;
ENEMYAMOUNT <- 0;
LoadoutType <- [1, 9]
WeaponLoadout <- {}

// NOTE: EnemyDifficulty() uses these to decide weapon loadouts, remember to keep in sync!

// early game loadouts

WeaponLoadout[1] <- "glock"
WeaponLoadout[2] <- "deagle"
WeaponLoadout[3] <- "tec9"
WeaponLoadout[4] <- "sawedoff"
WeaponLoadout[5] <- "nova"
WeaponLoadout[6] <- "mp7"
WeaponLoadout[7] <- "bizon"
WeaponLoadout[8] <- "mac10"
WeaponLoadout[9] <- "ump45"

// mid game

WeaponLoadout[10] <- "galilar"
WeaponLoadout[11] <- "famas"
WeaponLoadout[12] <- "p90"
WeaponLoadout[13] <- "ump45, flashbang"
WeaponLoadout[14] <- "mag7"
WeaponLoadout[15] <- "deagle, molotov"
WeaponLoadout[16] <- "xm1014"
WeaponLoadout[17] <- "famas, hegrenade"
WeaponLoadout[18] <- "nova, flashbang"

// late game

WeaponLoadout[19] <- "xm1014, flashbang"
WeaponLoadout[20] <- "ak47"
WeaponLoadout[21] <- "p90, hegrenade"
WeaponLoadout[22] <- "sg556"
WeaponLoadout[23] <- "m4a1, flashbang"
WeaponLoadout[24] <- "ak47, molotov"
WeaponLoadout[25] <- "galilar, hegrenade"

// PISTOLS: deagle, fiveseven, tec9, p250
// HEAVY : sawedoff, nova, xm1014, mag7, m249
// RIFLES : famas, sg556, ak47, galilar, aug, awp, m4a1
// SMG : mp9, mp7, bizon, ump45, p90, mac10
// NADES : hegrenade, smokegrenade, molotov, flashbang

m_CTs <- [];

function CollectCTs()
{
	ent <- null;

	while( ( ent = Entities.FindByClassname( ent, "player" ) ) != null )
	{
		if ( FindInArray( m_CTs, ent ) == null )
		{
			m_CTs.push( ent );
		}
	}
}

function RoundInit()		// called on OnLevelReset
{

	if (ISWARMUP == false)
	{
		wave = 0;
		EnemyDifficulty( 1 );

		FASTTRAVEL1 = PERSISTENTCONTAINER.GetScriptScope().FASTTRAVEL1;
		FASTTRAVEL2 = PERSISTENTCONTAINER.GetScriptScope().FASTTRAVEL2;
		FASTTRAVEL3 = PERSISTENTCONTAINER.GetScriptScope().FASTTRAVEL3;
	
		SendToConsoleServer( "mp_coopmission_bot_difficulty_offset 1" );
		ScriptCoopSetBotQuotaAndRefreshSpawns( 0 );
	
		CollectCTs();
	
		PLAYER_AMOUNT = m_CTs.len();
	
		printl ("");
		printl ("PLAYER AMOUNT: " + PLAYER_AMOUNT );
		printl ("");
	
		SetFloor();			// set up elevator, spawn points
		
		EntFire("trigger.elevator_doors", "Enable", 0, 0);
	}
	else
	{
	printl ("");
	printl ("");
	printl ("We're in warmup so I D G A F");
	printl ("");
	printl ("");
	}
}

SpawnCollection <- []

function CollectSpawns( name )
{
	ent <- null;

	while( ( ent = Entities.FindByName( ent, name ) ) != null )
	{
		if ( FindInArray( SpawnCollection, ent ) == null )
		{
			SpawnCollection.push( ent );
		}
	}
	
	SetupSpawns();
	
}

function PlayersInElevator( var )
{
local amount = var;
printl ("PLAYERS IN ELEVATOR : " + amount)

	if (amount ==  PLAYER_AMOUNT)
	{
		EntFire("elevator.relay.startmove", "Trigger", 0, 0);
	}
}

function Test()
{


RemoveDecalsAndGuns();



}

function EnemyDifficulty( difficulty )							// Updated via Progression();
{

	switch ( difficulty )
	{
		case 1: 
			LoadoutType[0] = 1;
			LoadoutType[1] = 9;
			ENEMYAMOUNT = 6;
			break;
		case 2:
			LoadoutType[0] = 10;
			LoadoutType[1] = 18;
			ENEMYAMOUNT = 8;
			break;
		case 3:
			LoadoutType[0] = 19;
			LoadoutType[1] = 25;
			ENEMYAMOUNT = 10;
			break;
	}



}

function SetupSpawns()
{

	foreach (spawn in SpawnCollection)
	{
	
	local loadout = WeaponLoadout[RandomInt( LoadoutType[0], LoadoutType[1] )];
	
	spawn.__KeyValueFromString ("weapons_to_give", loadout );
	
	printl ("Equipped bot with " + loadout);
	
	}

		if (wave >= 10)
		{
		local SpawnLen = SpawnCollection.len();
		local RandomPick = SpawnCollection[RandomInt( 0, SpawnLen - 1 )]
		
		RandomPick.__KeyValueFromInt ("armor_to_give", 2 );
		RandomPick.__KeyValueFromString ("model_to_use", "models/player/custom_player/legacy/tm_phoenix_heavy.mdl" );
		}

}

function RespawnPlayers()
{
	ScriptCoopMissionRespawnDeadPlayers();
}

function Progression()
{ 

printl ("WAVE IS CURRENTLY: " + wave);

	if (wave <= 4)
	{
	EntFire( "floor_group1", "PickRandomShuffle", "", 0 );
	EnemyDifficulty( 1 );
	}
	else if (wave == 5)
		{
		SetNextFloor(9);
		}
		else if (wave >= 6 && wave <= 9)
			{
			EntFire( "floor_group2", "PickRandomShuffle", "", 0 );
			EnemyDifficulty( 2 );
			}
			else if (wave == 10)
				{
				SetNextFloor(9);
				}
				else if (wave >= 11 && wave <= 14)
					{
					EntFire( "floor_group3", "PickRandomShuffle", "", 0 );
					EnemyDifficulty( 3 );
					}
					else if (wave == 15)
						{
						SetNextFloor(9);
						}
						else if (wave >= 16 && wave <= 17)
							{
							EntFire( "floor_group4", "PickRandomShuffle", "", 0 );
							}
							else if (wave == 18)
								{
								SetNextFloor(16);
								}
		
}

function SetNextFloor( floor )
{
NEXTFLOOR = floor;

SetSpawnGroup();
}

function SetFloor()
{
	EntFire( "*-spawn", "SetDisabled", "", 0 );		// disable all spawns
	
	// check if player has unlocked fast travel
	
	printl ("FAST TRAVEL STAGE 3: " + FASTTRAVEL3);
	printl ("FAST TRAVEL STAGE 2: " + FASTTRAVEL2);
	printl ("FAST TRAVEL STAGE 1: " + FASTTRAVEL1);
	
	if (FASTTRAVEL3 == true && wave <= 15)
	{
	wave = 16;
	}
	else if (FASTTRAVEL2 == true && wave <= 10)
		{
		wave = 11;
		}
		else if (FASTTRAVEL1 == true && wave <= 5)
			{
			wave = 6;
			}
			else
				{
				wave++;
				printl ("No fast travel unlocked");
				}
	
	Progression();
}

function SetSpawnGroup()
{

	local SpawnGroup = NEXTFLOOR + "-spawn";
	printl (SpawnGroup);
	
	EntFire( SpawnGroup, "SetEnabled", "", 0.1 );

	CollectSpawns( SpawnGroup );

}

function UnlockCheckpointSluice( players )		// check if players are spread out in different sluices
{

	if (players == PLAYER_AMOUNT)
	{
		EntFire( "@checkpoint_relay_start", "Trigger", "", 0 );
	}

}

DroppedWeapon <- null;

function RemoveDecalsAndGuns()				// don't use this quite yet, it will remove the players weapons as well..
{
printl ("CLEANING UP, WOO!");
SendToConsole("r_cleardecals");

//	while((DroppedWeapon = Entities.FindByClassname(DroppedWeapon,"prop_physics")) != null)
//		{
//			DoEntFire("!self","Kill","0",0,null,DroppedWeapon); // Will fire on named and un-named entities alike.
//		}

}

function ElevatorSetFloor()			// run when entering elevator 
{
	EntFire( "elevator.mover", "RunScriptCode", "SetTargetFloor(" + NEXTFLOOR + ")", 0 );
}

function ElevatorArrived()			// run when elevator stops moving
{

	if ( wave == 1 )
	{
		SpawnFirstEnemies( ENEMYAMOUNT );
	}
	else
	{
	SpawnNextWave( ENEMYAMOUNT );
	}

}

function SpawnFirstEnemies( amount )
{
	ScriptCoopMissionSpawnFirstEnemies( amount );	
	ScriptCoopResetRoundStartTime();
}

function SpawnNextWave( amount )
{
	ScriptCoopMissionSpawnNextWave( amount );
}

function OnMissionCompleted()
{
	// fade out screen, end round
	EntFire( "@screen_fade", "Fade", "", 0.0 );	
	EntFire( "@game_end", "EndRound_CounterTerroristsWin", "3", 0.0 );	
	
}

function OnRoundLostKilled()
{
	//what will happen if you loose the round because you died (you could tell the players that your grandma is better than them)
	
}

function OnRoundLostTime()
{
	//what will happen if you loose the round because the time runs out (you could tell the player that they are like turtles)
	
}

function OnRoundReset() 
{
	//called when the round resets
	// IMPORTANT: you need a game_coopmission_manager that has the output 'OnLevelReset' when this is called you NEED to call this function
	// in order for the level to work properly every round!
	RoundInit();
}

function OnSpawnsReset()
{
	//called right before the round resets (usually used for correcting stuff when on a new round other stuff is immediately called)
	//enabled/disabled the correct spawns for the start. * means every group going from Terrorist_00 to infinite enemygroup_example
	EntFire( "*-spawn", "SetDisabled", "", 0 );
	EntFire( "*-CT", "SetDisabled", "", 0 );
	EntFire( "1-CT", "SetEnabled", "", 0 );
}

function OnWaveCompleted()
{	
	if (wave < 18)
	{
		SpawnCollection.clear();
		SetFloor();
		EntFire("elevator.relay.unlock", "Trigger", 0, 0);
	}
	else if (wave == 18)
	{
	printl ("that was the final wave");
	OnMissionCompleted()
	}
	
	if (wave == 6)		// TODO: this one and the next should both be in a checkpoint fight, fast travel unlocked via level script. ooooor just increase enemy amount for checkpoint fights?
	{
	EntFire( "@script_varcontainer", "RunScriptCode", "SetFastTravelVar(" + 1 + ")", 0 );
	ScriptPrintMessageCenterAll ("Fast travel to floor 6 unlocked!");
	}
		if (wave == 11)
		{
		EntFire( "@script_varcontainer", "RunScriptCode", "SetFastTravelVar(" + 2 + ")", 0 );
		ScriptPrintMessageCenterAll ("Fast travel to floor 11 unlocked!");
		}
			if (wave == 16)
			{
			EntFire( "@script_varcontainer", "RunScriptCode", "SetFastTravelVar(" + 3 + ")", 0 );
			ScriptPrintMessageCenterAll ("Fast travel to floor 16 unlocked!");
			}
	

	//Check which wave the player is and do stuff
//	if ( wave == 1 )
//	{
//		EntFire( "wave_*", "SetDisabled", "", 0 );
//		EntFire( "wave_02", "SetEnabled", "", 0 );
//		EntFire( "door_wave_01", "Unlock", "", 1 );
//		EntFire( "door_wave_01", "SetGlowEnabled", "", 1 );
//	}
//	else if ( wave == 2 )
//	{
//		EntFire( "wave_*", "SetDisabled", "", 0 );
//		EntFire( "wave_03", "SetEnabled", "", 0 );
//		EntFire( "door_wave_02", "Unlock", "", 1 );
//		EntFire( "door_wave_02", "SetGlowEnabled", "", 1 );
//	}
//	else if ( wave == 3 )
//	{
//		EntFire( "door_wave_03", "Unlock", "", 1 );
//		EntFire( "door_wave_03", "SetGlowEnabled", "", 1 );
//	}


}

function ChangeGameModeToCoopIfNotCorrect()
{
	// This will change the game mode and game type if the player has not initialized this before starting the map.
        local game_mode = ScriptGetGameMode();
        local game_type = ScriptGetGameType();
        local map = GetMapName();

	if (game_mode != 1 || game_type != 4)
	{
		SendToConsole("game_mode 1; game_type 4; changelevel " + map);
	}
}

// util stuff

function FindInArray( array, thing )
{
	foreach( i, elem in array )
	{
		if ( elem == thing )
			return i;
	}
	
	return null;
}

function debugPrint( text )
{
	if ( DEBUG == false )
		return;

	printl( text );
}