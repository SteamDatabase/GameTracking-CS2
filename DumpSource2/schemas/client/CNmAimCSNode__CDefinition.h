// MGetKV3ClassDefaults = {
//	"_class": "CNmAimCSNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_nVerticalAngleNodeIdx": -1,
//	"m_nHorizontalAngleNodeIdx": -1,
//	"m_nWeaponCategoryNodeIdx": -1,
//	"m_nEnabledNodeIdx": -1,
//	"m_flBlendTimeSeconds": 0.000000
//}
class CNmAimCSNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	int16 m_nVerticalAngleNodeIdx;
	int16 m_nHorizontalAngleNodeIdx;
	int16 m_nWeaponCategoryNodeIdx;
	int16 m_nEnabledNodeIdx;
	float32 m_flBlendTimeSeconds;
};
