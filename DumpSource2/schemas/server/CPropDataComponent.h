class CPropDataComponent : public CEntityComponent
{
	float32 m_flDmgModBullet;
	float32 m_flDmgModClub;
	float32 m_flDmgModExplosive;
	float32 m_flDmgModFire;
	CUtlSymbolLarge m_iszPhysicsDamageTableName;
	CUtlSymbolLarge m_iszBasePropData;
	int32 m_nInteractions;
	bool m_bSpawnMotionDisabled;
	int32 m_nDisableTakePhysicsDamageSpawnFlag;
	int32 m_nMotionDisabledSpawnFlag;
};
