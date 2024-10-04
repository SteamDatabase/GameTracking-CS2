class shard_model_desc_t
{
	int32 m_nModelID;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterialBase;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterialDamageOverlay;
	ShardSolid_t m_solid;
	Vector2D m_vecPanelSize;
	Vector2D m_vecStressPositionA;
	Vector2D m_vecStressPositionB;
	CNetworkUtlVectorBase< Vector2D > m_vecPanelVertices;
	CNetworkUtlVectorBase< Vector4D > m_vInitialPanelVertices;
	float32 m_flGlassHalfThickness;
	bool m_bHasParent;
	bool m_bParentFrozen;
	CUtlStringToken m_SurfacePropStringToken;
}
