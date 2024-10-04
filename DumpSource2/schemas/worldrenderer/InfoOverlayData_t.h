class InfoOverlayData_t
{
	matrix3x4_t m_transform;
	float32 m_flWidth;
	float32 m_flHeight;
	float32 m_flDepth;
	Vector2D m_vUVStart;
	Vector2D m_vUVEnd;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_pMaterial;
	int32 m_nRenderOrder;
	Vector4D m_vTintColor;
	int32 m_nSequenceOverride;
};
