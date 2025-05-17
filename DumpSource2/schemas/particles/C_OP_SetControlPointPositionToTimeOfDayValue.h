// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetControlPointPositionToTimeOfDayValue : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "time-of-day parameter"
	char[128] m_pszTimeOfDayParameter;
	// MPropertyFriendlyName = "default value"
	Vector m_vecDefaultValue;
};
