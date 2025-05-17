// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyElementNameFn (UNKNOWN FOR PARSER)
class CSosSoundEventGroupSchema
{
	// MPropertyFriendlyName = "Group Name"
	CUtlString m_name;
	// MPropertyFriendlyName = "Group Type"
	SosGroupType_t m_nType;
	// MPropertyFriendlyName = "Blocks Events"
	bool m_bIsBlocking;
	// MPropertyFriendlyName = "Block Max Count"
	int32 m_nBlockMaxCount;
	// MPropertyFriendlyName = "Invert Match"
	bool m_bInvertMatch;
	// MPropertyFriendlyName = "Match Rules"
	CSosGroupMatchPattern m_matchPattern;
	// MPropertyFriendlyName = "Branch Rules"
	CSosGroupBranchPattern m_branchPattern;
	// MPropertyFriendlyName = "Member Lifespan Time"
	float32 m_flLifeSpanTime;
	// MPropertyFriendlyName = "Actions"
	CSosGroupActionSchema*[4] m_vActions;
};
