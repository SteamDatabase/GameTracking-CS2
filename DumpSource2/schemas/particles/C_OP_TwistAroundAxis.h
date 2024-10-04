class C_OP_TwistAroundAxis : public CParticleFunctionForce
{
	float32 m_fForceAmount;
	Vector m_TwistAxis;
	bool m_bLocalSpace;
	int32 m_nControlPointNumber;
};
