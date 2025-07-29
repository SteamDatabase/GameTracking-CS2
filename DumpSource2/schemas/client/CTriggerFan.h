// MNetworkVarNames = "Vector m_vFanOrigin"
// MNetworkVarNames = "Vector m_vFanOriginOffset"
// MNetworkVarNames = "Vector m_vFanEnd"
// MNetworkVarNames = "Vector m_vNoiseDirectionTarget"
// MNetworkVarNames = "Vector m_vDirection"
// MNetworkVarNames = "bool m_bPushTowardsInfoTarget"
// MNetworkVarNames = "bool m_bPushAwayFromInfoTarget"
// MNetworkVarNames = "Quaternion m_qNoiseDelta"
// MNetworkVarNames = "CHandle< CInfoFan> m_hInfoFan"
// MNetworkVarNames = "float m_flForce"
// MNetworkVarNames = "bool m_bFalloff"
// MNetworkVarNames = "CountdownTimer m_RampTimer"
class CTriggerFan : public C_BaseTrigger
{
	// MNetworkEnable
	Vector m_vFanOrigin;
	// MNetworkEnable
	Vector m_vFanOriginOffset;
	// MNetworkEnable
	Vector m_vFanEnd;
	// MNetworkEnable
	Vector m_vNoiseDirectionTarget;
	// MNetworkEnable
	Vector m_vDirection;
	// MNetworkEnable
	bool m_bPushTowardsInfoTarget;
	// MNetworkEnable
	bool m_bPushAwayFromInfoTarget;
	// MNetworkEnable
	Quaternion m_qNoiseDelta;
	// MNetworkEnable
	CHandle< CInfoFan > m_hInfoFan;
	// MNetworkEnable
	float32 m_flForce;
	// MNetworkEnable
	bool m_bFalloff;
	// MNetworkEnable
	CountdownTimer m_RampTimer;
};
