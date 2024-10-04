class BakedLightingInfo_t
{
	uint32 m_nLightmapVersionNumber;
	uint32 m_nLightmapGameVersionNumber;
	Vector2D m_vLightmapUvScale;
	bool m_bHasLightmaps;
	bool m_bBakedShadowsGamma20;
	bool m_bCompressionEnabled;
	uint8 m_nChartPackIterations;
	uint8 m_nVradQuality;
	CUtlVector< CStrongHandle< InfoForResourceTypeCTextureBase > > m_lightMaps;
};
