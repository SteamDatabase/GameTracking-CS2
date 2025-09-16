// MGetKV3ClassDefaults = {
//	"_class": "CClothSettingsAnimTag",
//	"m_name": "Unnamed Tag",
//	"m_sComment": "",
//	"m_group": "",
//	"m_tagID":
//	{
//		"m_id": 4294967295
//	},
//	"m_bIsReferenced": false,
//	"m_flStiffness": 1.000000,
//	"m_flEaseIn": 0.000000,
//	"m_flEaseOut": 0.000000,
//	"m_nVertexSet": ""
//}
// MPropertyFriendlyName = "Cloth Settings Tag"
class CClothSettingsAnimTag : public CAnimTagBase
{
	// MPropertyFriendlyName = "Stiffness"
	// MPropertyAttributeRange = "0 1"
	float32 m_flStiffness;
	// MPropertyFriendlyName = "EaseIn"
	// MPropertyAttributeRange = "0 1"
	float32 m_flEaseIn;
	// MPropertyFriendlyName = "EaseOut"
	// MPropertyAttributeRange = "0 1"
	float32 m_flEaseOut;
	// MPropertyFriendlyName = "VertexSet"
	CUtlString m_nVertexSet;
};
