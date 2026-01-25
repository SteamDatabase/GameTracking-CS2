// MGetKV3ClassDefaults = {
//	"_class": "CCS2ChickenGraphController",
//	"m_hExternalGraph": 4294967295,
//	"m_action": null,
//	"m_actionSubtype": null,
//	"m_bActionReset": null,
//	"m_idleVariation": null,
//	"m_runVariation": null,
//	"m_panicVariation": null,
//	"m_squatVariation": null,
//	"m_bInWater": null,
//	"m_bHasActionCompletedEvent": false,
//	"m_bWaitingForCompletedEvent": false
//}
class CCS2ChickenGraphController : public CAnimGraphControllerBase
{
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_action;
	CAnimGraph2ParamOptionalRef< CGlobalSymbol > m_actionSubtype;
	CAnimGraph2ParamAutoResetOptionalRef m_bActionReset;
	CAnimGraph2ParamOptionalRef< float32 > m_idleVariation;
	CAnimGraph2ParamOptionalRef< float32 > m_runVariation;
	CAnimGraph2ParamOptionalRef< float32 > m_panicVariation;
	CAnimGraph2ParamOptionalRef< float32 > m_squatVariation;
	CAnimGraph2ParamOptionalRef< bool > m_bInWater;
	bool m_bHasActionCompletedEvent;
	bool m_bWaitingForCompletedEvent;
};
