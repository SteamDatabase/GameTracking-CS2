// MGetKV3ClassDefaults = {
//	"_class": "CChoiceUpdateNode",
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
//	"m_children":
//	[
//	],
//	"m_weights":
//	[
//	],
//	"m_blendTimes":
//	[
//	],
//	"m_choiceMethod": "WeightedRandom",
//	"m_choiceChangeMethod": "OnReset",
//	"m_blendMethod": "SingleBlendTime",
//	"m_blendTime": 0.000000,
//	"m_bCrossFade": false,
//	"m_bResetChosen": false,
//	"m_bDontResetSameSelection": false
//}
class CChoiceUpdateNode : public CAnimUpdateNodeBase
{
	CUtlVector< CAnimUpdateNodeRef > m_children;
	CUtlVector< float32 > m_weights;
	CUtlVector< float32 > m_blendTimes;
	ChoiceMethod m_choiceMethod;
	ChoiceChangeMethod m_choiceChangeMethod;
	ChoiceBlendMethod m_blendMethod;
	float32 m_blendTime;
	bool m_bCrossFade;
	bool m_bResetChosen;
	bool m_bDontResetSameSelection;
};
