class CGeneralRandomRotation : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flDegrees;
	float32 m_flDegreesMin;
	float32 m_flDegreesMax;
	float32 m_flRotationRandExponent;
	bool m_bRandomlyFlipDirection;
};
