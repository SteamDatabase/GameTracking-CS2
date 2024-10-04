class CParticleVecInput : public CParticleInput
{
	ParticleVecType_t m_nType;
	Vector m_vLiteralValue;
	Color m_LiteralColor;
	CParticleNamedValueRef m_NamedValue;
	bool m_bFollowNamedValue;
	ParticleAttributeIndex_t m_nVectorAttribute;
	Vector m_vVectorAttributeScale;
	int32 m_nControlPoint;
	int32 m_nDeltaControlPoint;
	Vector m_vCPValueScale;
	Vector m_vCPRelativePosition;
	Vector m_vCPRelativeDir;
	CParticleFloatInput m_FloatComponentX;
	CParticleFloatInput m_FloatComponentY;
	CParticleFloatInput m_FloatComponentZ;
	CParticleFloatInput m_FloatInterp;
	float32 m_flInterpInput0;
	float32 m_flInterpInput1;
	Vector m_vInterpOutput0;
	Vector m_vInterpOutput1;
	CColorGradient m_Gradient;
	Vector m_vRandomMin;
	Vector m_vRandomMax;
};
