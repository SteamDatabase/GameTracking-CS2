// MGetKV3ClassDefaults = {
//	"_class": "CVMixSubgraphSwitchProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_name": "",
//		"m_effectName": "",
//		"m_subgraphs":
//		[
//		],
//		"m_interpolationMode": "SUBGRAPH_INTERPOLATION_TEMPORAL_CROSSFADE",
//		"m_bOnlyTailsOnFadeOut": false,
//		"m_flInterpolationTime": 0.000000
//	}
//}
class CVMixSubgraphSwitchProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixSubgraphSwitchDesc_t m_desc;
};
