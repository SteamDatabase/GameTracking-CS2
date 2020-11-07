// this is used to set and check whether a spot is in use or not
SpawnSpotsVacant <- [];
m_nTotalSpawnSpots <- 4
for ( local i=0; i<m_nTotalSpawnSpots; i++ )
{
	// force these to be a string
	local string = ""+i;
	SpawnSpotsVacant.append( string );
}

m_bIsRunningAimWall <- false
m_nAimWallOOATimes <- 0
m_bAimWallHitTarget <- false
m_bIsRunningPreTeamRec <- false
m_bIsRunningTeamRec <- false
m_bIsRunningBurst <- false
m_bIsRunningBurstBlocker <- false
m_bIsRunningCrouchTest <- false

// completed bools
m_bCompletedAimWall <- false
m_bCompletedPreTeamRec <- false
m_bCompletedTeamRec <- false
m_bCompletedBurst <- false
m_bCompletedBurstBlocker <- false
m_bCompletedCrouchTest <- false

// crouch data
m_bPlayerIsCrouching <- false

m_flSpawnDelay <- 1
m_flLastThink <- 0

// GLOBAL FUNCTIONS

// primary and active weapons
::g_szPrimaryWeapon	<- "none"		// the primary weapon the player possesses
::g_szActiveWeapon	<- "none"		// the weapon currently in use
::g_GrenadeThrowTime <- 0

getroottable().g_GetPrimaryWeapon <- function()
{
	return g_szPrimaryWeapon
}

getroottable().g_SetPrimaryWeapon <- function( weapon_name )
{
	g_szPrimaryWeapon = weapon_name
}

getroottable().g_GetActiveWeapon <- function()
{
	return g_szActiveWeapon
}

getroottable().g_SetActiveWeapon <- function( weapon_name )
{
	g_szActiveWeapon = weapon_name
}

getroottable().g_GetGrenadeLastThrowTime <- function()
{
	return g_GrenadeThrowTime
}

getroottable().g_SetGrenadeLastThrowTime <- function( time )
{
	g_GrenadeThrowTime = time
	
}


// we are specifically hard coding the order that CT will show versus a T
m_nFriendFoeIndex <- 0
FriendFoeOrder <- [
	"CT",
	"T",
	"CT",
	"CT",
	"T",
	"CT",
	"T",
	"CT",
	"T",
	"T",
	"CT",
	"T",
	"CT",
	"T",
	"CT",
	"T",
	"T",
	"CT",
	"CT",
	"T",
	"T",
	"T",
	"CT",
	"T",
	"T",
	"T",
	"T"
]

function PlayerCrouching()
{
	m_bPlayerIsCrouching = true
	
	// notify RadioVoice of the player crouch state
	EntFire( "@radiovoice", "RunScriptCode", "SetCrouchTrainingPlayerCrouching()", 0 )

	// bail early if crouch test is not running. 
	if( !m_bIsRunningCrouchTest )
		return
		
	EntFire( "@relay_crouch_hit_target", "enable", 0 )
}
 
function PlayerNotCrouching()
{
	m_bPlayerIsCrouching = false
	
	// notify RadioVoice of the player crouch state
	EntFire( "@radiovoice", "RunScriptCode", "SetCrouchTrainingPlayerNotCrouching()", 0 )
	
	// bail early if crouch test is not running. 
	if( !m_bIsRunningCrouchTest )
		return
	
	
	EntFire( "@relay_crouch_hit_target", "disable", 0 )
}

function PlayerEnterTestArea()
{
	EntFire ( "@fade_start","Fade", "", 0 )
	ScriptSetMiniScoreHidden( true )

	if ( ScriptGetPlayerCompletedTraining() == true )
	{
		
		EntFire ( "@radiovoice","RunScriptCode", "MainIntro2()", 2 )
		// TODO: this shoudl be fired when the above VCD finishes
		EntFire ( "@rl_start_revisit","Trigger", "", 12 )
	}
	else
	{
		ScriptSetRadarHidden( true )
		EntFire ( "@radiovoice","RunScriptCode", "MainIntro()", 2 )
		// TODO: this shoudl be fired when the above VCD finishes
		//EntFire ( "@rl_start_show_hint","Trigger", "", 14 )
	}
}

// this will fire when you pick up the gun from the table
function StartTest()
{
	if ( !m_bCompletedAimWall )
	{
		EntFire ( "@radiovoice","RunScriptCode", "GunTestStart()", 0 )
		//StartRunningTeam() is called from within this relay
		EntFire( "@rl_start_aim_wall", "Trigger", "" )
		return
	}

	if ( !m_bCompletedPreTeamRec )
	{
		//StartRunningTeam() is called from within this relay
		EntFire( "@rl_start_pre_team", "Trigger", "" )
		return
	}

	if ( !m_bCompletedTeamRec )
	{
		EntFire ( "@radiovoice","RunScriptCode", "IdTestStartActual()", 0 )
		//StartRunningTeam() is called from within this relay
		EntFire( "@rl_start_team_targets", "Trigger", "" )
		return
	}

	if ( !m_bCompletedBurst )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BurstTestStart()", 0 )
		//StartRunningBurst() is called from within this relay
		EntFire( "@rl_start_burst_test", "Trigger", "" )
		return
	}

	if ( !m_bCompletedBurstBlocker )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BurstBlockerTestStart()", 0 )
		//StartRunningBurst() is called from within this relay
		EntFire( "@rl_start_burst_block_test", "Trigger", "" )
		return
	}
	
	if ( !m_bCompletedCrouchTest )
	{
		EntFire ( "@radiovoice","RunScriptCode", "CrouchTestStart()", 0 )
		 
		//StartRunningCrouchTest() is called from within this relay
		EntFire( "@rl_start_crouch_test", "Trigger", "" )
		
		return
	}
	
}

function CompleteTest()
{
	if ( !m_bCompletedAimWall )
	{
		if ( m_bAimWallHitTarget )
		{
			// player hit the target wall at least once
			EntFire ( "@radiovoice","RunScriptCode", "GunTestComplete()", 0 )
		}
		else
		{
			// player emptied his clip without hitting the target wall at all
			EntFire ( "@radiovoice","RunScriptCode", "GunTestCompleteFail()", 0 )
		}

		CompleteAimWall()

		// this doesn't work yet  :(
		//ScriptHighlightAmmoCounter()
		return
	}

	if ( !m_bCompletedPreTeamRec )
	{
		CompletePreTeamTest()
		EntFire( "@lock_gunbutton_team", "Trigger", "", 0 )
		return
	}

	if ( !m_bCompletedTeamRec )
	{
		EntFire ( "@disable_rl_burst_addpoint","Trigger", "", 0 )
		CompleteTeamTest()

		EntFire ( "@radiovoice","RunScriptCode", "IdTestComplete()", 1 )
		EntFire( "@rl_leave_mp7", "Trigger", "", 1.9 )
		EntFire( "@rl_open_burst_target_wall", "Trigger", "", 3 )
		return
	}

	if ( m_bCompletedTeamRec && !m_bCompletedBurst )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BurstTestComplete()", 0 )
		CompleteBurstTest()
		EntFire( "@rl_start_burst_block_test", "Trigger", "", 3.5 )
		return
	}

	if ( m_bCompletedBurst && !m_bCompletedBurstBlocker )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BurstBlockerTestComplete()", 0 )
		CompleteBurstBlockerTest()
		
		
		EntFire( "@rl_leave_mp7", "Trigger", "", 1 )
		
		return		
	}
	
	if ( m_bCompletedBurstBlocker && !m_bCompletedCrouchTest )
	{
		EntFire ( "@radiovoice","RunScriptCode", "CrouchTestComplete()", 0 )
		CompleteCrouchTest()
		printl( "^^ YOU WIN!!!" )
	}
}

function HitEnemy()
{
	if ( m_bIsRunningAimWall || m_bIsRunningBurst || m_bIsRunningBurstBlocker || m_bIsRunningCrouchTest )
		return

	EntFire ( "@radiovoice","RunScriptCode", "iDEnemyFire()", 0 )
}

function HitFriendly()
{
	if ( m_bIsRunningAimWall || m_bIsRunningBurst || m_bIsRunningBurstBlocker || m_bIsRunningCrouchTest )
		return
	
	// only play friendly fire dialog if test is in progress
	if( !m_bCompletedTeamRec )
	{
		EntFire ( "@radiovoice","RunScriptCode", "iDFriendlyFire()", 0 )
	}
}

/////////////////////////////////////////
// show and spawn a target and remove it from the free list
function ShowTarget( slot )
{
	printl( "Showing Target.  Removing "+slot+" from table" )

	m_flSpawnDelay = 1.0

	// make sure we haven't hit the end of the FriendFoeOrder list
	// if so, start over
	if ( m_nFriendFoeIndex >= FriendFoeOrder.len() )
		m_nFriendFoeIndex = 0

	printl( "m_nFriendFoeIndex = "+m_nFriendFoeIndex+", FriendFoeOrder.len() ="+FriendFoeOrder.len() );
	local index = SpawnSpotsVacant[ slot ].tointeger()
	if ( FriendFoeOrder[m_nFriendFoeIndex] == "T" )
		index += m_nTotalSpawnSpots

	EntFire( EntityGroup[index].GetName(), "Open", "" );

	// move the friend or foe list to the next entry
	m_nFriendFoeIndex++

	SpawnSpotsVacant.remove( slot );
}

// when a target has been hit, hide it and free up the slot again
function TargetIsHidden( slot )
{
	printl( "Hiding target.  Adding "+slot+" to table" );
	local num = slot + ""
	SpawnSpotsVacant.append( num );

	// you get a spawn bonus for shooting a target
	//if ( m_flSpawnDelay > 0.2 )
	//{
	//	m_flSpawnDelay -= 1
	//	if ( m_flSpawnDelay < 0.2 )
	//		m_flSpawnDelay = 0.2
	//}
}

/////////////////////
function StartRunningAimWall()
{
	m_bIsRunningAimWall = true
	m_nAimWallOOATimes = 0
}

function AimWallHitTarget()
{
	m_bAimWallHitTarget = true
}

function StopRunningAimWall()
{
	m_bIsRunningAimWall = false
}

function CompleteAimWall()
{
	StopRunningAimWall()
	m_bCompletedAimWall = true
}

//////////////////
function StartRunningPreTeam()
{
	m_bIsRunningPreTeamRec = true
	EntFire ( "@radiovoice","RunScriptCode", "IdTestStart()", 0 )
}

function StopRunningPreTeam()
{
	m_bIsRunningPreTeamRec = false
}

function CompletePreTeamTest()
{
	StopRunningPreTeam()
	m_bCompletedPreTeamRec = true
}

/////////////////////
function StartRunningTeam()
{
	m_bIsRunningTeamRec = true
	m_flSpawnDelay = 0
}

function StopRunningTeam()
{
	m_bIsRunningTeamRec = false
}

function CompleteTeamTest()
{
	StopRunningTeam()
	m_bCompletedTeamRec = true
}

/////////////////////
function StartRunningBurst()
{
	if ( m_bCompletedBurst )
	{
		StartRunningBurstBlocker()
	}
	else
	{
		m_bIsRunningBurst = true
	}
}

function StopRunningBurst()
{
	m_bIsRunningBurst = false
}

function CompleteBurstTest()
{
	StopRunningBurst()
	m_bCompletedBurst = true
}

///////////////////////
function StartRunningBurstBlocker()
{
	m_bIsRunningBurstBlocker = true
}

function StopRunningBurstBlocker()
{
	m_bIsRunningBurstBlocker = false
}

function CompleteBurstBlockerTest()
{
	StopRunningBurstBlocker()
	m_bCompletedBurstBlocker = true
}

///////////////////////
function StartRunningCrouchTest()
{
	m_bIsRunningCrouchTest = true
	
	// initialize crouch target scoring relay state
	if( m_bPlayerIsCrouching )
	{
		EntFire( "@relay_crouch_hit_target", "enable", 0 )
	}
	else
	{
		EntFire( "@relay_crouch_hit_target", "disable", 0 )
	}	
}

function StopRunningCrouchTest()
{
	m_bIsRunningCrouchTest = false
}

function CompleteCrouchTest()
{
	printl("*** Completed Crouch Test - opening exit door ***")
	StopRunningCrouchTest()
	m_bCompletedCrouchTest = true
	// take away gun
	EntFire( "@rl_teamburst_test_over", "Trigger", "", 2 )
}

// this function gets called whenever the crouch target gets hit regardless of scoring
function CrouchTargetHitCallback()
{
	// bail early if not running crouch test
	if( !m_bIsRunningCrouchTest )
	{
		return
	}
}

function OutOfAmmo()
{
	if ( m_bIsRunningAimWall )
	{
		// we want to expell all ammo
		 EntFire( "@rl_burst_win", "Trigger", "", 0 )
		printl("========OutOfAmmo in m_bIsRunningAimWall !!!")
	}
	else if ( (m_bIsRunningTeamRec && !m_bCompletedTeamRec) || 
		(m_bIsRunningBurst && !m_bCompletedBurst) || 
		(m_bIsRunningBurstBlocker && !m_bCompletedBurstBlocker) ||
		(m_bIsRunningCrouchTest && !m_bCompletedCrouchTest) ) 
	{
		RoundFailed( 1 )
	}
}

function RoundFailed( reason )
{
	EntFire( "@relay_burst_round_failed", "Trigger", "", 0 )

	if ( m_bIsRunningTeamRec )
	{
		EntFire ( "@radiovoice","RunScriptCode", "IdTestFailed()", 0 )

		StopRunningTeam()
	}

	if ( m_bIsRunningBurst )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BurstTestFailed()", 0 )

		printl("===================FAIL!!!!!2222222222222222!!!")
		StopRunningBurst()
	}

	if ( m_bIsRunningBurstBlocker )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BurstBlockerTestFailed()", 0 )

		printl("===================FAIL!!!!!333333333333333333!!!")
		StopRunningBurstBlocker()
	}
	
	if( m_bIsRunningCrouchTest )
	{
		// hook up function
		EntFire ( "@radiovoice","RunScriptCode", "CrouchTestFailed()", 0 )
		
		printl("===================FAIL!!!!!444444444444444444444 (crouch test)!!!")
		// hook up function
		StopRunningCrouchTest()
	}
	

	if ( reason == 1 )
	{
		//EntFire ( "@radiovoice","RunScriptCode", "FailureAmmo()", 0 )
		EntFire( "@hint_fail_outofammo", "ShowHint", "", 0 )
	}
	else if ( reason == 2 )
	{
		EntFire ( "@radiovoice","RunScriptCode", "FailureTime()", 0 )
		EntFire( "@hint_fail_outoftime", "ShowHint", "", 0 )
	}

	EntFire( "@unlock_gunbutton_team", "Trigger", "", 6 )

}

function Think()
{
	// bail early if not running recognition test
	if ( !m_bIsRunningTeamRec )
		return
		
	// this controls the spawns
	if ( m_flLastThink + m_flSpawnDelay < Time() )
	{
		m_flLastThink = Time();

		if ( SpawnSpotsVacant.len() > 0 )
		{
			printl( "SpawnSpotsVacant.len() =  "+SpawnSpotsVacant.len() );	
			local nMax = (SpawnSpotsVacant.len() > 0) ? (SpawnSpotsVacant.len()-1) : 0
			local targetSpot = RandomInt( 0, nMax )
				
			//local slot = SpawnSpotsVacant[ targetSpot ];
			ShowTarget( targetSpot )
		}
	}
}
