// MGetKV3ClassDefaults = {
//	"m_code": "",
//	"m_paramsModified":
//	[
//	],
//	"m_proxyReadParams":
//	[
//	],
//	"m_proxyWriteParams":
//	[
//	],
//	"m_eScriptType": "ANIMSCRIPT_TYPE_INVALID"
//}
class ScriptInfo_t
{
	CUtlString m_code;
	CUtlVector< CAnimParamHandle > m_paramsModified;
	CUtlVector< int32 > m_proxyReadParams;
	CUtlVector< int32 > m_proxyWriteParams;
	AnimScriptType m_eScriptType;
};
