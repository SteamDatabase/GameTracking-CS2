class CPointProximitySensor : public CPointEntity
{
	bool m_bDisabled;
	CHandle< CBaseEntity > m_hTargetEntity;
	CEntityOutputTemplate< float32, float32 > m_Distance;
};
