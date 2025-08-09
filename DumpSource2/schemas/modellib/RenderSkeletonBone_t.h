// MGetKV3ClassDefaults = {
//	"m_boneName": "",
//	"m_parentName": "",
//	"m_invBindPose":
//	[
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000
//	],
//	"m_bbox":
//	{
//		"m_vecCenter":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_vecSize":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		]
//	},
//	"m_flSphereRadius": 0.000000
//}
class RenderSkeletonBone_t
{
	CUtlString m_boneName;
	CUtlString m_parentName;
	matrix3x4_t m_invBindPose;
	SkeletonBoneBounds_t m_bbox;
	float32 m_flSphereRadius;
};
