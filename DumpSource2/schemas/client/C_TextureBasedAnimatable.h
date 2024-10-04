class C_TextureBasedAnimatable : public C_BaseModelEntity
{
	bool m_bLoop;
	float32 m_flFPS;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hPositionKeys;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hRotationKeys;
	Vector m_vAnimationBoundsMin;
	Vector m_vAnimationBoundsMax;
	float32 m_flStartTime;
	float32 m_flStartFrame;
};
