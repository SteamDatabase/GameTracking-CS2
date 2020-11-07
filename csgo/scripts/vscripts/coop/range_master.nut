DEBUG <- false;

MAX_TARGETS_SPOTS <- 14
MAX_TARGETS_PER_SIDE <- 4

m_nLiveTargets_B <- 0
m_nLiveTargets_R <- 0

m_TargetSpots <- {}

m_bTimerActive <- false

m_nPoints_B <- 0;
m_nPoints_R <- 0;

function debugPrint( text )
{
	if ( DEBUG == false )
		return;

	printl( text );
}


function Precache()
{
	self.PrecacheScriptSound( "tr.Score100" );
}

function OnPostSpawn()
{
	for ( local i=0; i<MAX_TARGETS_SPOTS; i++ )
	{
		m_TargetSpots[i] <- false;
	}
}

function SpawnFirstTargets()
{
	m_bTimerActive = true;

	m_nPoints_B = 0;
	m_nPoints_R = 0;

	EntFire( "@spr_gal_WIN_B", "HideSprite", "", 0 );
	EntFire( "@spr_gal_WIN_R", "HideSprite", "", 0 );

	// we have a set pattern for the first 4 targets on each side
	// R = 1, 2, 10, 11
	SpawnNewTarget( 0, 1 );
	SpawnNewTarget( 0, 2 );
	SpawnNewTarget( 0, 10 );
	SpawnNewTarget( 0, 11 );

	// B = 4, 5, 13, 14
	SpawnNewTarget( 1, 4 );
	SpawnNewTarget( 1, 5 );
	SpawnNewTarget( 1, 13 );
	SpawnNewTarget( 1, 14 );
}

function AddPoint_B()
{
	m_nPoints_B++;
}

function AddPoint_R()
{
	m_nPoints_R++;
}

function SetTimerExpired()
{
	m_bTimerActive = false;
	debugPrint("**** SetTimerExpired()" );

	ResetAllTargets();

	if ( m_nPoints_B == m_nPoints_R )
	{
		EntFire( "@spr_gal_WIN_B", "ShowSprite", "", 0 );
		EntFire( "@spr_gal_WIN_R", "ShowSprite", "", 0 );	
	}
	else if ( m_nPoints_B > m_nPoints_R )
	{
		EntFire( "@spr_gal_WIN_B", "ShowSprite", "", 0 );
	}
	else if ( m_nPoints_B < m_nPoints_R )
	{
		EntFire( "@spr_gal_WIN_R", "ShowSprite", "", 0 );
	}

	self.EmitSound( "tr.Score100" );

	EntFire( "@button_start_gallery", "Unlock", "", 3 );
}

function OnTargetShot( color, number )
{ 
	// this number is now freed up
	local index = number.tointeger();
	m_TargetSpots[index] <- false;
	
	if ( color == 0 )
		m_nLiveTargets_B--;
	else if ( color == 1 )
		m_nLiveTargets_R--;

	// set up the next one
	EntFire( "@script_shooting_range","RunScriptCode", "SpawnNewTarget( "+color+", -1 )", 0.25 );

	debugPrint( "m_nLiveTargets_R = "+m_nLiveTargets_R+", m_nLiveTargets_B = "+m_nLiveTargets_B );
}

function SpawnNewTarget( color, newIndex )
{
	local strColor = "R";
	if ( color == 1 )
		strColor = "B";

	if ( m_bTimerActive )
	{
		if ( newIndex == -1 )
		{
			newIndex = RandomInt( 1, 14 ); 
			if ( m_TargetSpots[newIndex] == true )
			{
				for ( local i=0; i<MAX_TARGETS_SPOTS; i++)
				{
					newIndex++;
					if ( newIndex > MAX_TARGETS_SPOTS)
						newIndex = 1;
			
					if ( m_TargetSpots[newIndex] == false )
						break; // found a spot
				}	
			}		
		}

		if ( newIndex != -1 )
		{
			debugPrint("**** SpawnNewTarget() - color = "+color+", index = "+newIndex );

			m_TargetSpots[newIndex] <- true;
			EntFire( "sgm"+strColor+"_"+newIndex, "ForceSpawn", "", 0.0 );
	
			if ( color == 0 )
				m_nLiveTargets_B++;
			else if ( color == 1 )
				m_nLiveTargets_R++;				
		}
	}
}

function ResetAllTargets()
{
	debugPrint("**** ResetAllTargets()" );

	EntFire ( "targbup*","Close", "", 0.0 );
	EntFire ( "targup*","Close", "", 0.0 );

	for ( local i=1; i<=MAX_TARGETS_SPOTS; i++ )
	{
		m_TargetSpots[i] <- false;
	}	
}


