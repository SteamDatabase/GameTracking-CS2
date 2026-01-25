// MNetworkVarNames = "bool m_bLoop"
// MNetworkVarNames = "float m_flFPS"
// MNetworkVarNames = "HRenderTextureStrong m_hPositionKeys"
// MNetworkVarNames = "HRenderTextureStrong m_hRotationKeys"
// MNetworkVarNames = "Vector m_vAnimationBoundsMin"
// MNetworkVarNames = "Vector m_vAnimationBoundsMax"
// MNetworkVarNames = "float m_flStartTime"
// MNetworkVarNames = "float m_flStartFrame"
class C_TextureBasedAnimatable : public C_BaseModelEntity
{
	// MNetworkEnable
	bool m_bLoop;
	// MNetworkEnable
	float32 m_flFPS;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hPositionKeys;
	// MNetworkEnable
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hRotationKeys;
	// MNetworkEnable
	Vector m_vAnimationBoundsMin;
	// MNetworkEnable
	Vector m_vAnimationBoundsMax;
	// MNetworkEnable
	// MNotSaved
	float32 m_flStartTime;
	// MNetworkEnable
	float32 m_flStartFrame;
};
