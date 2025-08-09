// MGetKV3ClassDefaults = {
//	"m_programBuffer":
//	[
//	],
//	"m_variablesRead":
//	[
//	],
//	"m_variablesWritten":
//	[
//	],
//	"m_nMaxTempVarsUsed": 0
//}
class CFuseProgram
{
	CUtlVector< uint8 > m_programBuffer;
	CUtlVector< FuseVariableIndex_t > m_variablesRead;
	CUtlVector< FuseVariableIndex_t > m_variablesWritten;
	int32 m_nMaxTempVarsUsed;
};
