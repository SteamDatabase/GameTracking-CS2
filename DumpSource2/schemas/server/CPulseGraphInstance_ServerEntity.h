// MPulseInstanceDomainInfo (UNKNOWN FOR PARSER)
// MPulseDomainHookInfo (UNKNOWN FOR PARSER)
// MPulseDomainScopeInfo (UNKNOWN FOR PARSER)
// MPulseLibraryBindings (UNKNOWN FOR PARSER)
// MPulseDomainOptInFeatureTag (UNKNOWN FOR PARSER)
// MPulseDomainOptInValueType (UNKNOWN FOR PARSER)
// MPulseDomainOptInGameBlackboard (UNKNOWN FOR PARSER)
// MPulseDomainHiddenInTool
class CPulseGraphInstance_ServerEntity : public CBasePulseGraphInstance
{
	CHandle< CBaseEntity > m_hOwner;
	bool m_bActivated;
	CUtlSymbolLarge m_sNameFixupStaticPrefix;
	CUtlSymbolLarge m_sNameFixupParent;
	CUtlSymbolLarge m_sNameFixupLocal;
	CUtlSymbolLarge m_sProceduralWorldNameForRelays;
};
