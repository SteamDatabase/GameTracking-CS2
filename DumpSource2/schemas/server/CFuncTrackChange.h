class CFuncTrackChange : public CFuncPlatRot
{
	// MClassPtr
	CPathTrack* m_trackTop;
	// MClassPtr
	CPathTrack* m_trackBottom;
	// MClassPtr
	CFuncTrackTrain* m_train;
	CUtlSymbolLarge m_trackTopName;
	CUtlSymbolLarge m_trackBottomName;
	CUtlSymbolLarge m_trainName;
	TRAIN_CODE m_code;
	int32 m_targetState;
	int32 m_use;
};
