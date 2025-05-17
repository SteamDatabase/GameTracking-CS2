// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CDestructiblePartsSystemData_HitGroupInfoAndPartData
{
	// MPropertyDescription = "Name for this destructible part."
	CUtlString m_sName;
	// MPropertyDescription = "Data for this destructible part."
	// MPropertyAutoExpandSelf
	CUtlVector< CDestructiblePartsSystemData_PartData > m_DestructiblePartsData;
	// MPropertyStartGroup = "+Hitgroup"
	// MPropertyDescription = "Do we disable the hitgroup when all sub parts are destroyed?"
	bool m_bDisableHitGroupWhenDestroyed;
};
