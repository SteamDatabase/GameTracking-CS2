///////
///////
///////

m_bIsRunningTargetsNoFlash <- false
m_bIsRunningTargetsWithFlash <- false

m_bWasFlashed <- false

// completed bools
m_bCompletedTargetsNoFlash <- false
m_bCompletedTargetsWithFlash <- false

function PlayerEnterTestArea()
{
	EntFire ( "@radiovoice","RunScriptCode", "FlashBangIntro()", 0 )
}

function DisplayInitialGunHint()
{
	EntFire( "@hint_take_fb_gun", "ShowHint", "", 0 )
}

// this will fire when you pick up the gun from the table
function StartTest()
{
	if ( !m_bCompletedTargetsNoFlash )
	{
		EntFire ( "@radiovoice","RunScriptCode", "FlashBangNoFlashStart()", 0 )
		//StartRunning() is called from within this relay
		EntFire( "@rl_no_flash_shoot_targs", "Trigger", "" )
		printl( "rl_no_flash_shoot_targs" );
		return
	}

	if ( !m_bCompletedTargetsWithFlash )
	{
		EntFire ( "@radiovoice","RunScriptCode", "FlashBangFlashStart()", 0 )
		//StartRunningTargetsWithFlash() is called from within this relay
		EntFire( "@rl_flash_shoot_targs", "Trigger", "" )
		printl( "rl_flash_shoot_targs" )
		
		// only display the hint if the player was previously flashed
		if( m_bWasFlashed )
		{
			DisplaySpinHint()
		}
		
		return
	}
	
}

function CompleteTest()
{
	if ( !m_bCompletedTargetsNoFlash )
	{
		EntFire ( "@radiovoice","RunScriptCode", "FlashBangNoFlashComplete()", 0 )
		CompleteTargetsNoFlashTest()
		EntFire( "@rl_no_shoot_targs_stop", "Trigger", "", 2 )
		return
	}

	if ( m_bCompletedTargetsNoFlash && !m_bCompletedTargetsWithFlash )
	{
		EntFire ( "@radiovoice","RunScriptCode", "FlashBangFlashComplete()", 0 )
		CompleteTargetsWithFlashTest()
		EntFire( "@rl_flash_win", "Trigger", "", 0 )
		printl( "YOU WIN!!!" );
		return
	}
}

function StartRunningTargetsNoFlash()
{
	m_bIsRunningTargetsNoFlash = true
	m_bWasFlashed = false
}

function StopRunningTargetsNoFlash()
{
	m_bIsRunningTargetsNoFlash = false
}

function CompleteTargetsNoFlashTest()
{
	StopRunningTargetsNoFlash()
	m_bCompletedTargetsNoFlash = true
}

function StartRunningTargetsWithFlash()
{
	m_bIsRunningTargetsWithFlash = true
	m_bWasFlashed = false
}

function StopRunningTargetsWithFlash()
{
	m_bIsRunningTargetsWithFlash = false
}

function CompleteTargetsWithFlashTest()
{
	StopRunningTargetsWithFlash()
	m_bCompletedTargetsWithFlash = true
}

function OutOfAmmo()
{
	if ( (m_bIsRunningTargetsNoFlash && !m_bCompletedTargetsNoFlash) || 
		(m_bIsRunningTargetsWithFlash && !m_bCompletedTargetsWithFlash) )
	{
		RoundFailed( 1 )
	}
}

// the player has been flashbanged enough to where they cannot see and will most likely not be able to hit the targets
function FlashBanged()
{
	EntFire ( "@radiovoice","RunScriptCode", "FlashBangFlashed()", 0 )
	m_bWasFlashed = true
	
	if ( m_bIsRunningTargetsWithFlash )
	{
		
	}
}

function RoundFailed( reason )
{
	EntFire( "@rl_no_shoot_targs_stop", "Trigger", "" )
	if ( m_bIsRunningTargetsNoFlash )
	{
		StopRunningTargetsNoFlash()
		EntFire ( "@radiovoice","RunScriptCode", "FlashBangFailedTargets()", 0 )	
	}

	if ( m_bIsRunningTargetsWithFlash )
	{
		StopRunningTargetsWithFlash()
		if ( !m_bWasFlashed )
		{
			EntFire ( "@radiovoice","RunScriptCode", "FlashBangFailedTargets()", 0 )	
		}
	}

	if ( reason == 1 )
	{
		EntFire( "@hint_fail_outofammo", "ShowHint", "", 0 )
	}
	else if ( reason == 2 )
	{
		//EntFire( "@hint_fail_outoftime", "ShowHint", "", 0 )
	}
}

function DisplaySpinHint()
{
	if( ScriptIsLocalPlayerUsingController() )
	{
		EntFire("@hint_look_away", "showhint", 0 )
	}
}