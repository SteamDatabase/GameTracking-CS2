// MNetworkVarNames = "float m_gravityScale"
// MNetworkVarNames = "float m_linearLimit"
// MNetworkVarNames = "float m_linearDamping"
// MNetworkVarNames = "float m_angularLimit"
// MNetworkVarNames = "float m_angularDamping"
// MNetworkVarNames = "float m_linearForce"
// MNetworkVarNames = "float m_flFrequency"
// MNetworkVarNames = "float m_flDampingRatio"
// MNetworkVarNames = "Vector m_vecLinearForcePointAt"
// MNetworkVarNames = "bool m_bCollapseToForcePoint"
// MNetworkVarNames = "Vector m_vecLinearForcePointAtWorld"
// MNetworkVarNames = "Vector m_vecLinearForceDirection"
// MNetworkVarNames = "bool m_bConvertToDebrisWhenPossible"
class C_TriggerPhysics : public C_BaseTrigger
{
	// MNetworkEnable
	float32 m_gravityScale;
	// MNetworkEnable
	float32 m_linearLimit;
	// MNetworkEnable
	float32 m_linearDamping;
	// MNetworkEnable
	float32 m_angularLimit;
	// MNetworkEnable
	float32 m_angularDamping;
	// MNetworkEnable
	float32 m_linearForce;
	// MNetworkEnable
	float32 m_flFrequency;
	// MNetworkEnable
	float32 m_flDampingRatio;
	// MNetworkEnable
	Vector m_vecLinearForcePointAt;
	// MNetworkEnable
	bool m_bCollapseToForcePoint;
	// MNetworkEnable
	Vector m_vecLinearForcePointAtWorld;
	// MNetworkEnable
	Vector m_vecLinearForceDirection;
	// MNetworkEnable
	bool m_bConvertToDebrisWhenPossible;
};
