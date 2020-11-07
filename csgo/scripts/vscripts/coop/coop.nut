
SPAWN_ATTEMPTS <- 50;
SPAWN_ENABLE_RANGE <- 2000;
TERRORIST_MONEY_INTERVAL <- 10;
TERRORIST_MONEY <- 200;
THINK_INTERVAL <- 1;

m_CTs <- [];

iCT <- 0;

eTSpawn <- null;

m_lastTerroristMoney <- Time();
m_lastThink <- Time();


function FindInArray( array, thing )
{
	foreach( i, elem in array )
	{
		if ( elem == thing )
			return i;
	}
	
	return null;
}

function CollectCTs()
{
	ent <- null;

	while( ( ent = Entities.FindByName( ent, "CT" ) ) != null )
	{
		if ( FindInArray( m_CTs, ent ) == null )
		{
			m_CTs.push( ent );
		}
	}
}


function UpdateTerroristSpawnPoints()
{
	// Each Think() we use a different CT as a search point for spawns to enable.
	iCT <- iCT + 1;
	if ( iCT == m_CTs.len() )
		iCT <- 0;

	// Now try 50 times to find a spawn within 2000 units to turn on.
	for( i <- 0; i < SPAWN_ATTEMPTS; i++ )
	{
		eTSpawn <- Entities.FindByClassnameWithin( eTSpawn, "info_deathmatch_spawn", m_CTs[ iCT ].GetOrigin(), SPAWN_ENABLE_RANGE );
		
		if( eTSpawn != null )
			EntFireByHandle( eTSpawn, "SetEnabled", "", 0, 0, 0 );
	}
}

function UpdateTerroristMoney()
{
	if ( Time() - m_lastTerroristMoney < TERRORIST_MONEY_INTERVAL )
		return;

	EntFire( "money_Terrorist", "SetMoneyAmount", TERRORIST_MONEY, 0 );
	EntFire( "money_Terrorist", "AddTeamMoneyTerrorist", 0, 0 );

	m_lastTerroristMoney <- Time();
}

function Think()
{
	return;

	if ( Time() - m_lastThink < THINK_INTERVAL )
		return;

	// Start by turning all T spawns off
	EntFire( "info_deathmatch_spawn", "SetDisabled", "", 0 );

	// Find all CTs
	CollectCTs();

	// There are no CTs outsize of the starting trigger. Abort for now.
	if ( m_CTs.len() == 0 )
		return;

	UpdateTerroristMoney();

	UpdateTerroristSpawnPoints();

	m_lastThink <- Time();
}




