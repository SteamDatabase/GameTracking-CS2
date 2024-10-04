class CBaseViewModel : public CBaseAnimGraph
{
	Vector m_vecLastFacing;
	uint32 m_nViewModelIndex;
	uint32 m_nAnimationParity;
	float32 m_flAnimationStartTime;
	CHandle< CBasePlayerWeapon > m_hWeapon;
	CUtlSymbolLarge m_sVMName;
	CUtlSymbolLarge m_sAnimationPrefix;
	HSequence m_hOldLayerSequence;
	int32 m_oldLayer;
	float32 m_oldLayerStartTime;
	CHandle< CBaseEntity > m_hControlPanel;
}
