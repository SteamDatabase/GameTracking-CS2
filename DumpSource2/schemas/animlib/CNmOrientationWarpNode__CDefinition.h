// MGetKV3ClassDefaults = {
//	"_class": "CNmOrientationWarpNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nClipReferenceNodeIdx": -1,
//	"m_nTargetValueNodeIdx": -1,
//	"m_bIsOffsetNode": false,
//	"m_bIsOffsetRelativeToCharacter": true,
//	"m_samplingMode": "WorldSpace"
//}
class CNmOrientationWarpNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nClipReferenceNodeIdx;
	int16 m_nTargetValueNodeIdx;
	bool m_bIsOffsetNode;
	bool m_bIsOffsetRelativeToCharacter;
	CNmRootMotionData::SamplingMode_t m_samplingMode;
};
