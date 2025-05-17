// MNetworkVarNames = "CAttributeContainer m_AttributeManager"
// MNetworkVarNames = "uint32 m_OriginalOwnerXuidLow"
// MNetworkVarNames = "uint32 m_OriginalOwnerXuidHigh"
// MNetworkVarNames = "int m_nFallbackPaintKit"
// MNetworkVarNames = "int m_nFallbackSeed"
// MNetworkVarNames = "float m_flFallbackWear"
// MNetworkVarNames = "int m_nFallbackStatTrak"
class CEconEntity : public CBaseFlex
{
	// MNetworkEnable
	CAttributeContainer m_AttributeManager;
	// MNetworkEnable
	uint32 m_OriginalOwnerXuidLow;
	// MNetworkEnable
	uint32 m_OriginalOwnerXuidHigh;
	// MNetworkEnable
	int32 m_nFallbackPaintKit;
	// MNetworkEnable
	int32 m_nFallbackSeed;
	// MNetworkEnable
	float32 m_flFallbackWear;
	// MNetworkEnable
	int32 m_nFallbackStatTrak;
	CHandle< CBaseEntity > m_hOldProvidee;
	int32 m_iOldOwnerClass;
};
