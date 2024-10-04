class C_OP_NoiseEmitter : public CParticleFunctionEmitter
{
	float32 m_flEmissionDuration;
	float32 m_flStartTime;
	float32 m_flEmissionScale;
	int32 m_nScaleControlPoint;
	int32 m_nScaleControlPointField;
	int32 m_nWorldNoisePoint;
	bool m_bAbsVal;
	bool m_bAbsValInv;
	float32 m_flOffset;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	float32 m_flNoiseScale;
	float32 m_flWorldNoiseScale;
	Vector m_vecOffsetLoc;
	float32 m_flWorldTimeScale;
};
