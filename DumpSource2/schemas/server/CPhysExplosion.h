class CPhysExplosion : public CPointEntity
{
	bool m_bExplodeOnSpawn;
	float32 m_flMagnitude;
	float32 m_flDamage;
	float32 m_radius;
	CUtlSymbolLarge m_targetEntityName;
	float32 m_flInnerRadius;
	float32 m_flPushScale;
	bool m_bConvertToDebrisWhenPossible;
	bool m_bAffectInvulnerableEnts;
	CEntityIOOutput m_OnPushedPlayer;
};
