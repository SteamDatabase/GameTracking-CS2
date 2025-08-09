// MGetKV3ClassDefaults = {
//	"m_dspName": "default",
//	"m_modifiers":
//	[
//	]
//}
class CDspPresetModifierList
{
	// MPropertyDescription = "Name of the DSP effect / subgraph used."
	// MPropertyFriendlyName = "DSP Effect Name"
	CUtlString m_dspName;
	// MPropertyDescription = "Set of modifiers for individual mix groups"
	// MPropertyFriendlyName = "Mixgroup Modifiers"
	CUtlVector< CDSPMixgroupModifier > m_modifiers;
};
