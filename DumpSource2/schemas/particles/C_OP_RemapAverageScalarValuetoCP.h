class C_OP_RemapAverageScalarValuetoCP : public CParticleFunctionPreEmission
{
	int32 m_nOutControlPointNumber;
	int32 m_nOutVectorField;
	ParticleAttributeIndex_t m_nField;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
};
