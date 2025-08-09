// MGetKV3ClassDefaults = {
//	"_class": "CAnimationGraphVisualizerPie",
//	"m_Type": "ANIMATIONGRAPHVISUALIZERPRIMITIVETYPE_Pie",
//	"m_OwningAnimNodePaths":
//	[
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		},
//		{
//			"m_id": 4294967295
//		}
//	],
//	"m_nOwningAnimNodePathCount": 0,
//	"m_vWsCenter":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vWsStart":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vWsEnd":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_Color":
//	[
//		0,
//		0,
//		0,
//		0
//	]
//}
class CAnimationGraphVisualizerPie : public CAnimationGraphVisualizerPrimitiveBase
{
	VectorAligned m_vWsCenter;
	VectorAligned m_vWsStart;
	VectorAligned m_vWsEnd;
	Color m_Color;
};
