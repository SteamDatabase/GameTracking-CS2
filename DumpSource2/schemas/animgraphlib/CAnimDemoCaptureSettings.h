class CAnimDemoCaptureSettings
{
	Vector2D m_vecErrorRangeSplineRotation;
	Vector2D m_vecErrorRangeSplineTranslation;
	Vector2D m_vecErrorRangeSplineScale;
	float32 m_flIkRotation_MaxSplineError;
	float32 m_flIkTranslation_MaxSplineError;
	Vector2D m_vecErrorRangeQuantizationRotation;
	Vector2D m_vecErrorRangeQuantizationTranslation;
	Vector2D m_vecErrorRangeQuantizationScale;
	float32 m_flIkRotation_MaxQuantizationError;
	float32 m_flIkTranslation_MaxQuantizationError;
	CUtlString m_baseSequence;
	int32 m_nBaseSequenceFrame;
	EDemoBoneSelectionMode m_boneSelectionMode;
	CUtlVector< BoneDemoCaptureSettings_t > m_bones;
	CUtlVector< IKDemoCaptureSettings_t > m_ikChains;
};
