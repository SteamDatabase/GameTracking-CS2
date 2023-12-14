--
-- This is the script to handle de_shortdust
--



--
-- This function is called from the map OnMapSpawn
--
function GameModeCheck()
       local nMode = ScriptGetGameMode()
       local nType = ScriptGetGameType()

	if nType == 1 and nMode == 2 then		-- If we're running Deathmatch, disable blockers.
		EntFire( "thisEntity", "@model.dm_path_blocker", "Disable", 0, 0 )	-- door mdl
		EntFire( "thisEntity", "@model.dm_path_blocker", "disablecollision", 0, 0 )	-- door mdl collision
		EntFire( "thisEntity", "@brush.dm_path_blocker", "Disable", 0, 0 )	-- func_brush clip
		Msg("Running DM..")
	end

end


