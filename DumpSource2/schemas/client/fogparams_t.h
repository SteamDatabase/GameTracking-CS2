// MNetworkVarNames = "Vector dirPrimary"
// MNetworkVarNames = "Color colorPrimary"
// MNetworkVarNames = "Color colorSecondary"
// MNetworkVarNames = "Color colorPrimaryLerpTo"
// MNetworkVarNames = "Color colorSecondaryLerpTo"
// MNetworkVarNames = "float32 start"
// MNetworkVarNames = "float32 end"
// MNetworkVarNames = "float32 farz"
// MNetworkVarNames = "float32 maxdensity"
// MNetworkVarNames = "float32 exponent"
// MNetworkVarNames = "float32 HDRColorScale"
// MNetworkVarNames = "float32 skyboxFogFactor"
// MNetworkVarNames = "float32 skyboxFogFactorLerpTo"
// MNetworkVarNames = "float32 startLerpTo"
// MNetworkVarNames = "float32 endLerpTo"
// MNetworkVarNames = "float32 maxdensityLerpTo"
// MNetworkVarNames = "GameTime_t lerptime"
// MNetworkVarNames = "float32 duration"
// MNetworkVarNames = "float32 blendtobackground"
// MNetworkVarNames = "float32 scattering"
// MNetworkVarNames = "float32 locallightscale"
// MNetworkVarNames = "bool enable"
// MNetworkVarNames = "bool blend"
class fogparams_t
{
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	Vector dirPrimary;
	// MNetworkEnable
	Color colorPrimary;
	// MNetworkEnable
	Color colorSecondary;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	// MNotSaved
	Color colorPrimaryLerpTo;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	// MNotSaved
	Color colorSecondaryLerpTo;
	// MNetworkEnable
	float32 start;
	// MNetworkEnable
	float32 end;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	float32 farz;
	// MNetworkEnable
	float32 maxdensity;
	// MNetworkEnable
	float32 exponent;
	// MNetworkEnable
	float32 HDRColorScale;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	// MNotSaved
	float32 skyboxFogFactor;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	// MNotSaved
	float32 skyboxFogFactorLerpTo;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	// MNotSaved
	float32 startLerpTo;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	// MNotSaved
	float32 endLerpTo;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	// MNotSaved
	float32 maxdensityLerpTo;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	// MNotSaved
	GameTime_t lerptime;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	float32 duration;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	float32 blendtobackground;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	float32 scattering;
	// MNetworkEnable
	// MNetworkUserGroup = "FogController"
	float32 locallightscale;
	// MNetworkEnable
	bool enable;
	// MNetworkEnable
	bool blend;
	// MNotSaved
	bool m_bPadding2;
	// MNotSaved
	bool m_bPadding;
};
