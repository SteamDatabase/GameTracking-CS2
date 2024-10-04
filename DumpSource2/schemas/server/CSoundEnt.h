class CSoundEnt : public CPointEntity
{
	int32 m_iFreeSound;
	int32 m_iActiveSound;
	int32 m_cLastActiveSounds;
	CSound[128] m_SoundPool;
}
