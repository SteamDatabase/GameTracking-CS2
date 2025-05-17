// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CBaseConstraint : public CBoneConstraintBase
{
	CUtlString m_name;
	Vector m_vUpVector;
	CUtlLeanVector< CConstraintSlave > m_slaves;
	CUtlVector< CConstraintTarget > m_targets;
};
