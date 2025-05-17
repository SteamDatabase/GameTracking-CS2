// MNetworkIncludeByName = "m_nModelIndex"
// MNetworkIncludeByName = "m_hModel"
// MNetworkIncludeByName = "m_hOwnerEntity"
// MNetworkIncludeByName = "m_MeshGroupMask"
// MNetworkIncludeByName = "m_fEffects"
// MNetworkIncludeByName = "m_baseLayer.m_hSequence"
// MNetworkIncludeByName = "m_animationController.m_flPlaybackRate"
// MNetworkIncludeByName = "m_flAnimTime"
// MNetworkIncludeByName = "m_flSimulationTime"
// MNetworkIncludeByName = "m_animationController.m_animGraphNetworkedVars"
// MNetworkIncludeByName = "m_nResetEventsParity"
// MNetworkExcludeByUserGroup = "m_flPoseParameter"
// MNetworkOverride = "m_fEffects"
// MNetworkIncludeByName = "m_clrRender"
// MNetworkVarNames = "uint32 m_nViewModelIndex"
// MNetworkVarNames = "uint32 m_nAnimationParity"
// MNetworkVarNames = "float32 m_flAnimationStartTime"
// MNetworkVarNames = "CHandle< CBasePlayerWeapon> m_hWeapon"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hControlPanel"
class CBaseViewModel : public CBaseAnimGraph
{
	Vector m_vecLastFacing;
	// MNetworkEnable
	uint32 m_nViewModelIndex;
	// MNetworkEnable
	uint32 m_nAnimationParity;
	// MNetworkEnable
	float32 m_flAnimationStartTime;
	// MNetworkEnable
	CHandle< CBasePlayerWeapon > m_hWeapon;
	CUtlSymbolLarge m_sVMName;
	CUtlSymbolLarge m_sAnimationPrefix;
	HSequence m_hOldLayerSequence;
	int32 m_oldLayer;
	float32 m_oldLayerStartTime;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hControlPanel;
};
