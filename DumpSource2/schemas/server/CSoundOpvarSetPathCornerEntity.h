class CSoundOpvarSetPathCornerEntity : public CSoundOpvarSetPointEntity
{
	bool m_bUseParentedPath;
	float32 m_flDistMinSqr;
	float32 m_flDistMaxSqr;
	CUtlSymbolLarge m_iszPathCornerEntityName;
};
