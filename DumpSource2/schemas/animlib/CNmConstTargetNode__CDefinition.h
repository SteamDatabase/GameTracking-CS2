// MGetKV3ClassDefaults = {
//	"_class": "CNmConstTargetNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_value":
//	{
//		"m_transform":
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			1.000000,
//			0.000000,
//			0.000000,
//			0.000000,
//			1.000000
//		],
//		"m_boneID": "",
//		"m_bIsBoneTarget": false,
//		"m_bIsUsingBoneSpaceOffsets": true,
//		"m_bHasOffsets": false,
//		"m_bIsSet": false
//	}
//}
class CNmConstTargetNode::CDefinition : public CNmTargetValueNode::CDefinition
{
	CNmTarget m_value;
};
