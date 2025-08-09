// MGetKV3ClassDefaults = {
//	"m_constants":
//	[
//	],
//	"m_variables":
//	[
//	],
//	"m_functions":
//	[
//	],
//	"m_constantMap":
//	{
//	},
//	"m_variableMap":
//	{
//	},
//	"m_functionMap":
//	{
//	}
//}
class CFuseSymbolTable
{
	CUtlVector< ConstantInfo_t > m_constants;
	CUtlVector< VariableInfo_t > m_variables;
	CUtlVector< FunctionInfo_t > m_functions;
	CUtlHashtable< CUtlStringToken, int32 > m_constantMap;
	CUtlHashtable< CUtlStringToken, int32 > m_variableMap;
	CUtlHashtable< CUtlStringToken, int32 > m_functionMap;
};
