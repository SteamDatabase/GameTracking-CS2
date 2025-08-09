// MGetKV3ClassDefaults = {
//	"m_flMinDrawVolumeSize": 0.000000,
//	"m_bBuildBakedLighting": false,
//	"m_bAggregateInstanceStreams": false,
//	"m_bakedLightingInfo":
//	{
//		"m_nLightmapVersionNumber": 0,
//		"m_nLightmapGameVersionNumber": 0,
//		"m_vLightmapUvScale":
//		[
//			1.000000,
//			1.000000
//		],
//		"m_bHasLightmaps": false,
//		"m_bBakedShadowsGamma20": false,
//		"m_bCompressionEnabled": false,
//		"m_bSHLightmaps": false,
//		"m_nChartPackIterations": 0,
//		"m_nVradQuality": 0,
//		"m_lightMaps":
//		[
//		],
//		"m_bakedShadows":
//		[
//		]
//	},
//	"m_nCompileTimestamp": 0,
//	"m_nCompileFingerprint": 0
//}
class WorldBuilderParams_t
{
	float32 m_flMinDrawVolumeSize;
	bool m_bBuildBakedLighting;
	bool m_bAggregateInstanceStreams;
	BakedLightingInfo_t m_bakedLightingInfo;
	uint64 m_nCompileTimestamp;
	uint64 m_nCompileFingerprint;
};
