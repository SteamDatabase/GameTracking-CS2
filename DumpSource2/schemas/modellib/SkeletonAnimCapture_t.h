// MGetKV3ClassDefaults = {
//	"m_nEntIndex": -1,
//	"m_nEntParent": -1,
//	"m_ImportedCollision":
//	[
//	],
//	"m_ModelName": "",
//	"m_CaptureName": "",
//	"m_ModelBindPose":
//	[
//	],
//	"m_FeModelInitPose":
//	[
//	],
//	"m_nFlexControllers": 0,
//	"m_bPredicted": false,
//	"m_Frames":
//	[
//	]
//}
class SkeletonAnimCapture_t
{
	CEntityIndex m_nEntIndex;
	CEntityIndex m_nEntParent;
	CUtlVector< CEntityIndex > m_ImportedCollision;
	CUtlString m_ModelName;
	CUtlString m_CaptureName;
	CUtlVector< SkeletonAnimCapture_t::Bone_t > m_ModelBindPose;
	CUtlVector< SkeletonAnimCapture_t::Bone_t > m_FeModelInitPose;
	int32 m_nFlexControllers;
	bool m_bPredicted;
	CUtlVector< SkeletonAnimCapture_t::Frame_t > m_Frames;
};
