class C_OP_ParentVortices : public CParticleFunctionForce
{
	float32 m_flForceScale;
	Vector m_vecTwistAxis;
	bool m_bFlipBasedOnYaw;
};
