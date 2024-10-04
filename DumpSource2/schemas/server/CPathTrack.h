class CPathTrack : public CPointEntity
{
	CPathTrack* m_pnext;
	CPathTrack* m_pprevious;
	CPathTrack* m_paltpath;
	float32 m_flRadius;
	float32 m_length;
	CUtlSymbolLarge m_altName;
	int32 m_nIterVal;
	TrackOrientationType_t m_eOrientationType;
	CEntityIOOutput m_OnPass;
}
