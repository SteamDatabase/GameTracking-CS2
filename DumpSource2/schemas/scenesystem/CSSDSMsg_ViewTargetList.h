// MGetKV3ClassDefaults = {
//	"m_viewId":
//	{
//		"m_nViewId": 0,
//		"m_nFrameCount": 0
//	},
//	"m_ViewName": "",
//	"m_Targets":
//	[
//	]
//}
class CSSDSMsg_ViewTargetList
{
	SceneViewId_t m_viewId;
	CUtlString m_ViewName;
	CUtlVector< CSSDSMsg_ViewTarget > m_Targets;
};
