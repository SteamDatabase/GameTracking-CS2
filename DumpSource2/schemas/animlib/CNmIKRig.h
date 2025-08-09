// MGetKV3ClassDefaults = {
//	"m_skeleton": "",
//	"m_vecBodies":
//	[
//	],
//	"m_vecJoints":
//	[
//	]
//}
class CNmIKRig
{
	CStrongHandle< InfoForResourceTypeCNmSkeleton > m_skeleton;
	CUtlVector< CNmIKBody > m_vecBodies;
	CUtlVector< CNmIKJoint > m_vecJoints;
};
