class CEconItemView : public IEconItemInterface
{
	uint16 m_iItemDefinitionIndex;
	int32 m_iEntityQuality;
	uint32 m_iEntityLevel;
	uint64 m_iItemID;
	uint32 m_iItemIDHigh;
	uint32 m_iItemIDLow;
	uint32 m_iAccountID;
	uint32 m_iInventoryPosition;
	bool m_bInitialized;
	CAttributeList m_AttributeList;
	CAttributeList m_NetworkedDynamicAttributes;
	char[161] m_szCustomName;
	char[161] m_szCustomNameOverride;
}
