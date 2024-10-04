class C_Chicken : public C_DynamicProp
{
	CHandle< CBaseAnimGraph > m_hHolidayHatAddon;
	bool m_jumpedThisFrame;
	CHandle< C_CSPlayerPawn > m_leader;
	C_AttributeContainer m_AttributeManager;
	bool m_bAttributesInitialized;
	ParticleIndex_t m_hWaterWakeParticles;
	bool m_bIsPreviewModel;
};
