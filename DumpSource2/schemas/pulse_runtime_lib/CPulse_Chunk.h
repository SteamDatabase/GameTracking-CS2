// MGetKV3ClassDefaults = {
//	"m_Instructions":
//	[
//	],
//	"m_Registers":
//	[
//	],
//	"m_InstructionEditorIDs":
//	[
//	]
//}
class CPulse_Chunk
{
	CUtlLeanVector< PGDInstruction_t > m_Instructions;
	CUtlLeanVector< CPulse_RegisterInfo > m_Registers;
	CUtlLeanVector< PulseDocNodeID_t > m_InstructionEditorIDs;
};
