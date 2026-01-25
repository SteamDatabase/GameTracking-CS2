class CBaseMoveBehavior : public CPathKeyFrame
{
	int32 m_iPositionInterpolator;
	int32 m_iRotationInterpolator;
	float32 m_flAnimStartTime;
	float32 m_flAnimEndTime;
	float32 m_flAverageSpeedAcrossFrame;
	// MClassPtr
	CPathKeyFrame* m_pCurrentKeyFrame;
	// MClassPtr
	CPathKeyFrame* m_pTargetKeyFrame;
	// MClassPtr
	CPathKeyFrame* m_pPreKeyFrame;
	// MClassPtr
	CPathKeyFrame* m_pPostKeyFrame;
	float32 m_flTimeIntoFrame;
	int32 m_iDirection;
};
