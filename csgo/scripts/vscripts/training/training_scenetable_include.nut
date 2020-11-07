includeTestString <- "!!!INCLUDE SUCCESS!!!"

SceneTable <- {}
	if (curMapName=="training1")
	{

		//1
		//We setup this field so you can play around with the high explosive grenades. Take your time, throw as many as you want.  But before you can leave, you have to take out the Mannequin in the cage. 
		SceneTable["grenadeteststart_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_grenadeteststart_01.vcd"),postdelay=0.00,next="grenadeteststart_02",char="radiovoice",fires=[{entity="@unlock_take_grenades",input="Trigger",parameter="",delay=0.00}]}
		//There are many different types of throwable weapons in the field.  For this test we have one.  It’s the kind that goes kaboom.  You like to make things go kaboom don’t you son? 
		SceneTable["grenadeteststart_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_grenadeteststart_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//2
		//Nice job.  Now let’s go test your reaction time at the pistol range. 
		SceneTable["grenadetestcompletegood_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_grenadetestcompletegood_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//3
		//This is about fast reaction times with the pistol. Pick it up and see if you can hit the two targets in under 5 seconds. 
		SceneTable["flashbangintro_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangintro_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//4
		//Nice. Now pick up the pistol again and do it one more time just for practice. 
		SceneTable["flashbang_noflash_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangstart_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//5
		//And that was a flash bang.  When you hear one coming, shield your eyes by looking away or blocking the line of site.  Let’s try that again. 
		SceneTable["flashbangflashed_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangflashed_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=1.00}

		//6
		//Nice job avoiding that flash bang. 
		SceneTable["flashbangcompleted_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangcompleted_01.vcd"),postdelay=0.00,next="train_flashbangcompleted_05",char="radiovoice",predelay=0.00}
		//For your reward - let’s go blow something up. 
		SceneTable["train_flashbangcompleted_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangcompleted_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//8
		//Listen up. Now, unless you are a traitor, you will not be planting bombs in the field but we want you to understand what you’re up against.  So pick up a bomb and head over to bomb site A. 
		SceneTable["bombplantintro_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantintro_01.vcd"),postdelay=0.00,next=null,char="radiovoice",fires=[{entity="@rl_hint_take_bomb",input="Trigger",parameter="",delay=0.00}],uninterruptible = true}

		//9
		//Good job on the bomb planting –traitor.  But you better hurry up, we just planted a bomb at bomb site B and you only have seconds to defuse it.  You can find the bombsite using your radar. 
		SceneTable["bombplanta_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplanta_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//10
		//Good job, do you know what would have made the defusing faster?  If I had remembered to give you the defusing kit.  A kit will cut in half the time it takes to defuse a bomb.  Sorry about that. We’re done here,  let’s move out to the active training course.
		SceneTable["bombplantbcomplete_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbcomplete_01.vcd"),postdelay=0.00,next="train_bombplantbcomplete_02b",char="radiovoice",predelay=0.00}
		//We're done here.  Let's move on to the active training course. 
		SceneTable["train_bombplantbcomplete_02b"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbcomplete_02b.vcd"),postdelay=0.00,next=null,char="radiovoice",fires=[{entity="@rl_enable_weapon_display_trigger",input="Trigger",parameter="",delay=0.00}],predelay=0.00}

		//11
		//Observe your bullet spread and weapon kick during firing. 
		SceneTable["GunTestStart"] <- {vcd=CreateSceneEntity("scenes/commander/train_gunteststart_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//14
		//Nice  work.  You can fire a gun. 
		SceneTable["train_guntestcomplete_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestcomplete_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//16
		//Now we need to do some target identification.  We have a good guys and we have a bad guys.  We need you to shoot the bad guys. 
		SceneTable["IdTestStart_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_idteststart_01.vcd"),postdelay=0.00,next="IdTestStart_02",char="radiovoice",predelay=0.00}
		//And just to prove you were paying attention pick up the weapon and shoot 5 bad guys for me. 
		SceneTable["IdTestStart_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_idteststart_02.vcd"),postdelay=0.00,next=null,char="radiovoice",fires=[{entity="@unlock_gunbutton_team",input="Trigger",parameter="",delay=0.00}],uninterruptible = true}

		//18
		//Let’s me get this straight.  You were just defeated by an unarmed wooden target.  Maybe we should move straight to bomb defusal and save us both some time. 
		SceneTable["idtestfailed_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_idtestfailed_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//19
		//Nice work with those wooden terrorists. For this next test we need you to hit that target.  Fire in short controlled bursts.  A great marksmen can do this in under 5 seconds a decent shot can do this in under 15, let’s see how you do. 
		SceneTable["idtestcompleted_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_idtestcompleted_01.vcd"),postdelay=0.00,next=null,char="radiovoice",fires=[{entity="@unlock_gunbutton_team",input="Trigger",parameter="",delay=0.00}],uninterruptible = true}

		//20
		//Running out of ammunition is always a failure. 
		SceneTable["bursttestfailed_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_failureammo_01.vcd"),postdelay=0.00,next="bursttestfailed_04",char="radiovoice",predelay=0.00}
		//Aim at the target and shoot in short controlled bursts.  This isn’t hard. 
		SceneTable["bursttestfailed_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_failuretime_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//22
		//That was not firing in short controlled bursts.  Tap your trigger to maintain accuracy. 
		SceneTable["bursttestfailed_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_bursttestfailed_01.vcd"),postdelay=0.00,next="bursttestfailed_02",char="radiovoice",predelay=0.00}
		//Let’s try that again. (disgusted exhale) 
		SceneTable["bursttestfailed_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_bursttestfailed_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//23
		//High caliber firearms can penetrate materials.  Hit the target through that piece of wood. 
		SceneTable["burstblockerteststart_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_burstblockerteststart_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//24
		//Does that piece of wood scare you? 
		SceneTable["burstblockertestfailed_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_burstblockertestfailed_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//25
		//Nicely done. You can experiment in the field to find out what weapon can penetrate what material at different distances.
		SceneTable["burstblockertestcompleted_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_burstblockertestcompleted_01.vcd"),postdelay=0.00,next=null,char="radiovoice", fires=[{entity="@radiovoice",input="runscriptcode",parameter="CrouchTestIntro()",delay=0.00}],uninterruptible = true}
		
		//60
		//Keep going...
		// old scene:
		//SceneTable["train_crouchtestintro_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_08.vcd"),postdelay=0.00,predelay=1.50,next=null,char="radiovoice",fires=[{entity="@unlock_gunbutton_team",input="Trigger",parameter="",delay=0.00}],uninterruptible = true}	
		
		// new scene:
		//700
		//And some materials you can't shoot through.
		
		SceneTable["New_Metal06"] <- {vcd=CreateSceneEntity("scenes/commander/New_Metal06.vcd"),postdelay=0.00,predelay=1,next="New_Metal07",char="radiovoice",uninterruptible = true}	
		SceneTable["New_Metal07"] <- {vcd=CreateSceneEntity("scenes/commander/New_Metal07.vcd"),postdelay=0.00,predelay=0.2,next=null,char="radiovoice",fires=[{entity="@unlock_gunbutton_team",input="Trigger",parameter="",delay=0.00}],uninterruptible = true}	
		
		//70
		//Very nice!
		SceneTable["train_crouchtestcomplete_01"] <- {vcd=CreateSceneEntity("scenes/commander/Commander_comment_03.vcd"),postdelay=0.00,next="burstblockertestcompleted_02",char="radiovoice",predelay=0.00}
		//Now let's get you out into the sunshine and shoot some wood in the head. 
		SceneTable["burstblockertestcompleted_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_burstblockertestcompleted_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//26
		//You haven’t forgotten about head shots have you?  We setup this test to demonstrate location damage. 
		SceneTable["bodydamagestart_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagestart_01.vcd"),postdelay=0.00,next="bodydamagestart_04",char="radiovoice",predelay=0.00}
		//Pick up both weapons and let’s get started. 
		SceneTable["bodydamagestart_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagestart_05a.vcd"),postdelay=0.00,next=null,char="radiovoice",fires=[{entity="@rl_start_BD_show_hint",input="Trigger",parameter="",delay=0.00}],uninterruptible = true}
		

		//27
		//Now we are going to see how fast you can do this.  A decent time is 30 seconds.  I’m bettin’ at least a minute for you. 
		SceneTable["bodydamagetimerstart_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagetimerstart_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//28
		//Nice work, that wood is going to terrified to pop back up.  Let’s head on over the grenade range and see how you do against some plastic mannequins. 
		SceneTable["bodydamagetimercomplete_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagetimercomplete_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//29
		//Nice head shot. 
		SceneTable["bodydamageheadshot_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageheadshot_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//30
		//Head shot! 
		SceneTable["bodydamageheadshot_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageheadshot_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//31
		//There you go. 
		SceneTable["train_bodydamageheadshot_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageheadshot_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//32
		//Keep aiming for the head. 
		SceneTable["bodydamagechestshot_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagechestshot_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//33
		//Come on, that’s not the head. 
		SceneTable["bodydamagechestshot_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagechestshot_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//34
		//Leg shot! 
		SceneTable["bodydamagelegshot_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagelegshot_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//35
		//Aim for the head! 
		SceneTable["bodydamagelegshot_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagelegshot_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//36
		//One way to conserve ammo is to make your shots count.  Like by shooting them in the head. 
		SceneTable["train_bodydamageoutofammo_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageoutofammo_01.vcd"),postdelay=0.00,next="train_bombplantbfail_05b",char="radiovoice",predelay=0.00}
		//Let’s try that again. 
		SceneTable["train_bombplantbfail_05b"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_05b.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//37
		//Listen up, thanks for coming out to the G-O test center today.  I am sure these tests will be beneath a man of your stature, but quick refresher is always good and HQ likes to see every new recruit one through these tests at least once. So now let’s get started.  Pick up that weapon and unload the clip into the target.
		SceneTable["MainIntro"] <- {vcd=CreateSceneEntity("scenes/commander/train_mainintro_01.vcd"),postdelay=0.00,next=null,char="radiovoice",fires=[{entity="@rl_start_show_hint",input="Trigger",parameter="",delay=0.00}],uninterruptible = true}

		//38
		//Don't forget, shoot in short bursts
		SceneTable["bodydamage_rangestart_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_burstblockerteststart_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//50
		//From your inability to find the one weapon in this room, I am going with the theory that you must have been your team’s translator.  We’ve got a lot of work ahead of us. 
		SceneTable["guntestwait_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestwait_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//51
		//Do you need a hint?  It’s the shiny thing on the counter.  Now pick it up and let’s get started. 
		SceneTable["guntestwait_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestwait_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//52
		//Aim for the head. 
		SceneTable["bodydamagechestshot_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagechestshot_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//53
		//You want to shoot ‘em in the head. 
		SceneTable["bodydamagechestshot_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagechestshot_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//54
		//That’s the toe, not the head. 
		SceneTable["bodydamagelegshot_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagelegshot_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//55
		//Check your weapon for a second. 
		SceneTable["bodydamagestart_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagestart_02.vcd"),postdelay=0.00,next="bodydamagestart_03",char="radiovoice",predelay=0.00, uninterruptible = true}
		//These targets will show you how much damage is done in each location.  Unsurprisingly shooting someone in the foot is NOT very effective.  The chest is better but the highest damage is done by a head shot. Take out these two targets and we will begin the 
		SceneTable["bodydamagestart_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagestart_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00, uninteruptible = true}
		
		//80
		//Switch weapons to continue.
		SceneTable["train_bodydamagestart_06"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagestart_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//101
		//That was a friendly. 
		SceneTable["activetestingchatter_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//102
		//That was a good guy. 
		SceneTable["activetestingchatter_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//103
		//The bad guys are wearing white. 
		SceneTable["activetestingchatter_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//104
		//The good guys are in black. 
		SceneTable["activetestingchatter_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//105
		//You remind me of my old squad mate pappy.  He was a hellevu cook. 
		SceneTable["train_activetestingchatter_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_05.vcd"),postdelay=0.00,next="train_activetestingcomplete_16",char="radiovoice",predelay=0.00}

		//106
		//There you go. 
		SceneTable["activetestingchatter_06"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//108
		//Keep going 
		SceneTable["activetestingchatter_08"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_08.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//110
		//Faster. 
		SceneTable["activetestingchatter_10"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_10.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//112
		//You cleared the first area. 
		SceneTable["activetestingchatter_12"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_12.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00, fires=[{entity="@radiovoice",input="runscriptcode",parameter="ActiveTrainingRoom1ReloadTip()",delay=0.50}],uninterruptible = true}

		//114
		//Cleared, go go go. 
		SceneTable["activetestingchatter_14"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_14.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//115
		//Cleared, on to the next. 
		SceneTable["activetestingchatter_15"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_15.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//116
		//This course is all about speed and accuracy. 
		SceneTable["activetestingchatter_16"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_16.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//117
		//You need to clear each area before you can continue 
		SceneTable["activetestingchatter_17"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_17.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00, uninterruptible = true}

		//118
		//Run with your knife out for added speed. 
		SceneTable["activetestingchatter_18"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_18.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//120
		//Nice job! Your time was fast enough to qualify you.  You can either try the course again to improve your time or we can say our goodbyes and you can report to active duty.
		SceneTable["activetestingcomplete_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//121
		//Good job moving through that course. 
		SceneTable["train_activetestingcomplete_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_02.vcd"),postdelay=0.00,next="train_activetestingcomplete_21",char="radiovoice",predelay=0.00}

		//122
		//That was a respectable time. You can try the course again to improve that time or you can join us in active duty because you made it.   Good job.  See you in the field. 
		SceneTable["train_activetestingcomplete_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//123
		//Now for a little fun where we put all the pieces together.  I’m going to need you to pick up the hand gun, a knife, a grenade and the primary weapon of your choosing. 
		SceneTable["activetestingintro_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingintro_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//124
		//When you’re ready enter the test area and let’s see how quickly you can move through course.  Remember your training, short controlled bursts. 
		SceneTable["activetestingintro_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingintro_02.vcd"),postdelay=0.00,next=null,char="radiovoice",fires=[{entity="@rl_room_0_audio_completed",input="trigger",parameter="",delay=0.00}],uninterruptible = true}

		//131
		//Well done. 
		SceneTable["train_bodydamageheadshot_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageheadshot_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//137
		//Nice work, you ran out of ammo.  In case you can’t tell, I am being ironic. 
		SceneTable["train_bodydamageoutofammo_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageoutofammo_02.vcd"),postdelay=0.00,next="train_bombplantbfail_05b",char="radiovoice",predelay=0.00}
		//Let’s try that again. 
		SceneTable["train_bombplantbfail_05b"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_05b.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//138
		//There’s a reason I keep telling you to shoot them in the head.  It helps you conserve ammunition . 
		SceneTable["train_bodydamageoutofammo_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageoutofammo_03.vcd"),postdelay=0.00,next="train_bombplantbfail_05b",char="radiovoice",predelay=0.00}
		//Let’s try that again. 
		SceneTable["train_bombplantbfail_05b"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_05b.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//147
		//Nice try but in the field you and your squad mates would be dead.  We would miss them. 
		SceneTable["bombplantbfail_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_01.vcd"),postdelay=0.00,next="train_bombplantbfail_06",char="radiovoice",predelay=0.00}
		//Get moving! The bomb is ticking! 
		SceneTable["train_bombplantbfail_06"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.50}

		//159
		//You have failed so many times, you may have damaged your retina.  At least I hope so. 
		SceneTable["train_flashbangmultifail_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangmultifail_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=1.00}

		//180
		//Any time you're ready pick up the weapon and we can start the course
		SceneTable["train_idtestwaiting_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestwait_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//232
		//Remember, look away from the flash.
		SceneTable["train_activetestingchatter_27"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangmultifail_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.75}

		//233
		//That was a flashbang. 
		SceneTable["train_activetestingchatter_28"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_28.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.75}

		//234
		//Remember, those are things you want to look away from. 
		SceneTable["train_activetestingchatter_29"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_29.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.75}

		//235
		//Nice! You just beat the course record. 
		SceneTable["train_activetestingcomplete_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_04.vcd"),postdelay=0.00,next="train_activetestingcomplete_28",char="radiovoice",predelay=0.00}

		//236
		//Well that’s something.  I didn’t know that clock went so high. 
		SceneTable["train_activetestingcomplete_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_05.vcd"),postdelay=0.00,next="train_activetestingcomplete_06",char="radiovoice",predelay=0.00}

		//237
		//You can run the test again to improve your time or can just give up and let the terrorists win. 
		SceneTable["train_activetestingcomplete_06"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//238
		//Good job you beat your best time. 
		SceneTable["train_activetestingcomplete_07"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_07.vcd"),postdelay=0.00,next="train_activetestingcomplete_06",char="radiovoice",predelay=0.00}

		//239
		//You just ran your best time. 
		SceneTable["train_activetestingcomplete_08"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_08.vcd"),postdelay=0.00,next="train_activetestingcomplete_20",char="radiovoice",predelay=0.00}

		//240
		//That’s a new course record! 
		SceneTable["train_activetestingcomplete_09"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_09.vcd"),postdelay=0.00,next="train_activetestingcomplete_28",char="radiovoice",predelay=0.00}

		//241
		//That was an improvement but why don’t you give it one more try. 
		SceneTable["train_activetestingcomplete_10"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_10.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//242
		//All right, all right, you are getting this down! 
		SceneTable["train_activetestingcomplete_11"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_11.vcd"),postdelay=0.00,next="train_activetestingcomplete_28",char="radiovoice",predelay=0.00}

		//243
		//Look, you are making this course harder than it needs to be. 
		SceneTable["train_activetestingcomplete_12"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_12.vcd"),postdelay=0.00,next="train_activetestingcomplete_18",char="radiovoice",predelay=0.00}

		//244
		//Son, you are making this course harder than it needs to be. 
		SceneTable["train_activetestingcomplete_12b"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_12b.vcd"),postdelay=0.00,next="train_activetestingcomplete_16",char="radiovoice",predelay=0.00}

		//246
		//My seven year old can do this in under 40 seconds  blindfolded.  (pause) To be fair, the blindfold does help with the flashbang. 
		SceneTable["train_activetestingcomplete_14"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_14.vcd"),postdelay=0.00,next="train_activetestingcomplete_21",char="radiovoice",predelay=0.00}

		//247
		//You’re getting worse, are you getting tired?  Is it nappy time? 
		SceneTable["train_activetestingcomplete_15"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_15.vcd"),postdelay=0.00,next="train_activetestingcomplete_22",char="radiovoice",predelay=0.00}

		//248
		//If at first you don’t succeed, try try again and keep trying until you master it. 
		SceneTable["train_activetestingcomplete_16"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_16.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//249
		//They always say, if at first you don’t succeed try try again but in your case I don’t think that’s going to help. 
		SceneTable["train_activetestingcomplete_17"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_17.vcd"),postdelay=0.00,next="train_activetestingcomplete_21",char="radiovoice",predelay=0.00}

		//250
		//Maybe you’re peaked and you’re not going to improve.  Ahhh… who knows, give it another shot. 
		SceneTable["train_activetestingcomplete_18"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_18.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//251
		//In case you were pacing yourself, there’s nothing after this course. 
		SceneTable["train_activetestingcomplete_19"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_19.vcd"),postdelay=0.00,next="train_activetestingcomplete_20",char="radiovoice",predelay=0.00}
		
		//252
		//Go ahead try it again. 
		SceneTable["train_activetestingcomplete_20"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_20.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//253
		//Give it one more shot. 
		SceneTable["train_activetestingcomplete_21"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_21.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//254
		//You can give up or try again. 
		SceneTable["train_activetestingcomplete_22"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_22.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//255
		//You can give up or you can try it again. 
		SceneTable["train_activetestingcomplete_22b"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_22b.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//256
		//You can return to the G-O test center at anytime and repeat just this part of the training. 
		SceneTable["train_activetestingcomplete_23"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_23.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//258
		//Well that’s something.  I didn’t know that clock went so high. 
		SceneTable["train_activetestingcomplete_25"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_25.vcd"),postdelay=0.00,next="train_activetestingcomplete_22b",char="radiovoice",predelay=0.00}

		//259
		//You can run the test again to improve your time or can just give up and let the terrorists win. 
		SceneTable["train_activetestingcomplete_26"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_26.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//260
		//Good job you beat your best time. 
		SceneTable["train_activetestingcomplete_27"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_27.vcd"),postdelay=0.00,next="train_activetestingcomplete_28",char="radiovoice",predelay=0.00}

		//261
		//You can try it again or leave at any time.  Don’t worry, my heart won’t be broken. 
		SceneTable["train_activetestingcomplete_28"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_28.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//263
		//Good to have you back at the active training course.  Let’s see if you learned anything since your last run. 
		SceneTable["train_activetestingintro_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingintro_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//264
		//A little higher. 
		SceneTable["train_bodydamagechestshot_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagechestshot_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//266
		//Keep at it. 
		SceneTable["train_bodydamageheadshot_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageheadshot_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//267
		//You got it. 
		SceneTable["train_bodydamageheadshot_06"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamageheadshot_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//268
		//Too low. 
		SceneTable["train_bodydamagelegshot_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagelegshot_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//269
		//You’re gonna run out of bullets shooting them in the toe! 
		SceneTable["train_bodydamagelegshot_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagelegshot_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//271
		//Try kneeling for additional accuracy 
		SceneTable["train_bodydamagestart_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_bodydamagestart_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//272 - first time active course, new course record
		// points to train_activetestingcomplete_03, but we could use a custom end to tell people to keep playing
		//Nice! You just beat the course record. 
		SceneTable["train_activetestingcomplete_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingcomplete_04.vcd"),postdelay=0.00,next="train_activetestingcomplete_03",char="radiovoice",predelay=0.00}

		//280
		//Huuuurrrry  hurrrry that’s a live bomb. 
		SceneTable["train_bombplantbdefusing_01b"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbdefusing_01b.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//289
		//Get moving! The bomb is ticking! 
		SceneTable["train_bombplantbfail_06"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.50}

		//290
		//Get moving! The bomb is ticking! 
		SceneTable["train_bombplantbfail_06b"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_06b.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.50}

		//291
		//Terrorists like to mark their intended bomb sites with letters, we can use that against them, so you can look for that or check your radar. 
		SceneTable["bombplantintro_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantintro_02.vcd"),postdelay=0.00,next="bombplantintro_03",char="radiovoice",predelay=0.00}

		//292
		//Plant the bomb by equipping it and then using it.  Now plant it inside the blast shield. 
		SceneTable["bombplantintro_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantintro_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//294
		//Hey I'm with you, but we can both get out of here quicker if  you just hit the target.
		SceneTable["burstblockertestfailed_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestcomplete_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//295
		//Remember your training, aim at the target and shoot in short controlled bursts.
		SceneTable["burstblockertestfailed_03"] <- {vcd=CreateSceneEntity("scenes/commander/TRAIN_FAILURETIME_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//303
		//You can stop looking away, we’re done here. 
		SceneTable["train_flashbangcompleted_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangcompleted_03.vcd"),postdelay=0.00,next="train_flashbangcompleted_05",char="radiovoice",predelay=0.00}
		//For your reward - let’s go blow something up. 
		SceneTable["train_flashbangcompleted_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangcompleted_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//304
		//Good job! You cowered from that flashbang like a pro. 
		SceneTable["train_flashbangcompleted_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangcompleted_04.vcd"),postdelay=0.00,next="train_flashbangcompleted_05",char="radiovoice",predelay=0.00}
		//For your reward - let’s go blow something up. 
		SceneTable["train_flashbangcompleted_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangcompleted_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//305
		//For your reward - let’s go blow something up. 
		SceneTable["train_flashbangcompleted_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangcompleted_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//309
		//All right, let’s try that again. 
		SceneTable["train_flashbangfail_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangfail_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=1.00}

		//310
		//One more time. 
		SceneTable["train_flashbangfail_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangfail_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=1.00}

		//313
		//And one more time. 
		SceneTable["train_flashbangflashed_04"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangflashed_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=1.00}

		//314
		//And again. 
		SceneTable["train_flashbangflashed_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_flashbangflashed_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=1.00}

		//318
		//Kaboom 
		SceneTable["train_grenadetestactive_01b"] <- {vcd=CreateSceneEntity("scenes/commander/train_grenadetestactive_01b.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//322
		//We have seen in testing, the lower the IQ the more enjoyment the test subject derives from this test. 
		SceneTable["train_grenadetestactive_05"] <- {vcd=CreateSceneEntity("scenes/commander/train_grenadetestactive_05.vcd"),postdelay=0.00,next="grenadetestcompletegood_01",char="radiovoice",predelay=0.00}
		//Nice job.  Now let’s go test your reaction time at the pistol range. 
		SceneTable["grenadetestcompletegood_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_grenadetestcompletegood_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//327
		//I will take your not hitting the target with a single bullet as a sign you thought that part was optional.  It was. Good job. 
		SceneTable["train_guntestcompletefail_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestcomplete_03.vcd"),postdelay=0.00,next="Train_misc_01b",char="radiovoice",predelay=0.00}

		//328
		//Way to hit the giant wood target. 
		SceneTable["train_guntestcomplete_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestcomplete_04.vcd"),postdelay=0.00,next="train_guntestcomplete_03",char="radiovoice",predelay=0.00}
		//Nice work, I believe you just saved Democracy. 
		SceneTable["train_guntestcomplete_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestcomplete_02.vcd"),postdelay=0.00,next="Train_misc_01b",char="radiovoice",predelay=0.00}
		
		//512
		//Put your weapon back on the table when your done
		SceneTable["Train_misc_01b"] <- {vcd=CreateSceneEntity("scenes/commander/Train_misc_01b.vcd"),postdelay=0.00,next=null,char="radiovoice",fires=[{entity="@radiovoice",input="runscriptcode",parameter="GunTestPlaceWeaponOnTable()",delay=0.00}],uninterruptible = true}
		
		

		//329
		//Normally at this point I make a joke about how hitting that giant target really isn’t a test.  (SIGH)  This is going to be a long afternoon. 
		SceneTable["train_guntestcompletefail_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_guntestcomplete_05.vcd"),postdelay=0.00,next="Train_misc_01b",char="radiovoice",predelay=0.00}

		//333
		//Come on, lets try that again!
		SceneTable["bursttestfailed_01"] <- {vcd=CreateSceneEntity("scenes/commander/train_bursttestfailed_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//334
		//Well, crack shot you’re out of bullets.  Maybe you can sweet talk them into surrendering. 
		SceneTable["idtestfailed_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_idtestfailed_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//337
		//Can we start already?  You are about to be defeated by a cardboard enemy. 
		SceneTable["train_idtestwaiting_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_idtestwaiting_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//338
		//Hello again, good to have you back at the G-O test center.  We have some options for you.  If you would like to repeat your complete training just pick up the weapon and we can begin.  Hopefully this time you won’t embarrass yourself.  Otherwise, head ou 
		SceneTable["train_mainintro_01a"] <- {vcd=CreateSceneEntity("scenes/commander/train_mainintro_01a.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//500
		//Do you know who wins when you don’t defuse the bomb? 
		SceneTable["train_bombplantbfail_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_02.vcd"),postdelay=0.00,next="train_bombplantbfail_03",char="radiovoice",predelay=0.00}
		//That’s right, the terrorists win. 
		SceneTable["train_bombplantbfail_03"] <- {vcd=CreateSceneEntity("scenes/commander/train_bombplantbfail_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//510
		//switch to your pistol now
		SceneTable["train_activetestingchatter_19"] <- {vcd=CreateSceneEntity("scenes/commander/train_activetestingchatter_19.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//511
		//you can switch to your pistol at any time
		SceneTable["train_gunteststart_02"] <- {vcd=CreateSceneEntity("scenes/commander/train_gunteststart_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//513
		//move quicker by reloading during downtime
		SceneTable["Train_activetestingchatter_22"] <- {vcd=CreateSceneEntity("scenes/commander/Train_activetestingchatter_22.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00,uninterruptible = true}

		//514
		//switching to secondary is always faster than reloading
		SceneTable["Train_activetestingchatter_23"] <- {vcd=CreateSceneEntity("scenes/commander/Train_activetestingchatter_23.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00,uninterruptible = true}

		//515
		//Reload during the transitions
		SceneTable["Train_activetestingchatter_25"] <- {vcd=CreateSceneEntity("scenes/commander/Train_activetestingchatter_25.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00,uninterruptible = true}
		
		//516
		//Nows a good time to reload
		SceneTable["Train_activetestingchatter_26"] <- {vcd=CreateSceneEntity("scenes/commander/Train_activetestingchatter_26.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00,uninterruptible = true}
	
		//701
		//Go ahead and kneel, that will also improve your accuracy.
		SceneTable["New_Metal02"] <- {vcd=CreateSceneEntity("scenes/commander/New_Metal02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//702
		//You're not going to be able to shoot through the metal so go ahead and kneel.
		SceneTable["New_Metal03"] <- {vcd=CreateSceneEntity("scenes/commander/New_Metal03.vcd"),postdelay=0.00,next="New_Metal05",char="radiovoice",predelay=0.00}
		
		//703
		//Kneeling also improves your accuracy.
		SceneTable["New_Metal04"] <- {vcd=CreateSceneEntity("scenes/commander/New_Metal04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00,uninterruptible = true}
		
		//704
		//As an added bonus, kneeling will also improve your accuracy.
		SceneTable["New_Metal05"] <- {vcd=CreateSceneEntity("scenes/commander/New_Metal05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//705
		// But lets still hit that target
		//SceneTable["New_Metal07"] <- {vcd=CreateSceneEntity("scenes/commander/new_metal07.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//706
		// Here are all the guns available to you in the field.  Sorry, but the suits will only allow us to use a few in training.
		SceneTable["New_GunRoom03"] <- {vcd=CreateSceneEntity("scenes/commander/New_GunRoom03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//707
		// Don't forget to grab some ammo
		SceneTable["New_Course08"] <- {vcd=CreateSceneEntity("scenes/commander/New_Course08.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//708
		// Goodbye!
		SceneTable["New_GoodBye01"] <- {vcd=CreateSceneEntity("scenes/commander/New_GoodBye01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
	}


SceneTableLookup <- {}
SceneTableLookup[1] <- "grenadeteststart_01"
SceneTableLookup[2] <- "grenadetestcompletegood_01"
SceneTableLookup[3] <- "flashbangintro_01"
SceneTableLookup[4] <- "flashbang_noflash_01"
SceneTableLookup[5] <- "flashbangflashed_01"
SceneTableLookup[6] <- "flashbangcompleted_01"
SceneTableLookup[8] <- "bombplantintro_01"
SceneTableLookup[9] <- "bombplanta_01"
SceneTableLookup[10] <- "bombplantbcomplete_01"
SceneTableLookup[11] <- "GunTestStart"
SceneTableLookup[14] <- "train_guntestcomplete_01"
SceneTableLookup[16] <- "IdTestStart_01"
SceneTableLookup[18] <- "idtestfailed_01"
SceneTableLookup[19] <- "idtestcompleted_01"
SceneTableLookup[20] <- "bursttestfailed_03"
SceneTableLookup[22] <- "bursttestfailed_05"
SceneTableLookup[23] <- "burstblockerteststart_01"
SceneTableLookup[24] <- "burstblockertestfailed_01"
SceneTableLookup[25] <- "burstblockertestcompleted_01"
SceneTableLookup[26] <- "bodydamagestart_01"
SceneTableLookup[27] <- "bodydamagetimerstart_01"
SceneTableLookup[28] <- "bodydamagetimercomplete_01"
SceneTableLookup[29] <- "bodydamageheadshot_01"
SceneTableLookup[30] <- "bodydamageheadshot_02"
SceneTableLookup[31] <- "train_bodydamageheadshot_03"
SceneTableLookup[32] <- "bodydamagechestshot_01"
SceneTableLookup[33] <- "bodydamagechestshot_02"
SceneTableLookup[34] <- "bodydamagelegshot_01"
SceneTableLookup[35] <- "bodydamagelegshot_02"
SceneTableLookup[36] <- "train_bodydamageoutofammo_01"
SceneTableLookup[37] <- "MainIntro"
SceneTableLookup[38] <- "bodydamage_rangestart_01"
SceneTableLookup[50] <- "guntestwait_01"
SceneTableLookup[51] <- "guntestwait_02"
SceneTableLookup[52] <- "bodydamagechestshot_03"
SceneTableLookup[53] <- "bodydamagechestshot_04"
SceneTableLookup[54] <- "bodydamagelegshot_03"
SceneTableLookup[55] <- "bodydamagestart_02"
SceneTableLookup[60] <- "train_crouchtestintro_01"
SceneTableLookup[61] <- "train_crouchteststart_02"
SceneTableLookup[70] <- "train_crouchtestcomplete_01"
SceneTableLookup[71] <- "burstblockertestcompleted_02"
SceneTableLookup[80] <- "train_bodydamagestart_06"
SceneTableLookup[101] <- "activetestingchatter_01"
SceneTableLookup[102] <- "activetestingchatter_02"
SceneTableLookup[103] <- "activetestingchatter_03"
SceneTableLookup[104] <- "activetestingchatter_04"
SceneTableLookup[105] <- "train_activetestingchatter_05"
SceneTableLookup[106] <- "activetestingchatter_06"
SceneTableLookup[108] <- "activetestingchatter_08"
SceneTableLookup[110] <- "activetestingchatter_10"
SceneTableLookup[112] <- "activetestingchatter_12"
SceneTableLookup[114] <- "activetestingchatter_14"
SceneTableLookup[115] <- "activetestingchatter_15"
SceneTableLookup[116] <- "activetestingchatter_16"
SceneTableLookup[117] <- "activetestingchatter_17"
SceneTableLookup[118] <- "activetestingchatter_18"
SceneTableLookup[120] <- "activetestingcomplete_01"
SceneTableLookup[121] <- "train_activetestingcomplete_02"
SceneTableLookup[122] <- "train_activetestingcomplete_03"
SceneTableLookup[123] <- "activetestingintro_01"
SceneTableLookup[124] <- "activetestingintro_02"
SceneTableLookup[131] <- "train_bodydamageheadshot_04"
SceneTableLookup[137] <- "train_bodydamageoutofammo_02"
SceneTableLookup[138] <- "train_bodydamageoutofammo_03"
SceneTableLookup[147] <- "bombplantbfail_01"
SceneTableLookup[159] <- "train_flashbangmultifail_01"
SceneTableLookup[180] <- "train_idtestwaiting_01"
SceneTableLookup[232] <- "train_activetestingchatter_27"
SceneTableLookup[233] <- "train_activetestingchatter_28"
SceneTableLookup[234] <- "train_activetestingchatter_29"
SceneTableLookup[235] <- "train_activetestingcomplete_04"
SceneTableLookup[236] <- "train_activetestingcomplete_05"
SceneTableLookup[237] <- "train_activetestingcomplete_06"
SceneTableLookup[238] <- "train_activetestingcomplete_07"
SceneTableLookup[239] <- "train_activetestingcomplete_08"
SceneTableLookup[240] <- "train_activetestingcomplete_09"
SceneTableLookup[241] <- "train_activetestingcomplete_10"
SceneTableLookup[242] <- "train_activetestingcomplete_11"
SceneTableLookup[243] <- "train_activetestingcomplete_12"
SceneTableLookup[244] <- "train_activetestingcomplete_12b"
SceneTableLookup[246] <- "train_activetestingcomplete_14"
SceneTableLookup[247] <- "train_activetestingcomplete_15"
SceneTableLookup[248] <- "train_activetestingcomplete_16"
SceneTableLookup[249] <- "train_activetestingcomplete_17"
SceneTableLookup[250] <- "train_activetestingcomplete_18"
SceneTableLookup[251] <- "train_activetestingcomplete_19"
SceneTableLookup[252] <- "train_activetestingcomplete_20"
SceneTableLookup[253] <- "train_activetestingcomplete_21"
SceneTableLookup[254] <- "train_activetestingcomplete_22"
SceneTableLookup[255] <- "train_activetestingcomplete_22b"
SceneTableLookup[256] <- "train_activetestingcomplete_23"
SceneTableLookup[258] <- "train_activetestingcomplete_25"
SceneTableLookup[259] <- "train_activetestingcomplete_26"
SceneTableLookup[260] <- "train_activetestingcomplete_27"
SceneTableLookup[261] <- "train_activetestingcomplete_28"
SceneTableLookup[263] <- "train_activetestingintro_03"
SceneTableLookup[264] <- "train_bodydamagechestshot_05"
SceneTableLookup[266] <- "train_bodydamageheadshot_05"
SceneTableLookup[267] <- "train_bodydamageheadshot_06"
SceneTableLookup[268] <- "train_bodydamagelegshot_04"
SceneTableLookup[269] <- "train_bodydamagelegshot_05"
SceneTableLookup[271] <- "train_bodydamagestart_04"
SceneTableLookup[272] <- "train_activetestingcomplete_04"
SceneTableLookup[279] <- "train_bombplantbcomplete_02b"
SceneTableLookup[280] <- "train_bombplantbdefusing_01b"
SceneTableLookup[289] <- "train_bombplantbfail_06"
SceneTableLookup[290] <- "train_bombplantbfail_06b"
SceneTableLookup[291] <- "bombplantintro_02"
SceneTableLookup[292] <- "bombplantintro_03"
SceneTableLookup[294] <- "burstblockertestfailed_02"
SceneTableLookup[295] <- "burstblockertestfailed_03"
SceneTableLookup[303] <- "train_flashbangcompleted_03"
SceneTableLookup[304] <- "train_flashbangcompleted_04"
SceneTableLookup[305] <- "train_flashbangcompleted_05"
SceneTableLookup[309] <- "train_flashbangfail_03"
SceneTableLookup[310] <- "train_flashbangfail_04"
SceneTableLookup[313] <- "train_flashbangflashed_04"
SceneTableLookup[314] <- "train_flashbangflashed_05"
SceneTableLookup[318] <- "train_grenadetestactive_01b"
SceneTableLookup[322] <- "train_grenadetestactive_05"
SceneTableLookup[327] <- "train_guntestcompletefail_01"
SceneTableLookup[328] <- "train_guntestcomplete_02"
SceneTableLookup[329] <- "train_guntestcompletefail_02"
SceneTableLookup[333] <- "bursttestfailed_01"
SceneTableLookup[334] <- "idtestfailed_02"
SceneTableLookup[337] <- "train_idtestwaiting_02"
SceneTableLookup[338] <- "train_mainintro_01a"
SceneTableLookup[500] <- "train_bombplantbfail_02"
SceneTableLookup[510] <- "train_activetestingchatter_19"
SceneTableLookup[511] <- "train_gunteststart_02"
SceneTableLookup[512] <- "Train_misc_01b"
SceneTableLookup[513] <- "Train_activetestingchatter_22"
SceneTableLookup[514] <- "Train_activetestingchatter_23"
SceneTableLookup[515] <- "Train_activetestingchatter_25"
SceneTableLookup[516] <- "Train_activetestingchatter_26"
SceneTableLookup[700] <- "New_Metal06"
SceneTableLookup[701] <- "New_Metal02"
SceneTableLookup[702] <- "New_Metal03"
SceneTableLookup[703] <- "New_Metal04"
SceneTableLookup[704] <- "New_Metal05"
SceneTableLookup[705] <- "New_Metal07"
SceneTableLookup[706] <- "New_GunRoom03"
SceneTableLookup[707] <- "New_Course08"
SceneTableLookup[708] <- "New_GoodBye01"

