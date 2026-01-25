// MNetworkVarNames = "int32 m_nameStringableIndex"
class CEntityIdentity
{
	// MNetworkEnable
	// MNotSaved
	// MNetworkChangeCallback = "entityIdentityNameChanged"
	int32 m_nameStringableIndex;
	CUtlSymbolLarge m_name;
	// MNotSaved
	CUtlSymbolLarge m_designerName;
	// MNotSaved
	uint32 m_flags;
	// MNotSaved
	WorldGroupId_t m_worldGroupId;
	// MNotSaved
	uint32 m_fDataObjectTypes;
	// MNotSaved
	ChangeAccessorFieldPathIndex_t m_PathIndex;
	// MSaveOpsForField (UNKNOWN FOR PARSER)
	CEntityAttributeTable* m_pAttributes;
	// MNotSaved
	CEntityIdentity* m_pPrev;
	// MNotSaved
	CEntityIdentity* m_pNext;
	// MNotSaved
	CEntityIdentity* m_pPrevByClass;
	// MNotSaved
	CEntityIdentity* m_pNextByClass;
};
