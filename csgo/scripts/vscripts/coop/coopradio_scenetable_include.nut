includeTestString <- "!!!INCLUDE SUCCESS!!!"

SceneTable <- {}
//if (curMapName=="coop_cementplant")
	{
		printl( "INCLUDING COOPRADIO SCENE TABLE!!!!" );

		//1
		//Felix - Go to the wall and pick out your weapons of choice.  When you're ready, step into the taped off square to be deployed.  One more thing:  we're providing you with heavy armor and medical stims so you'll be able to take more abuse than normal.
		SceneTable["m1_prep_room"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_prep_room.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//2
		//Felix - Alright operators, Kincaide is counting on you.  Move swiftly and decisively... clearing each area of Phoenix before moving forward.  Good luck.
		SceneTable["m1_first_land"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_first_land.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//3
		//Felix - Good work: The peremiter is secure.  Time to take that compound.
		SceneTable["m1_wave1_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_wave1_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//4
		//Felix - They have to know you're coming for Kincaide - be careful,  they're going to shore up their defenses.
		SceneTable["m1_wave2_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_wave2_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//5
		//Felix - Kincaide has to be close.  They wouldn't have a merc like that protect some random door.
		SceneTable["m1_wave3_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_wave3_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//6
		//Felix - Great job, now get the hell outta there!
		SceneTable["m1_hostage"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_hostage.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//7
		//Felix - Evac is on it's way, get to the extraction point!
		SceneTable["m1_wave4_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_wave4_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//8
		//Felix - You're on the home stretch, your bird's almost there.
		SceneTable["m1_wave5_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_wave5_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9
		//Felix - First we killed Turner, now we've extracted Kincaide... I could get used to things going our way.
		SceneTable["m1_wave6_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_wave6_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//10
		//Felix - We're not leaving without Kincaide!
		SceneTable["m1_no_kincaide"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_no_kincaide.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		

		//11
		//Felix - Looks like I spoke too soon - The Phoenix are coming in force, hold out until evac arrives.
		SceneTable["m1_survial_wave"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_survial_wave.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
				
		//12
		//Felix - There's the chopper!There's the chopper!
		SceneTable["m1_helicopter"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_helicopter.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//13
		//Felix - Let's get you home. 
		SceneTable["m1_finish"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_finish.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//14
		//Kincaide - I thought I was gonna die here...
		SceneTable["m1_kincaide_rescue"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_rescue.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//15
		//Kincaide - Don't leave me!
		SceneTable["m1_kincaide_dropped"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_dropped.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//16
		//Kincaide - The Phoenix... they made me interview Valeria... document their cause... I know what they're planning.
		SceneTable["m1_kincaide_extaract"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_extaract.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//17
		//Kincaide - screams
		SceneTable["m1_kincaide_panic_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_panic_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//18
		//Kincaide - Jesus!
		SceneTable["m1_kincaide_panic_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_panic_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//19
		//Kincaide - I'm not gonna die...I'm not gonna die...
		SceneTable["m1_kincaide_panic_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_panic_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//20
		//Kincaide - Couldn't they have sent more than 2 of you?
		SceneTable["m1_kincaide_panic_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_panic_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//21
		//Felix - If your ammo runs low, you can always take a weapon from enemy combatants
		SceneTable["m1_gun_check"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_wave5_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//23
		//Felix - This isn't just a base, it's a staging area...what are the Phoenix planning?
		SceneTable["m1_tents"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_tents.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//24
		//Felix - These are blueprints for one of Kriegelds rail yards...why would he target one of his own trains... what is he moving?
		SceneTable["m1_train"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_train.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//25
		//Kincaide - Hello?  Who's there?  
		SceneTable["m1_forklift_room_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_forklift_room_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//26
		//Felix - That's kincaide!  There has to be a way to unlock this door from the other side.
		SceneTable["m1_forklift_room_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_forklift_room_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//27
		//Kincaide - I heard gunfire, what's happening?
		SceneTable["m1_forklift_idle_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_forklift_idle_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//28
		//Kincaide - You're not with them, are you?
		SceneTable["m1_forklift_idle_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_forklift_idle_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//29
		//Kincaide - Come on, man say something!
		SceneTable["m1_forklift_idle_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_forklift_idle_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//31
		//Felix - Evac will be there in 60 seconds
		SceneTable["m1_60_seconds"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_60_seconds.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//32
		//Felix - 30 more seconds and we're home free.
		SceneTable["m1_30_seconds"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_30_seconds.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//33
		//Felix - 15 more seconds.
		SceneTable["m1_15_seconds"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_15_seconds.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//34
		//Felix - 5 more seconds.
		SceneTable["m1_5_seconds"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_5_seconds.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//35
		//Kincaide - Valeria is targeting a nuclear facility, you have to stop her!
		SceneTable["m1_kincaide_extaract_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_extaract_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//36
		//Kincaide - I've spent the past year profiling Valeria for her propaganda pieces. I know her better than anyone...I can help you stop her.
		SceneTable["m1_kincaide_extaract_alt_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_extaract_alt_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//37
		//Kincaide - It's been a year... I had almost given up...
		SceneTable["m1_kincaide_extaract_alt_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_kincaide_extaract_alt_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//38
		//Felix - What are you doing?  We're not leaving without Kincaide!
		SceneTable["m1_forget_kincaide"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_forget_kincaide.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//39
		//Felix - There has to be another way out of that room - look for vent or a switch or something...
		SceneTable["m1_vent"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_vent.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//41
		//Felix - The Tactical Awareness Grenade is a great tool to identify the location of near by enemies
		SceneTable["m1_tag_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_tag_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//42
		//Felix - If Phoenix keep getting the drop on you, use a TAG grenade before entering an area.
		SceneTable["m1_tag_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_tag_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//43
		//Felix - Don't forget to use your medical stims if you're low on health... you have 3 of them so don’t befraid to use them.
		SceneTable["m1_heal"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m1_heal.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		
		//Mission 2
		
		//201
		//Felix - Good work extracting Kincaide... hopfully this will go just as smoothly.  You need to gain access to Kriegeld's computer, download his business files, then upload a trojan so we can follow the money.
		SceneTable["m2_prep_room"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_prep_room.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//202
		//Felix - Make your way through the maintance building to get into Kriegeld's accounting office.
		SceneTable["m2_first_land"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_first_land.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//203
		//Felix - You got more company!
		SceneTable["m2_wave1_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_wave1_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//204
		//Felix - Damn it, they were ready for us... be careful moving forward, I have a feeling that won't be the last ambush.
		SceneTable["m2_wave2_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_wave2_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
				
		//206
		//Felix - The storm is getting worse - if you don't get that data soon we won't be able to fly in your ride.
		SceneTable["m2_wave4_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_wave4_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
				
		//208
		//Felix - You got what we needed.  Make your way to a rooftop, we'll extact you hot.
		SceneTable["m2_wave6_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_wave6_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
				
		//210
		//Felix - Felix - The programs working, hang tight while we copy the data over.
		SceneTable["m2_thumbdrive_start"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_thumbdrive_start.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//211
		//Felix - Download complete, now upload the virus!
		SceneTable["m2_thumbdrive1_ready"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_thumbdrive1_ready.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//212
		//Felix - Virus uploading!
		SceneTable["m2_thumbdrive_swap"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_thumbdrive_swap.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//213
		//Felix - It's done!
		SceneTable["m2_thumbdrive2_ready"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_thumbdrive2_ready.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//214
		//Felix - They've disabled the feight elevator, take out The Phoenix and get it moving again.
		SceneTable["m2_reach_elevator"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_reach_elevator.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		
		//216
		//Felix - You just beat the storm, good work.
		SceneTable["m2_finish"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_finish.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//217
		//Felix - Once we start downloading their data they'll know exactly where you are: stay close and watch each other's backs.  Good luck.
		SceneTable["m2_stay_close"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_stay_close.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//218
		//Felix - You're almost out of there...the choppers waiting for you on the roof. 
		SceneTable["m2_ride_elevator"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_ride_elevator.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}			
	
		//219
		//Felix - Alright, once you're out of the maintance building, find a way to cross the yard and get to the accounting office.		
		SceneTable["m2_wave3_clear_alt"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m2_wave3_clear_alt.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//220
		//Felix - You're almost to the objective.			
		SceneTable["mx_wave_completed_09"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_wave_completed_09.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//222
		//Felix - Excellent work!			
		SceneTable["mx_compliment_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_compliment_05.vcd"),postdelay=0.75,next="mx_wave_completed_05",char="radiovoice",predelay=0.0}

		//223
		//Felix - Remind me to give you boys a raise.			
		SceneTable["mx_wave_completed_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_wave_completed_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}


		//Mission 3
		
		//301
		//Felix - I'm not wild about helping Booth, but Imogen could be a powerful asset.  This time we'll be going in by boat - by approaching from the river we should be able to get past all their gates and get right in the compound.  Once we're on site we'll make contact with Imogen.
		SceneTable["m3_prep_room"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_prep_room.vcd"),postdelay=0.00,next="m3_prep_room_02",char="radiovoice",predelay=0.00}

		//302
		//Felix - Imogen, can you hear me?
		SceneTable["m3_first_land_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_first_land_01.vcd"),postdelay=0.00,next="m3_first_land_02",char="radiovoice",predelay=0.00}

		//303
		//Imogen - Thank god you're here - I don't know how much longer I can listen to Valeria drone on.
		SceneTable["m3_first_land_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_first_land_02.vcd"),postdelay=0.00,next="m3_first_land_03",char="radiovoice",predelay=0.00}

		//304
		//Felix - My people are onsite, where are you?
		SceneTable["m3_first_land_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_first_land_03.vcd"),postdelay=0.00,next="m3_first_land_04",char="radiovoice",predelay=0.00}

		//305
		//Imogen - The motorpool.  I'm hiding in an APC.
		SceneTable["m3_first_land_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_first_land_04.vcd"),postdelay=0.00,next="m3_first_land_05",char="radiovoice",predelay=0.00}

		//306
		//Felix - Hang tight, we're on our way.
		SceneTable["m3_first_land_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_first_land_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//307
		//Valeria - There's no hiding from us Imogen... we'll find you and make you pay for your treachery.  Failure can be forgiven.... Betrayal will always be met with death.
		SceneTable["m3_courtyard_pa"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_courtyard_pa.vcd"),postdelay=0.00,next=null,char="valeria",predelay=0.00}

		//308
		//Felix - Courtyard's clear, get to the motorpool.
		SceneTable["m3_1st_wave_clear"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_1st_wave_clear.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//309
		//Imogen - Punctual and deadly.  If I wasn't spoken for I- (FELIX) - They'll be time for jokes later, let's get you out of here (merged 309 and 310)
		SceneTable["m3_see_apc_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_see_apc_01.vcd"),postdelay=0.00,next="m3_see_apc_03",char="radiovoice",predelay=0.00}

		//310
		//Felix - They'll be time for jokes later.  Let's get you out of here
		SceneTable["m3_see_apc_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_see_apc_02.vcd"),postdelay=0.00,next="m3_see_apc_03",char="radiovoice",predelay=0.00}		

		//311
		//Imogen - Great, let me get out of this APC... (CONTINUED AT 356
		SceneTable["m3_see_apc_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_see_apc_03.vcd"),postdelay=-2.0,next="m3_see_apc_04",char="radiovoice",predelay=0.5}
				
		//312
		//Valeria - Stop that APC!
		SceneTable["m3_gate_1"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_gate_1.vcd"),postdelay=0.00,next=null,char="valeria",predelay=0.00}
		
		//313
		//Imogen - I'm at the gate.
		SceneTable["m3_closed_gate_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_closed_gate_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//314
		//Imogen - Let's get out of here.
		SceneTable["m3_closed_gate_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_closed_gate_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//315
		//Imogen - The gate's locked.
		SceneTable["m3_closed_gate_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_closed_gate_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//316
		//Imogen - We have to open the gate.
		SceneTable["m3_closed_gate_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_closed_gate_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//317
		//Imogen - Ready when you are.
		SceneTable["m3_closed_gate_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_closed_gate_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//318
		//Felix - They're trying to slow you down, you can expect more of these choke points.
		SceneTable["m3_open_1st_gate_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_open_1st_gate_01.vcd"),postdelay=0.00,next="m3_open_1st_gate_02",char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//319
		//Imogen - Great.
		SceneTable["m3_open_1st_gate_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_open_1st_gate_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//320
		//Valeria - It's not too late for you Imogen.  I understand that you're scared, and that you don't want to die.  But if you step out of that vehicle with courage and dignity I will grant a quick and merciful end. But if you stand defiant...  If you continue to cast your lot with these jack booted thugs... you will reap the whirlwind.
		SceneTable["m3_open_2nd_gate_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_open_2nd_gate_01.vcd"),postdelay=0.00,next=null, char="valeria",predelay=0.00, fireentity="@radiovoice", fireinput="RunScriptCode", fireparm="PlayVcd(321)", firedelay=0}
		
		//321
		//Imogen - She's a helluva negotiator isn't she...
		SceneTable["m3_open_2nd_gate_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_open_2nd_gate_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//322
		//Felix - We need both of you to secure Imogen
		SceneTable["m3_separate"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_separate.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//323
		//Imogen - Shall we?
		SceneTable["m3_start_apc"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_start_apc.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//324
		//Felix - You also have a second objective:  Destroy that facility.
		SceneTable["m3_prep_room_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_prep_room_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//325
		//Felix - Imogen, you have any ideas on how to take this place out?  
		SceneTable["m3_bomb_planning_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planning_01.vcd"),postdelay=0.00,next="m3_bomb_planning_02",char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//326
		//Imogen - Sure.  You call in an airstrike after we're miles away.
		SceneTable["m3_bomb_planning_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planning_02.vcd"),postdelay=0.00,next="m3_bomb_planning_03",char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//327
		//Felix - What if I told you we only had 2 packs of c4.
		SceneTable["m3_bomb_planning_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planning_03.vcd"),postdelay=0.00,next="m3_bomb_planning_04",char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//328
		//Imogen - I'd say you're woefully underfunded.
		SceneTable["m3_bomb_planning_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planning_04.vcd"),postdelay=0.00,next="m3_bomb_planning_05",char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//329
		//Felix - And I would agree... then tell you we still only have 2 packs of c4.
		SceneTable["m3_bomb_planning_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planning_05.vcd"),postdelay=0.00,next="m3_bomb_planning_06",char="radiovoice",predelay=0.00, uninterruptible=true}

		//330
		//Imogen - I'll see what I can come up with.
		SceneTable["m3_bomb_planning_06"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planning_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//332
		//Imogen - Alright, we'll plant the first bomb in that building over there.
		SceneTable["m3_bomb_site_a_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_site_a_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//334
		//Imogen - The last bomb goes in that building.
		SceneTable["m3_bomb_site_b_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_site_b_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//335
		//Imogen - Wait a minute:  that's not the c4 we sell.
		SceneTable["m3_bomb_planting_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planting_01.vcd"),postdelay=0.00,next="m3_bomb_planting_02",char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//336
		//Felix - You're father's not the only game in town Imogen.
		SceneTable["m3_bomb_planting_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planting_02.vcd"),postdelay=0.00,next="m3_bomb_planting_03",char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//337
		//Imogen - You're buying explosives from Huxley?  That snake oil salesman sells inferior product, we'll be lucky if this thing doesn't explode while we're on site.
		SceneTable["m3_bomb_planting_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planting_03.vcd"),postdelay=0.00,next="m3_bomb_planting_04",char="radiovoice",predelay=0.00, uninterruptible=true}

		//338
		//Felix - We can argue about inventory later, stay focused on the task at hand.
		SceneTable["m3_bomb_planting_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_planting_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00, uninterruptible=true}
		
		//345
		//Felix - Why'd that bomb go off early?
		SceneTable["m3_bomb_goes_off_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_goes_off_01.vcd"),postdelay=0.00,next="m3_bomb_goes_off_02",char="radiovoice",predelay=0.00}
		
		//346
		//Imogen- I already told you why: inferior. product.
		SceneTable["m3_bomb_goes_off_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_goes_off_02.vcd"),postdelay=0.00,next="m3_bomb_goes_off_03",char="radiovoice",predelay=0.00}

		//347
		//Felix - *sigh* when you're safe, set up a meeting with Booth.
		SceneTable["m3_bomb_goes_off_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_goes_off_03.vcd"),postdelay=0.00,next="m3_bomb_goes_off_04",char="radiovoice",predelay=0.00}
			
		//348
		//Imogen - It would be my pleasure.
		SceneTable["m3_bomb_goes_off_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_bomb_goes_off_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//349
		//Felix - Get Imogen back to base - we'll check for Valeria's body later.  Good work.
		SceneTable["m3_mission_end"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_mission_end.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//350
		//Valeria - Find Imogen and bring her to me.  Anyone wh35o plays a part in bringing this traitor to justice will earn my favor and be rewarded.
		SceneTable["m3_imogen_rant_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_imogen_rant_01.vcd"),postdelay=0.00,next=null,char="valeria",predelay=0.00}
		
		//351
		//Valeria - You've failed The Phoenix by letting Kincaide be removed from our care, and now a modern Judas Ascarriot hides in plain sight.  Find Imogen... and in doing so earn your absolution.
		SceneTable["m3_imogen_rant_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_imogen_rant_02.vcd"),postdelay=0.00,next=null,char="valeria",predelay=0.00}
		
		//352
		//Valeria - Do not let that APC leave this compound!  
		SceneTable["m3_imogen_rant_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_imogen_rant_03.vcd"),postdelay=0.00,next=null,char="valeria",predelay=0.00}
		
		//353
		//Valeria - Stop the coalition taskforce!  Do not give these imperialists quarter or mercy!
		SceneTable["m3_imogen_rant_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_imogen_rant_04.vcd"),postdelay=0.00,next=null,char="valeria",predelay=0.00}
		
		//Valeria - 354
		//Imogen... I know you can hear me... and I want you to understand something very clearly.  Even if you escape today, you can not hide from us.  The firey wings of the Phoenix embrace this world, and not even your father can shield you from the flames.
		SceneTable["m3_imogen_rant_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_imogen_rant_05.vcd"),postdelay=0.00,next=null,char="valeria",predelay=0.00}

		//355
		//Valeria - Imogen...come out come out whereever you are
		SceneTable["m3_imogen_taunt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_imogen_taunt_01.vcd"),postdelay=0.00,next=null,char="valeria",predelay=0.00}		

		//356
		//Felix - No, stay in the vehicle; you'll be safer inside - my people will escort you out of the facility.
		SceneTable["m3_see_apc_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_see_apc_04.vcd"),postdelay=0.00,next="m3_see_apc_05",char="radiovoice",predelay=0.00}

		//357
		//Imogen - You don't have to sell me on not getting shot at.
		SceneTable["m3_see_apc_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_see_apc_05.vcd"),postdelay=1.00,next=null,char="radiovoice",predelay=0.00, fireentity="@coopmission_manager_script", fireinput="RunScriptCode", fireparm="ApcGarageDoorOpen()", firedelay=0.25}

		//359
		//Imogen - Here we go...
		SceneTable["m3_start_escape"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_start_escape.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}			

		//360
		//Felix - We're clear of the facility, Imogen gun it!
		SceneTable["m3_home_free_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_home_free_01.vcd"),postdelay=0.00,next="m3_home_free_02",char="radiovoice",predelay=0.00}

		//361
		//Imogen - I can't.  I don't know how to drive stick.
		SceneTable["m3_home_free_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_home_free_02.vcd"),postdelay=0.00,next="m3_home_free_03",char="radiovoice",predelay=0.00}

		//362
		//Felix - Are you kidding me?
		SceneTable["m3_home_free_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_home_free_03.vcd"),postdelay=0.00,next="m3_home_free_04",char="radiovoice",predelay=0.00}

		//363
		//Imogen - Hey I'm good at a lot of things:  You need to find a coutre firearm?  No problem.  Smuggle 30 palates of assault rifles into Topeka?  I'm your girl.  Manual Transmission just happens to be outside of my wheel house.
		SceneTable["m3_home_free_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_home_free_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//364
		//Felix - How could Booth never teach you how to drive a proper car?
		SceneTable["m3_home_free_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_home_free_05.vcd"),postdelay=0.00,next="m3_home_free_06",char="radiovoice",predelay=0.00}

		//365
		//Imogen - He was busy teaching me how to avoid UN Sanctions.
		SceneTable["m3_home_free_06"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_home_free_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//367
		//Imogen - Time to go home...
		SceneTable["m3_leave_compound_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_leave_compound_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		

		//368
		//Imogen - Almost home free...
		SceneTable["m3_leave_compound_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_leave_compound_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		

		//369
		//Imogen - Well I for one, am pleasently surprised I'm not dead...
		SceneTable["m3_leave_compound_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_leave_compound_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		

		//370
		//Imogen - When we're back in civilization, drinks are on me.
		SceneTable["m3_leave_compound_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_leave_compound_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		

		//373
		//Imogen - If we're lucky Valeria died in that blast...
		SceneTable["m3_second_explosion_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_second_explosion_03.vcd"),postdelay=0.00,next="m3_felix_finale",char="radiovoice",predelay=0.00}		
		
		//380
		//Felix - Get to the extraction point!
		SceneTable["m3_extraction"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_extraction.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		

		//379
		//Felix - Well check for Valeria's body later... good work
		SceneTable["m3_felix_finale"] <- {vcd=CreateSceneEntity("scenes/coop_radio/m3_felix_finale.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		
		
		
		//General
		
		//9001
		//Felix - It's up to you now: kill the remaining Phoenix and wait for backup.
		SceneTable["mx_ally_down_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_ally_down_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9002
		//Felix - Take out the remaining enemies, help is on it's way.
		SceneTable["mx_ally_down_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_ally_down_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//9003
		//Felix - Secure the area so we can bring in back up.
		SceneTable["mx_ally_down_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_ally_down_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//9004
		//Felix - Once you clear out the enemies we'll bring in reinforcements.
		SceneTable["mx_ally_down_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_ally_down_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//9005
		//Felix - Operator down!
		SceneTable["mx_ally_down_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_ally_down_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//9006
		//Felix - We're out of time... get back to base.
		SceneTable["mx_time_out_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_time_out_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9007
		//Felix - We missed our window.
		SceneTable["mx_time_out_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_time_out_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9008
		//Felix - Pull out, the window's closed.
		SceneTable["mx_time_out_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_time_out_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9009
		//Felix - We missed out shot... come back home, we'll try again later.
		SceneTable["mx_time_out_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_time_out_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//90010
		//Felix - Damn it, we're out of time...
		SceneTable["mx_time_out_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_time_out_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9011
		//Felix - We failed...
		SceneTable["mx_all_dead_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_all_dead_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9012
		//Felix - It's over...
		SceneTable["mx_all_dead_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_all_dead_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9013
		//Felix - Operator, what is your status? Again, what is your status?
		SceneTable["mx_all_dead_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_all_dead_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9014
		//Felix - Valeria will answer for this...
		SceneTable["mx_all_dead_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_all_dead_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9015
		//Felix - We were so close...
		SceneTable["mx_all_dead_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_all_dead_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//9016
		//Felix - Ah...looking for a challenge eh?
		SceneTable["mx_hard"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_hard.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9017
		//Felix - Keep trying, you can do this.
		SceneTable["mx_encouragement_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_encouragement_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9018
		//Felix - Learn from your previous mistakes - I know you can stop The Phoenix.
		SceneTable["mx_encouragement_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_encouragement_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9019
		//Felix - I wouldn't send you out there if I didn't think you could do it.
		SceneTable["mx_encouragement_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_encouragement_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9020
		//Felix - Check your sight lines, make sure The Phoenix can't get the drop on you.
		SceneTable["mx_encouragement_04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_encouragement_04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9021
		//Felix - Remember: Teamwork is the key to success.  Communicate, and watch each other's backs.
		SceneTable["mx_encouragement_05"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_encouragement_05.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//9022
		//Felix - Don't forget to check the area for supplies, after Lord William's death we're not exactly swimming in resources and I refuse to owe Booth a favor.
		SceneTable["mx_fluff_06"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_fluff_06.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//9023
		//Felix - Remember your training and you'll both come home.
		SceneTable["mx_fluff_08"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_fluff_08.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//9024
		//Felix - Communicate.  Work as a team.  It's the only way you're going to survive.
		SceneTable["mx_fluff_10"] <- {vcd=CreateSceneEntity("scenes/coop_radio/mx_encouragement_10.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
	
		
		

	}


SceneTableLookup <- {}
SceneTableLookup[1] <- "m1_prep_room"
SceneTableLookup[2] <- "m1_first_land"
SceneTableLookup[3] <- "m1_wave1_clear"
SceneTableLookup[4] <- "m1_wave2_clear"
SceneTableLookup[5] <- "m1_wave3_clear"
SceneTableLookup[6] <- "m1_hostage"
SceneTableLookup[7] <- "m1_wave4_clear"
SceneTableLookup[8] <- "m1_wave5_clear"
SceneTableLookup[9] <- "m1_wave6_clear"
SceneTableLookup[10] <- "m1_no_kincaide"
SceneTableLookup[11] <- "m1_survial_wave"
SceneTableLookup[12] <- "m1_helicopter"
SceneTableLookup[13] <- "m1_finish"
SceneTableLookup[14] <- "m1_kincaide_rescue"
SceneTableLookup[15] <- "m1_kincaide_dropped"
SceneTableLookup[16] <- "m1_kincaide_extaract"
SceneTableLookup[17] <- "m1_kincaide_panic_01"
SceneTableLookup[18] <- "m1_kincaide_panic_02"
SceneTableLookup[19] <- "m1_kincaide_panic_03"
SceneTableLookup[20] <- "m1_kincaide_panic_04"
SceneTableLookup[21] <- "m1_gun_check"
SceneTableLookup[23] <- "m1_tents"
SceneTableLookup[24] <- "m1_train"
SceneTableLookup[25] <- "m1_forklift_room_01"
SceneTableLookup[26] <- "m1_forklift_room_02"
SceneTableLookup[27] <- "m1_forklift_idle_01"
SceneTableLookup[28] <- "m1_forklift_idle_02"
SceneTableLookup[29] <- "m1_forklift_idle_03"
SceneTableLookup[31] <- "m1_60_seconds"
SceneTableLookup[32] <- "m1_30_seconds"
SceneTableLookup[33] <- "m1_15_seconds"
SceneTableLookup[34] <- "m1_5_seconds"
SceneTableLookup[35] <- "m1_kincaide_extaract_alt_01"
SceneTableLookup[36] <- "m1_kincaide_extaract_alt_02"
SceneTableLookup[37] <- "m1_kincaide_extaract_alt_03"
SceneTableLookup[38] <- "m1_forget_kincaide"
SceneTableLookup[39] <- "m1_vent"
SceneTableLookup[41] <- "m1_tag_01"
SceneTableLookup[42] <- "m1_tag_02"
SceneTableLookup[43] <- "m1_heal"
SceneTableLookup[75] <- "m1_heavy_02_alt"
SceneTableLookup[201] <- "m2_prep_room"
SceneTableLookup[202] <- "m2_first_land"
SceneTableLookup[203] <- "m2_wave1_clear"
SceneTableLookup[204] <- "m2_wave2_clear"
SceneTableLookup[206] <- "m2_wave4_clear"
SceneTableLookup[208] <- "m2_wave6_clear"
SceneTableLookup[210] <- "m2_thumbdrive_start"
SceneTableLookup[211] <- "m2_thumbdrive1_ready"
SceneTableLookup[212] <- "m2_thumbdrive_swap"
SceneTableLookup[213] <- "m2_thumbdrive2_ready"
SceneTableLookup[214] <- "m2_reach_elevator"
SceneTableLookup[216] <- "m2_finish"
SceneTableLookup[217] <- "m2_stay_close"
SceneTableLookup[218] <- "m2_ride_elevator"
SceneTableLookup[219] <- "m2_wave3_clear_alt"
SceneTableLookup[220] <- "mx_wave_completed_09"
SceneTableLookup[222] <- "mx_compliment_05"
SceneTableLookup[223] <- "mx_wave_completed_05"
SceneTableLookup[301] <- "m3_prep_room"
SceneTableLookup[302] <- "m3_first_land_01"
SceneTableLookup[303] <- "m3_first_land_02"
SceneTableLookup[304] <- "m3_first_land_03"
SceneTableLookup[305] <- "m3_first_land_04"
SceneTableLookup[306] <- "m3_first_land_05"
SceneTableLookup[307] <- "m3_courtyard_pa"
SceneTableLookup[308] <- "m3_1st_wave_clear"
SceneTableLookup[309] <- "m3_see_apc_01"
SceneTableLookup[310] <- "m3_see_apc_02"
SceneTableLookup[311] <- "m3_see_apc_03"
SceneTableLookup[312] <- "m3_gate_1"
SceneTableLookup[313] <- "m3_closed_gate_01"
SceneTableLookup[314] <- "m3_closed_gate_02"
SceneTableLookup[315] <- "m3_closed_gate_03"
SceneTableLookup[316] <- "m3_closed_gate_04"
SceneTableLookup[317] <- "m3_closed_gate_05"
SceneTableLookup[318] <- "m3_open_1st_gate_01"
SceneTableLookup[319] <- "m3_open_1st_gate_02"
SceneTableLookup[320] <- "m3_open_2nd_gate_01"
SceneTableLookup[321] <- "m3_open_2nd_gate_02"
SceneTableLookup[322] <- "m3_separate"
SceneTableLookup[323] <- "m3_start_apc"
SceneTableLookup[324] <- "m3_prep_room_02"
SceneTableLookup[325] <- "m3_bomb_planning_01"
SceneTableLookup[326] <- "m3_bomb_planning_02"
SceneTableLookup[327] <- "m3_bomb_planning_03"
SceneTableLookup[328] <- "m3_bomb_planning_04"
SceneTableLookup[329] <- "m3_bomb_planning_05"
SceneTableLookup[330] <- "m3_bomb_planning_06"
SceneTableLookup[332] <- "m3_bomb_site_a_02"
SceneTableLookup[334] <- "m3_bomb_site_b_02"
SceneTableLookup[335] <- "m3_bomb_planting_01"
SceneTableLookup[336] <- "m3_bomb_planting_02"
SceneTableLookup[337] <- "m3_bomb_planting_03"
SceneTableLookup[338] <- "m3_bomb_planting_04"
SceneTableLookup[345] <- "m3_bomb_goes_off_01"
SceneTableLookup[346] <- "m3_bomb_goes_off_02"
SceneTableLookup[347] <- "m3_bomb_goes_off_03"
SceneTableLookup[348] <- "m3_bomb_goes_off_04"
SceneTableLookup[349] <- "m3_mission_end"
SceneTableLookup[350] <- "m3_imogen_rant_01"
SceneTableLookup[351] <- "m3_imogen_rant_02"
SceneTableLookup[352] <- "m3_imogen_rant_03"
SceneTableLookup[353] <- "m3_imogen_rant_04"
SceneTableLookup[354] <- "m3_imogen_rant_05"
SceneTableLookup[355] <- "m3_imogen_taunt_01"
SceneTableLookup[356] <- "m3_see_apc_04"
SceneTableLookup[357] <- "m3_see_apc_05"
SceneTableLookup[359] <- "m3_start_escape"
SceneTableLookup[360] <- "m3_home_free_01"
SceneTableLookup[361] <- "m3_home_free_02"
SceneTableLookup[362] <- "m3_home_free_03"
SceneTableLookup[363] <- "m3_home_free_04"
SceneTableLookup[364] <- "m3_home_free_05"
SceneTableLookup[365] <- "m3_home_free_06"
SceneTableLookup[367] <- "m3_leave_compound_02"
SceneTableLookup[368] <- "m3_leave_compound_03"
SceneTableLookup[369] <- "m3_leave_compound_04"
SceneTableLookup[370] <- "m3_leave_compound_05"
SceneTableLookup[373] <- "m3_second_explosion_03"
SceneTableLookup[380] <- "m3_extraction"
SceneTableLookup[379] <- "m3_felix_finale"
SceneTableLookup[9001] <- "mx_ally_down_05"
SceneTableLookup[9002] <- "mx_ally_down_04"
SceneTableLookup[9003] <- "mx_ally_down_03"
SceneTableLookup[9004] <- "mx_ally_down_02"
SceneTableLookup[9005] <- "mx_ally_down_01"
SceneTableLookup[9006] <- "mx_time_out_01"
SceneTableLookup[9007] <- "mx_time_out_02"
SceneTableLookup[9008] <- "mx_time_out_03"
SceneTableLookup[9009] <- "mx_time_out_04"
SceneTableLookup[9010] <- "mx_time_out_05"
SceneTableLookup[9011] <- "mx_all_dead_01"
SceneTableLookup[9012] <- "mx_all_dead_02"
SceneTableLookup[9013] <- "mx_all_dead_03"
SceneTableLookup[9014] <- "mx_all_dead_04"
SceneTableLookup[9015] <- "mx_all_dead_05"
SceneTableLookup[9016] <- "mx_hard"
SceneTableLookup[9017] <- "mx_encouragement_01"
SceneTableLookup[9018] <- "mx_encouragement_02"
SceneTableLookup[9019] <- "mx_encouragement_03"
SceneTableLookup[9020] <- "mx_encouragement_04"
SceneTableLookup[9021] <- "mx_encouragement_05"