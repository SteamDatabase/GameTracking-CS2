// MNetworkIncludeByName = "m_ProviderType"
// MNetworkIncludeByName = "m_hOuter"
// MNetworkIncludeByName = "m_iReapplyProvisionParity"
// MNetworkIncludeByName = "m_Item"
// MNetworkVarNames = "CEconItemView m_Item"
class C_AttributeContainer : public CAttributeManager
{
	// MNetworkEnable
	C_EconItemView m_Item;
	int32 m_iExternalItemProviderRegisteredToken;
	uint64 m_ullRegisteredAsItemID;
};
