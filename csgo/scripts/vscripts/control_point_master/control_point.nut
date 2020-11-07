

MAX_PLAYERS_ON_CAP <- 5;
THINK_FREQUENCY <- 0.5;
// how much each person adds to the cap amount (on a range from 0 - 1000)
DEFAULT_CAP_AMT_PER_TICK <- 25;
// how much each player contributes to the CAP AMT
EACH_PLAYER_MULTIPLIER <- 1.7;
// this should match the "Move Distance" for the func_move_linear that controls the flag
FLAG_TOTAL_MOVE_DISTANCE <- 220;

// these match the enties defined in the EntityGroup entries in the logic_script entity in Hammer
m_FlagBrush_T <- EntityGroup[0].GetName();
m_FlagBrush_CT <- EntityGroup[1].GetName();
m_MdlFlag_T <- EntityGroup[2].GetName();
m_MdlFlag_CT <- EntityGroup[3].GetName();
m_SoundFlag <- EntityGroup[4].GetName();
m_RelayCapture_T <- EntityGroup[5].GetName();
m_RelayLost_T <- EntityGroup[6].GetName();
m_RelayCapture_CT <- EntityGroup[7].GetName();
m_RelayLost_CT <- EntityGroup[8].GetName();

m_flNextThink <- 0;

// the number of players currently on the cap
m_nNumPlayers_T <- 0
m_nNumPlayers_CT <- 0

// for simplicity, this is 0-1000
m_nCaptureAmt_T <- 0
m_nCaptureAmt_CT <- 0

m_nBaseCapAmtPerTick <- DEFAULT_CAP_AMT_PER_TICK;

function SetBaseCapAmtPerTick( nAmount )
{
	// If this function isn't called, it's DEFAULT_CAP_AMT_PER_TICK per THINK_FREQUENCY
	// which is 25 every 0.5 seconds.  Use this function to increase or decrease the speed at which the flag will cap when someone is on it
	// NOTE! scaling per number of players is already handled below.  Increasing this will just increase the base cap per tick
	m_nBaseCapAmtPerTick = nAmount;
}

function AddPlayer_Terrorist()
{
	m_nNumPlayers_T++;
	if ( m_nNumPlayers_T > MAX_PLAYERS_ON_CAP )
	{
		m_nNumPlayers_T = MAX_PLAYERS_ON_CAP;
	}
}

function RemovePlayer_Terrorist()
{
	m_nNumPlayers_T--;
	if ( m_nNumPlayers_T < 0 )
	{
		m_nNumPlayers_T = 0;
	}
}

function AddPlayer_CT()
{
	m_nNumPlayers_CT++;
	if ( m_nNumPlayers_CT > MAX_PLAYERS_ON_CAP )
	{
		m_nNumPlayers_CT = MAX_PLAYERS_ON_CAP;
	}
}

function RemovePlayer_CT()
{
	m_nNumPlayers_CT--;
	if ( m_nNumPlayers_CT < 0 )
	{
		m_nNumPlayers_CT = 0;
	}
}

function ResetCapPoint()
{
	m_nCaptureAmt_T = 0;
	m_nCaptureAmt_CT = 0;

	EntFire( m_SoundFlag, "StopSound", "", 0 );
	EntFire( m_MdlFlag_T, "Disable", "", 0 );
	EntFire( m_MdlFlag_CT, "Disable", "", 0 );

	EntFire( m_MdlFlag_T, "SetGlowDisabled", "", 0 );
	EntFire( m_MdlFlag_CT, "SetGlowDisabled", "", 0 );

	EntFire( m_FlagBrush_T, "SetPosition", "0", 0 );
	EntFire( m_FlagBrush_CT, "SetPosition", "0", 0 );
}

function CaptureThink()
{
	if ( m_flNextThink > Time() )
		return;

	m_flNextThink = Time() + THINK_FREQUENCY;

	//printl( "CaptureThink is thinking!" );

	if ( m_nNumPlayers_T == 0 && m_nNumPlayers_CT == 0 )
	{
		// there are no players on the point!  do nothing!
		return;
	}

	if ( m_nNumPlayers_T > 0 && m_nNumPlayers_CT > 0 )
	{
		// we have players from both sides on the point.  stalemate!  do nothing!
		printl( "we have players from both sides on the point.  stalemate!  do nothing!" );
		return;
	}

	local flPrevAmtT = m_nCaptureAmt_T;
	local flPrevAmtCT = m_nCaptureAmt_CT;

	if ( m_nNumPlayers_T > 0 )
	{
		local flMulti = 1;
		for ( local i = 2; i<=m_nNumPlayers_T; i++ )
		{
			flMulti *= EACH_PLAYER_MULTIPLIER;
		}

		m_nCaptureAmt_T = m_nCaptureAmt_T + (m_nBaseCapAmtPerTick * flMulti);
		if ( m_nCaptureAmt_T > 1000 )
			m_nCaptureAmt_T = 1000;

		if ( flPrevAmtT < 1000 && m_nCaptureAmt_T == 1000 )
		{
			// we just capped
			EntFire( m_RelayCapture_T, "Trigger", "", 0 );
			EntFire( m_MdlFlag_T, "SetGlowEnabled", "", 0 );
			EntFire( m_MdlFlag_CT, "SetGlowDisabled", "", 0 );

			if ( m_nCaptureAmt_CT == 1000 )
			{
				// CT's lost the point
				EntFire( m_RelayLost_CT, "Trigger", "", 0 );
			}

			// CT's get set to 0, the position of the flag will get updated below
			m_nCaptureAmt_CT = 0;
		}
		//printl( "m_nNumPlayers_T = " + m_nNumPlayers_T + ", m_nCaptureAmt_T = " + m_nCaptureAmt_T );
	}
	
	if ( m_nNumPlayers_CT > 0 )
	{
		local flMulti = 1;
		for ( local i = 2; i<=m_nNumPlayers_CT; i++ )
		{
			flMulti *= EACH_PLAYER_MULTIPLIER;
		}

		m_nCaptureAmt_CT = m_nCaptureAmt_CT + (m_nBaseCapAmtPerTick * flMulti);
		if ( m_nCaptureAmt_CT > 1000 )
			m_nCaptureAmt_CT = 1000;

		if ( flPrevAmtCT < 1000 && m_nCaptureAmt_CT == 1000 )
		{
			// we just capped
			EntFire( m_RelayCapture_CT, "Trigger", "", 0 );
			EntFire( m_MdlFlag_T, "SetGlowDisabled", "", 0 );
			EntFire( m_MdlFlag_CT, "SetGlowEnabled", "", 0 );

			if ( m_nCaptureAmt_T == 1000 )
			{
				// T's lost the point
				EntFire( m_RelayLost_T, "Trigger", "", 0 );
			}

			// T's get set to 0, the position of the flag will get updated below
			m_nCaptureAmt_T = 0;
		}
		//printl( "m_nNumPlayers_CT = " + m_nNumPlayers_CT + ", m_nCaptureAmt_CT = " + m_nCaptureAmt_CT );
	}

	if ( m_nCaptureAmt_T > 0 || m_nCaptureAmt_CT > 0 )
	{
		EntFire( m_SoundFlag, "PlaySound", "", 0 );
	}
	else
	{
		EntFire( m_SoundFlag, "StopSound", "", 0 );
	}

	if ( m_nCaptureAmt_T > 50 )
		EntFire( m_MdlFlag_T, "Enable", "", 0 );
	else
		EntFire( m_MdlFlag_T, "Disable", "", 0 );

	if ( m_nCaptureAmt_CT > 50 )
		EntFire( m_MdlFlag_CT, "Enable", "", 0 );
	else
		EntFire( m_MdlFlag_CT, "Disable", "", 0 );

	//FLAG_TOTAL_MOVE_DISTANCE

	local flSpeedT = "" + abs( m_nCaptureAmt_T - flPrevAmtT ) * THINK_FREQUENCY;
	EntFire( m_FlagBrush_T, "SetSpeed", flSpeedT, 0 );
	local flTAmt = "" + m_nCaptureAmt_T/1000.0;
	EntFire( m_FlagBrush_T, "SetPosition", flTAmt, 0 );

	local flSpeedCT = "" + abs( m_nCaptureAmt_CT - flPrevAmtCT ) * THINK_FREQUENCY;
	EntFire( m_FlagBrush_CT, "SetSpeed", flSpeedCT, 0 );
	local flCTAmt = "" + m_nCaptureAmt_CT/1000.0;
	EntFire( m_FlagBrush_CT, "SetPosition", flCTAmt, 0 );
}

/////////////////////////////////////////
