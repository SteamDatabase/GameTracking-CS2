// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_childLumps":
//	[
//	],
//	"m_entityKeyValues":
//	[
//	]
//}
class PermEntityLumpData_t
{
	CUtlString m_name;
	CUtlVector< CStrongHandleCopyable< InfoForResourceTypeCEntityLump > > m_childLumps;
	CUtlLeanVector< EntityKeyValueData_t > m_entityKeyValues;
};
