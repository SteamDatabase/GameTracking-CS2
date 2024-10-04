class CEnvExplosion : public CModelPointEntity
{
	int32 m_iMagnitude;
	float32 m_flPlayerDamage;
	int32 m_iRadiusOverride;
	float32 m_flInnerRadius;
	int32 m_spriteScale;
	float32 m_flDamageForce;
	CHandle< CBaseEntity > m_hInflictor;
	DamageTypes_t m_iCustomDamageType;
	bool m_bCreateDebris;
	CUtlSymbolLarge m_iszExplosionType;
	CUtlSymbolLarge m_iszCustomEffectName;
	CUtlSymbolLarge m_iszCustomSoundName;
	Class_T m_iClassIgnore;
	Class_T m_iClassIgnore2;
	CUtlSymbolLarge m_iszEntityIgnoreName;
	CHandle< CBaseEntity > m_hEntityIgnore;
}
