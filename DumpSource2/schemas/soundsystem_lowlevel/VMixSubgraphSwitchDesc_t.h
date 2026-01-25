// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_effectName": "",
//	"m_subgraphs":
//	[
//	],
//	"m_interpolationMode": "SUBGRAPH_INTERPOLATION_TEMPORAL_CROSSFADE",
//	"m_bOnlyTailsOnFadeOut": false,
//	"m_flInterpolationTime": 0.000000
//}
class VMixSubgraphSwitchDesc_t
{
	CUtlString m_name;
	CUtlString m_effectName;
	CUtlVector< CUtlString > m_subgraphs;
	VMixSubgraphSwitchInterpolationType_t m_interpolationMode;
	bool m_bOnlyTailsOnFadeOut;
	float32 m_flInterpolationTime;
};
