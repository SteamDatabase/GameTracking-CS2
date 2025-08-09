// MGetKV3ClassDefaults = {
//	"_class": "CMovementComponentUpdater",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_bStartEnabled": false,
//	"m_motors":
//	[
//	],
//	"m_facingDamping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_nDefaultMotorIndex": 0,
//	"m_flDefaultRunSpeed": 0.000000,
//	"m_bMoveVarsDisabled": false,
//	"m_bNetworkPath": true,
//	"m_bNetworkFacing": true,
//	"m_paramHandles":
//	[
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		},
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		}
//	]
//}
class CMovementComponentUpdater : public CAnimComponentUpdater
{
	CUtlVector< CSmartPtr< CAnimMotorUpdaterBase > > m_motors;
	CAnimInputDamping m_facingDamping;
	int32 m_nDefaultMotorIndex;
	float32 m_flDefaultRunSpeed;
	bool m_bMoveVarsDisabled;
	bool m_bNetworkPath;
	bool m_bNetworkFacing;
	CAnimParamHandle[34] m_paramHandles;
};
