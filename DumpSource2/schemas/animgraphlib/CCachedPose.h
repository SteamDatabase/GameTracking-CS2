// MGetKV3ClassDefaults = {
//	"_class": "CCachedPose",
//	"m_transforms":
//	[
//	],
//	"m_morphWeights":
//	[
//	],
//	"m_hSequence": -1,
//	"m_flCycle": 0.000000
//}
class CCachedPose
{
	CUtlVector< CTransform > m_transforms;
	CUtlVector< float32 > m_morphWeights;
	HSequence m_hSequence;
	float32 m_flCycle;
};
