// MGetKV3ClassDefaults = {
//	"m_flTime": -0.000000,
//	"m_Stamp":
//	{
//		"m_flTime": 0.000000,
//		"m_flEntitySimTime": 0.000000,
//		"m_bTeleportTick": false,
//		"m_bPredicted": false,
//		"m_flCurTime": 0.000000,
//		"m_flRealTime": 0.000000,
//		"m_nFrameCount": 0,
//		"m_nTickCount": 0
//	},
//	"m_Transform":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_bTeleport": false,
//	"m_CompositeBones":
//	[
//	],
//	"m_SimStateBones":
//	[
//	],
//	"m_FeModelAnims":
//	[
//	],
//	"m_FeModelPos":
//	[
//	],
//	"m_FlexControllerWeights":
//	[
//	]
//}
class SkeletonAnimCapture_t::Frame_t
{
	float32 m_flTime;
	SkeletonAnimCapture_t::FrameStamp_t m_Stamp;
	CTransform m_Transform;
	bool m_bTeleport;
	CUtlVector< CTransform > m_CompositeBones;
	CUtlVector< CTransform > m_SimStateBones;
	CUtlVector< CTransform > m_FeModelAnims;
	CUtlVector< VectorAligned > m_FeModelPos;
	CUtlVector< float32 > m_FlexControllerWeights;
};
