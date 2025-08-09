// MGetKV3ClassDefaults = {
//	"m_nLightmapVersionNumber": 0,
//	"m_nLightmapGameVersionNumber": 0,
//	"m_vLightmapUvScale":
//	[
//		1.000000,
//		1.000000
//	],
//	"m_bHasLightmaps": false,
//	"m_bBakedShadowsGamma20": false,
//	"m_bCompressionEnabled": false,
//	"m_bSHLightmaps": false,
//	"m_nChartPackIterations": 0,
//	"m_nVradQuality": 0,
//	"m_lightMaps":
//	[
//	],
//	"m_bakedShadows":
//	[
//	]
//}
class BakedLightingInfo_t
{
	uint32 m_nLightmapVersionNumber;
	uint32 m_nLightmapGameVersionNumber;
	Vector2D m_vLightmapUvScale;
	bool m_bHasLightmaps;
	bool m_bBakedShadowsGamma20;
	bool m_bCompressionEnabled;
	bool m_bSHLightmaps;
	uint8 m_nChartPackIterations;
	uint8 m_nVradQuality;
	CUtlVector< CStrongHandle< InfoForResourceTypeCTextureBase > > m_lightMaps;
	CUtlVector< BakedLightingInfo_t::BakedShadowAssignment_t > m_bakedShadows;
};
