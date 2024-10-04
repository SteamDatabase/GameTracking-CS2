class CSolveIKChainUpdateNode : public CUnaryUpdateNode
{
	CUtlVector< CSolveIKTargetHandle_t > m_targetHandles;
	SolveIKChainPoseOpFixedSettings_t m_opFixedData;
}
