class C_BaseCombatCharacter : public C_BaseFlex
{
	C_NetworkUtlVectorBase< CHandle< C_EconWearable > > m_hMyWearables;
	AttachmentHandle_t m_leftFootAttachment;
	AttachmentHandle_t m_rightFootAttachment;
	C_BaseCombatCharacter::WaterWakeMode_t m_nWaterWakeMode;
	float32 m_flWaterWorldZ;
	float32 m_flWaterNextTraceTime;
}
