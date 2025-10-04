// MNetworkVarNames = "CAttributeContainer m_AttributeManager"
// MNetworkVarNames = "uint32 m_OriginalOwnerXuidLow"
// MNetworkVarNames = "uint32 m_OriginalOwnerXuidHigh"
// MNetworkVarNames = "int m_nFallbackPaintKit"
// MNetworkVarNames = "int m_nFallbackSeed"
// MNetworkVarNames = "float m_flFallbackWear"
// MNetworkVarNames = "int m_nFallbackStatTrak"
class C_EconEntity : public C_BaseFlex, public IHasAttributes
{
	float32 m_flFlexDelayTime;
	float32* m_flFlexDelayedWeight;
	bool m_bAttributesInitialized;
	// MNetworkEnable
	C_AttributeContainer m_AttributeManager;
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
	bool m_bClientside;
	bool m_bParticleSystemsCreated;
	CUtlVector< int32 > m_vecAttachedParticles;
	CHandle< CBaseAnimGraph > m_hViewmodelAttachment;
	int32 m_iOldTeam;
	bool m_bAttachmentDirty;
	int32 m_nUnloadedModelIndex;
	int32 m_iNumOwnerValidationRetries;
	CHandle< C_BaseEntity > m_hOldProvidee;
	CUtlVector< C_EconEntity::AttachedModelData_t > m_vecAttachedModels;
};
