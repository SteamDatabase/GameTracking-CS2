// MGetKV3ClassDefaults = {
//	"m_nGuideHairIndices_nSurfaceTriIndex":
//	[
//		0,
//		0
//	],
//	"m_vGuideBary_vBaseBary":
//	[
//		0,
//		0,
//		0,
//		0
//	],
//	"m_vRootOffset_flLengthScale":
//	[
//		0,
//		0,
//		0,
//		0
//	],
//	"m_nPackedBaseUv":
//	[
//		0,
//		0
//	],
//	"m_nPackedSurfaceNormalOs": 0,
//	"m_nPackedSurfaceTangentOs": 0,
//	"m_nDataOffset_Segments": 0
//}
class RenderHairStrandInfo_t
{
	uint32[2] m_nGuideHairIndices_nSurfaceTriIndex;
	uint16[4] m_vGuideBary_vBaseBary;
	uint16[4] m_vRootOffset_flLengthScale;
	uint16[2] m_nPackedBaseUv;
	uint32 m_nPackedSurfaceNormalOs;
	uint32 m_nPackedSurfaceTangentOs;
	uint32 m_nDataOffset_Segments;
};
