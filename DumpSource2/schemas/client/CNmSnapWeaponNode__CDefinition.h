// MGetKV3ClassDefaults = {
//	"_class": "CNmSnapWeaponNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_nEnabledNodeIdx": -1,
//	"m_nLockLeftHandNodeIdx": -1,
//	"m_flBlendTimeSeconds": 0.000000
//}
class CNmSnapWeaponNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	int16 m_nEnabledNodeIdx;
	int16 m_nLockLeftHandNodeIdx;
	float32 m_flBlendTimeSeconds;
};
