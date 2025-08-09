// MGetKV3ClassDefaults = {
//	"_class": "CModelConfigElement_RandomPick",
//	"m_ElementName": "",
//	"m_NestedElements":
//	[
//	],
//	"m_Choices":
//	[
//	],
//	"m_ChoiceWeights":
//	[
//	]
//}
class CModelConfigElement_RandomPick : public CModelConfigElement
{
	CUtlVector< CUtlString > m_Choices;
	CUtlVector< float32 > m_ChoiceWeights;
};
