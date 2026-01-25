// MNetworkVarNames = "bool m_ragEnabled"
// MNetworkVarNames = "Vector m_ragPos"
// MNetworkVarNames = "QAngle m_ragAngles"
// MNetworkVarNames = "float32 m_flBlendWeight"
// MNetworkVarNames = "EHANDLE m_hRagdollSource"
class C_RagdollProp : public CBaseAnimGraph
{
	// MNetworkEnable
	// MNetworkChangeCallback = "ragEnabledChanged"
	// MNotSaved
	C_NetworkUtlVectorBase< bool > m_ragEnabled;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNotSaved
	C_NetworkUtlVectorBase< Vector > m_ragPos;
	// MNetworkEnable
	// MNetworkEncoder = "qangle"
	// MNetworkBitCount = 13
	// MNotSaved
	C_NetworkUtlVectorBase< QAngle > m_ragAngles;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 1
	// MNotSaved
	float32 m_flBlendWeight;
	// MNetworkEnable
	// MNotSaved
	CHandle< C_BaseEntity > m_hRagdollSource;
	// MNotSaved
	AttachmentHandle_t m_iEyeAttachment;
	// MNotSaved
	float32 m_flBlendWeightCurrent;
	// MNotSaved
	CUtlVector< int32 > m_parentPhysicsBoneIndices;
	// MNotSaved
	CUtlVector< int32 > m_worldSpaceBoneComputationOrder;
};
