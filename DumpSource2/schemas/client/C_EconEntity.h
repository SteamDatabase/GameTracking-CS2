class C_EconEntity : public C_BaseFlex
{
	float32 m_flFlexDelayTime;
	float32* m_flFlexDelayedWeight;
	bool m_bAttributesInitialized;
	C_AttributeContainer m_AttributeManager;
	uint32 m_OriginalOwnerXuidLow;
	uint32 m_OriginalOwnerXuidHigh;
	int32 m_nFallbackPaintKit;
	int32 m_nFallbackSeed;
	float32 m_flFallbackWear;
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
}
