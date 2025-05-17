enum PulseMethodCallMode_t : uint32_t
{
	// MPropertyFriendlyName = "Wait For Completion"
	// MPropertyDescription = "Synchronous - wait for the method to fully complete before returning"
	SYNC_WAIT_FOR_COMPLETION = 0,
	// MPropertyFriendlyName = "Fire And Forget"
	// MPropertyDescription = "Asynchronous - returns and continues despite the called method yielding"
	ASYNC_FIRE_AND_FORGET = 1,
};
