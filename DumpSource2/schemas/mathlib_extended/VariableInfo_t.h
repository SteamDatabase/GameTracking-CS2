// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_nameToken": "",
//	"m_nIndex": 65535,
//	"m_nNumComponents": 1,
//	"m_eVarType": "INVALID",
//	"m_eAccess": "WRITABLE"
//}
class VariableInfo_t
{
	CUtlString m_name;
	CUtlStringToken m_nameToken;
	FuseVariableIndex_t m_nIndex;
	uint8 m_nNumComponents;
	FuseVariableType_t m_eVarType;
	FuseVariableAccess_t m_eAccess;
};
