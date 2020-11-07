m_nHealth <- 0
m_nMaxHealth <- 1

// amount of time to suppress target speech after grenade throw
GRENADE_DELAY <- 4 // default: 4

m_HealthZeroRelay <- EntityGroup[0].GetName()
m_MatModHealthDisplay <- EntityGroup[1].GetName()

m_bENABLED <- false;

/////////////////////////////////////////

// sets the max health and also sets the health to the max
function SetMaxHealth( nHealth )
{
	if ( nHealth < 0 || nHealth > 10 )
	{
		printl("Digit value is out of range (" + nHealth + ").  Should be between 0 and 10.")
		return
	}

	m_nHealth = nHealth
	m_nMaxHealth = nHealth

	// this has to be done to "initialize" the material modify or they'll all get updated when any of them do (not sure why)
	UpdateDisplay()
}

function Enable()
{
	m_bENABLED = true
	EntFire( m_MatModHealthDisplay, "SetMaterialVar", m_nHealth + "", 0 )
}

function Disable()
{
	m_bENABLED = false
	EntFire( m_MatModHealthDisplay, "SetMaterialVar", 0 + "", 0 )
}

// determines if body damage dialog should be played or not based on last grenade throw time
function ShouldPlayBodyDamageDialog()
{
	if( ( g_GetGrenadeLastThrowTime() + GRENADE_DELAY ) < Time() )
	{
		return true
	}
	
	return false
}
 
function HitHead()
{
	if( ShouldPlayBodyDamageDialog() )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BodyDamageHeadShot()", 0 )
	}
	
	local activeWeapon = g_GetActiveWeapon()
	local primaryWeapon = g_GetPrimaryWeapon()
	printl(" *** Player currently wielding weapon category '" + activeWeapon + "' and primary is '" +  primaryWeapon + "'" )

	if ( (primaryWeapon == "awp" && activeWeapon == "sniper") || (primaryWeapon == "ak" && activeWeapon == "rifle") )
	{
		SubtractFromHealth( 10 );
	}
	else
	{
		SubtractFromHealth( 5 );
	}
}

function HitChest()
{
	if( ShouldPlayBodyDamageDialog() )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BodyDamageChestShot()", 0 )
	}
	
	local activeWeapon = g_GetActiveWeapon()	
	local primaryWeapon = g_GetPrimaryWeapon()

	if ( (primaryWeapon == "awp" && activeWeapon == "sniper") )
	{
		SubtractFromHealth( 5 );
	}
	else if ( (primaryWeapon == "ak" && activeWeapon == "rifle") || activeWeapon == "knife" )
	{
		SubtractFromHealth( 3 );
	}
	else if ( activeWeapon == "smg" )
	{
		SubtractFromHealth( 1.75 );
	}
	else
	{
		SubtractFromHealth( 2 );
	}
}

function HitLegs()
{
	if( ShouldPlayBodyDamageDialog() )
	{
		EntFire ( "@radiovoice","RunScriptCode", "BodyDamageLegShot()", 0 )
	}
	
	local activeWeapon = g_GetActiveWeapon()
	local primaryWeapon = g_GetPrimaryWeapon()

	if ( (primaryWeapon == "awp" && activeWeapon == "sniper") )
	{
		SubtractFromHealth( 5 );
	}
	else if ( activeWeapon == "knife" )
	{
		SubtractFromHealth( 3 );
	}
	else
	{
		SubtractFromHealth( 1 );
	}
}

function AddToHealth( nAmt )
{
	if ( !m_bENABLED )
		return

	m_nHealth += nAmt

	if ( m_nHealth > m_nMaxHealth )
	{
		m_nHealth = m_nMaxHealth
	}

	UpdateDisplay()
}

function SubtractFromHealth( nAmt )
{
	if ( !m_bENABLED )
		return

	local activeWeapon = g_GetActiveWeapon()	

	m_nHealth -= nAmt

	if ( m_nHealth < 1 )
	{
		m_nHealth = 0
	}

	printl(" *** Target dealt " + nAmt + " damage. Player currently wielding weapon category '" + activeWeapon + "'"  )

	UpdateDisplay()
}

function ResetScore()
{
	m_nHealth = m_nMaxHealth

	UpdateDisplay()
}

function UpdateDisplay()
{	
	printl("Setting Health to " + m_nHealth)
	EntFire( m_MatModHealthDisplay, "SetMaterialVar", m_nHealth + "", 0 )

	if ( m_nHealth <= 0 )
	{
		// we end up doing this twice (when the door OnClose(s)).  No biggie.
		Disable()
		EntFire( m_HealthZeroRelay, "Trigger", "", 0 )
	}
}
