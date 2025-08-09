// MGetKV3ClassDefaults = {
//	"m_DomainIdentifier": "",
//	"m_DomainSubType": "PVAL_VOID",
//	"m_ParentMapName": "",
//	"m_ParentXmlName": "",
//	"m_Chunks":
//	[
//	],
//	"m_Cells":
//	[
//	],
//	"m_Vars":
//	[
//	],
//	"m_PublicOutputs":
//	[
//	],
//	"m_InvokeBindings":
//	[
//	],
//	"m_CallInfos":
//	[
//	],
//	"m_Constants":
//	[
//	],
//	"m_DomainValues":
//	[
//	],
//	"m_BlackboardReferences":
//	[
//	],
//	"m_OutputConnections":
//	[
//	]
//}
class CPulseGraphDef
{
	PulseSymbol_t m_DomainIdentifier;
	CPulseValueFullType m_DomainSubType;
	PulseSymbol_t m_ParentMapName;
	PulseSymbol_t m_ParentXmlName;
	CUtlVector< CPulse_Chunk* > m_Chunks;
	CUtlVector< CPulseCell_Base* > m_Cells;
	CUtlVector< CPulse_Variable > m_Vars;
	CUtlVector< CPulse_PublicOutput > m_PublicOutputs;
	CUtlVector< CPulse_InvokeBinding* > m_InvokeBindings;
	CUtlVector< CPulse_CallInfo* > m_CallInfos;
	CUtlVector< CPulse_Constant > m_Constants;
	CUtlVector< CPulse_DomainValue > m_DomainValues;
	CUtlVector< CPulse_BlackboardReference > m_BlackboardReferences;
	CUtlVector< CPulse_OutputConnection* > m_OutputConnections;
};
