class C_OP_ExternalWindForce : public CParticleFunctionForce
{
	CPerParticleVecInput m_vecSamplePosition;
	CPerParticleVecInput m_vecScale;
	bool m_bSampleWind;
	bool m_bSampleWater;
	bool m_bDampenNearWaterPlane;
	bool m_bSampleGravity;
	CPerParticleVecInput m_vecGravityForce;
	bool m_bUseBasicMovementGravity;
	CPerParticleFloatInput m_flLocalGravityScale;
	CPerParticleFloatInput m_flLocalBuoyancyScale;
	CPerParticleVecInput m_vecBuoyancyForce;
};
