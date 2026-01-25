// MNetworkVarNames = "CHandle< CBaseEntity> m_hEntAttached"
// MNetworkVarNames = "bool m_bCheapEffect"
class CEntityFlame : public CBaseEntity
{
	// MNetworkEnable
	CHandle< CBaseEntity > m_hEntAttached;
	// MNetworkEnable
	bool m_bCheapEffect;
	float32 m_flSize;
	// MNotSaved
	bool m_bUseHitboxes;
	// MNotSaved
	int32 m_iNumHitboxFires;
	// MNotSaved
	float32 m_flHitboxFireScale;
	GameTime_t m_flLifetime;
	// MNotSaved
	CHandle< CBaseEntity > m_hAttacker;
	// MNotSaved
	float32 m_flDirectDamagePerSecond;
	// MNotSaved
	int32 m_iCustomDamageType;
};
