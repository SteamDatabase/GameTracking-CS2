// MNetworkVarNames = "bool m_ragEnabled"
// MNetworkVarNames = "Vector m_ragPos"
// MNetworkVarNames = "QAngle m_ragAngles"
// MNetworkVarNames = "float32 m_flBlendWeight"
// MNetworkVarNames = "EHANDLE m_hRagdollSource"
class C_RagdollProp : public CBaseAnimGraph
{
	// MNetworkEnable
	// MNetworkChangeCallback = "ragEnabledChanged"
	C_NetworkUtlVectorBase< bool > m_ragEnabled;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	C_NetworkUtlVectorBase< Vector > m_ragPos;
	// MNetworkEnable
	// MNetworkEncoder = "qangle"
	// MNetworkBitCount = 13
	C_NetworkUtlVectorBase< QAngle > m_ragAngles;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 1
	float32 m_flBlendWeight;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hRagdollSource;
	AttachmentHandle_t m_iEyeAttachment;
	float32 m_flBlendWeightCurrent;
	CUtlVector< int32 > m_parentPhysicsBoneIndices;
	CUtlVector< int32 > m_worldSpaceBoneComputationOrder;
};
