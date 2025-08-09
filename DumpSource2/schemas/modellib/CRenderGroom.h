// MGetKV3ClassDefaults = {
//	"m_hairs":
//	[
//	],
//	"m_hairPositionOffsets":
//	[
//	],
//	"m_hSimParamsMat": "",
//	"m_strandSegmentCountHist":
//	[
//	],
//	"m_nMaxSegmentsPerHairStrand": 0,
//	"m_nGuideHairCount": 0,
//	"m_nHairCount": 0,
//	"m_nTotalVertexCount": 0,
//	"m_nTotalSegmentCount": 0,
//	"m_nGroomGroupID": 0,
//	"m_nAttachBoneIdx": 0,
//	"m_nAttachMeshIdx": -1,
//	"m_nAttachMeshDrawCallIdx": -1,
//	"m_bEnableSimulation": false
//}
class CRenderGroom
{
	CUtlVector< RenderHairStrandInfo_t > m_hairs;
	CUtlVector< uint32 > m_hairPositionOffsets;
	CStrongHandleCopyable< InfoForResourceTypeIMaterial2 > m_hSimParamsMat;
	CUtlVector< int32 > m_strandSegmentCountHist;
	int32 m_nMaxSegmentsPerHairStrand;
	int32 m_nGuideHairCount;
	int32 m_nHairCount;
	int32 m_nTotalVertexCount;
	int32 m_nTotalSegmentCount;
	int32 m_nGroomGroupID;
	int32 m_nAttachBoneIdx;
	int32 m_nAttachMeshIdx;
	int32 m_nAttachMeshDrawCallIdx;
	bool m_bEnableSimulation;
};
