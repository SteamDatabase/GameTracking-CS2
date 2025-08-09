// MGetKV3ClassDefaults = {
//	"audioreflectivity": 0.000000,
//	"audiohardnessfactor": 0.000000,
//	"audioroughnessfactor": 0.000000,
//	"scrapeRoughThreshold": 0.000000,
//	"impactHardThreshold": 0.000000,
//	"audioHardMinVelocity": 0.000000,
//	"staticImpactVolume": 0.000000,
//	"occlusionFactor": 0.000000
//}
class CPhysSurfacePropertiesAudio
{
	// MKV3TransferName = "audioreflectivity"
	float32 m_reflectivity;
	// MKV3TransferName = "audiohardnessfactor"
	float32 m_hardnessFactor;
	// MKV3TransferName = "audioroughnessfactor"
	float32 m_roughnessFactor;
	// MKV3TransferName = "scrapeRoughThreshold"
	float32 m_roughThreshold;
	// MKV3TransferName = "impactHardThreshold"
	float32 m_hardThreshold;
	// MKV3TransferName = "audioHardMinVelocity"
	float32 m_hardVelocityThreshold;
	// MKV3TransferName = "staticImpactVolume"
	float32 m_flStaticImpactVolume;
	// MKV3TransferName = "occlusionFactor"
	float32 m_flOcclusionFactor;
};
