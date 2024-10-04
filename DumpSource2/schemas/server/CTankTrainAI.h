class CTankTrainAI : public CPointEntity
{
	CHandle< CFuncTrackTrain > m_hTrain;
	CHandle< CBaseEntity > m_hTargetEntity;
	int32 m_soundPlaying;
	CUtlSymbolLarge m_startSoundName;
	CUtlSymbolLarge m_engineSoundName;
	CUtlSymbolLarge m_movementSoundName;
	CUtlSymbolLarge m_targetEntityName;
};
