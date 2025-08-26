// MGetKV3ClassDefaults = {
//	"surfacePropertyName": "",
//	"m_nameHash": <HIDDEN FOR DIFF>,
//	"m_baseNameHash": <HIDDEN FOR DIFF>,
//	"hidden": false,
//	"description": "",
//	"physics":
//	{
//		"friction": 0.000000,
//		"elasticity": 0.000000,
//		"density": 0.000000,
//		"thickness": 0.100000,
//		"softcontactfrequency": 0.000000,
//		"softcontactdampingratio": 0.000000
//	},
//	"vehicleparams":
//	{
//		"wheeldrag": 0.000000,
//		"wheelfrictionscale": 1.000000
//	},
//	"audiosounds":
//	{
//		"impactsoft": "",
//		"impacthard": "",
//		"scrapesmooth": "",
//		"scraperough": "",
//		"bulletimpact": "",
//		"rolling": "",
//		"break": "",
//		"strain": "",
//		"meleeimpact": "",
//		"pushoff": "",
//		"skidstop": "",
//		"resonant": ""
//	},
//	"audioparams":
//	{
//		"audioreflectivity": 0.000000,
//		"audiohardnessfactor": 0.000000,
//		"audioroughnessfactor": 0.000000,
//		"scrapeRoughThreshold": 0.000000,
//		"impactHardThreshold": 0.000000,
//		"audioHardMinVelocity": 0.000000,
//		"staticImpactVolume": 0.000000,
//		"occlusionFactor": 0.000000
//	}
//}
class CPhysSurfaceProperties
{
	// MKV3TransferName = "surfacePropertyName"
	CUtlString m_name;
	uint32 m_nameHash;
	uint32 m_baseNameHash;
	// MKV3TransferName = "hidden"
	bool m_bHidden;
	// MKV3TransferName = "description"
	CUtlString m_description;
	// MKV3TransferName = "physics"
	CPhysSurfacePropertiesPhysics m_physics;
	// MKV3TransferName = "vehicleparams"
	CPhysSurfacePropertiesVehicle m_vehicleParams;
	// MKV3TransferName = "audiosounds"
	CPhysSurfacePropertiesSoundNames m_audioSounds;
	// MKV3TransferName = "audioparams"
	CPhysSurfacePropertiesAudio m_audioParams;
};
