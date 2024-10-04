class CEconEntity : public CBaseFlex
{
	CAttributeContainer m_AttributeManager;
	uint32 m_OriginalOwnerXuidLow;
	uint32 m_OriginalOwnerXuidHigh;
	int32 m_nFallbackPaintKit;
	int32 m_nFallbackSeed;
	float32 m_flFallbackWear;
	int32 m_nFallbackStatTrak;
	CHandle< CBaseEntity > m_hOldProvidee;
	int32 m_iOldOwnerClass;
}
