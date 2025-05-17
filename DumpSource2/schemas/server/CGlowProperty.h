// MNetworkVarNames = "int32 m_iGlowType"
// MNetworkVarNames = "int32 m_iGlowTeam"
// MNetworkVarNames = "int32 m_nGlowRange"
// MNetworkVarNames = "int32 m_nGlowRangeMin"
// MNetworkVarNames = "Color m_glowColorOverride"
// MNetworkVarNames = "bool m_bFlashing"
// MNetworkVarNames = "float m_flGlowTime"
// MNetworkVarNames = "float m_flGlowStartTime"
// MNetworkVarNames = "bool m_bEligibleForScreenHighlight"
class CGlowProperty
{
	Vector m_fGlowColor;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGlowTypeChanged"
	int32 m_iGlowType;
	// MNetworkEnable
	int32 m_iGlowTeam;
	// MNetworkEnable
	int32 m_nGlowRange;
	// MNetworkEnable
	int32 m_nGlowRangeMin;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGlowColorChanged"
	Color m_glowColorOverride;
	// MNetworkEnable
	bool m_bFlashing;
	// MNetworkEnable
	float32 m_flGlowTime;
	// MNetworkEnable
	float32 m_flGlowStartTime;
	// MNetworkEnable
	bool m_bEligibleForScreenHighlight;
	bool m_bGlowing;
};
