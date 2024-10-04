class CTriggerLerpObject : public CBaseTrigger
{
	CUtlSymbolLarge m_iszLerpTarget;
	CHandle< CBaseEntity > m_hLerpTarget;
	CUtlSymbolLarge m_iszLerpTargetAttachment;
	AttachmentHandle_t m_hLerpTargetAttachment;
	float32 m_flLerpDuration;
	bool m_bLerpRestoreMoveType;
	bool m_bSingleLerpObject;
	CUtlVector< lerpdata_t > m_vecLerpingObjects;
	CUtlSymbolLarge m_iszLerpEffect;
	CUtlSymbolLarge m_iszLerpSound;
	bool m_bAttachTouchingObject;
	CHandle< CBaseEntity > m_hEntityToWaitForDisconnect;
	CEntityIOOutput m_OnLerpStarted;
	CEntityIOOutput m_OnLerpFinished;
};
