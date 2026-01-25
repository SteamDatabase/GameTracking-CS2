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
	// MNotSaved
	Vector m_fGlowColor;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGlowTypeChanged"
	int32 m_iGlowType;
	// MNetworkEnable
	// MNotSaved
	int32 m_iGlowTeam;
	// MNetworkEnable
	// MNotSaved
	int32 m_nGlowRange;
	// MNetworkEnable
	// MNotSaved
	int32 m_nGlowRangeMin;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGlowColorChanged"
	// MNotSaved
	Color m_glowColorOverride;
	// MNetworkEnable
	// MNotSaved
	bool m_bFlashing;
	// MNetworkEnable
	// MNotSaved
	float32 m_flGlowTime;
	// MNetworkEnable
	// MNotSaved
	float32 m_flGlowStartTime;
	// MNetworkEnable
	bool m_bEligibleForScreenHighlight;
	// MNotSaved
	bool m_bGlowing;
};
