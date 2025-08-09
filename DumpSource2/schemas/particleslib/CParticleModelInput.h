// MGetKV3ClassDefaults = {
//	"m_nType": "PM_TYPE_INVALID",
//	"m_NamedValue": "",
//	"m_nControlPoint": -1
//}
// MPropertyCustomEditor = "ModelInput()"
// MClassIsParticleModel
// MParticleCustomFieldDefaultValue (UNKNOWN FOR PARSER)
class CParticleModelInput : public CParticleInput
{
	ParticleModelType_t m_nType;
	CParticleNamedValueRef m_NamedValue;
	int32 m_nControlPoint;
};
