class CChangeLevel : public CBaseTrigger
{
	CUtlString m_sMapName;
	CUtlString m_sLandmarkName;
	CEntityIOOutput m_OnChangeLevel;
	bool m_bTouched;
	bool m_bNoTouch;
	bool m_bNewChapter;
	bool m_bOnChangeLevelFired;
}
