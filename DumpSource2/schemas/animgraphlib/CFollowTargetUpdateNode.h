// MGetKV3ClassDefaults = {
//	"_class": "CFollowTargetUpdateNode",
//	"m_nodePath":
//	{
//		"m_path":
//		[
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			}
//		],
//		"m_nCount": 0
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_name": "",
//	"m_pChildNode":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_opFixedData":
//	{
//		"m_boneIndex": -1,
//		"m_bBoneTarget": true,
//		"m_boneTargetIndex": -1,
//		"m_bWorldCoodinateTarget": true,
//		"m_bMatchTargetOrientation": false
//	},
//	"m_hParameterPosition":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hParameterOrientation":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	}
//}
class CFollowTargetUpdateNode : public CUnaryUpdateNode
{
	FollowTargetOpFixedSettings_t m_opFixedData;
	CAnimParamHandle m_hParameterPosition;
	CAnimParamHandle m_hParameterOrientation;
};
