// MNetworkExcludeByUserGroup = "LocalPlayerExclusive"
// MNetworkVarNames = "CHandle<C_EconWearable > m_hMyWearables"
class C_BaseCombatCharacter : public C_BaseFlex
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnWearablesChanged"
	C_NetworkUtlVectorBase< CHandle< C_EconWearable > > m_hMyWearables;
	AttachmentHandle_t m_leftFootAttachment;
	AttachmentHandle_t m_rightFootAttachment;
	C_BaseCombatCharacter::WaterWakeMode_t m_nWaterWakeMode;
	float32 m_flWaterWorldZ;
	float32 m_flWaterNextTraceTime;
};
