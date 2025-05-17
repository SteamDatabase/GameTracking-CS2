// MNetworkVarNames = "item_definition_index_t m_iItemDefinitionIndex"
// MNetworkVarNames = "int m_iEntityQuality"
// MNetworkVarNames = "uint32 m_iEntityLevel"
// MNetworkVarNames = "uint32 m_iItemIDHigh"
// MNetworkVarNames = "uint32 m_iItemIDLow"
// MNetworkVarNames = "uint32 m_iAccountID"
// MNetworkVarNames = "uint32 m_iInventoryPosition"
// MNetworkVarNames = "bool m_bInitialized"
// MNetworkVarNames = "CAttributeList m_AttributeList"
// MNetworkVarNames = "CAttributeList m_NetworkedDynamicAttributes"
// MNetworkVarNames = "char m_szCustomName"
class CEconItemView : public IEconItemInterface
{
	// MNetworkEnable
	uint16 m_iItemDefinitionIndex;
	// MNetworkEnable
	int32 m_iEntityQuality;
	// MNetworkEnable
	uint32 m_iEntityLevel;
	uint64 m_iItemID;
	// MNetworkEnable
	uint32 m_iItemIDHigh;
	// MNetworkEnable
	uint32 m_iItemIDLow;
	// MNetworkEnable
	uint32 m_iAccountID;
	// MNetworkEnable
	uint32 m_iInventoryPosition;
	// MNetworkEnable
	bool m_bInitialized;
	// MNetworkEnable
	CAttributeList m_AttributeList;
	// MNetworkEnable
	CAttributeList m_NetworkedDynamicAttributes;
	// MNetworkEnable
	char[161] m_szCustomName;
	char[161] m_szCustomNameOverride;
};
