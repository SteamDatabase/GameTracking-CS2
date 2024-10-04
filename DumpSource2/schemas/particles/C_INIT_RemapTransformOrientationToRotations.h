class C_INIT_RemapTransformOrientationToRotations : public CParticleFunctionInitializer
{
	CParticleTransformInput m_TransformInput;
	Vector m_vecRotation;
	bool m_bUseQuat;
	bool m_bWriteNormal;
};
