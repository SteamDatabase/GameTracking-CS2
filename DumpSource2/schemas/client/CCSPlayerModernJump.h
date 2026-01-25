// MNetworkVarNames = "GameTick_t m_nLastActualJumpPressTick"
// MNetworkVarNames = "float m_flLastActualJumpPressFrac"
// MNetworkVarNames = "GameTick_t m_nLastUsableJumpPressTick"
// MNetworkVarNames = "float m_flLastUsableJumpPressFrac"
// MNetworkVarNames = "GameTick_t m_nLastLandedTick"
// MNetworkVarNames = "float m_flLastLandedFrac"
// MNetworkVarNames = "float m_flLastLandedVelocityX"
// MNetworkVarNames = "float m_flLastLandedVelocityY"
// MNetworkVarNames = "float m_flLastLandedVelocityZ"
class CCSPlayerModernJump
{
	// MNetworkEnable
	GameTick_t m_nLastActualJumpPressTick;
	// MNetworkEnable
	// MNetworkBitCount = 6
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 4
	float32 m_flLastActualJumpPressFrac;
	// MNetworkEnable
	GameTick_t m_nLastUsableJumpPressTick;
	// MNetworkEnable
	// MNetworkBitCount = 6
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 4
	float32 m_flLastUsableJumpPressFrac;
	// MNetworkEnable
	GameTick_t m_nLastLandedTick;
	// MNetworkEnable
	// MNetworkBitCount = 6
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 1.000000
	// MNetworkEncodeFlags = 4
	float32 m_flLastLandedFrac;
	// MNetworkEnable
	// MNetworkBitCount = 20
	// MNetworkMinValue = -16384.000000
	// MNetworkMaxValue = 16384.000000
	// MNetworkEncodeFlags = 4
	float32 m_flLastLandedVelocityX;
	// MNetworkEnable
	// MNetworkBitCount = 20
	// MNetworkMinValue = -16384.000000
	// MNetworkMaxValue = 16384.000000
	// MNetworkEncodeFlags = 4
	float32 m_flLastLandedVelocityY;
	// MNetworkEnable
	// MNetworkBitCount = 20
	// MNetworkMinValue = -16384.000000
	// MNetworkMaxValue = 16384.000000
	// MNetworkEncodeFlags = 4
	float32 m_flLastLandedVelocityZ;
};
