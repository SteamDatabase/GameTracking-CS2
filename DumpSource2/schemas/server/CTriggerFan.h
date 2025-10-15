// MNetworkVarNames = "Vector m_vFanOriginOffset"
// MNetworkVarNames = "Vector m_vDirection"
// MNetworkVarNames = "bool m_bPushTowardsInfoTarget"
// MNetworkVarNames = "bool m_bPushAwayFromInfoTarget"
// MNetworkVarNames = "Quaternion m_qNoiseDelta"
// MNetworkVarNames = "CHandle< CInfoFan> m_hInfoFan"
// MNetworkVarNames = "float m_flForce"
// MNetworkVarNames = "bool m_bFalloff"
// MNetworkVarNames = "CountdownTimer m_RampTimer"
class CTriggerFan : public CBaseTrigger
{
	// MNetworkEnable
	Vector m_vFanOriginOffset;
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
	VectorWS m_vFanOriginWS;
	Vector m_vFanOriginLS;
	Vector m_vFanEndLS;
	Vector m_vNoiseDirectionTarget;
	CUtlSymbolLarge m_iszInfoFan;
	float32 m_flRopeForceScale;
	float32 m_flParticleForceScale;
	float32 m_flPlayerForce;
	bool m_bPlayerWindblock;
	float32 m_flNPCForce;
	float32 m_flRampTime;
	float32 m_fNoiseDegrees;
	float32 m_fNoiseSpeed;
	bool m_bPushPlayer;
	bool m_bRampDown;
	int32 m_nManagerFanIdx;
};
