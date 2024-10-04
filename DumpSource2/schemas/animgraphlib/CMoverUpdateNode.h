class CMoverUpdateNode : public CUnaryUpdateNode
{
	CAnimInputDamping m_damping;
	AnimValueSource m_facingTarget;
	CAnimParamHandle m_hMoveVecParam;
	CAnimParamHandle m_hMoveHeadingParam;
	CAnimParamHandle m_hTurnToFaceParam;
	float32 m_flTurnToFaceOffset;
	float32 m_flTurnToFaceLimit;
	bool m_bAdditive;
	bool m_bApplyMovement;
	bool m_bOrientMovement;
	bool m_bApplyRotation;
	bool m_bLimitOnly;
};
