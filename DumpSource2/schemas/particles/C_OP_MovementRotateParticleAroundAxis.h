class C_OP_MovementRotateParticleAroundAxis : public CParticleFunctionOperator
{
	CParticleCollectionVecInput m_vecRotAxis;
	CParticleCollectionFloatInput m_flRotRate;
	CParticleTransformInput m_TransformInput;
	bool m_bLocalSpace;
};
