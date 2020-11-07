m_nNumDigits <- 0

m_MatModEnts <- []
m_TimerEndedRelay <- EntityGroup[0].GetName()
m_SecDotsMatMod <- EntityGroup[1].GetName()

m_nDisplayTime <- 0
m_flLastRealTime <- 0
m_nMaxTime <- 1

m_bCountingDown <- false

m_flTimerIncrement <- 0.1

m_bTimerRunning <- false

m_bTurnedOn <- true

/////////////////////////////////////////

// sets the number of digits in the display
function SetNumberOfDigits( nDigits )
{
	printl("SetNumberOfDigits( " + nDigits + " )")
	if ( nDigits < 0 || nDigits > 10 )
	{
		printl("Digit value is out of range (" + nDigits + ").  Should be between 0 and 10.")
		return
	}

	m_nNumDigits <- nDigits
	local nMultiplier = 1

	// set the total max score based on the number of digits
	for ( local i = 0; i < m_nNumDigits; i++ )
	{	
		if ( m_nNumDigits > 3 && i > 0 )
		{
			m_nMaxTime *= 6
		}
		else
		{
			m_nMaxTime *= 10
		}
		
		// start at 2 because the first two are other things (output relay and the seconds dot material)
		m_MatModEnts.append( EntityGroup[i+2].GetName() )
	}

	m_nMaxTime -= 1

	// this has to be done to "initialize" the material modify or they'll all get updated when any of them do (not sure why)
	UpdateDisplay()
}

function StartCountDownFrom( nFromTime )
{
	if ( nFromTime < 0 )
		nFromTime = 0

	if ( nFromTime > m_nMaxTime )
		nFromTime = m_nMaxTime

	m_bCountingDown = true

	m_nDisplayTime = (nFromTime * 10)

	StartTimer()
}

function SetCountDownFrom( nFromTime )
{
	if ( nFromTime < 0 )
		nFromTime = 0

	if ( nFromTime > m_nMaxTime )
		nFromTime = m_nMaxTime

	m_bCountingDown = true

	m_nDisplayTime = (nFromTime * 10)

	UpdateDisplay()
}

function StartTimer()
{
	printl("** StopTimer()");
	m_bTimerRunning = true
}

function StopTimer()
{
	printl("** StopTimer()");
	m_bTimerRunning = false
}

function ResetTimer()
{
	m_nDisplayTime = 0

	UpdateDisplay()
}

function TurnDisplayOn()
{
	m_bTurnedOn = true
	EntFire( m_SecDotsMatMod, "SetMaterialVar", "0", 0 )
	UpdateDisplay()
}

function TurnDisplayOff()
{
	m_bTurnedOn = false
	EntFire( m_SecDotsMatMod, "SetMaterialVar", "1", 0 )
	for ( local i = 0; i<m_nNumDigits; i++ )
	{		
		if ( m_MatModEnts[i] )
		{
			EntFire( m_MatModEnts[i], "SetMaterialVar", "10", 0 )
		}
	}
}

function Think()
{
	if ( m_bTimerRunning == false )
		return

	//printl("** Think() start");
	if ( m_bCountingDown == true && m_nDisplayTime <= 0 )
	{
		StopTimer()
		m_bCountingDown = false
		
		EntFire( m_TimerEndedRelay, "Trigger", "", 0 )
		ResetTimer()
		return
	}
	else if ( (m_bCountingDown == false && m_nDisplayTime >= m_nMaxTime) )
	{
		StopTimer()
		EntFire( m_TimerEndedRelay, "Trigger", "", 0 )
		return
	}
		

	local flRealTime = Time()
	//printl("** Think() - flRealTime = "+flRealTime );
	if ( (flRealTime + m_flTimerIncrement) >= m_flLastRealTime )
	{
		// we store the time as an int, but we always want to keep track of the tenth
		if ( m_bCountingDown )
		{
			m_nDisplayTime -= (m_flTimerIncrement*10)
		}
		else
		{
			m_nDisplayTime += (m_flTimerIncrement*10)
		}
		
		if ( m_nDisplayTime < 0 )
			m_nDisplayTime = 0

		if ( m_nDisplayTime > m_nMaxTime )
			m_nDisplayTime = m_nMaxTime

		m_flLastRealTime = flRealTime
		UpdateDisplay()
	}

}

function UpdateDisplay()
{	
	if ( !m_bTurnedOn )
		return

	local nDivider = 10;
	local nTempDisplay = m_nDisplayTime;

	//printl("Updating time to " + m_nDisplayTime)

	if ( m_nNumDigits > 3 )
	{
		local nMilliseconds = floor(m_nDisplayTime % 10);
		local nSeconds = floor((m_nDisplayTime/10) % 60) * 10;
		local nMinutes = floor((m_nDisplayTime/600) % 60) * 1000;
		local nHours = floor((m_nDisplayTime/36000) % 24) * 100000;

		nTempDisplay = nHours + nMinutes + nSeconds + nMilliseconds;
		//printl("Displaying " + nHours + ":" + nMinutes + ":" + nSeconds + ":" + nMilliseconds)
	}

	for ( local i = 0; i<m_nNumDigits; i++ )
	{
		local sSetval = ( nTempDisplay % nDivider ) + ""
				
		if ( m_MatModEnts[i] )
		{
			if( sSetval.tofloat() < 0 )
			{
				printl(" *** display SetMaterialVar value " + sSetval + " is negative! Clamping to 0.  This shouldn't happen!" )
				printl(" *** display SetMaterialVar value " + sSetval + " is negative! Clamping to 0.  This shouldn't happen!" )
				printl(" *** display SetMaterialVar value " + sSetval + " is negative! Clamping to 0.  This shouldn't happen!" )
				
				sSetval = 0 + ""
			}
			
			//printl( "** ("+i+") -- " + sSetval );
			EntFire( m_MatModEnts[i], "SetMaterialVar", sSetval, 0 )
		}

		nTempDisplay = nTempDisplay / nDivider
	}
}