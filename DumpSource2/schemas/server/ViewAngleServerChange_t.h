// MNetworkVarNames = "FixAngleSet_t nType"
// MNetworkVarNames = "QAngle qAngle"
// MNetworkVarNames = "uint32 nIndex"
class ViewAngleServerChange_t
{
	// MNetworkEnable
	FixAngleSet_t nType;
	// MNetworkEnable
	// MNetworkEncoder = "qangle_precise"
	QAngle qAngle;
	// MNetworkEnable
	uint32 nIndex;
};
