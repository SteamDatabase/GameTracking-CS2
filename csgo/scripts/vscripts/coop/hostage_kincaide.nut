
m_bDroppedTimes <- 0;
m_nUseTimes <- 0;

function Precache()
{
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_dropped" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_extaract" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_extaract_alt01" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_extaract_alt_01" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_extaract_alt_02" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_extaract_alt_03" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_panic_01" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_panic_02" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_panic_03" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_panic_04" );
	self.PrecacheScriptSound( "coop_radio.m1_kincaide_rescue" );

	self.PrecacheScriptSound( "coop_radio.m1_forklift_room_01" );
	self.PrecacheScriptSound( "coop_radio.m1_forklift_idle_01" );
	self.PrecacheScriptSound( "coop_radio.m1_forklift_idle_02" );
	self.PrecacheScriptSound( "coop_radio.m1_forklift_idle_02_alt01" );
}

function OnPostSpawn()
{
	printl( "-------------------------hostage kincaide OnPostSpawn" );
}
function CheckIsBeingCarried()
{
	return self.IsBeingCarried();
}
function OnFirstSpotted()
{
	// hello who's there
	EntFire( "mission01_hostage","RunScriptCode", "OnFirstSpottedTalk()", 2.5 );
}

function OnFirstSpottedTalk()
{
	// hello who's there
	self.EmitSound( "coop_radio.m1_forklift_room_01" );
}

function OnHostageBeginGrab()
{
	if ( m_nUseTimes <= 0 )
		self.EmitSound( "coop_radio.m1_forklift_idle_02_alt01" );

	m_nUseTimes++;
}

function OnPickedUpFirstTime()
{
	self.EmitSound( "coop_radio.m1_kincaide_rescue" );

	EntFire( "mission01_hostage","RunScriptCode", "OnPickedUpFirstTime2()", 2.25 );
}

function OnPickedUpFirstTime2()
{
	self.EmitSound( "coop_radio.m1_kincaide_extaract_alt_03" );
}

function StartStory01()
{
	self.EmitSound( "coop_radio.m1_kincaide_extaract_alt_02" );
}

function OnDropped()
{
	if ( m_bDroppedTimes == 0 )
		m_bDroppedTimes = RandomInt( 1, 3 );

	m_bDroppedTimes++;
	if ( m_bDroppedTimes >= 4 )
		m_bDroppedTimes = 1;

	switch (m_bDroppedTimes)
	{
		case 1: 
			self.EmitSound( "coop_radio.m1_kincaide_dropped" )
			break
		case 2:
			self.EmitSound( "coop_radio.m1_kincaide_panic_04" )
			break
		case 3:
			self.EmitSound( "coop_radio.m1_kincaide_panic_01" )
			break
	}
}

function OnRescued()
{
	self.EmitSound( "coop_radio.m1_kincaide_rescue" );
}

