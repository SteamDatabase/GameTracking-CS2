// simulate c4 beeping

BEEPFREQUENCY_MAX <- 1.0;
BEEPFREQUENCY <- BEEPFREQUENCY_MAX;
NEXTBEEP <- 0.0;
FASTERBEEP <- 0.0;
FASTERBEEP_FREQ <- 2;		// how often to speed things up
THATLL_DO_PIG <- 22;		// when to call it quits
ENDTIME <- 0;
ENABLED <- false;


SND_BEEP <- "C4.PlantSound";
SND_BEEP_NORMAL <- "coop.c4_beep_normal";
SND_BEEP_LOUD <- "coop.c4_beep_loud";


function Precache()
{
	self.PrecacheScriptSound( SND_BEEP );
}

function Think()
{

	if (ENABLED)
	{
	
		if ( Time() >= FASTERBEEP && BEEPFREQUENCY >= 0.1)
		{
		
		BEEPFREQUENCY = BEEPFREQUENCY - 0.1;
		FASTERBEEP = Time() + FASTERBEEP_FREQ;
		//printl ("Beep frequency is : " + BEEPFREQUENCY);
		//DoBeep();
		
		}
			
			
			if ( Time() >= NEXTBEEP )
			{
			DoBeep();
			}
			
			if (Time() >= ENDTIME)
			{
			Disable();
			}
		

	
	
	}

}

function DoBeep()
{
		//	self.EmitSound (SND_BEEP);
			
			if (BEEPFREQUENCY >= 0.5)
			{
			self.EmitSound (SND_BEEP_NORMAL);
			}
			else
				{
				self.EmitSound (SND_BEEP_LOUD);
				}
			
			NEXTBEEP = Time() + BEEPFREQUENCY;
			//printl ("Beeping at " + Time() + " next beep at : " + NEXTBEEP);
}

function Enable()
{
ENABLED = true;

NEXTBEEP = Time() + BEEPFREQUENCY;
FASTERBEEP = Time() + FASTERBEEP_FREQ;
ENDTIME = Time() + THATLL_DO_PIG;
}

function Disable()
{
ENABLED = false;
}

