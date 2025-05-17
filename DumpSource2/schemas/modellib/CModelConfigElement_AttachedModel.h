// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
	bool m_bAcceptParentMaterialDrivenDecals;
	CUtlString m_BodygroupOnOtherModels;
	CUtlString m_MaterialGroupOnOtherModels;
};
