class CBtActionCombatPositioning : public CBtNode
{
	CUtlString m_szSensorInputKey;
	CUtlString m_szIsAttackingKey;
	CountdownTimer m_ActionTimer;
	bool m_bCrouching;
}
