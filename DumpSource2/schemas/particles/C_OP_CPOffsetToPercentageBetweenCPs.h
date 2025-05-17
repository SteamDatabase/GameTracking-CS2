// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_CPOffsetToPercentageBetweenCPs : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "percentage minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "percentage maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "percentage bias"
	float32 m_flInputBias;
	// MPropertyFriendlyName = "starting control point"
	int32 m_nStartCP;
	// MPropertyFriendlyName = "ending control point"
	int32 m_nEndCP;
	// MPropertyFriendlyName = "offset control point"
	int32 m_nOffsetCP;
	// MPropertyFriendlyName = "output control point"
	int32 m_nOuputCP;
	// MPropertyFriendlyName = "input control point"
	int32 m_nInputCP;
	// MPropertyFriendlyName = "treat distance between points as radius"
	bool m_bRadialCheck;
	// MPropertyFriendlyName = "treat offset as scale of total distance"
	bool m_bScaleOffset;
	// MPropertyFriendlyName = "offset amount"
	// MVectorIsCoordinate
	Vector m_vecOffset;
};
