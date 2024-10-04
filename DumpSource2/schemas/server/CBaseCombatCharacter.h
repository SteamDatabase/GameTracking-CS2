class CBaseCombatCharacter : public CBaseFlex
{
	bool m_bForceServerRagdoll;
	CNetworkUtlVectorBase< CHandle< CEconWearable > > m_hMyWearables;
	float32 m_impactEnergyScale;
	HitGroup_t m_LastHitGroup;
	bool m_bApplyStressDamage;
	int32 m_iDamageCount;
	CUtlVector< RelationshipOverride_t >* m_pVecRelationships;
	CUtlSymbolLarge m_strRelationships;
	Hull_t m_eHull;
	uint32 m_nNavHullIdx;
}
