// MGetKV3ClassDefaults = {
//	"m_nType": "PT_TYPE_CONTROL_POINT",
//	"m_NamedValue": "",
//	"m_bFollowNamedValue": false,
//	"m_bSupportsDisabled": false,
//	"m_bUseOrientation": true,
//	"m_nControlPoint": 0,
//	"m_nControlPointRangeMax": 0,
//	"m_flEndCPGrowthTime": 0.000000
//}
// MPropertyCustomEditor = "TransformInput()"
// MCustomFGDMetadata = "{ KV3DefaultTestFnName = 'CParticleTransformInputDefaultTestFunc' }"
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
