// MGetKV3ClassDefaults = {
//	"m_srcStateIndex": 0,
//	"m_destStateIndex": 0,
//	"m_nHandshakeMaskToDisableFirst": 0,
//	"m_bDisabled": 0
//}
class CTransitionUpdateData
{
	uint8 m_srcStateIndex;
	uint8 m_destStateIndex;
	bitfield:7 m_nHandshakeMaskToDisableFirst;
	bitfield:1 m_bDisabled;
};
