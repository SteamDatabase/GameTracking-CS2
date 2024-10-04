class C_OP_RemapTransformOrientationToRotations : public CParticleFunctionOperator
{
	CParticleTransformInput m_TransformInput;
	Vector m_vecRotation;
	bool m_bUseQuat;
	bool m_bWriteNormal;
};
