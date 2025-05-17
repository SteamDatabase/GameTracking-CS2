// MNetworkVarNames = "Color m_fadeColor"
class CEnvFade : public CLogicalEntity
{
	// MNetworkEnable
	Color m_fadeColor;
	float32 m_Duration;
	float32 m_HoldDuration;
	CEntityIOOutput m_OnBeginFade;
};
