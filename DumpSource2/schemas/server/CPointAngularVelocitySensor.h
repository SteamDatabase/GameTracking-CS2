class CPointAngularVelocitySensor : public CPointEntity
{
	CHandle< CBaseEntity > m_hTargetEntity;
	float32 m_flThreshold;
	int32 m_nLastCompareResult;
	int32 m_nLastFireResult;
	GameTime_t m_flFireTime;
	float32 m_flFireInterval;
	float32 m_flLastAngVelocity;
	QAngle m_lastOrientation;
	VectorWS m_vecAxis;
	bool m_bUseHelper;
	CEntityOutputTemplate< float32 > m_AngularVelocity;
	CEntityIOOutput m_OnLessThan;
	CEntityIOOutput m_OnLessThanOrEqualTo;
	CEntityIOOutput m_OnGreaterThan;
	CEntityIOOutput m_OnGreaterThanOrEqualTo;
	CEntityIOOutput m_OnEqualTo;
};
