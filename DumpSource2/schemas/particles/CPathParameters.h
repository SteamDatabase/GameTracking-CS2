// MGetKV3ClassDefaults = {
//	"m_nStartControlPointNumber": 0,
//	"m_nEndControlPointNumber": 0,
//	"m_nBulgeControl": 0,
//	"m_flBulge": 0.000000,
//	"m_flMidPoint": 0.500000,
//	"m_vStartPointOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vMidPointOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vEndOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	]
//}
class CPathParameters
{
	// MPropertyFriendlyName = "start control point number"
	int32 m_nStartControlPointNumber;
	// MPropertyFriendlyName = "end control point number"
	int32 m_nEndControlPointNumber;
	// MPropertyFriendlyName = "bulge control 0=random 1=orientation of start pnt 2=orientation of end point"
	int32 m_nBulgeControl;
	// MPropertyFriendlyName = "random bulge"
	float32 m_flBulge;
	// MPropertyFriendlyName = "mid point position"
	float32 m_flMidPoint;
	// MPropertyFriendlyName = "Offset from curve start point for path start"
	// MVectorIsCoordinate
	Vector m_vStartPointOffset;
	// MPropertyFriendlyName = "Offset from curve midpoint for curve center"
	// MVectorIsCoordinate
	Vector m_vMidPointOffset;
	// MPropertyFriendlyName = "Offset from control point for path end"
	// MVectorIsCoordinate
	Vector m_vEndOffset;
};
