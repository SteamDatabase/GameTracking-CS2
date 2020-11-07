///////
///////
///////
// total number of targets minus the one behind the gate
m_nTotalTargets <- 5
m_nTotalTargetsHit <- 0
m_bHitCageTarget <- false

function PlayerEnterTestArea()
{
	EntFire ( "@radiovoice","RunScriptCode", "GrenadeIntro()", 0 )
}

// fires when one of the targets is exploded by a grenade
function HitTarget()
{
	EntFire ( "@radiovoice","RunScriptCode", "GrenadeHit()", 0 )
	// adds 1 every time a target is hit so when the last one is hit, we know it
	m_nTotalTargetsHit++

	if ( m_nTotalTargetsHit >= m_nTotalTargets && m_bHitCageTarget )
	{
		HitAllGrenadeTargets()
	}
}

// we open up the door to the next test when you hit the cage target
function HitCageTarget()
{
	EntFire ( "@radiovoice","RunScriptCode", "GrenadeHitCaged()", 0 )
	m_bHitCageTarget = true

	if ( m_nTotalTargetsHit >= m_nTotalTargets )
	{
		HitAllGrenadeTargets()
	}
}

// we've hit every single one of the targets
function HitAllGrenadeTargets()
{

}