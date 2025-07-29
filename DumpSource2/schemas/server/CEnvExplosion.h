class CEnvExplosion : public CModelPointEntity
{
	int32 m_iMagnitude;
	float32 m_flPlayerDamage;
	int32 m_iRadiusOverride;
	float32 m_flInnerRadius;
	float32 m_flDamageForce;
	CHandle< CBaseEntity > m_hInflictor;
	DamageTypes_t m_iCustomDamageType;
	bool m_bCreateDebris;
	CUtlSymbolLarge m_iszCustomEffectName;
	CUtlSymbolLarge m_iszCustomSoundName;
	bool m_bSuppressParticleImpulse;
	Class_T m_iClassIgnore;
	Class_T m_iClassIgnore2;
	CUtlSymbolLarge m_iszEntityIgnoreName;
	CHandle< CBaseEntity > m_hEntityIgnore;
};
