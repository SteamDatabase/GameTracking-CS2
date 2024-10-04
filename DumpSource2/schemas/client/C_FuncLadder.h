class C_FuncLadder : public C_BaseModelEntity
{
	Vector m_vecLadderDir;
	CUtlVector< CHandle< C_InfoLadderDismount > > m_Dismounts;
	Vector m_vecLocalTop;
	Vector m_vecPlayerMountPositionTop;
	Vector m_vecPlayerMountPositionBottom;
	float32 m_flAutoRideSpeed;
	bool m_bDisabled;
	bool m_bFakeLadder;
	bool m_bHasSlack;
}
