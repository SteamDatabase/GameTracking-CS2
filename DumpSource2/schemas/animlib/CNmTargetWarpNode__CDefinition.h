// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
