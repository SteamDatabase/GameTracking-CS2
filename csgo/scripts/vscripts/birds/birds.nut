m_bIsBirdScript <- true;

m_bInitialized <- false;
m_MasterScript <- null;

THINK_FREQUENCY <- 0.5;
START_FADING_TIME <- 5.5;
m_flLastThink <- 0;
m_bIsFlying <- false;

m_flFlyAwayStart <- -1;
m_nAlpha <- 255;

m_bIsIdling <- false;
m_bIsDestroyed <- false;

m_bIsAlerted <- false;
m_bPlaySound <- true;
m_nBirdType <- 0; // 0 = seagull, 1 = pigeon, 2 = crow

m_bGeneratedRandomIdleTime <- false;
m_bRandomIdleTime <- -1;

function SetBirdType( nType )
{
	// 0 = seagull, 1 = pigeon, 2 = crow
	m_nBirdType <- nType; 
}

function FindPlayersCloseBy()
{
	ent <- null;

	local nDistance = 400;
	while( ( ent = Entities.FindByClassnameWithin( null, "player", EntityGroup[0].GetOrigin(), nDistance ) ) != null )
	{
		if ( ent )
			return true;
	}
}

function BirdThink()
{
	if ( m_bInitialized == false )
	{
		master <- null;
		while( ( master = Entities.FindByClassname( null, "logic_script" ) ) != null )
		{
			if ( master )
			{
				m_MasterScript = master;
				m_bInitialized = true;
				m_MasterScript.GetScriptScope().AddBird();
				break;
			}
		}
	}

	if ( m_bIsDestroyed || EntityGroup[0] == null )
		return;

	if ( m_flLastThink + THINK_FREQUENCY > Time() )
		return;

	m_flLastThink = Time();

	if ( m_bIsFlying == true ) 
	{
		if ( m_flFlyAwayStart + START_FADING_TIME < Time() )
		{
			m_nAlpha = m_nAlpha - 10;
			if ( m_nAlpha <= 0 )
			{
				CleanupBird();
				return;
			}

			local alpha = m_nAlpha + "";
			EntFire( EntityGroup[0].GetName(), "Alpha", alpha, 0 );
			//printl( "^^ Setting Alpha to "+alpha );
		}

		return;
	}
	else if ( (m_flFlyAwayStart != -1 && m_flFlyAwayStart < Time()) )
	{
		FlyAwayBird();
	}
	else if ( FindPlayersCloseBy() )
	{
		local nRandomDelay = RandomInt(0,35);
		local flDelay = nRandomDelay/100.0;
		FlyAwayAfterDelay( flDelay );

		ScareOtherNearbyBirds();
	}
	else if ( m_bIsIdling == false )
	{
		if ( m_bGeneratedRandomIdleTime == false )
		{
			local nRandomDelay = RandomInt(0,80);
			//printl( "^^ nRandomDelay = "+nRandomDelay );
			local flDelay = nRandomDelay/100.0;
			m_bRandomIdleTime = Time() + flDelay;
			m_bGeneratedRandomIdleTime = true; 
		}
		 
		if ( m_bRandomIdleTime < Time() )
		{
			EntFire( EntityGroup[0].GetName(), "SetAnimation", "Idle01", 0 );
			m_bIsIdling = true;

			// find another bird nearby and face it
			//local vecDir = EntityGroup[0].GetForwardVector();

			local vecOtherBirdOrigin = Vector(0, 0, 0);
			otherbird <- null;
			local nDistance = 128;
			while( ( otherbird = Entities.FindByClassnameWithin( null, "logic_script", EntityGroup[0].GetOrigin(), nDistance ) ) != null )
			{
				if ( otherbird )
				{
					local scope = otherbird.GetScriptScope();
					if ( scope.m_bIsBirdScript == true )
					{
						vecOtherBirdOrigin = otherbird.GetOrigin();
						break;
					}
				}
			}

			local vecDir = vecOtherBirdOrigin - EntityGroup[0].GetOrigin();
			local flNorm = vecDir.Norm();
			//printl( "^^ flNorm = "+flNorm );
			vecDir.x = vecDir.x / flNorm;
			vecDir.y = vecDir.y / flNorm;
			vecDir.z = 0;

			//printl( "^^ vecDir.x = "+vecDir.x );
			//printl( "^^ vecDir.y = "+vecDir.y );
			//printl( "^^ vecDir.z = "+vecDir.z );

			// randomly set direction		
			EntityGroup[3].SetForwardVector( vecDir );
			EntityGroup[0].SetForwardVector( vecDir );

			EntFire( EntityGroup[1].GetName(), "TeleportToPathNode", EntityGroup[3].GetName(), 0 );
			EntFire( EntityGroup[0].GetName(), "SetParent", EntityGroup[1].GetName(), 0.1 );
			//printl( "^^ m_bRandomIdleTime < Time()" );
		}
	}
}

function FlyAwayAfterDelay( flDelay )
{
	if ( m_bIsFlying == true )
		return;

	m_flFlyAwayStart = Time() + flDelay;
	ScareOtherNearbyBirds();
}

function FlyAwayBird()
{
	if ( m_bIsFlying == true || m_bIsDestroyed == true || EntityGroup[0] == null )
		return;

	EntFire( EntityGroup[0].GetName(), "SetAnimation", "Takeoff", 0 );
	EntFire( EntityGroup[1].GetName(), "SetSpeed", 120, 0.65 );
	
	if ( m_nBirdType == 0 )
	{
		if ( m_bPlaySound )
			EntFire( EntityGroup[2].GetName(), "PlaySound", 0, 0.65 );

		EntFire( EntityGroup[1].GetName(), "StartForward", 0, 0.65 );
		EntFire( EntityGroup[0].GetName(), "SetParent", EntityGroup[1].GetName(), 0.7 );
	}
	else
	{
		if ( m_bPlaySound )
			EntFire( EntityGroup[2].GetName(), "PlaySound", 0, 0.3 );
				
		EntFire( EntityGroup[1].GetName(), "StartForward", 0, 0.3 );
		EntFire( EntityGroup[0].GetName(), "SetParent", EntityGroup[1].GetName(), 0.35 );	
	}

	if ( m_nBirdType == 0 )
		EntFire( EntityGroup[0].GetName(), "SetAnimation", "Fly", 1.65 );
	else
		EntFire( EntityGroup[0].GetName(), "SetAnimation", "Fly01", 1.0 );

	EntFire( EntityGroup[2].GetName(), "StopSound", 0, 3.0 );

	m_bIsFlying = true; 
	m_flFlyAwayStart <- Time();
	THINK_FREQUENCY = 0.25;	
}

function ScareOtherNearbyBirds()
{
	if ( m_bIsAlerted == true )
		return;

	m_bIsAlerted = true;

	ent <- null;
	local nDistance = 128;
	while( ( ent = Entities.FindByClassnameWithin( null, "logic_script", EntityGroup[0].GetOrigin(), nDistance ) ) != null )
	{
		if ( ent && ent.GetScriptScope() )
		{
			//printl( "^^ Found ScriptScope!!!! ("+ent.GetName()+")" );
			local scope = ent.GetScriptScope();

			if ( scope.m_bIsBirdScript == true && scope.m_bIsAlerted != true )
			{
				local nRandomDelay = RandomInt(0,5);
				local flDelay = nRandomDelay/10.0;
				scope.m_bPlaySound = false;
				scope.FlyAwayAfterDelay( flDelay );
				//printl( "^^ FlyAwayAfterDelay!!!! ("+flDelay+")" );
			}
			return;
		}
	}
}

function Hurtme()
{
	if ( m_bIsDestroyed || EntityGroup[0] == null )
		return;

	//printl( "^^ Hurtme!!!!" );

	DispatchParticleEffect( "chicken_gone", EntityGroup[0].GetOrigin(), EntityGroup[0].GetForwardVector() );

	ScareOtherNearbyBirds();

	if ( EntityGroup[1] == null )
		return;

	//printl( "^^ EntityGroup[1] = "+EntityGroup[1]+", EntityGroup[1].GetName() = "+EntityGroup[1].GetName() );
	EntFire( EntityGroup[1].GetName(), "StartForward", 0, 0 );	

	CleanupBird();
}

function CleanupBird()
{
	EntityGroup[0].Destroy();
	EntityGroup[1].Destroy();
	EntityGroup[2].Destroy();
	EntityGroup[3].Destroy();
	m_bIsDestroyed = true;

	m_MasterScript.GetScriptScope().SubtractBird();
}

/////////////////////////////////////////
