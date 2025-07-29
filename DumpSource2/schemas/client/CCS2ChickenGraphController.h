class CCS2ChickenGraphController : public CAnimGraphControllerBase
{
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_action;
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_actionSubtype;
	CAnimGraph2ParamOptionalRef< bool > m_bActionReset;
	CAnimGraph2ParamOptionalRef< float32 > m_idleVariation;
	CAnimGraph2ParamOptionalRef< float32 > m_runVariation;
	CAnimGraph2ParamOptionalRef< float32 > m_panicVariation;
	CAnimGraph2ParamOptionalRef< bool > m_bInWater;
	bool m_bHasActionCompletedEvent;
	bool m_bWaitingForCompletedEvent;
};
