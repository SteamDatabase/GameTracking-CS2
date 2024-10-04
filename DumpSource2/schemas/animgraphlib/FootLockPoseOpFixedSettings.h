class FootLockPoseOpFixedSettings
{
	CUtlVector< FootFixedData_t > m_footInfo;
	CAnimInputDamping m_hipDampingSettings;
	int32 m_nHipBoneIndex;
	IKSolverType m_ikSolverType;
	bool m_bApplyTilt;
	bool m_bApplyHipDrop;
	bool m_bAlwaysUseFallbackHinge;
	bool m_bApplyFootRotationLimits;
	bool m_bApplyLegTwistLimits;
	float32 m_flMaxFootHeight;
	float32 m_flExtensionScale;
	float32 m_flMaxLegTwist;
	bool m_bEnableLockBreaking;
	float32 m_flLockBreakTolerance;
	float32 m_flLockBlendTime;
	bool m_bEnableStretching;
	float32 m_flMaxStretchAmount;
	float32 m_flStretchExtensionScale;
};
