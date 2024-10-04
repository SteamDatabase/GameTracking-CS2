class C_OP_InterpolateRadius : public CParticleFunctionOperator
{
	float32 m_flStartTime;
	float32 m_flEndTime;
	float32 m_flStartScale;
	float32 m_flEndScale;
	bool m_bEaseInAndOut;
	float32 m_flBias;
};
