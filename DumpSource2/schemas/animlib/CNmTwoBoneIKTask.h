class CNmTwoBoneIKTask : public CNmPoseTask
{
	int32 m_nEffectorBoneIdx;
	int32 m_nEffectorTargetBoneIdx;
	CTransform m_targetTransform;
	CNmTarget m_effectorTarget;
	NmIKBlendMode_t m_blendMode;
	float32 m_flBlendWeight;
	bool m_bIsTargetInWorldSpace;
	bool m_bIsRunningFromDeserializedData;
	float32 m_flReferencePoseTwistWeight;
	CGlobalSymbol m_debugEffectorBoneID;
};
