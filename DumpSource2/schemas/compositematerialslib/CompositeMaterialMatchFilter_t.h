// MGetKV3ClassDefaults = {
//	"m_nCompositeMaterialMatchFilterType": "MATCH_FILTER_MATERIAL_ATTRIBUTE_EXISTS",
//	"m_strMatchFilter": "composite_inputs",
//	"m_strMatchValue": "",
//	"m_bPassWhenTrue": true
//}
// MPropertyElementNameFn (UNKNOWN FOR PARSER)
class CompositeMaterialMatchFilter_t
{
	// MPropertyFriendlyName = "Match Type"
	CompositeMaterialMatchFilterType_t m_nCompositeMaterialMatchFilterType;
	// MPropertyFriendlyName = "Name"
	CUtlString m_strMatchFilter;
	// MPropertyFriendlyName = "Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strMatchValue;
	// MPropertyFriendlyName = "Pass when True"
	bool m_bPassWhenTrue;
};
