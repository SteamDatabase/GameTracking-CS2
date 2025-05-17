// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_TeleportBeam : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "Position Control Point"
	int32 m_nCPPosition;
	// MPropertyFriendlyName = "Velocity Control Point"
	int32 m_nCPVelocity;
	// MPropertyFriendlyName = "Misc Control Point"
	int32 m_nCPMisc;
	// MPropertyFriendlyName = "Color Control Point"
	int32 m_nCPColor;
	// MPropertyFriendlyName = "Invalid Color Control Point"
	int32 m_nCPInvalidColor;
	// MPropertyFriendlyName = "Extra Arc Data Point"
	int32 m_nCPExtraArcData;
	// MPropertyFriendlyName = "Gravity"
	Vector m_vGravity;
	// MPropertyFriendlyName = "Arc Duration Maximum"
	float32 m_flArcMaxDuration;
	// MPropertyFriendlyName = "Segment Break"
	float32 m_flSegmentBreak;
	// MPropertyFriendlyName = "Arc Speed"
	float32 m_flArcSpeed;
	// MPropertyFriendlyName = "Alpha"
	float32 m_flAlpha;
};
