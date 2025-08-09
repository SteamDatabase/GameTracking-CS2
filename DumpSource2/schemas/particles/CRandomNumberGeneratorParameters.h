// MGetKV3ClassDefaults = {
//	"m_bDistributeEvenly": false,
//	"m_nSeed": -1
//}
class CRandomNumberGeneratorParameters
{
	// MPropertyFriendlyName = "Distribute evenly"
	bool m_bDistributeEvenly;
	// MPropertyFriendlyName = "Seed (negative values=randomize)"
	// MPropertySuppressExpr = "!m_bDistributeEvenly"
	int32 m_nSeed;
};
