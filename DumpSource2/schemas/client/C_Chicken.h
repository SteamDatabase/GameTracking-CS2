// MNetworkVarNames = "bool m_jumpedThisFrame"
// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_leader"
// MNetworkVarNames = "CAttributeContainer m_AttributeManager"
class C_Chicken : public C_DynamicProp, public IHasAttributes
{
	CHandle< CBaseAnimGraph > m_hHolidayHatAddon;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnJumpedChanged"
	bool m_jumpedThisFrame;
	// MNetworkEnable
	CHandle< C_CSPlayerPawn > m_leader;
	// MNetworkEnable
	C_AttributeContainer m_AttributeManager;
	bool m_bAttributesInitialized;
	ParticleIndex_t m_hWaterWakeParticles;
	bool m_bIsPreviewModel;
};
