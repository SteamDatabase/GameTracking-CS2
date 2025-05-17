// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CSosGroupActionSoundeventPrioritySchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Priority Value, typically 0.0 to 1.0"
	CUtlString m_priorityValue;
	// MPropertyFriendlyName = "Priority-Based Volume Multiplier, 0.0 to 1.0"
	CUtlString m_priorityVolumeScalar;
	// MPropertyFriendlyName = "Contribute to the priority system, but volume is unaffected by it (bool)"
	CUtlString m_priorityContributeButDontRead;
	// MPropertyFriendlyName = "Don't contribute to the priority system, but volume is affected by it (bool)"
	CUtlString m_bPriorityReadButDontContribute;
};
