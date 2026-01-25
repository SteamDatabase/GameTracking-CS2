// MNetworkExcludeByUserGroup = "LocalPlayerExclusive"
// MNetworkVarNames = "CHandle< CEconWearable > m_hMyWearables"
class CBaseCombatCharacter : public CBaseFlex
{
	bool m_bForceServerRagdoll;
	// MNetworkEnable
	// MNotSaved
	CNetworkUtlVectorBase< CHandle< CEconWearable > > m_hMyWearables;
	float32 m_impactEnergyScale;
	bool m_bApplyStressDamage;
	bool m_bDeathEventsDispatched;
	// MNotSaved
	CUtlVector< RelationshipOverride_t >* m_pVecRelationships;
	CUtlSymbolLarge m_strRelationships;
	Hull_t m_eHull;
	uint32 m_nNavHullIdx;
	CMovementStatsProperty m_movementStats;
};
