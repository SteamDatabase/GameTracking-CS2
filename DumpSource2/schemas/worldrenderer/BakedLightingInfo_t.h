// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
