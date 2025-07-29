class CNmChainSolverTask : public CNmPoseTask
{
	int32 m_nEffectorBoneIdx;
	CTransform m_targetTransform;
	int32 m_nNumBonesInChain;
	CNmTarget m_effectorTarget;
	NmIKBlendMode_t m_blendMode;
	float32 m_flBlendWeight;
	bool m_bIsTargetInWorldSpace;
	bool m_bIsRunningFromDeserializedData;
	CGlobalSymbol m_debugEffectorBoneID;
	CTransform m_chainStartTransformMS;
	CTransform m_debugRequestedTargetTransformMS;
	float32 m_debugTotalChainLength;
};
