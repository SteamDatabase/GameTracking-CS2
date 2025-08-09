// MGetKV3ClassDefaults = {
//	"_class": "CNmTargetWarpNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nClipReferenceNodeIdx": -1,
//	"m_nTargetValueNodeIdx": -1,
//	"m_samplingMode": "Delta",
//	"m_bAllowTargetUpdate": false,
//	"m_flSamplingPositionErrorThresholdSq": 0.000000,
//	"m_flMaxTangentLength": 1.250000,
//	"m_flLerpFallbackDistanceThreshold": 0.100000,
//	"m_flTargetUpdateDistanceThreshold": 0.100000,
//	"m_flTargetUpdateAngleThresholdRadians": 0.087266
//}
class CNmTargetWarpNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nClipReferenceNodeIdx;
	int16 m_nTargetValueNodeIdx;
	CNmRootMotionData::SamplingMode_t m_samplingMode;
	bool m_bAllowTargetUpdate;
	float32 m_flSamplingPositionErrorThresholdSq;
	float32 m_flMaxTangentLength;
	float32 m_flLerpFallbackDistanceThreshold;
	float32 m_flTargetUpdateDistanceThreshold;
	float32 m_flTargetUpdateAngleThresholdRadians;
};
