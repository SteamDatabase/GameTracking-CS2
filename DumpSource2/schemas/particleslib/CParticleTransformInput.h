// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyCustomEditor = "TransformInput()"
// MClassIsParticleTransform
// MParticleCustomFieldDefaultValue (UNKNOWN FOR PARSER)
class CParticleTransformInput : public CParticleInput
{
	ParticleTransformType_t m_nType;
	CParticleNamedValueRef m_NamedValue;
	bool m_bFollowNamedValue;
	bool m_bSupportsDisabled;
	bool m_bUseOrientation;
	int32 m_nControlPoint;
	int32 m_nControlPointRangeMax;
	float32 m_flEndCPGrowthTime;
};
