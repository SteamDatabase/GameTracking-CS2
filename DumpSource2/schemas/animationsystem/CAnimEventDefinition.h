// MGetKV3ClassDefaults = {
//	"m_nFrame": 0,
//	"m_nEndFrame": -1,
//	"m_flCycle": 0.000000,
//	"m_flDuration": 0.000000,
//	"m_EventData": null,
//	"m_sOptions": "",
//	"m_sEventName": ""
//}
class CAnimEventDefinition
{
	int32 m_nFrame;
	int32 m_nEndFrame;
	float32 m_flCycle;
	float32 m_flDuration;
	KeyValues3 m_EventData;
	// MKV3TransferName = "m_sOptions"
	CBufferString m_sLegacyOptions;
	CGlobalSymbol m_sEventName;
};
