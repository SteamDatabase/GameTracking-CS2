class CSkeletonInstance : public CGameSceneNode
{
	CModelState m_modelState;
	bool m_bIsAnimationEnabled;
	bool m_bUseParentRenderBounds;
	bool m_bDisableSolidCollisionsForHierarchy;
	bitfield:1 m_bDirtyMotionType;
	bitfield:1 m_bIsGeneratingLatchedParentSpaceState;
	CUtlStringToken m_materialGroup;
	uint8 m_nHitboxSet;
}
