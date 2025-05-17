// MNetworkVarNames = "float m_flVisibilityStrength"
// MNetworkVarNames = "float m_flFogDistanceMultiplier"
// MNetworkVarNames = "float m_flFogMaxDensityMultiplier"
// MNetworkVarNames = "float m_flFadeTime"
// MNetworkVarNames = "bool m_bStartDisabled"
// MNetworkVarNames = "bool m_bIsEnabled"
class C_PlayerVisibility : public C_BaseEntity
{
	// MNetworkEnable
	// MNetworkChangeCallback = "PlayerVisibilityStateChanged"
	float32 m_flVisibilityStrength;
	// MNetworkEnable
	// MNetworkChangeCallback = "PlayerVisibilityStateChanged"
	float32 m_flFogDistanceMultiplier;
	// MNetworkEnable
	// MNetworkChangeCallback = "PlayerVisibilityStateChanged"
	float32 m_flFogMaxDensityMultiplier;
	// MNetworkEnable
	// MNetworkChangeCallback = "PlayerVisibilityStateChanged"
	float32 m_flFadeTime;
	// MNetworkEnable
	bool m_bStartDisabled;
	// MNetworkEnable
	bool m_bIsEnabled;
};
