// MGetKV3ClassDefaults = {
//	"_class": "CNmAimCSNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_nVerticalAngleNodeIdx": -1,
//	"m_nHorizontalAngleNodeIdx": -1,
//	"m_nWeaponCategoryNodeIdx": -1,
//	"m_nWeaponTypeNodeIdx": -1,
//	"m_nIsWeaponActionActiveNodeIdx": -1,
//	"m_nWeaponDropNodeIdx": -1,
//	"m_nEnabledNodeIdx": -1,
//	"m_flBlendTimeSeconds": 0.000000,
//	"m_flReduceRangeTimeSeconds": 0.000000
//}
class CNmAimCSNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	int16 m_nVerticalAngleNodeIdx;
	int16 m_nHorizontalAngleNodeIdx;
	int16 m_nWeaponCategoryNodeIdx;
	int16 m_nWeaponTypeNodeIdx;
	int16 m_nIsWeaponActionActiveNodeIdx;
	int16 m_nWeaponDropNodeIdx;
	int16 m_nEnabledNodeIdx;
	float32 m_flBlendTimeSeconds;
	float32 m_flReduceRangeTimeSeconds;
};
