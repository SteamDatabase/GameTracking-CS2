///////
///////
///////
// this is used to set and check whether a spot is in use or not
SpawnSpotsVacant <- [];
m_nTotalSpawnSpots <- 10
for ( local i=0; i<m_nTotalSpawnSpots; i++ )
{
	// force these to be a string
	local string = ""+i;
	SpawnSpotsVacant.append( string );
}

m_nMaxHitIntroTargs <- 2
m_nHitIntroTargs <- 0

m_nPrevVacantAddNum <- -1

m_bDisplayingInOrder <- true
m_nSpawnInOrderIndex <- 0
SpawnInOrder <- [
	"5",
	"8",
	"9",
	"6",
	"7",
	"3",
	"4",
	"2",
	"0",
	"1"
]
m_nNumOrderTargetsVisible <- 0
m_nMaxNumOrderTargetsVisible <- 2

m_bIsRunningBodyDamIntro <- false
m_bIsRunningBodyDamMain <- false
m_bIsRunningBodyDamTimed <- false
m_bHasPlayedPistolDialog<- false

// completed bools
m_bCompletedBodyDamIntro <- false
m_bCompletedBodyDamMain <- false
m_bCompletedBodyDamTimed <- false

// crouch data
m_bPlayerIsCrouching <- false
m_bHasPlayedCrouchDialog <- false

m_flSpawnDelay <- 1.5
m_flLastThink <- 0

m_nOutOfAmmoTimes <- 0

function PlayerEnterTestArea()
{
	EntFire ( "@radiovoice","RunScriptCode", "BodyDamageIntro()", 0 )
}

function PlayerCrouching()
{
	m_bPlayerIsCrouching = true
}
 
function PlayerNotCrouching()
{
	m_bPlayerIsCrouching = false
}

// this will fire when you pick up the gun from the table
function StartTest()
{
	if ( !m_bCompletedBodyDamIntro )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BodyDamageStart()", 0 )
		//StartRunning() is called from within this relay
		EntFire( "@rl_start_bd_intro", "Trigger", "" )
		printl( "StartTest() - @rl_start_bd_intro" )
		return
	}

	if ( !m_bCompletedBodyDamMain )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BodyDamageTimerStart()", 0 )
		//StartRunningBodyDamMain() is called from within this relay
		EntFire( "@rl_start_bd_targets", "Trigger", "" )
		printl( "StartTest() - @rl_start_bd_targets" )
		return
	}

	if ( !m_bIsRunningBodyDamTimed )
	{
		//StartRunningBodyDamMain() is called from within this relay
		EntFire( "@rl_start_bd_targets_timed", "Trigger", "" )
		printl( "StartTest() - @rl_start_bd_targets_timed" )
		return
	}
	
}

function CompleteTest()
{
	if ( !m_bCompletedBodyDamIntro )
	{
		CompleteBodyDamIntroTest()
		EntFire( "@rl_start_bd_targets", "Trigger", "", 2 )
		return
	}

	if ( m_bCompletedBodyDamIntro && !m_bCompletedBodyDamMain )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BodyDamageComplete()", 0 )
		CompleteBodyDamMainTest()
		EntFire( "@rl_start_bd_targets_timed", "Trigger", "", 2 )
		return
	}

	if ( m_bCompletedBodyDamMain && !m_bCompletedBodyDamTimed )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BodyDamageTimerComplete()", 0 )
		CompleteBodyDamTimedTest()
		printl( "YOU WIN!!!" );
	}
}

/////////////////////////////////////////
// show and spawn a target and remove it from the free list
function ShowTarget( slot )
{
	printl( "Showing Target.  Removing "+slot+" from table" )

	m_flSpawnDelay = 1

	local index = SpawnSpotsVacant[ slot ].tointeger()

	EntFire( EntityGroup[index].GetName(), "Open", "" );

	SpawnSpotsVacant.remove( slot );
}

function ShowTargetInOrder()
{
	// this is not rebust, m_nTotalSpawnSpots needs to match the # of entries in the SpawnInOrder table
	if ( m_nSpawnInOrderIndex >= m_nTotalSpawnSpots )
		return

	//printl( "Showing Target.  Removing "+slot+" from table" )

	local index = SpawnInOrder[m_nSpawnInOrderIndex].tointeger()

	if ( m_bIsRunningBodyDamMain && index == 5 )
	{
		EntFire( "@hint_crouch_button", "ShowHint", "" )
		
		if( !m_bPlayerIsCrouching && !m_bHasPlayedCrouchDialog )
		{
			m_bHasPlayedCrouchDialog <- true
			EntFire( "@radiovoice", "runscriptcode", "BodyDamageCrouchForAccuracy()", 0)
		}
	}

	if ( m_bIsRunningBodyDamTimed )
	{
		if ( index == 4 )
		{
			// there was a bug here that prevented this part of the test from working and we don't have the time to fix it
			//EntFire( "@hint_hical_bullets_penetrate", "ShowHint", "" );
		}
		else if ( index == 7 )
		{
			EntFire( "@hint_crouch_is_more_accurate", "ShowHint", "" );
		}
	}

	EntFire( EntityGroup[index].GetName(), "Open", "" );

	m_nSpawnInOrderIndex++
	m_nNumOrderTargetsVisible++
}

// when a target has been hit, hide it and free up the slot again
function TargetIsHidden( slot )
{
	if ( m_bIsRunningBodyDamIntro == true )
	{
		if ( m_nHitIntroTargs < m_nMaxHitIntroTargs )
		{
			m_nHitIntroTargs++
			if ( m_nHitIntroTargs >= m_nMaxHitIntroTargs )
			{
				CompleteTest()
			}
		}
		return
	}

	printl( "Hiding target.  Adding "+slot+" to table" );
	
	if ( m_bDisplayingInOrder )
	{
		TargetIsHiddenInOrder()
		return
	}

	if ( m_nPrevVacantAddNum > -1 )
	{
		local num = m_nPrevVacantAddNum + ""
		SpawnSpotsVacant.append( num );
	}

	m_nPrevVacantAddNum = slot
}

// we dont care which target was hidden, just that it's time to show a new one
function TargetIsHiddenInOrder()
{
	//printl( "Hiding target.  Adding "+slot+" to table" );
	
	m_nNumOrderTargetsVisible--
	
	// clamp
	if( m_nNumOrderTargetsVisible < 0 )
	{	
		m_nNumOrderTargetsVisible = 0
	}
	
	m_flLastThink <- Time()
}

function StartRunning()
{
	m_bIsRunningBodyDamIntro = true
	m_flSpawnDelay = 0
	m_nOutOfAmmoTimes = 0
}

function StopRunningBodyDamIntro()
{
	m_bIsRunningBodyDamIntro = false

	for ( local i=0; i<m_nTotalSpawnSpots; i++ )
	{
		EntFire( EntityGroup[i].GetName(), "Close", "" )
	}

	EntFire ( "@radiovoice","RunScriptCode", "StopRunningBodyDamIntro()", 0 )
}

function CompleteBodyDamIntroTest()
{
	StopRunningBodyDamIntro()
	m_bCompletedBodyDamIntro = true
}

function StartRunningBodyDamMain()
{
	m_nOutOfAmmoTimes = 0
	EntFire ( "@relay_team_switch_weapons","Enable", "", 0 )
	if ( m_bCompletedBodyDamMain )
	{
		StartRunningBodyDamTimed()
	}
	else
	{
		//EntFire ( "@radiovoice","RunScriptCode", "BodyDamageFail()", 0 )

		m_bIsRunningBodyDamMain = true
	}
}

function StopRunningBodyDamMain()
{
	m_bIsRunningBodyDamMain = false

	// we don't reset m_nNumOrderTargetsVisible because TargetIsHiddenInOrder() 
	// decrements it to the proper value when each target hides itself
	m_nSpawnInOrderIndex = 0
	m_flLastThink <- Time()

	for ( local i=0; i<m_nTotalSpawnSpots; i++ )
	{
		EntFire( EntityGroup[i].GetName(), "Close", "" )
	}
}

function CompleteBodyDamMainTest()
{
	StopRunningBodyDamMain()
	m_bCompletedBodyDamMain = true
}

/////////
function StartRunningBodyDamTimed()
{
	m_bIsRunningBodyDamTimed = true
	m_nOutOfAmmoTimes = 0
}

function StopRunningBodyDamTimed()
{
	m_bIsRunningBodyDamTimed = false

	// we don't reset m_nNumOrderTargetsVisible because TargetIsHiddenInOrder() 
	// decrements it to the proper value when each target hides itself
	m_nSpawnInOrderIndex = 0
	m_flLastThink <- Time()

	for ( local i=0; i<m_nTotalSpawnSpots; i++ )
	{
		EntFire( EntityGroup[i].GetName(), "Close", "" )
	}
}

function CompleteBodyDamTimedTest()
{
	StopRunningBodyDamTimed()
	m_bCompletedBodyDamTimed = true

	EntFire( "@rl_bodydam_test_over", "Trigger", "", 2 )
}

function OutOfAmmo()
{
	if ( (m_bIsRunningBodyDamIntro && !m_bCompletedBodyDamIntro) || 
		(m_bIsRunningBodyDamMain && !m_bCompletedBodyDamMain) || 
		(m_bIsRunningBodyDamTimed && !m_bCompletedBodyDamTimed) )
	{
		// we want to expell all ammo from both guns (we have a pistol and an smg)
		if ( m_nOutOfAmmoTimes == 0 )
		{
			m_nOutOfAmmoTimes++
			EntFire( "@relay_team_switch_weapons", "Trigger", "", 0 )
			
			// play the 'switch to pistol' audio if we haven't already done so
			if( !m_bHasPlayedPistolDialog && g_GetActiveWeapon() != "pistol" )
			{
				EntFire ( "@radiovoice","RunScriptCode", "BodyDamageSwitchToPistol()", 0 )
				//m_bHasPlayedPistolDialog = true
			}
			else
			{
				EntFire( "@radiovoice", "runscriptcode", "BodyDamageSwitchToOtherWeapon()", 0 )
			}
		}
		else
		{
			m_nOutOfAmmoTimes = 0
			RoundFailed( 1 )
		}		
	}
}

function RoundFailed( reason )
{
	EntFire( "@relay_BD_round_failed", "Trigger", "" )
	if ( m_bIsRunningBodyDamIntro )
	{
		StopRunningBodyDamIntro()
	}

	if ( m_bIsRunningBodyDamMain )
	{
		StopRunningBodyDamMain()
	}

	if ( m_bIsRunningBodyDamTimed )
	{
		StopRunningBodyDamTimed()
	}

	if ( reason == 1 )
	{
		EntFire( "@hint_fail_outofammo", "ShowHint", "", 0 )
		EntFire ( "@radiovoice","RunScriptCode", "BodyDamageFail()", 0 )
	}
	else if ( reason == 2 )
	{
		EntFire( "@hint_fail_outoftime", "ShowHint", "", 0 )
	}
}

function Think()
{
	if ( !m_bIsRunningBodyDamMain && !m_bIsRunningBodyDamTimed )
		return
		
	if ( m_flLastThink + m_flSpawnDelay > Time() )
		return

	// this controls the spawns
	if ( m_bDisplayingInOrder == true )
	{
		if ( m_nNumOrderTargetsVisible < m_nMaxNumOrderTargetsVisible )
		{
			ShowTargetInOrder()
			printl( "ShowTargetInOrder; time = "+ Time() +"; m_nNumOrderTargetsVisible = "+ m_nNumOrderTargetsVisible );
		}
	}
	else
	{
		m_flLastThink = Time();

		if ( SpawnSpotsVacant.len() > 0 )
		{
			printl( "SpawnSpotsVacant.len() =  "+SpawnSpotsVacant.len() );	
			local nMax = (SpawnSpotsVacant.len() > 0) ? (SpawnSpotsVacant.len()-1) : 0
			local targetSpot = RandomInt( 0, nMax )
				
			ShowTarget( targetSpot )
		}
	}
}
