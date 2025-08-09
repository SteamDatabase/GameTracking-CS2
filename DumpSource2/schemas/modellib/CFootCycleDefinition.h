// MGetKV3ClassDefaults = {
//	"m_vStancePositionMS":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vMidpointPositionMS":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flStanceDirectionMS": 0.000000,
//	"m_vToStrideStartPos":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_stanceCycle":
//	{
//		"m_flCycle": 0.000000
//	},
//	"m_footLiftCycle":
//	{
//		"m_flCycle": 0.000000
//	},
//	"m_footOffCycle":
//	{
//		"m_flCycle": 0.000000
//	},
//	"m_footStrikeCycle":
//	{
//		"m_flCycle": 0.000000
//	},
//	"m_footLandCycle":
//	{
//		"m_flCycle": 0.000000
//	}
//}
class CFootCycleDefinition
{
	Vector m_vStancePositionMS;
	Vector m_vMidpointPositionMS;
	float32 m_flStanceDirectionMS;
	Vector m_vToStrideStartPos;
	CAnimCycle m_stanceCycle;
	CFootCycle m_footLiftCycle;
	CFootCycle m_footOffCycle;
	CFootCycle m_footStrikeCycle;
	CFootCycle m_footLandCycle;
};
