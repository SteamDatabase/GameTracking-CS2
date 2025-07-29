// MNetworkVarNames = "HModelStrong m_hModel"
// MNetworkVarNames = "bool m_bClientClothCreationSuppressed"
// MNetworkVarNames = "MeshGroupMask_t m_MeshGroupMask"
// MNetworkVarNames = "int32 m_nBodyGroupChoices"
// MNetworkVarNames = "int8 m_nIdealMotionType"
class CModelState
{
	// MNetworkEnable
	// MNetworkChangeCallback = "skeletonModelChanged"
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	CUtlSymbolLarge m_ModelName;
	// MNetworkEnable
	bool m_bClientClothCreationSuppressed;
	// MNetworkEnable
	// MNetworkChangeCallback = "skeletonMeshGroupMaskChanged"
	uint64 m_MeshGroupMask;
	// MNetworkEnable
	// MNetworkChangeCallback = "bodyGroupChoiceChanged"
	CNetworkUtlVectorBase< int32 > m_nBodyGroupChoices;
	// MNetworkEnable
	// MNetworkChangeCallback = "skeletonMotionTypeChanged"
	int8 m_nIdealMotionType;
	int8 m_nForceLOD;
	int8 m_nClothUpdateFlags;
};
