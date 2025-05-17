// MNetworkVarNames = "int32 m_nModelID"
// MNetworkVarNames = "HMaterialStrong m_hMaterialBase"
// MNetworkVarNames = "HMaterialStrong m_hMaterialDamageOverlay"
// MNetworkVarNames = "ShardSolid_t m_solid"
// MNetworkVarNames = "Vector2D m_vecPanelSize"
// MNetworkVarNames = "Vector2D m_vecStressPositionA"
// MNetworkVarNames = "Vector2D m_vecStressPositionB"
// MNetworkVarNames = "Vector2D m_vecPanelVertices"
// MNetworkVarNames = "Vector4D m_vInitialPanelVertices"
// MNetworkVarNames = "float m_flGlassHalfThickness"
// MNetworkVarNames = "bool m_bHasParent"
// MNetworkVarNames = "bool m_bParentFrozen"
// MNetworkVarNames = "CUtlStringToken m_SurfacePropStringToken"
class shard_model_desc_t
{
	// MNetworkEnable
	int32 m_nModelID;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterialBase;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterialDamageOverlay;
	// MNetworkEnable
	ShardSolid_t m_solid;
	// MNetworkEnable
	Vector2D m_vecPanelSize;
	// MNetworkEnable
	Vector2D m_vecStressPositionA;
	// MNetworkEnable
	Vector2D m_vecStressPositionB;
	// MNetworkEnable
	CNetworkUtlVectorBase< Vector2D > m_vecPanelVertices;
	// MNetworkEnable
	CNetworkUtlVectorBase< Vector4D > m_vInitialPanelVertices;
	// MNetworkEnable
	float32 m_flGlassHalfThickness;
	// MNetworkEnable
	bool m_bHasParent;
	// MNetworkEnable
	bool m_bParentFrozen;
	// MNetworkEnable
	CUtlStringToken m_SurfacePropStringToken;
};
