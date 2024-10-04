class CSosGroupActionSoundeventMinMaxValuesSchema : public CSosGroupActionSchema
{
	CUtlString m_strQueryPublicFieldName;
	CUtlString m_strDelayPublicFieldName;
	bool m_bExcludeStoppedSounds;
	bool m_bExcludeDelayedSounds;
	bool m_bExcludeSoundsBelowThreshold;
	float32 m_flExcludeSoundsMinThresholdValue;
	bool m_bExcludSoundsAboveThreshold;
	float32 m_flExcludeSoundsMaxThresholdValue;
	CUtlString m_strMinValueName;
	CUtlString m_strMaxValueName;
};
