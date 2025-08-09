// MGetKV3ClassDefaults = {
//	"_class": "CAnimationGraphVisualizerLine",
//	"m_Type": "ANIMATIONGRAPHVISUALIZERPRIMITIVETYPE_Line",
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
//	"m_vWsPositionStart":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vWsPositionEnd":
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
class CAnimationGraphVisualizerLine : public CAnimationGraphVisualizerPrimitiveBase
{
	VectorAligned m_vWsPositionStart;
	VectorAligned m_vWsPositionEnd;
	Color m_Color;
};
