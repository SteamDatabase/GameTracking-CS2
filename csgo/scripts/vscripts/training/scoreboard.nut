m_nNumDigits <- 0

m_MatModEnts <- []
m_ReachedTargetRelay <- EntityGroup[0].GetName()

m_nScore <- 0
m_nTargetScore <- 1
m_nMaxScore <- 1

m_bInverted <- false

m_bTurnedOn <- true

/////////////////////////////////////////

// sets the number of digits in the display
// this should only be called inside the instance at the start of the map
function SetNumberOfDigits( nDigits )
{
	if ( nDigits < 0 || nDigits > 10 )
	{
		printl("Digit vale is out of range (" + nDigits + ").  Should be between 0 and 10.")
		return
	}

	m_nNumDigits <- nDigits

	// set the total max score based on the number of digits
	for ( local i = 0; i < m_nNumDigits; i++ )
	{	
		m_nMaxScore *= 10
		m_MatModEnts.append( EntityGroup[i+1].GetName() )
	}

	m_nScore = 0
	m_nMaxScore -= 1
	m_nTargetScore = m_nMaxScore

	// this has to be done to "initialize" the material modify or they'll all get updated when any of them do (not sure why)
	UpdateScore()
}

function SetTargetScore( nAmt )
{
	if ( nAmt < 0 )
		nAmt = 0

	if ( nAmt > m_nMaxScore )
		nAmt = m_nMaxScore

	// we just want to reduce the score if its going to fire the target score output again
	if ( m_nScore >= m_nTargetScore )
		m_nScore = m_nTargetScore - 1

	m_nTargetScore = nAmt

	UpdateScore()
}

function SetInverted( bInverted )
{
	m_bInverted = bInverted;
}

function AddTOScore( nAmt )
{
	m_nScore += nAmt

	if ( m_nScore > m_nMaxScore )
	{
		m_nScore = m_nMaxScore
	}

	UpdateScore()
}

function SubtractFromScore( nAmt )
{
	m_nScore -= nAmt

	if ( m_nScore < 0 )
	{
		m_nScore = 0
	}

	UpdateScore()
}

function ResetScore()
{
	m_nScore = 0

	if ( m_nScore < 0 )
		m_nScore = 0

	UpdateScore()
}

function TurnDisplayOn()
{
	m_bTurnedOn = true
	UpdateScore()
}

function TurnDisplayOff()
{
	m_bTurnedOn = false
	for ( local i = 0; i<m_nNumDigits; i++ )
	{		
		if ( m_MatModEnts[i] )
		{
			EntFire( m_MatModEnts[i], "SetMaterialVar", "10", 0 )
		}
	}
}

function UpdateScore()
{	
	if ( !m_bTurnedOn )
		return

	//printl("Updating score to " + m_nScore)
	local nDivider = 10;
	local nTempScore;
	if ( m_bInverted )
	{
		nTempScore = m_nTargetScore - m_nScore;
	} else
	{
		nTempScore = m_nScore;
	}

	for ( local i = 0; i<m_nNumDigits; i++ )
	{
		local sSetval = ( nTempScore % nDivider ) + ""
				
		if ( m_MatModEnts[i] )
		{
			EntFire( m_MatModEnts[i], "SetMaterialVar", sSetval, 0 )
		}

		nTempScore = nTempScore / nDivider
	}

	if ( m_nScore >= m_nTargetScore )
	{
		EntFire( m_ReachedTargetRelay, "Trigger", "", 0 )
	}
}
