// MModelGameData
// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CDestructiblePartsSystemData
{
	// MPropertyDescription = "Destructible Parts"
	CUtlOrderedMap< HitGroup_t, CDestructiblePartsSystemData_HitGroupInfoAndDamageLevels > m_PartsDataByHitGroup;
	// MPropertyDescription = "Min/Max number parts to destroy when gibbing"
	CRangeInt m_nMinMaxNumberHitGroupsToDestroyWhenGibbing;
};
