// MGetKV3ClassDefaults = {
//	"_class": "CAnimParameterManagerUpdater",
//	"m_parameters":
//	[
//	],
//	"m_idToIndexMap":
//	[
//	],
//	"m_nameToIndexMap":
//	{
//	},
//	"m_indexToHandle":
//	[
//	],
//	"m_autoResetParams":
//	[
//	],
//	"m_autoResetMap":
//	[
//	]
//}
class CAnimParameterManagerUpdater
{
	CUtlVector< CSmartPtr< CAnimParameterBase > > m_parameters;
	CUtlHashtable< AnimParamID, int32 > m_idToIndexMap;
	CUtlHashtable< CUtlString, int32 > m_nameToIndexMap;
	CUtlVector< CAnimParamHandle > m_indexToHandle;
	CUtlVector< std::pair< CAnimParamHandle, CAnimVariant > > m_autoResetParams;
	CUtlHashtable< CAnimParamHandle, int16 > m_autoResetMap;
};
