class C_OP_TimeVaryingForce : public CParticleFunctionForce
{
	float32 m_flStartLerpTime;
	Vector m_StartingForce;
	float32 m_flEndLerpTime;
	Vector m_EndingForce;
};
