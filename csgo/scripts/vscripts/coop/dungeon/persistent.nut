// persistent variables, checked and set from main script

FASTTRAVEL1 <- false;				// has player unlocked fast travel stage 1? 
FASTTRAVEL2 <- false;				// has player unlocked fast travel stage 2? 
FASTTRAVEL3 <- false;				// has player unlocked fast travel stage 3? 

function SetFastTravelVar( var )
{

	if (var == 1)
	{
		FASTTRAVEL1 = true;
	}
		if (var == 2)
		{
			FASTTRAVEL2 = true;
		}
			if (var == 3)
			{
				FASTTRAVEL3 = true;
			}

printl ("")
printl ("PERSISTENT VAR:")
printl ("FASTRAVEL1 = " + FASTTRAVEL1)
printl ("FASTRAVEL2 = " + FASTTRAVEL2)
printl ("FASTRAVEL3 = " + FASTTRAVEL3)
printl ("")
}

