class CFootPinningUpdateNode : public CUnaryUpdateNode
{
	FootPinningPoseOpFixedData_t m_poseOpFixedData;
	FootPinningTimingSource m_eTimingSource;
	CUtlVector< CAnimParamHandle > m_params;
	bool m_bResetChild;
};
