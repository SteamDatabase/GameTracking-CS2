// MNetworkVarNames = "CHandle< CBaseEntity> m_hEntAttached"
// MNetworkVarNames = "bool m_bCheapEffect"
class CEntityFlame : public CBaseEntity
{
	// MNetworkEnable
	CHandle< CBaseEntity > m_hEntAttached;
	// MNetworkEnable
	bool m_bCheapEffect;
	float32 m_flSize;
	bool m_bUseHitboxes;
	int32 m_iNumHitboxFires;
	float32 m_flHitboxFireScale;
	GameTime_t m_flLifetime;
	CHandle< CBaseEntity > m_hAttacker;
	float32 m_flDirectDamagePerSecond;
	int32 m_iCustomDamageType;
};
