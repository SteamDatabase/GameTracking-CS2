// MNetworkVarNames = "float m_flInnerAngle"
// MNetworkVarNames = "float m_flOuterAngle"
// MNetworkVarNames = "bool m_bShowLight"
class COmniLight : public CBarnLight
{
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flInnerAngle;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	float32 m_flOuterAngle;
	// MNetworkEnable
	// MNetworkChangeCallback = "RenderingChanged"
	bool m_bShowLight;
};
