// MGetKV3ClassDefaults = {
//	"m_Name": "",
//	"m_Description": "",
//	"m_Type": "PVAL_VOID",
//	"m_DefaultValue": null,
//	"m_nKeysSource": "PRIVATE",
//	"m_bIsPublicBlackboardVariable": false,
//	"m_bIsObservable": false,
//	"m_nEditorNodeID": -1
//}
class CPulse_Variable
{
	PulseSymbol_t m_Name;
	CUtlString m_Description;
	CPulseValueFullType m_Type;
	KeyValues3 m_DefaultValue;
	PulseVariableKeysSource_t m_nKeysSource;
	bool m_bIsPublicBlackboardVariable;
	bool m_bIsObservable;
	PulseDocNodeID_t m_nEditorNodeID;
};
