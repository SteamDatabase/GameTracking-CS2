// MNetworkVarNames = "CModelState m_modelState"
// MNetworkVarNames = "bool m_bIsAnimationEnabled"
// MNetworkVarNames = "bool m_bUseParentRenderBounds"
// MNetworkVarNames = "CUtlStringToken m_materialGroup"
// MNetworkVarNames = "uint8 m_nHitboxSet"
class CSkeletonInstance : public CGameSceneNode
{
	// MNetworkEnable
	CModelState m_modelState;
	// MNetworkEnable
	bool m_bIsAnimationEnabled;
	// MNetworkEnable
	bool m_bUseParentRenderBounds;
	bool m_bDisableSolidCollisionsForHierarchy;
	bitfield:1 m_bDirtyMotionType;
	bitfield:1 m_bIsGeneratingLatchedParentSpaceState;
	// MNetworkEnable
	// MNetworkChangeCallback = "skeletonMaterialGroupChanged"
	CUtlStringToken m_materialGroup;
	// MNetworkEnable
	uint8 m_nHitboxSet;
};
