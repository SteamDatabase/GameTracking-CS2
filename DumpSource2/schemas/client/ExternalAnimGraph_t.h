class ExternalAnimGraph_t
{
	ExternalAnimGraphHandle_t m_hExtGraphHandle;
	CGlobalSymbol m_sExternalGraphSlotID;
	CStrongHandleCopyable< InfoForResourceTypeCNmGraphDefinition > m_hGraphDefinition;
	CHandle< CBaseAnimGraph > m_hExternalGraphOwner;
	ExternalAnimGraphInactiveBehavior_t m_nInactiveBehavior;
};
