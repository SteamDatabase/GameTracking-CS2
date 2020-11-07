m_bIsApcActivated <- false;

DEBUG <- false;

m_APC <- EntityGroup[0];
m_APCTrain <- EntityGroup[1];
m_APC_Wheel_R <- EntityGroup[2];
m_APC_Wheel_L <- EntityGroup[3];
m_MissionManagerScriptMaster <- EntityGroup[4];

APC_THINK_INTERVAL <- 0.15;
m_fNextApcThinkTime <- 0;

m_bFAST_DustOn <- false;
m_bSLOW_DustOn <- false;

m_flNextDustSpawn <- 0;
m_bInitialized <- false;
m_bApcIsMoving <- false;
m_bApcIsPausedAtGate <- false;
m_fNextApcPauseCheckTime <- 0;

APC_ENGINE_START_SOUND <- "coop_apc.ignition";
APC_MOVE_SOUND <- "coop_apc.driveLoop";
APC_STOP_SOUND <- "coop_apc.stopIdleLoop";

function OnPostSpawn()
{
	if ( m_bInitialized == false )
	{
		m_bInitialized = true;
		DoIncludeScript("dev/Util.nut",null);
	}
}

function Precache()
{
	self.PrecacheSoundScript( APC_ENGINE_START_SOUND );
	self.PrecacheSoundScript( APC_MOVE_SOUND );
	self.PrecacheSoundScript( APC_STOP_SOUND );
}

function PlayEngineStartSound()
{
	m_APC.EmitSound( APC_ENGINE_START_SOUND );
}

function EnableApc()
{
	m_bIsApcActivated = true;

	StartApcMoving();

	//EntFire( "@apc_train", "StartForward", "", 0 );
	//EntFire( "@apc_train", "SetSpeed", "0", 0.01 );	
}

function PauseApc()
{
	m_bApcIsPausedAtGate = true;
	m_fNextApcPauseCheckTime = Time() + 12;
	StopApcMoving();
	//EntFire( "@apc_trigger", "Disable", "", 0 );
}

function OpenApcGate( nGate )
{
	local nMission = ScriptCoopMissionGetMissionNumber( );
	if ( nMission != 3 )
		return;

	local flDelay = 3.5;

	if ( nGate == 5 )
		EntFire( "rl_apcstopgate5", "Kill", "", 0 );
	else if ( nGate == 4 )
		EntFire( "rl_apcstopgate4", "Kill", "", 0 );
	else if ( nGate == 3 )
		EntFire( "rl_apcstopgate3", "Kill", "", 0 );
	else if ( nGate == 2 )
	{
		EntFire( "rl_apcstopgate2", "Kill", "", 0 );
		flDelay = flDelay+3;	
	}
	else if ( nGate == 1 )
		EntFire( "rl_apcstopgate1", "Kill", "", 0 );

	if ( m_bApcIsPausedAtGate )
	{
		EntFire( "script_APC", "RunScriptCode", "StartApcMoving()", flDelay );
		//EntFire( "@apc_train", "StartForward", "", flDelay );
		//EntFire( "@apc_train", "SetSpeed", "0.5", flDelay + 0.1 );	
		
		m_bApcIsPausedAtGate = false;
	}

	// tell the main script what to spawn
	EntFire( "@coopmission_manager_script", "RunScriptCode", "SpawnEnemiesM3("+nGate+")", 0 ); 

}

function StartApcMoving()
{
	if ( m_bIsApcActivated == false )
		return;

	if ( m_bApcIsMoving == false )
	{
		EntFire( "@projlight_apc", "TurnOn", "", 0 );
	
		m_bApcIsMoving = true; 
		EntFire( "@apc_train", "Resume", "", 0 );
		EntFire( "@apc_train", "SetSpeed", "0.5", 0.1 ); 

		m_APC.StopSound( APC_STOP_SOUND );
		m_APC.EmitSound( APC_MOVE_SOUND );
	}
}

function StopApcMoving()
{
	if ( m_bIsApcActivated == false )
		return;

	if ( m_bApcIsMoving == true )
	{
		m_bApcIsMoving = false; 
		EntFire( "@apc_train", "Stop", "", 0 );
		EntFire( "@apc_velocity_remap", "InValue", 0+"", 0 );

		m_APC.EmitSound( APC_STOP_SOUND );
		m_APC.StopSound( APC_MOVE_SOUND );
	}
}

function SetNextgateNagDelay( delay )
{
	m_fNextApcPauseCheckTime = Time() + delay;
}

function APCThink()
{
	if ( m_bIsApcActivated == false )
		return;

	if ( m_fNextApcThinkTime > Time() )
		return;

	m_fNextApcThinkTime = Time() + APC_THINK_INTERVAL; 

	if ( m_bApcIsPausedAtGate && m_fNextApcPauseCheckTime <= Time() )
	{
		m_fNextApcPauseCheckTime = Time() + RandomInt( 15, 22 );

		if ( m_MissionManagerScriptMaster != null && m_MissionManagerScriptMaster.GetScriptScope().CanNagWaitingAtGateM3() )
		{
			// nag reminder
			EntFire( "@radiovoice","RunScriptCode", "PlayVcd( ReturnRandom(313,314,315,316,317,0) )", 0 );		
		}
	}

	local Vel = m_APC.GetVelocity();
	local X = Vel.x; 
 	local Y = Vel.y;

	// this modifier at the end is to account for the wheel size
 	local speed = sqrt(X*X + Y*Y) * 0.7;

	if ( m_bApcIsMoving )
		EntFire( "@apc_velocity_remap", "InValue", speed+"", 0 );
	
	local vecAPCPoint = m_APCTrain.GetOrigin();
	local vectorAPC = m_APC.GetForwardVector();
	local vecLookPointLong = m_APCTrain.GetFuturePosition( 3.5, 60 );  

	local angAPC = atan2(vectorAPC.y, vectorAPC.x);
	local angWheel = atan2(vecLookPointLong.y - vecAPCPoint.y, vecLookPointLong.x - vecAPCPoint.x);

	local angFinal = (angAPC - angWheel);
	// this turns radians into degrees
	angFinal = 360 * (angFinal / (2 * Pi));
	angFinal = angFinal % 360;
	if ( angFinal > 180 )
		angFinal = angFinal - 360;  

	local flRotPos = ((-angFinal*1.5)/360.0) + 0.5;

	if ( DEBUG )
	{
		printl( "GetForwardVector() = "+m_APC.GetForwardVector() );
		printl( "SPEED = "+speed );
		printl( "angAPC = "+angAPC );
		printl( "angWheel = "+angWheel );
		printl( ">>>> angFinal = "+angFinal );
		printl( ">>>>>> flRotPos = "+flRotPos );
	}

	if ( m_bApcIsMoving )
	{
		EntFire( m_APC_Wheel_R.GetName(), "SetPosition", flRotPos+"", 0 ); 
		EntFire( m_APC_Wheel_L.GetName(), "SetPosition", flRotPos+"", 0 ); 	
	}
 
	if ( speed > 12 )
	{
		if ( m_bSLOW_DustOn == false )
		{
			m_bSLOW_DustOn = true;
			EntFire( "@APC_dust_S", "Start", "", 0 );
		}
	}
	else
	{
		if ( m_bSLOW_DustOn == true )
		{
			m_bSLOW_DustOn = false;
			EntFire( "@APC_dust_S", "Stop", "", 0 );
		}
	}	
}


/////////////////////////////////////////
