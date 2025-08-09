// MModelGameData
// MGetKV3ClassDefaults = {
//	"m_PartsDataByHitGroup":
//	{
//	},
//	"m_nMinMaxNumberHitGroupsToDestroyWhenGibbing":
//	[
//		1,
//		3
//	]
//}
class CDestructiblePartsSystemData
{
	// MPropertyDescription = "Destructible Parts"
	CUtlOrderedMap< HitGroup_t, CDestructiblePartsSystemData_HitGroupInfoAndDamageLevels > m_PartsDataByHitGroup;
	// MPropertyDescription = "Min/Max number parts to destroy when gibbing"
	CRangeInt m_nMinMaxNumberHitGroupsToDestroyWhenGibbing;
};
