class C_OP_SetCPOrientationToPointAtCP : public CParticleFunctionPreEmission
{
	int32 m_nInputCP;
	int32 m_nOutputCP;
	CParticleCollectionFloatInput m_flInterpolation;
	bool m_b2DOrientation;
	bool m_bAvoidSingularity;
	bool m_bPointAway;
};
