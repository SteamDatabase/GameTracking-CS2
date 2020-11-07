m_bIsBirdMasterSpawner <- true;

m_bInitialized <- false;

m_BirdSpawnEnts <- [];
m_nNumBirdsInMap <- 0;

THINK_FREQUENCY <- 0.5;
SPAWN_FREQUENCY <- 15;
MAX_BIRDS_SPAWNED <- 16;

m_flLastThink <- 0;
m_flLastSpawnTime <- 0;

m_nCurBirdArrayPos <- 0;

function OnPostSpawn()
{
	if ( m_bInitialized == false )
	{
		CollectBirdSpawnEnts();
		m_bInitialized = true;
		DoIncludeScript("dev/Util.nut",null);
	}
}

function AddBird()
{
	m_nNumBirdsInMap++;
	//printl( "^^ m_nNumBirdsInMap = "+m_nNumBirdsInMap );
}

function SubtractBird()
{
	m_nNumBirdsInMap--;
	//printl( "^^ m_nNumBirdsInMap = "+m_nNumBirdsInMap );
}

function FindInArray( array, thing )
{
	foreach( i, elem in array )
	{
		if ( elem == thing )
			return i;
	}
	
	return null;
}

function CollectBirdSpawnEnts()
{
	ent <- null;

	while( ( ent = Entities.FindByClassname( ent, "env_entity_maker" ) ) != null )
	{
		if ( FindInArray( m_BirdSpawnEnts, ent ) == null )
		{
			if ( ent && ent.GetScriptScope() && ent.GetScriptScope().m_bIsBirdSpawner )
			{
				m_BirdSpawnEnts.push( ent );
				//printl( "^^ Adding bird spawner! total = "+m_BirdSpawnEnts.len() );
			}		
		}
	}
}

function Think()
{
	if ( m_flLastThink + THINK_FREQUENCY > Time() )
		return;

	m_flLastThink = Time();

	if ( m_nNumBirdsInMap >= MAX_BIRDS_SPAWNED )
		return;

	if ( m_flLastSpawnTime == 0 || m_flLastSpawnTime + SPAWN_FREQUENCY < Time() )
	{
		if ( m_BirdSpawnEnts.len() <= 0 )
			return;

		local nStartPos = RandomInt( 0, m_BirdSpawnEnts.len()-1 );
		m_nCurBirdArrayPos = nStartPos;

		local nDistance = 1600;
		// find any players close by
		local bFoundPlayer = false;
		local bNearOtherBirds = false;
		ent <- null;
		while( ( ent = Entities.FindByClassnameWithin( null, "player", m_BirdSpawnEnts[m_nCurBirdArrayPos].GetOrigin(), nDistance ) ) != null )
		{
			if ( ent )
			{
				bFoundPlayer = true;
				break;
			}
		}

		if ( bFoundPlayer == false )
		{
			// we got one!  now see if there are any birds close by, if so, dont spawn
			otherbird <- null;
			nDistance = 200;
			while( ( otherbird = Entities.FindByClassnameWithin( null, "logic_script", m_BirdSpawnEnts[m_nCurBirdArrayPos].GetOrigin(), nDistance ) ) != null )
			{
				if ( otherbird && otherbird.GetScriptScope() && otherbird.GetScriptScope().m_bIsBirdScript )
				{
					bNearOtherBirds = true;
					break;
				}
			}

			if ( bNearOtherBirds == false )
			{
				local bSuccessfull = false;
				//printl( "^^ bNearOtherBirds = false! trying to spawn a bird!" );
				// we really got one now!
				// spawn all of them in a radius
				for( j <- 0; j < m_BirdSpawnEnts.len(); j++ )
				{
					local dist = Distance3D(m_BirdSpawnEnts[j].GetOrigin(),m_BirdSpawnEnts[m_nCurBirdArrayPos].GetOrigin());
					//printl( "^^ dist = "+dist );
					if ( dist < 160 )
					{
						EntFire( m_BirdSpawnEnts[j].GetName(), "ForceSpawn", 0, 0 );
						//printl( "^^ Spawning a bird!" );
						// spawn successful		
						bSuccessfull = true;		
					}
				}

				if ( bSuccessfull == true )
				{
					m_flLastSpawnTime = Time();	
					return;
				}
			}
		}

		// didn't find a spawn spot, try the next spawner
		// try again next think
		m_nCurBirdArrayPos = (m_nCurBirdArrayPos + 1) % m_BirdSpawnEnts.len();
	}
}
