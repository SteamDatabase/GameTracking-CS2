// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CJumpHelperUpdateNode : public CSequenceUpdateNode
{
	CAnimParamHandle m_hTargetParam;
	Vector m_flOriginalJumpMovement;
	float32 m_flOriginalJumpDuration;
	float32 m_flJumpStartCycle;
	float32 m_flJumpEndCycle;
	JumpCorrectionMethod m_eCorrectionMethod;
	bool[3] m_bTranslationAxis;
	bool m_bScaleSpeed;
};
