class CGameMoney : public CRulePointEntity
{
	CEntityIOOutput m_OnMoneySpent;
	CEntityIOOutput m_OnMoneySpentFail;
	int32 m_nMoney;
	CUtlString m_strAwardText;
};
