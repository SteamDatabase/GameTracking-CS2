class CFollowPathUpdateNode : public CUnaryUpdateNode
{
	float32 m_flBlendOutTime;
	bool m_bBlockNonPathMovement;
	bool m_bStopFeetAtGoal;
	bool m_bScaleSpeed;
	float32 m_flScale;
	float32 m_flMinAngle;
	float32 m_flMaxAngle;
	float32 m_flSpeedScaleBlending;
	CAnimInputDamping m_turnDamping;
	AnimValueSource m_facingTarget;
	CAnimParamHandle m_hParam;
	float32 m_flTurnToFaceOffset;
	bool m_bTurnToFace;
}
