// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_UpdateLightSource : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "color tint"
	Color m_vColorTint;
	// MPropertyFriendlyName = "amount to multiply light brightness by"
	float32 m_flBrightnessScale;
	// MPropertyFriendlyName = "amount to multiply particle system radius by to get light radius"
	float32 m_flRadiusScale;
	// MPropertyFriendlyName = "minimum radius for created lights"
	float32 m_flMinimumLightingRadius;
	// MPropertyFriendlyName = "maximum radius for created lights"
	float32 m_flMaximumLightingRadius;
	// MPropertyFriendlyName = "amount of damping of changes"
	float32 m_flPositionDampingConstant;
};
