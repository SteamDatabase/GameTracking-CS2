// MNetworkVarNames = "HModelStrong m_hModel"
// MNetworkVarNames = "bool m_bClientClothCreationSuppressed"
// MNetworkVarNames = "MeshGroupMask_t m_MeshGroupMask"
// MNetworkVarNames = "int8 m_nIdealMotionType"
class CModelState
{
	// MNetworkEnable
	// MNetworkChangeCallback = "skeletonModelChanged"
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	// MNetworkDisable
	CUtlSymbolLarge m_ModelName;
	// MNetworkEnable
	bool m_bClientClothCreationSuppressed;
	// MNetworkEnable
	// MNetworkChangeCallback = "skeletonMeshGroupMaskChanged"
	uint64 m_MeshGroupMask;
	// MNetworkEnable
	// MNetworkChangeCallback = "skeletonMotionTypeChanged"
	int8 m_nIdealMotionType;
	// MNetworkDisable
	int8 m_nForceLOD;
	// MNetworkDisable
	int8 m_nClothUpdateFlags;
};
