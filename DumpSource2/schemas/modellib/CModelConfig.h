// MGetKV3ClassDefaults = {
//	"m_ConfigName": "",
//	"m_Elements":
//	[
//	],
//	"m_bTopLevel": false,
//	"m_bActiveInEditorByDefault": false
//}
class CModelConfig
{
	CUtlString m_ConfigName;
	CUtlVector< CModelConfigElement* > m_Elements;
	bool m_bTopLevel;
	bool m_bActiveInEditorByDefault;
};
