// MGetKV3ClassDefaults = {
//	"m_flags":
//	{
//		"m_bRealtime": false,
//		"m_bCylepose": false,
//		"m_b0D": false,
//		"m_b1D": false,
//		"m_b2D": false,
//		"m_b2D_TRI": false
//	},
//	"m_localReferenceArray":
//	[
//	],
//	"m_nGroupSize":
//	[
//		0,
//		0
//	],
//	"m_nLocalPose":
//	[
//		0,
//		0
//	],
//	"m_poseKeyArray0":
//	[
//	],
//	"m_poseKeyArray1":
//	[
//	],
//	"m_nLocalCyclePoseParameter": 0,
//	"m_bCalculatePoseParameters": false,
//	"m_bFixedBlendWeight": false,
//	"m_flFixedBlendWeightVals":
//	[
//		0.000000,
//		0.000000
//	]
//}
class CSeqMultiFetch
{
	CSeqMultiFetchFlag m_flags;
	CUtlVector< int16 > m_localReferenceArray;
	int32[2] m_nGroupSize;
	int32[2] m_nLocalPose;
	CUtlVector< float32 > m_poseKeyArray0;
	CUtlVector< float32 > m_poseKeyArray1;
	int32 m_nLocalCyclePoseParameter;
	bool m_bCalculatePoseParameters;
	bool m_bFixedBlendWeight;
	float32[2] m_flFixedBlendWeightVals;
};
