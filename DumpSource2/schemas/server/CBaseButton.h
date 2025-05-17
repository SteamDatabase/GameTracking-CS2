// MNetworkVarNames = "CHandle< CBaseModelEntity> m_glowEntity"
// MNetworkVarNames = "bool m_usable"
// MNetworkVarNames = "string_t m_szDisplayText"
class CBaseButton : public CBaseToggle
{
	QAngle m_angMoveEntitySpace;
	bool m_fStayPushed;
	bool m_fRotating;
	locksound_t m_ls;
	CUtlSymbolLarge m_sUseSound;
	CUtlSymbolLarge m_sLockedSound;
	CUtlSymbolLarge m_sUnlockedSound;
	CUtlSymbolLarge m_sOverrideAnticipationName;
	bool m_bLocked;
	bool m_bDisabled;
	GameTime_t m_flUseLockedTime;
	bool m_bSolidBsp;
	CEntityIOOutput m_OnDamaged;
	CEntityIOOutput m_OnPressed;
	CEntityIOOutput m_OnUseLocked;
	CEntityIOOutput m_OnIn;
	CEntityIOOutput m_OnOut;
	int32 m_nState;
	CEntityHandle m_hConstraint;
	CEntityHandle m_hConstraintParent;
	bool m_bForceNpcExclude;
	CUtlSymbolLarge m_sGlowEntity;
	// MNetworkEnable
	CHandle< CBaseModelEntity > m_glowEntity;
	// MNetworkEnable
	bool m_usable;
	// MNetworkEnable
	CUtlSymbolLarge m_szDisplayText;
};
