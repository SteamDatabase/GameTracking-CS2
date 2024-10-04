class C_OP_CPOffsetToPercentageBetweenCPs : public CParticleFunctionOperator
{
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flInputBias;
	int32 m_nStartCP;
	int32 m_nEndCP;
	int32 m_nOffsetCP;
	int32 m_nOuputCP;
	int32 m_nInputCP;
	bool m_bRadialCheck;
	bool m_bScaleOffset;
	Vector m_vecOffset;
};
