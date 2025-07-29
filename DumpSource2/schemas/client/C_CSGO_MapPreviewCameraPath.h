class C_CSGO_MapPreviewCameraPath : public C_BaseEntity
{
	float32 m_flZFar;
	float32 m_flZNear;
	bool m_bLoop;
	bool m_bVerticalFOV;
	bool m_bConstantSpeed;
	float32 m_flDuration;
	float32 m_flPathLength;
	float32 m_flPathDuration;
	bool m_bDofEnabled;
	float32 m_flDofNearBlurry;
	float32 m_flDofNearCrisp;
	float32 m_flDofFarCrisp;
	float32 m_flDofFarBlurry;
	float32 m_flDofTiltToGround;
};
