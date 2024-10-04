class CDampedPathAnimMotorUpdater : public CPathAnimMotorUpdaterBase
{
	float32 m_flAnticipationTime;
	float32 m_flMinSpeedScale;
	CAnimParamHandle m_hAnticipationPosParam;
	CAnimParamHandle m_hAnticipationHeadingParam;
	float32 m_flSpringConstant;
	float32 m_flMinSpringTension;
	float32 m_flMaxSpringTension;
}
