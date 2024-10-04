class CTurnHelperUpdateNode : public CUnaryUpdateNode
{
	AnimValueSource m_facingTarget;
	float32 m_turnStartTimeOffset;
	float32 m_turnDuration;
	bool m_bMatchChildDuration;
	float32 m_manualTurnOffset;
	bool m_bUseManualTurnOffset;
};
