// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Material Attribute Tag"
class CMaterialAttributeAnimTag : public CAnimTagBase
{
	// MPropertyFriendlyName = "Attribute Name"
	CUtlString m_AttributeName;
	// MPropertyFriendlyName = "Attribute Type"
	// MPropertyAttrChangeCallback (UNKNOWN FOR PARSER)
	MatterialAttributeTagType_t m_AttributeType;
	// MPropertyFriendlyName = "Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	float32 m_flValue;
	// MPropertyFriendlyName = "Color"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	Color m_Color;
};
