// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "float m_FOV"
// MNetworkVarNames = "float m_Resolution"
// MNetworkVarNames = "bool m_bFogEnable"
// MNetworkVarNames = "Color m_FogColor"
// MNetworkVarNames = "float m_flFogStart"
// MNetworkVarNames = "float m_flFogEnd"
// MNetworkVarNames = "float m_flFogMaxDensity"
// MNetworkVarNames = "bool m_bActive"
// MNetworkVarNames = "bool m_bUseScreenAspectRatio"
// MNetworkVarNames = "float m_flAspectRatio"
// MNetworkVarNames = "bool m_bNoSky"
// MNetworkVarNames = "float m_fBrightness"
// MNetworkVarNames = "float m_flZFar"
// MNetworkVarNames = "float m_flZNear"
// MNetworkVarNames = "bool m_bCanHLTVUse"
// MNetworkVarNames = "bool m_bAlignWithParent"
// MNetworkVarNames = "bool m_bDofEnabled"
// MNetworkVarNames = "float m_flDofNearBlurry"
// MNetworkVarNames = "float m_flDofNearCrisp"
// MNetworkVarNames = "float m_flDofFarCrisp"
// MNetworkVarNames = "float m_flDofFarBlurry"
// MNetworkVarNames = "float m_flDofTiltToGround"
class CPointCamera : public CBaseEntity
{
	// MNetworkEnable
	float32 m_FOV;
	// MNetworkEnable
	float32 m_Resolution;
	// MNetworkEnable
	bool m_bFogEnable;
	// MNetworkEnable
	Color m_FogColor;
	// MNetworkEnable
	float32 m_flFogStart;
	// MNetworkEnable
	float32 m_flFogEnd;
	// MNetworkEnable
	float32 m_flFogMaxDensity;
	// MNetworkEnable
	bool m_bActive;
	// MNetworkEnable
	bool m_bUseScreenAspectRatio;
	// MNetworkEnable
	float32 m_flAspectRatio;
	// MNetworkEnable
	bool m_bNoSky;
	// MNetworkEnable
	float32 m_fBrightness;
	// MNetworkEnable
	float32 m_flZFar;
	// MNetworkEnable
	float32 m_flZNear;
	// MNetworkEnable
	bool m_bCanHLTVUse;
	// MNetworkEnable
	bool m_bAlignWithParent;
	// MNetworkEnable
	bool m_bDofEnabled;
	// MNetworkEnable
	float32 m_flDofNearBlurry;
	// MNetworkEnable
	float32 m_flDofNearCrisp;
	// MNetworkEnable
	float32 m_flDofFarCrisp;
	// MNetworkEnable
	float32 m_flDofFarBlurry;
	// MNetworkEnable
	float32 m_flDofTiltToGround;
	float32 m_TargetFOV;
	float32 m_DegreesPerSecond;
	bool m_bIsOn;
	CPointCamera* m_pNext;
};
