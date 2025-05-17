// MNetworkVarNames = "CUtlString m_strStartTouchEventName"
// MNetworkVarNames = "CUtlString m_strEndTouchEventName"
// MNetworkVarNames = "CUtlString m_strTriggerID"
class CTriggerGameEvent : public CBaseTrigger
{
	// MNetworkEnable
	CUtlString m_strStartTouchEventName;
	// MNetworkEnable
	CUtlString m_strEndTouchEventName;
	// MNetworkEnable
	CUtlString m_strTriggerID;
};
