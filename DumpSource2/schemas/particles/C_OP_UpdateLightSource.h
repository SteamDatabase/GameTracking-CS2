class C_OP_UpdateLightSource : public CParticleFunctionOperator
{
	Color m_vColorTint;
	float32 m_flBrightnessScale;
	float32 m_flRadiusScale;
	float32 m_flMinimumLightingRadius;
	float32 m_flMaximumLightingRadius;
	float32 m_flPositionDampingConstant;
};
