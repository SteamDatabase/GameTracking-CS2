// This function is called from the map OnMapSpawn

function EnableGuardian()
{
       // checks the game mode and type and the current match
       local nMode = ScriptGetGameMode();
       local nType = ScriptGetGameType();

       // type 0, mode 0 = casual
       // type 0, mode 1 = competitive
       // type 1, mode 0 = arms race
       // type 1, mode 1 = demolition
       // type 1, mode 2 = deathmatch
       // etc 

	   
	if (nMode == 0 && nType == 4)								// if we are running guardian, do stuff
	{
	  EntFire("brush.blocker.guardian", "Enable", 0, 0);
	  EntFire("brush.bombsite.guardian", "Enable", 0, 0);	  
	  EntFire("nav.blocker.guardian", "BlockNav", 0, 0); 
	  EntFire("spawnpoints.ct.guardian", "SetEnabled", 0,  0);
	  EntFire("spawnpoints.guardian", "SetEnabled", 0,  0);
	  EntFire("buyzone.guardian", "SetEnabled", 0, 0); 
	  EntFire("spawnpoints.standard", "SetDisabled", 0, 0);
	}

	else                      //all other game modes
	{
	  EntFire("brush.bombsite.guardian", "Disable", 0, 0);				// disable bombsite
	  EntFire("buyzone.guardian", "Disable", 0, 0);
	  EntFire("buyzone.wingman", "Disable", 0, 0);
	  EntFire("nav.blocker.guardian", "UnblockNav", 0, 0);
	  EntFire("nav.blocker.wingman", "UnblockNav", 0, 0);	  
	}
  
 }

 
