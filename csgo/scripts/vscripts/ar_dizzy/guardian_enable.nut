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
	  EntFire("brush.blocker", "Enable", 0, 0);
	  EntFire("brush.bombsite", "Enable", 0, 0);
	  EntFire("brush.nav", "BlockNav", 0, 0);
	}
	else
	{
	  EntFire("brush.bombsite", "Disable", 0, 0);				// disable bombsite
	  EntFire("brush.nav", "UnblockNav", 0, 0);
	}
  
 }

 
