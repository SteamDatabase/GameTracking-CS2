// MGetKV3ClassDefaults = {
//	"_class": "CModelConfigElement_AttachedModel",
//	"m_ElementName": "",
//	"m_NestedElements":
//	[
//	],
//	"m_InstanceName": "",
//	"m_EntityClass": "",
//	"m_hModel": "",
//	"m_vOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_aAngOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_AttachmentName": "",
//	"m_LocalAttachmentOffsetName": "",
//	"m_AttachmentType": "MODEL_CONFIG_ATTACHMENT_ROOT_RELATIVE",
//	"m_bBoneMergeFlex": false,
//	"m_bUserSpecifiedColor": false,
//	"m_bUserSpecifiedMaterialGroup": false,
//	"m_BodygroupOnOtherModels": "",
//	"m_MaterialGroupOnOtherModels": ""
//}
class CModelConfigElement_AttachedModel : public CModelConfigElement
{
	CUtlString m_InstanceName;
	CUtlString m_EntityClass;
	CStrongHandle< InfoForResourceTypeCModel > m_hModel;
	Vector m_vOffset;
	QAngle m_aAngOffset;
	CUtlString m_AttachmentName;
	CUtlString m_LocalAttachmentOffsetName;
	ModelConfigAttachmentType_t m_AttachmentType;
	bool m_bBoneMergeFlex;
	bool m_bUserSpecifiedColor;
	bool m_bUserSpecifiedMaterialGroup;
	CUtlString m_BodygroupOnOtherModels;
	CUtlString m_MaterialGroupOnOtherModels;
};
