class CMathCounter : public CLogicalEntity
{
	float32 m_flMin;
	float32 m_flMax;
	bool m_bHitMin;
	bool m_bHitMax;
	bool m_bDisabled;
	CEntityOutputTemplate< float32 > m_OutValue;
	CEntityOutputTemplate< float32 > m_OnGetValue;
	CEntityIOOutput m_OnHitMin;
	CEntityIOOutput m_OnHitMax;
	CEntityIOOutput m_OnChangedFromMin;
	CEntityIOOutput m_OnChangedFromMax;
};
