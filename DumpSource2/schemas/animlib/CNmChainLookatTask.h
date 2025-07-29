class CNmChainLookatTask : public CNmPoseTask
{
	int32 m_nChainEndBoneIdx;
	int32 m_nNumBonesInChain;
	Vector m_chainForwardDir;
	float32 m_flBlendWeight;
	float32 m_flHorizontalAngleLimitDegrees;
	float32 m_flVerticalAngleLimitDegrees;
	Vector m_lookatTarget;
	bool m_bIsTargetInWorldSpace;
	bool m_bIsRunningFromDeserializedData;
	float32 m_flHorizontalAngleDegrees;
	float32 m_flVerticalAngleDegrees;
};
