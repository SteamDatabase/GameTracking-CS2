// This function is called from the map OnMultiNewRound

function CheckRound()
{

    local nMode = ScriptGetGameMode();
    local nType = ScriptGetGameType();

	if (nMode == 0 && nType == 0)								// Are we running in Casual mode?
	{
		local nRounds = ScriptGetRoundsPlayed();

		if ( nRounds % 2 == 0)
		{
			
		}
		else
			{
				EntFire("teleport_triggers", "Enable", 0, 0);
				EntFire("skyboxswapper", "Trigger", 0, 0);
			}
	}
	
}