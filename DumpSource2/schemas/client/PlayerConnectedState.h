enum PlayerConnectedState : uint32_t
{
	PlayerNeverConnected = -1,
	PlayerConnected = 0,
	PlayerConnecting = 1,
	PlayerReconnecting = 2,
	PlayerDisconnecting = 3,
	PlayerDisconnected = 4,
	PlayerReserved = 5,
};
