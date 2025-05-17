// MNetworkVarNames = "bool m_bIsIncGrenade"
class CMolotovProjectile : public CBaseCSGrenadeProjectile
{
	// MNetworkEnable
	bool m_bIsIncGrenade;
	bool m_bDetonated;
	IntervalTimer m_stillTimer;
	bool m_bHasBouncedOffPlayer;
};
