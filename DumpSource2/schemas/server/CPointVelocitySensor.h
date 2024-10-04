class CPointVelocitySensor : public CPointEntity
{
	CHandle< CBaseEntity > m_hTargetEntity;
	Vector m_vecAxis;
	bool m_bEnabled;
	float32 m_fPrevVelocity;
	float32 m_flAvgInterval;
	CEntityOutputTemplate< float32 > m_Velocity;
}
