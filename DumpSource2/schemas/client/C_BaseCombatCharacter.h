// MNetworkExcludeByUserGroup = "LocalPlayerExclusive"
// MNetworkVarNames = "CHandle<C_EconWearable > m_hMyWearables"
class C_BaseCombatCharacter : public C_BaseFlex
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnWearablesChanged"
	// MNotSaved
	C_NetworkUtlVectorBase< CHandle< C_EconWearable > > m_hMyWearables;
	// MNotSaved
	AttachmentHandle_t m_leftFootAttachment;
	// MNotSaved
	AttachmentHandle_t m_rightFootAttachment;
	// MNotSaved
	C_BaseCombatCharacter::WaterWakeMode_t m_nWaterWakeMode;
	// MNotSaved
	float32 m_flWaterWorldZ;
	// MNotSaved
	float32 m_flWaterNextTraceTime;
};
