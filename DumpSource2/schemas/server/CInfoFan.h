// MNetworkVarNames = "float m_fFanForceMaxRadius"
// MNetworkVarNames = "float m_fFanForceMinRadius"
// MNetworkVarNames = "float m_flCurveDistRange"
// MNetworkVarNames = "string_t m_FanForceCurveString"
class CInfoFan : public CPointEntity
{
	// MNetworkEnable
	float32 m_fFanForceMaxRadius;
	// MNetworkEnable
	float32 m_fFanForceMinRadius;
	// MNetworkEnable
	float32 m_flCurveDistRange;
	// MNetworkEnable
	CUtlSymbolLarge m_FanForceCurveString;
};
