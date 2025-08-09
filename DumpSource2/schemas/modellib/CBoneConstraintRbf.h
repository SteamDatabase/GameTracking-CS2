// MGetKV3ClassDefaults = {
//	"_class": "CBoneConstraintRbf",
//	"m_inputBones":
//	[
//	],
//	"m_outputBones":
//	[
//	],
//	"m_rbfParameters": "[BINARY BLOB]"
//}
class CBoneConstraintRbf : public CBoneConstraintBase
{
	CUtlVector< std::pair< CUtlString, uint32 > > m_inputBones;
	CUtlVector< std::pair< CUtlString, uint32 > > m_outputBones;
};
