class C_OP_RenderTreeShake : public CParticleFunctionRenderer
{
	float32 m_flPeakStrength;
	ParticleAttributeIndex_t m_nPeakStrengthFieldOverride;
	float32 m_flRadius;
	ParticleAttributeIndex_t m_nRadiusFieldOverride;
	float32 m_flShakeDuration;
	float32 m_flTransitionTime;
	float32 m_flTwistAmount;
	float32 m_flRadialAmount;
	float32 m_flControlPointOrientationAmount;
	int32 m_nControlPointForLinearDirection;
};
