// MGetKV3ClassDefaults = {
//	"m_sAnimGraphNavlinkType": "",
//	"m_unAlignmentDegrees": 0
//}
class CNavLinkAnimgraphVar
{
	// MPropertyFriendlyName = "Animgraph Navlink Type"
	// MPropertyDescription = "The value of the 'e_navlink_type' or 'e_navlink_type_shared' parameter that should be set on the NPC's animgraph as it starts a 'navlink' movement handshake."
	// MPropertyAttributeEditor = "VDataAnimGraphParamEnumValue( m_sToolsOnlyOwnerModelName; literal; e_navlink_type; e_navlink_type_shared )"
	CGlobalSymbol m_sAnimGraphNavlinkType;
	// MPropertyFriendlyName = "Alignment Degrees"
	// MPropertyDescription = "Amount of angular slack the animation has when aligning to the navlink. 0 indicates that it must be strictly aligned."
	uint32 m_unAlignmentDegrees;
};
