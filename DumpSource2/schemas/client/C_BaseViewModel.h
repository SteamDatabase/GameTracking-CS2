class C_BaseViewModel : public CBaseAnimGraph
{
	Vector m_vecLastFacing;
	uint32 m_nViewModelIndex;
	uint32 m_nAnimationParity;
	float32 m_flAnimationStartTime;
	CHandle< C_BasePlayerWeapon > m_hWeapon;
	CUtlSymbolLarge m_sVMName;
	CUtlSymbolLarge m_sAnimationPrefix;
	AttachmentHandle_t m_iCameraAttachment;
	QAngle m_vecLastCameraAngles;
	float32 m_previousElapsedDuration;
	float32 m_previousCycle;
	int32 m_nOldAnimationParity;
	HSequence m_hOldLayerSequence;
	int32 m_oldLayer;
	float32 m_oldLayerStartTime;
	CHandle< C_BaseEntity > m_hControlPanel;
};
