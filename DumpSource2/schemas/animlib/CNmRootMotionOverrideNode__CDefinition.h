// MGetKV3ClassDefaults = {
//	"_class": "CNmRootMotionOverrideNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_desiredMovingVelocityNodeIdx": -1,
//	"m_desiredFacingDirectionNodeIdx": -1,
//	"m_linearVelocityLimitNodeIdx": -1,
//	"m_angularVelocityLimitNodeIdx": -1,
//	"m_maxLinearVelocity": -1.000000,
//	"m_maxAngularVelocityRadians": -1.000000,
//	"m_overrideFlags":
//	{
//		"m_flags": 1
//	}
//}
class CNmRootMotionOverrideNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	int16 m_desiredMovingVelocityNodeIdx;
	int16 m_desiredFacingDirectionNodeIdx;
	int16 m_linearVelocityLimitNodeIdx;
	int16 m_angularVelocityLimitNodeIdx;
	float32 m_maxLinearVelocity;
	float32 m_maxAngularVelocityRadians;
	CNmBitFlags m_overrideFlags;
};
