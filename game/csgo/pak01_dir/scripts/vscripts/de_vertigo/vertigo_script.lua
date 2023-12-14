--
-- This is the script to handle de_vertigo
--

--
-- Initialize the helicopter variable
--
vHelicopterShot = false

function HelicopterFiredAt() -- called when heli gets shot
	local bWarmupPeriod = ScriptIsWarmupPeriod()
	if bWarmupPeriod == false then
		vHelicopterShot = true
	end
end

--
-- This function is called from the map OnMapSpawn
--
function GameModeCheck()
       -- checks the game mode and type and the current match
       local nMode = ScriptGetGameMode()
       local nType = ScriptGetGameType()
	   -- local nRounds = ScriptGetRoundsPlayed()
       -- type 0, mode 0 = casual
       -- type 0, mode 1 = competitive
       -- type 1, mode 0 = arms race
       -- type 1, mode 1 = demolition
       -- type 1, mode 2 = deathmatch
       -- etc 

	   
	if nType == 0 and nMode == 2 then		-- If we're running Wingman, enable blockers. Note: Each bombsite has its own relay: "wingman.asite.relay" / "wingman.bsite.relay"
		EntFire( "thisEntity", "wingman.bsite.relay", "trigger", 0, 0 )
	  
		if vHelicopterShot == false then
			EntFire( "thisEntity", "helicopter.template", "ForceSpawn", 0, 0 )
		end
	end

end

--
-- This variable is increased every time someone has a workplace related injury (outside of warmup)
--
 
vInjury = 0

function WorkplaceInjury()
	local bWarmupPeriod = ScriptIsWarmupPeriod()
	if bWarmupPeriod == false then
--		vInjury += 1
		vInjury = vInjury + 1
--		Msg(tostring(vInjury))
	end
end

--
-- This function is run every map spawn (round restart etc.)
--

function WorkplaceInjuryDisplay()

	if  vInjury > 9 then
		--EntFire( "thisEntity", "texturetoggle.injury", "SetTextureIndex", 11, 0 )
		EntFire( "thisEntity", "safetysign.numbers", "Skin", 10, 0 )
	elseif vInjury > 0 then
		EntFire( "thisEntity", "safetysign.numbers", "Skin", vInjury, 0 )
	end

end


--
-- ragdoll detector
--
-- 
-- ent <- null;
-- vDone <- false;
-- 
-- function RagdollDetect()
-- {
-- 
-- 	local origin = self.GetCenter();
-- 
-- 	if ( (ent = Entities.FindByClassnameWithin (null, "cs_ragdoll", origin, 32.0)) != null && vDone == false)
-- 	{
-- 	
-- 		vDone = true;
-- 		EntFire ("!self", "FireUser1", 0, 0);
-- 		
-- 	}
-- 
-- }
-- 