// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_Value_Curve",
//	"m_nEditorNodeID": -1,
//	"m_Curve":
//	{
//		"m_spline":
//		[
//		],
//		"m_tangents":
//		[
//		],
//		"m_vDomainMins":
//		[
//			0.000000,
//			0.000000
//		],
//		"m_vDomainMaxs":
//		[
//			0.000000,
//			0.000000
//		]
//	}
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Curve"
class CPulseCell_Value_Curve : public CPulseCell_BaseValue
{
	CPiecewiseCurve m_Curve;
};
