class C_INIT_AgeNoise : public CParticleFunctionInitializer
{
	bool m_bAbsVal;
	bool m_bAbsValInv;
	float32 m_flOffset;
	float32 m_flAgeMin;
	float32 m_flAgeMax;
	float32 m_flNoiseScale;
	float32 m_flNoiseScaleLoc;
	Vector m_vecOffsetLoc;
};
