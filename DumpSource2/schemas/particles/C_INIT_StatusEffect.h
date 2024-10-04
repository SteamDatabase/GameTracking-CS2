class C_INIT_StatusEffect : public CParticleFunctionInitializer
{
	Detail2Combo_t m_nDetail2Combo;
	float32 m_flDetail2Rotation;
	float32 m_flDetail2Scale;
	float32 m_flDetail2BlendFactor;
	float32 m_flColorWarpIntensity;
	float32 m_flDiffuseWarpBlendToFull;
	float32 m_flEnvMapIntensity;
	float32 m_flAmbientScale;
	Color m_specularColor;
	float32 m_flSpecularScale;
	float32 m_flSpecularExponent;
	float32 m_flSpecularExponentBlendToFull;
	float32 m_flSpecularBlendToFull;
	Color m_rimLightColor;
	float32 m_flRimLightScale;
	float32 m_flReflectionsTintByBaseBlendToNone;
	float32 m_flMetalnessBlendToFull;
	float32 m_flSelfIllumBlendToFull;
};
