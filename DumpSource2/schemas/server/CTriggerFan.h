class CTriggerFan : public CBaseTrigger
{
	Vector m_vFanOrigin;
	Vector m_vFanEnd;
	Vector m_vNoise;
	float32 m_flForce;
	float32 m_flRopeForceScale;
	float32 m_flPlayerForce;
	float32 m_flRampTime;
	bool m_bFalloff;
	bool m_bPushPlayer;
	bool m_bRampDown;
	bool m_bAddNoise;
	CountdownTimer m_RampTimer;
};
