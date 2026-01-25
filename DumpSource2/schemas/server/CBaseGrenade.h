// MNetworkIncludeByName = "m_fFlags"
// MNetworkIncludeByName = "m_vecVelocity"
// MNetworkExcludeByName = "m_flexWeight"
// MNetworkExcludeByUserGroup = "m_flPoseParameter"
// MNetworkExcludeByName = "m_nResetEventsParity"
// MNetworkExcludeByUserGroup = "overlay_vars"
// MNetworkExcludeByUserGroup = "m_flCycle"
// MNetworkExcludeByName = "m_baseLayer.m_hSequence"
// MNetworkExcludeByName = "m_animationController.m_flPlaybackRate"
// MNetworkExcludeByName = "m_nNewSequenceParity"
// MNetworkVarNames = "bool m_bIsLive"
// MNetworkVarNames = "float32 m_DmgRadius"
// MNetworkVarNames = "GameTime_t m_flDetonateTime"
// MNetworkVarNames = "float32 m_flDamage"
// MNetworkVarNames = "CHandle< CCSPlayerPawn > m_hThrower"
class CBaseGrenade : public CBaseFlex
{
	CEntityIOOutput m_OnPlayerPickup;
	CEntityIOOutput m_OnExplode;
	bool m_bHasWarnedAI;
	bool m_bIsSmokeGrenade;
	// MNetworkEnable
	bool m_bIsLive;
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1024.000000
	// MNetworkEncodeFlags = 1
	float32 m_DmgRadius;
	// MNetworkEnable
	GameTime_t m_flDetonateTime;
	float32 m_flWarnAITime;
	// MNetworkEnable
	// MNetworkBitCount = 10
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 256.000000
	// MNetworkEncodeFlags = 1
	float32 m_flDamage;
	CUtlSymbolLarge m_iszBounceSound;
	CUtlString m_ExplosionSound;
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_hThrower;
	GameTime_t m_flNextAttack;
	CHandle< CCSPlayerPawn > m_hOriginalThrower;
};
