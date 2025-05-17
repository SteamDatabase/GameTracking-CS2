// MNetworkVarNames = "bool m_bShouldIgnoreOffsetAndAccuracy"
class C_CSGOViewModel : public C_PredictedViewModel
{
	// MNetworkEnable
	bool m_bShouldIgnoreOffsetAndAccuracy;
	CEntityIndex m_nLastKnownAssociatedWeaponEntIndex;
	bool m_bNeedToQueueHighResComposite;
	QAngle m_vLoweredWeaponOffset;
};
