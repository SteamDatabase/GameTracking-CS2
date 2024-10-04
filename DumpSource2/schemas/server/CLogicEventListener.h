class CLogicEventListener : public CLogicalEntity
{
	CUtlString m_strEventName;
	bool m_bIsEnabled;
	int32 m_nTeam;
	CEntityIOOutput m_OnEventFired;
};
