class C_CSGO_TeamPreviewCamera : public C_CSGO_MapPreviewCameraPath
{
	int32 m_nVariant;
	bool m_bDofEnabled;
	float32 m_flDofNearBlurry;
	float32 m_flDofNearCrisp;
	float32 m_flDofFarCrisp;
	float32 m_flDofFarBlurry;
	float32 m_flDofTiltToGround;
};
