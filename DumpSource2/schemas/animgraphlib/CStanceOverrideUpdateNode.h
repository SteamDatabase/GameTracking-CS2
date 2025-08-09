// MGetKV3ClassDefaults = {
//	"_class": "CStanceOverrideUpdateNode",
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
//	"m_footStanceInfo":
//	[
//	],
//	"m_pStanceSourceNode":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_hParameter":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_eMode": "Sequence"
//}
class CStanceOverrideUpdateNode : public CUnaryUpdateNode
{
	CUtlVector< StanceInfo_t > m_footStanceInfo;
	CAnimUpdateNodeRef m_pStanceSourceNode;
	CAnimParamHandle m_hParameter;
	StanceOverrideMode m_eMode;
};
