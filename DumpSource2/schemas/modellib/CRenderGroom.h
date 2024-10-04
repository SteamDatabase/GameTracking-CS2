class CRenderGroom
{
	CUtlVector< RenderHairStrandInfo_t > m_hairs;
	CUtlVector< uint32 > m_hairPositionOffsets;
	CStrongHandleCopyable< InfoForResourceTypeIMaterial2 > m_hSimParamsMat;
	int32 m_nSegmentsPerHairStrand;
	int32 m_nGuideHairCount;
	int32 m_nHairCount;
	int32 m_nGroomGroupID;
	int32 m_nAttachBoneIdx;
	int32 m_nAttachMeshIdx;
	int32 m_nAttachMeshDrawCallIdx;
	bool m_bEnableSimulation;
};
