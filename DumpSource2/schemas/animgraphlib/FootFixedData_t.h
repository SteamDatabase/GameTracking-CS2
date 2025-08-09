// MGetKV3ClassDefaults = {
//	"m_vToeOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vHeelOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_nTargetBoneIndex": -1,
//	"m_nAnkleBoneIndex": -1,
//	"m_nIKAnchorBoneIndex": -1,
//	"m_ikChainIndex": -1,
//	"m_flMaxIKLength": -1.000000,
//	"m_nFootIndex": -1,
//	"m_nTagIndex": -1,
//	"m_flMaxRotationLeft": 90.000000,
//	"m_flMaxRotationRight": 90.000000
//}
class FootFixedData_t
{
	VectorAligned m_vToeOffset;
	VectorAligned m_vHeelOffset;
	int32 m_nTargetBoneIndex;
	int32 m_nAnkleBoneIndex;
	int32 m_nIKAnchorBoneIndex;
	int32 m_ikChainIndex;
	float32 m_flMaxIKLength;
	int32 m_nFootIndex;
	int32 m_nTagIndex;
	float32 m_flMaxRotationLeft;
	float32 m_flMaxRotationRight;
};
