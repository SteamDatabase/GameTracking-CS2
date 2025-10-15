class CTakeDamageInfo
{
	Vector m_vecDamageForce;
	VectorWS m_vecDamagePosition;
	VectorWS m_vecReportedPosition;
	Vector m_vecDamageDirection;
	CHandle< C_BaseEntity > m_hInflictor;
	CHandle< C_BaseEntity > m_hAttacker;
	CHandle< C_BaseEntity > m_hAbility;
	float32 m_flDamage;
	float32 m_flTotalledDamage;
	DamageTypes_t m_bitsDamageType;
	int32 m_iDamageCustom;
	AmmoIndex_t m_iAmmoType;
	float32 m_flOriginalDamage;
	bool m_bShouldBleed;
	bool m_bShouldSpark;
	TakeDamageFlags_t m_nDamageFlags;
	CGlobalSymbol m_sDamageSourceName;
	HitGroup_t m_iHitGroupId;
	int32 m_nNumObjectsPenetrated;
	float32 m_flFriendlyFireDamageReductionRatio;
	CUtlVector< DestructibleHitGroupToDestroy_t > m_nDestructibleHitGroupsToForceDestroy;
	bool m_bInTakeDamageFlow;
};
