// MGetKV3ClassDefaults = {
//	"m_strVariable": "",
//	"m_nVariableField": 18,
//	"m_flScale": 1.000000
//}
class MaterialVariable_t
{
	// MPropertyFriendlyName = "material variable"
	CUtlString m_strVariable;
	// MPropertyFriendlyName = "particle field"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nVariableField;
	// MPropertyFriendlyName = "scale"
	float32 m_flScale;
};
