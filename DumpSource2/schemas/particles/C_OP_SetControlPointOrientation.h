class C_OP_SetControlPointOrientation : public CParticleFunctionPreEmission
{
	bool m_bUseWorldLocation;
	bool m_bRandomize;
	bool m_bSetOnce;
	int32 m_nCP;
	int32 m_nHeadLocation;
	QAngle m_vecRotation;
	QAngle m_vecRotationB;
	CParticleCollectionFloatInput m_flInterpolation;
};
