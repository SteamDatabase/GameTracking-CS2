class CPathTrack : public CPointEntity
{
	// MClassPtr
	CPathTrack* m_pnext;
	// MClassPtr
	CPathTrack* m_pprevious;
	// MClassPtr
	CPathTrack* m_paltpath;
	float32 m_flRadius;
	float32 m_length;
	CUtlSymbolLarge m_altName;
	// MNotSaved
	int32 m_nIterVal;
	TrackOrientationType_t m_eOrientationType;
	CEntityIOOutput m_OnPass;
};
