class C_EnvDecal : public C_BaseModelEntity
{
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hDecalMaterial;
	float32 m_flWidth;
	float32 m_flHeight;
	float32 m_flDepth;
	uint32 m_nRenderOrder;
	bool m_bProjectOnWorld;
	bool m_bProjectOnCharacters;
	bool m_bProjectOnWater;
	float32 m_flDepthSortBias;
}
