// MGetKV3ClassDefaults = {
//	"m_times":
//	[
//	],
//	"m_nameHashCodes":
//	[
//	],
//	"m_nameStrings":
//	[
//	],
//	"m_samples":
//	[
//	],
//	"m_flEaseIn": 0.200000,
//	"m_flEaseOut": 0.200000
//}
class CAudioMorphData
{
	CUtlVector< float32 > m_times;
	CUtlVector< uint32 > m_nameHashCodes;
	CUtlVector< CUtlString > m_nameStrings;
	CUtlVector< CUtlVector< float32 > > m_samples;
	float32 m_flEaseIn;
	float32 m_flEaseOut;
};
