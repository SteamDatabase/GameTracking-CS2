// MGetKV3ClassDefaults = {
//	"m_nChainIndex": -1,
//	"m_SolverSettings":
//	{
//		"m_SolverType": "IKSOLVER_TwoBone",
//		"m_nNumIterations": 6,
//		"m_EndEffectorRotationFixUpMode": "MatchTargetOrientation"
//	},
//	"m_TargetSettings":
//	{
//		"m_TargetSource": "Bone",
//		"m_Bone":
//		{
//			"m_Name": ""
//		},
//		"m_AnimgraphParameterNamePosition":
//		{
//			"m_id": 4294967295
//		},
//		"m_AnimgraphParameterNameOrientation":
//		{
//			"m_id": 4294967295
//		},
//		"m_TargetCoordSystem": "World Space"
//	},
//	"m_DebugSetting": "SOLVEIKCHAINANIMNODEDEBUGSETTING_None",
//	"m_flDebugNormalizedValue": 1.000000,
//	"m_vDebugOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	]
//}
class ChainToSolveData_t
{
	int32 m_nChainIndex;
	IKSolverSettings_t m_SolverSettings;
	IKTargetSettings_t m_TargetSettings;
	SolveIKChainAnimNodeDebugSetting m_DebugSetting;
	float32 m_flDebugNormalizedValue;
	VectorAligned m_vDebugOffset;
};
