class CBaseMoveBehavior : public CPathKeyFrame
{
	int32 m_iPositionInterpolator;
	int32 m_iRotationInterpolator;
	float32 m_flAnimStartTime;
	float32 m_flAnimEndTime;
	float32 m_flAverageSpeedAcrossFrame;
	CPathKeyFrame* m_pCurrentKeyFrame;
	CPathKeyFrame* m_pTargetKeyFrame;
	CPathKeyFrame* m_pPreKeyFrame;
	CPathKeyFrame* m_pPostKeyFrame;
	float32 m_flTimeIntoFrame;
	int32 m_iDirection;
};
