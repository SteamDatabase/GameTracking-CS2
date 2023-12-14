--
-- This is the script to enable 2v2 entities when playing Wingman mode
--

function EnableWingman()
	-- check the game mode and type for the current match:
	nType = ScriptGetGameType()
	nMode = ScriptGetGameMode()

	--
	-- if it is "Wingman" then enable 2v2 map elements and disable standard
	--
	if nType == 0 and nMode == 2 then
		EntFire( "thisEntity", "spawnpoints.standard", "SetDisabled", 0, 0 );
		EntFire( "thisEntity", "spawnpoints.2v2", "SetEnabled", 0, 0 );
		EntFire( "thisEntity", "brush.blocker", "Enable", 0, 0 );
		EntFire( "thisEntity", "buyzone.2v2", "Enable", 0, 0 );
		EntFire( "thisEntity", "navblocker.2v2", "BlockNav", 0, 0 );
		EntFire( "thisEntity", "props.2v2", "Enable", 0, 0 );
		EntFire( "thisEntity", "props.2v2", "EnableCollision", 0, 0 );
	--
	-- for all other modes disable all 2v2 map elements
	--
	else
		EntFire( "thisEntity", "buyzone.2v2", "Disable", 0, 0 )
		EntFire( "thisEntity", "navblocker.2v2", "UnblockNav", 0, 0 )
		EntFire( "thisEntity", "brush.blocker", "Disable", 0, 0 )
	end
end
