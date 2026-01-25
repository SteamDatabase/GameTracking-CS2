// MGetKV3ClassDefaults = {
//	"m_Instructions":
//	[
//	],
//	"m_Registers":
//	[
//	],
//	"m_InstructionDebugInfos":
//	[
//	]
//}
class CPulse_Chunk
{
	CUtlLeanVector< PGDInstruction_t > m_Instructions;
	CUtlLeanVector< CPulse_RegisterInfo > m_Registers;
	CUtlLeanVector< CPulse_InstructionDebug > m_InstructionDebugInfos;
};
