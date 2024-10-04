class CPointCamera : public CBaseEntity
{
	float32 m_FOV;
	float32 m_Resolution;
	bool m_bFogEnable;
	Color m_FogColor;
	float32 m_flFogStart;
	float32 m_flFogEnd;
	float32 m_flFogMaxDensity;
	bool m_bActive;
	bool m_bUseScreenAspectRatio;
	float32 m_flAspectRatio;
	bool m_bNoSky;
	float32 m_fBrightness;
	float32 m_flZFar;
	float32 m_flZNear;
	bool m_bCanHLTVUse;
	bool m_bAlignWithParent;
	bool m_bDofEnabled;
	float32 m_flDofNearBlurry;
	float32 m_flDofNearCrisp;
	float32 m_flDofFarCrisp;
	float32 m_flDofFarBlurry;
	float32 m_flDofTiltToGround;
	float32 m_TargetFOV;
	float32 m_DegreesPerSecond;
	bool m_bIsOn;
	CPointCamera* m_pNext;
}
