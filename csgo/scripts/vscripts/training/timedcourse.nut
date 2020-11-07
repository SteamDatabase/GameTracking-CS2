///////
///////
///////

m_bRunningCourse <- false
m_bFirstRunthroughThisSession <- true
m_bHasHintedPistolSwitch <- false
m_bHasHintedReloading<- false

// track whether the grenade hint in the timed course has played or not
m_bGrenadeHintSucceeded <- false
m_bHasGrenade <- false

m_bIsInRoom_1 <- false
m_nHIT_TargetsInRoom_1 <- 0
m_nMAX_TargetsInRoom_1 <- 3

m_bIsInRoom_2 <- false
m_nHIT_TargetsInRoom_2 <- 0
m_nMAX_TargetsInRoom_2 <- 4

m_bIsInRoom_3 <- false
m_nHIT_TargetsInRoom_3 <- 0
m_nMAX_TargetsInRoom_3 <- 5

m_bIsInRoom_4 <- false
m_nHIT_TargetsInRoom_4 <- 0
m_nMAX_TargetsInRoom_4 <- 2

function PlayerEnterWeaponBox()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingIntro()", 0 )
	//  player enters the container that contains the weapons that can be picked up
	// dialogue suggests taking a primary weapon, frag grenade and you're required to have a sidearm and pistol at all times

	// yay, player has completed the weapons course!
	ScriptSetPlayerCompletedTraining( true )
}

function PlayerExitsWeaponBox()
{
	// player has their weapons, the box opens to the course lobby
	// player shoudl be instructed to enter the Live Fire obstacle course
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingStart()", 0 )
}

function PlayerEnterCourseLobby()
{
	// since we don't have an alt line for when you enter the course the first time on a return visit, 
	// just play the original line again and ignore whether it's the first time ever
	//local nTime = ScriptGetBestTrainingCourseTime()
	//if ( nTime > 0 )
	
	if ( !m_bFirstRunthroughThisSession )
	{
		// if they have a best time then they've done the test before, recognize that
		EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingTryAgain()", 0 )
	}
	else
	{
		// first time entering the course
		EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingStart()", 0 )
	}
}

function HitFriendly()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingFriendlyFire()", 0 )
	// when the player shoots a CT
}

function GiveCurrentAmmo()
{
	ScriptTrainingGivePlayerAmmo()
}

function OutOfAmmo()
{
	printl(" ** Out of ammo in timed training!")
	
	if( g_GetActiveWeapon() != "pistol" && m_bRunningCourse && !m_bHasHintedPistolSwitch )
	{
		EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingSwitchToPistol()", 0 )
		EntFire ( "@timed_course_hint_switch_weapons", "showhint", 0 )
	}
}

function StartCourse()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingFirstStart()", 0 )
	if ( m_bRunningCourse )
	{
		return
	}

	m_bRunningCourse = true

	m_nHIT_TargetsInRoom_1 <- 0
	m_nHIT_TargetsInRoom_2 <- 0
	m_nHIT_TargetsInRoom_3 <- 0
	m_nHIT_TargetsInRoom_4 <- 0

	StartRoom_1()
}

// ROOM 1
function StartRoom_1()
{
	if ( m_bIsInRoom_1 )
	{
		return
	}

	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom1Start()", 0 )

	m_bIsInRoom_1 = true
	EntFire ( "@rl_course_room_1","Trigger", "", 0 )
	GiveCurrentAmmo()
}

function HitTargetCourse_1()
{
	m_nHIT_TargetsInRoom_1++

	if ( m_nHIT_TargetsInRoom_1 >= m_nMAX_TargetsInRoom_1 )
	{
		CompleteRoom_1()
	}
}

function CompleteRoom_1()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom1End()", 0 )
	m_bIsInRoom_1 = false
	EntFire ( "@rl_course_complete_room_1","Trigger", "", 0 )

	EntFire ( "@hint_downtime_reload","ShowHint", "", 1 )
}

// ROOM 2
function StartRoom_2()
{
	if ( m_bIsInRoom_2 )
	{
		return
	}
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom2Start()", 0 )

	m_bIsInRoom_2 = true
	EntFire ( "@rl_course_room_2","Trigger", "", 0 )
}

function HitTargetCourse_2()
{
	m_nHIT_TargetsInRoom_2++

	if ( m_nHIT_TargetsInRoom_2 >= m_nMAX_TargetsInRoom_2 )
	{
		CompleteRoom_2()
	}
}

function CompleteRoom_2()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom2End()", 0 )
	m_bIsInRoom_2 = false
	EntFire ( "@rl_course_complete_room_2","Trigger", "", 0 )
}

// ROOM 3
function StartRoom_3()
{
	if ( m_bIsInRoom_3 )
	{
		return
	}

	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom3Start()", 0 )

	m_bIsInRoom_3 = true
	EntFire ( "@rl_course_room_3","Trigger", "", 0 )
}

function HitTargetCourse_3()
{
	m_nHIT_TargetsInRoom_3++

	if ( m_nHIT_TargetsInRoom_3 >= m_nMAX_TargetsInRoom_3 )
	{
		CompleteRoom_3()
	}
}

function CompleteRoom_3()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom3End()", 0 )
	m_bIsInRoom_3 = false
	EntFire ( "@rl_course_complete_room_3","Trigger", "", 0 )
}

// ROOM 4
function StartRoom_4()
{
	if ( m_bIsInRoom_4 )
	{
		return
	}

	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom4Start()", 0 )

	m_bIsInRoom_4 = true
	EntFire ( "@rl_course_room_4","Trigger", "", 0 )
}

function HitTargetCourse_4()
{
	m_nHIT_TargetsInRoom_4++

	if ( m_nHIT_TargetsInRoom_4 >= m_nMAX_TargetsInRoom_4 )
	{
		CompleteRoom_4()
	}
}

function CompleteRoom_4()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom4End()", 0 )
	m_bIsInRoom_4 = false
	EntFire ( "@rl_course_complete_room_4","Trigger", "", 0 )
}

function RunToFinishLine()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingRoom5Start()", 0 )
	// this is fired when the player enters the last hallway to run to the finish line
	// we also show the hint to select your knife to run faster here
}

function CompleteCourse()
{
	if ( !m_bRunningCourse )
	{
		return
	}

	m_bFirstRunthroughThisSession = false

	// call this to pop up the dialog box
	local nTime = ScriptGetBestTrainingCourseTime()
	if ( nTime == 0 )
	{
		EntFire ( "move_course_exit_gate","Open", "", 7.5 )	
		EntFire ( "@hint_restart_timed_course","ShowHint", "", 11.0 )	
		
		// this should happen the first time after the commander has finished his success line
		EntFire ( "@boox_exit","Unlock", "", 7.1 )	
		EntFire ( "@boox_exit","Open", "", 7.2 )	
	}
	else
	{
		EntFire ( "move_course_exit_gate","Open", "", 0 )	

		EntFire ( "@boox_exit","Unlock", "", 0 )	
		EntFire ( "@boox_exit","Open", "", 0.1 )	
	}

	m_bRunningCourse = false
	EntFire ( "@rl_course_complete","Trigger", "", 0 )	
}

// here's where you can tell the radio voice when the player has completed a course
// we can do some cool things like have him say different things based on your time
// great time, good time, horrible time, beat last best score, beat valve's score

// first time through, VERY slow
function Complete_FirstTime_VerySlow()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteFirstBad()", 0 )
}

// first time through, slow
function Complete_FirstTime_Slow()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteFirstBad()", 0 )
}

// first time through, not bad
function Complete_FirstTime_Medium()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteFirstGood()", 0 )
}

// first time through, very good!
function Complete_FirstTime_Fast()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteFirstGood()", 0 )
}

// players beats the company score on their very first run
function Complete_FirstTime_BeatCompanyScore()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteFirstBeatBest()", 0 )
}

// more than one time through, didn't beat best, VERY slow bracket
function Complete_VerySlow()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteVerySlow()", 0 )
}

// more than one time through, didn't beat best, slow bracket
function Complete_Slow()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteSlow()", 0 )
}

// more than one time through, didn't beat best, medium bracket
function Complete_Medium()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteMedium()", 0 )
}	

// more than one time through, didn't beat best, fast bracket
function Complete_Fast()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteFast()", 0 )
}

// player beat their best score, but new score is still SUPER SLOW
function Complete_NewBestTime_VerySlow()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteVerySlow()", 0 )
}

// player beat their best score, but new score is still in the slow bracket
function Complete_NewBestTime_Slow()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteSlowBetter()", 0 )
}

// player beat their best score, new score is in the "not bad" bracket
function Complete_NewBestTime_Medium()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteMediumBetter()", 0 )
}

// player beat their best score, new score is in the fast bracket
function Complete_NewBestTime_Fast()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteFastBetter()", 0 )
}

// player beat the company score (really fast)
function Complete_BeatCompanyScore()
{
	EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingCompleteBeatCompany()", 0 )
}

function ShowExitAskMsg()
{
	EntFire( "@radiovoice", "RunScriptCode", "ActiveTrainingAskLeave()", 0 )
	ScriptShowExitDoorMsg()	
}

function ShowExitHintMsg()
{
	EntFire( "@radiovoice", "RunScriptCode", "ActiveTrainingGoodbye()", 0 )
	ScriptShowFinishMsgBox()
}
//@tr_exit_hint

// Weapon table.  Only weapons in this list are considered valid weapons.  If the level tries to pass a weapon name string that is
// not in this list an error in the script will occur.
awp <- "awp"
ak <- "ak"
p90 <- "p90"
m4<- "m4"
bizon <- "bizon"
mp7 <- "mp7"

// Weapon category table
sniper	<- "sniper"
rifle	<- "rifle"		
smg		<- "smg"
pistol	<- "pistol"
knife	<- "knife"
grenade	<- "grenade"
c4		<- "c4"


function PickupWeapon( szWeapon )
{
	printl(" ** PickupWeapon() setting primary weapon to type: " + szWeapon )
	g_SetPrimaryWeapon( szWeapon )
	
	// check special rules for grenades
	WieldingGrenadeCheck( szWeapon )
}

function SwitchedToWeapon( szWeapon )
{
	printl(" ** SwitchedToWeapon() setting current weapon to category: " + szWeapon )
	g_SetActiveWeapon( szWeapon )
	
	// check special rules for grenades
	WieldingGrenadeCheck( szWeapon )
}

function WieldingGrenadeCheck( szWeapon )
{
	// bail if we're not running the course
	if ( !m_bRunningCourse )
		return
	
	// if we're wielding a grenade enable the listener, otherwise disable it
	if( szWeapon == "grenade" )
	{
		EntFire( "@eventlisten_timed_test_oogrenades", "enable", 0 )
	}
	else
	{
		EntFire( "@eventlisten_timed_test_oogrenades", "disable", 0 )
	}
}

// called by the map when player enters grenade hint room
function TryGrenadeHint()
{
	if( m_bGrenadeHintSucceeded || !m_bHasGrenade )
		return
	
	EntFire( "@hint_crs_grenade", "showhint", 0 )
	
	m_bGrenadeHintSucceeded = true
}

// called by timed course grenade listener on grenade throw
function TimedCourseGrenadeThrow()
{
	// grenade was thrown!  mark the time
	g_SetGrenadeLastThrowTime( Time() )
	
	m_bHasGrenade <- false
}

// called by time course grenade pickup button
function TimedCourseGrenadePickup() 
{	
	m_bHasGrenade <- true
}

// called by timed course reload listener
function TimedCourseWeaponReload()
{
	if( !m_bHasHintedReloading && m_bRunningCourse )
	{
		m_bHasHintedReloading = true
		// play the 'reloading is faster' hint
		EntFire ( "@radiovoice","RunScriptCode", "ActiveTrainingSuggestReloading()", 0 )
	}
}