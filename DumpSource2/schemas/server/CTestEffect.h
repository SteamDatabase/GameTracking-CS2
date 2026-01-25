class CTestEffect : public CBaseEntity
{
	int32 m_iLoop;
	int32 m_iBeam;
	CHandle< CBeam >[24] m_pBeam;
	GameTime_t[24] m_flBeamTime;
	GameTime_t m_flStartTime;
};
