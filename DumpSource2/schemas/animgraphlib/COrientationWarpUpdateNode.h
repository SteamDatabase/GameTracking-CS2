// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class COrientationWarpUpdateNode : public CUnaryUpdateNode
{
	OrientationWarpMode_t m_eMode;
	CAnimParamHandle m_hTargetParam;
	CAnimParamHandle m_hTargetPositionParam;
	CAnimParamHandle m_hFallbackTargetPositionParam;
	OrientationWarpTargetOffsetMode_t m_eTargetOffsetMode;
	float32 m_flTargetOffset;
	CAnimParamHandle m_hTargetOffsetParam;
	CAnimInputDamping m_damping;
	OrientationWarpRootMotionSource_t m_eRootMotionSource;
	float32 m_flMaxRootMotionScale;
	bool m_bEnablePreferredRotationDirection;
	AnimValueSource m_ePreferredRotationDirection;
	float32 m_flPreferredRotationThreshold;
};
