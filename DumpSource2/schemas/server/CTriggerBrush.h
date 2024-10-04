class CTriggerBrush : public CBaseModelEntity
{
	CEntityIOOutput m_OnStartTouch;
	CEntityIOOutput m_OnEndTouch;
	CEntityIOOutput m_OnUse;
	int32 m_iInputFilter;
	int32 m_iDontMessageParent;
}
