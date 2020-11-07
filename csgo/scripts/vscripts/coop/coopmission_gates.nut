
m_OpenGateRelay <- EntityGroup[0];
m_ButtonL <- EntityGroup[1];
m_ModelL <- EntityGroup[2];
m_ButtonR <- EntityGroup[3];
m_ModelR <- EntityGroup[4];
m_DisableButtonsRelay <- EntityGroup[5];
m_GlowL <- EntityGroup[6];
m_GlowR <- EntityGroup[7];

m_bGateOpened <- false;

m_bSwitchDown_L <- false;
m_bSwitchDown_R <- false;

SND_FAIL <- "Buttons.snd11";
SND_LEVER <- "coop_apc.gateLever";

function Precache()
{
	self.PrecacheScriptSound( SND_FAIL );
	self.PrecacheScriptSound( SND_LEVER );
}

function OnPostSpawn()
{
	EntFire( m_DisableButtonsRelay.GetName(), "Trigger", "", 1 );	
}

function GateThink()
{
	if ( m_bGateOpened == false && m_bSwitchDown_R == true && m_bSwitchDown_L == true )
	{
		m_bGateOpened = true;
		EntFire( m_OpenGateRelay.GetName(), "Trigger", "", 0 );	
		//printl( "m_OpenGateRelay.GetName() - Trigger" );
	}
}

function OnCloseGate()
{
	m_bGateOpened = false;
	m_bSwitchDown_R = false;
	m_bSwitchDown_L = false;

	EntFire( m_DisableButtonsRelay.GetName(), "Trigger", "", 0 );

	//printl( "OnCloseGate()" );
}

function PulledLeftSwitchStart()
{
	m_ButtonL.EmitSound( SND_LEVER );

	EntFire( m_ModelL.GetName(), "SetAnimationNoReset", "pull_down", 0 );	
	EntFire( m_ButtonL.GetName(), "Lock", "", 0 );	
	EntFire( m_GlowL.GetName(), "Color", "0 255 0", 0.6 );	
	EntFire( self.GetName(), "RunScriptCode", "PulledLeftSwitch()", 0.6 );	
	EntFire( self.GetName(), "RunScriptCode", "LeftSwitchExpired()", 1.5 );	
}

function PulledLeftSwitch()
{
	m_bSwitchDown_L = true;
}

function LeftSwitchExpired()
{
	if ( m_bGateOpened == false )
	{
		m_bSwitchDown_L = false;
		m_ButtonL.EmitSound( SND_FAIL );

		EntFire( m_GlowL.GetName(), "Color", "255 255 0", 0.0 );	
		EntFire( m_ModelL.GetName(), "SetAnimationNoReset", "return_up", 0 );	
		EntFire( m_ButtonL.GetName(), "PressOut", "", 0 );	
		EntFire( m_ButtonL.GetName(), "Unlock", "", 0.25 );		
	}
}

function PulledRightSwitchStart()
{
	m_ButtonR.EmitSound( SND_LEVER );

	EntFire( m_ModelR.GetName(), "SetAnimationNoReset", "pull_down", 0 );	
	EntFire( m_ButtonR.GetName(), "Lock", "", 0 );	
	EntFire( m_GlowR.GetName(), "Color", "0 255 0", 0.6 );	
	EntFire( self.GetName(), "RunScriptCode", "PulledRightSwitch()", 0.6 );
	EntFire( self.GetName(), "RunScriptCode", "RightSwitchExpired()", 1.5 );	
}

function PulledRightSwitch()
{
	m_bSwitchDown_R = true;
}

function RightSwitchExpired()
{
	if ( m_bGateOpened == false )
	{
		m_bSwitchDown_R = false;
		m_ButtonR.EmitSound( SND_FAIL );

		EntFire( m_GlowR.GetName(), "Color", "255 255 0", 0.0 );
		EntFire( m_ModelR.GetName(), "SetAnimationNoReset", "return_up", 0 );	
		EntFire( m_ButtonR.GetName(), "PressOut", "", 0 );	
		EntFire( m_ButtonR.GetName(), "Unlock", "", 0.25 );		
	}
}
