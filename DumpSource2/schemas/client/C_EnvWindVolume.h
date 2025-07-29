// MEntityAllowsPortraitWorldSpawn
// MNetworkVarNames = "bool m_bActive"
// MNetworkVarNames = "Vector m_vBoxMins"
// MNetworkVarNames = "Vector m_vBoxMaxs"
// MNetworkVarNames = "bool m_bStartDisabled"
// MNetworkVarNames = "int m_nShape"
// MNetworkVarNames = "float m_fWindSpeedMultiplier"
// MNetworkVarNames = "float m_fWindTurbulenceMultiplier"
// MNetworkVarNames = "float m_fWindSpeedVariationMultiplier"
// MNetworkVarNames = "float m_fWindDirectionVariationMultiplier"
class C_EnvWindVolume : public C_BaseEntity
{
	// MNetworkEnable
	bool m_bActive;
	// MNetworkEnable
	Vector m_vBoxMins;
	// MNetworkEnable
	Vector m_vBoxMaxs;
	// MNetworkEnable
	bool m_bStartDisabled;
	// MNetworkEnable
	int32 m_nShape;
	// MNetworkEnable
	float32 m_fWindSpeedMultiplier;
	// MNetworkEnable
	float32 m_fWindTurbulenceMultiplier;
	// MNetworkEnable
	float32 m_fWindSpeedVariationMultiplier;
	// MNetworkEnable
	float32 m_fWindDirectionVariationMultiplier;
};
