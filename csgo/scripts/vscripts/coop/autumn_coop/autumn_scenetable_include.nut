includeTestString <- "!!!INCLUDE SUCCESS!!!"

SceneTable <- {}
//if (curMapName=="coop_autumn" && self.GetName() == "@radiovoice")
if (self.GetName() == "@radiovoice")
	{
		printl(self.GetName() + " INCLUDING COOPRADIO SCENE TABLE FELIX AUTUMN!!!!" );

		//1
		//Felix - Good to see you back, Operators… It's been a while since we've been back in the field so we're gonna start with a little recon mission.  Phoenix Convoys have been spotted moving in and out of a provincal farmstead… and seeing as Valeria probably hasn't taken interest in agriculture, we need to know what's going on there.  Investigate the farm, take note of anything odd, then pull out.  Welcome to Operation Broken Fang.
		SceneTable["felix_broken_fang_mission1_intro_alt_01_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_intro_alt_01_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//2
		//Felix - Coming up on the location now, get ready to dismount.
		SceneTable["felix_broken_fang_mission1_arrive"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_arrive.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//3
		//Felix - Follow the riverbed, stay low and out of sight.
		SceneTable["felix_broken_fang_mission1_riverbed"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_riverbed.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//4
		//Felix - Hope they don't notice the extra speedholes once they're stopped..
		SceneTable["felix_broken_fang_mission1_shoot_truck"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_shoot_truck.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//5
		//Felix - Would it kill you to try to be subtle?
		SceneTable["felix_broken_fang_mission1_shoot_truck_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_shoot_truck_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//6
		//Felix - Coming up on the farm now, stay alert.
		SceneTable["felix_broken_fang_mission1_approach"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_approach.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//7
		//Felix - So much for the quiet approach. Move quickly on the farm!
		SceneTable["felix_broken_fang_mission1_1st_wave_defeated"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_1st_wave_defeated.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//8
		//Felix - I'm no expert, but that does not look like regular farm equipment.
		SceneTable["felix_broken_fang_mission1_investigate_farm_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_investigate_farm_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9
		//Felix - What the hell are the Phoenix planning…
		SceneTable["felix_broken_fang_mission1_investigate_farm_alt_01_tk04"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_investigate_farm_alt_01_tk04.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//10
		//Felix - Well what do we have here…
		SceneTable["felix_broken_fang_mission1_find_console_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_find_console_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		

		//11
		//Felix - We need to find a way to power up that console.
		SceneTable["felix_broken_fang_mission1_no_power"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_no_power.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
				
		//12
		//Felix - That console has no power.
		SceneTable["felix_broken_fang_mission1_no_power_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_no_power_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//13
		//Felix - How do we get that thing working…
		SceneTable["felix_broken_fang_mission1_no_power_alt_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_no_power_alt_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//14
		//Felix - You're one of those people who hit lit buttons on a lift, aren't you.
		SceneTable["felix_broken_fang_mission1_no_power_alt_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_no_power_alt_03.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//15
		//Felix - Guess we're going underground..
		SceneTable["felix_broken_fang_mission1_use_console"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_use_console.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		

		//28
		//Felix - That's not ominous or anything…
		SceneTable["felix_broken_fang_mission1_use_console_alt_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_use_console_alt_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		

		//31
		//Felix - Time to find out what was hiding behind that door…
		SceneTable["felix_broken_fang_mission1_backtrack_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_backtrack_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//32
		//Felix - This is a bit more advanced than I expected..
		SceneTable["felix_broken_fang_mission1_descent_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_descent_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//33
		//Felix - What the hell is this place…
		SceneTable["felix_broken_fang_mission1_descent_alt_01_tk02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_descent_alt_01_tk02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//34
		//Felix - What is Valeria up to down here…
		SceneTable["felix_broken_fang_mission1_descent_alt_02_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_descent_alt_02_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//100
		//Felix - This is getting absurd.
		SceneTable["felix_broken_fang_mission1_fake_wall_alt_01_tk02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_fake_wall_alt_01_tk02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//101
		//Felix - How big is this place?
		SceneTable["felix_broken_fang_mission1_fake_wall_alt_02_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_fake_wall_alt_02_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//102
		//Felix - Looks like the Phoenix are better financed than we thought…
		SceneTable["felix_broken_fang_mission1_discover_facility_alt_01_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_discover_facility_alt_01_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//103
		//Felix - How can they afford this stuff..?
		SceneTable["felix_broken_fang_mission1_discover_facility_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_discover_facility_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//104
		//Felix - Nice, that will really annoy them if they want a drink later.
		SceneTable["felix_broken_fang_mission1_vending"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_vending.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//105
		//Felix - This is a counter terrorist operation, not a fraternity prank.
		SceneTable["felix_broken_fang_mission1_vending_alt_03_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_vending_alt_03_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//106
		//Felix - End of the line, there's the trucks..
		SceneTable["felix_broken_fang_mission1_find_trucks"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_find_trucks.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//107
		//Felix - Uh oh, that's not good.
		SceneTable["felix_broken_fang_mission1_alarm"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_alarm.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//108
		//Felix - Finally, some peace and quiet. Lets get that door opened
		SceneTable["felix_broken_fang_mission1_survive_ambush"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_survive_ambush.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//109
		//Felix - Good work. Now get that door open.
		SceneTable["felix_broken_fang_mission1_survive_ambush_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_survive_ambush_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//110
		//Felix - Of course, that'd be too easy.. We'll have to breach, did you bring any thermite charges with you?
		SceneTable["felix_broken_fang_mission1_cant_open"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_cant_open.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//111
		//Felix - Nevermind, get out of there and back to the APC, we need to rethink this
		SceneTable["felix_broken_fang_mission1_evac_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_evac_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//112
		//Felix - Excellent! Cross your fingers it leads to an exit!
		SceneTable["felix_broken_fang_mission1_way_out"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_way_out.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//113
		//Felix - Keep those fingers crossed..!
		SceneTable["felix_broken_fang_mission1_elevator_out"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_elevator_out.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//114
		//Felix - Let's hope this works.
		SceneTable["felix_broken_fang_mission1_elevator_out_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_elevator_out_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//115
		//Felix - Keep those fingers crossed..!
		SceneTable["felix_broken_fang_mission1_elevator_out_tk01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_elevator_out_tk01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//116
		//Felix - Well it would have been handy if we found this first, now wouldn't it -  believe me the advance team is gonna hear about this.  Extraction should be there any moment, let's get you back home and figure out a way to crack that door.
		SceneTable["felix_broken_fang_mission1_end_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/autumn/felix_broken_fang_mission1_end_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		// M2
		
		//200
		//Felix - I was hoping to find a way to breach the Phoenix facility without having to ask Booth for a favor, but desperate times and blah blah blah. The point is, we got the the explosives we need to knock Valeria's front door down.  It's time to finish Operation Broken Fang.
		SceneTable["felix_broken_fang_pt2_intro"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_intro.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//201
		//Felix - Do you know what sort of deal I had to make with Booth to get that Breach Charge? You're not leavin' it behind, you're gonna use that to blow a hole through a damn door.
		SceneTable["felix_broken_fang_pt2_breach_charge_pickup"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_breach_charge_pickup.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
	
		//202
		//Felix - Are you daft?  Pick up the charge and get moving, Operator!
		SceneTable["felix_broken_fang_pt2_breach_charge_nag"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_breach_charge_nag.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//203
		//Felix - Valeria knows her facility is exposed, be careful, they’re going to be on high alert.
		SceneTable["felix_broken_fang_pt2_elevator_down"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_elevator_down.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//204
		//Felix - Here's hoping Booth's merchandise works as advertised.  Place the breach charge and stand back…it's time we knock on that door and say hello.
		SceneTable["felix_broken_fang_pt2_breach_ready"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_breach_ready.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//205
		//Felix - Well… shit.  In hindight low balling booth for 1 charge was probably not the best idea.  That one's on me, sorry mate.  Time to improvise and find a way around that door.
		SceneTable["felix_broken_fang_pt2_second_breach"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_second_breach.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//206
		//Felix - Christ, it's some sort of training facility… 
		SceneTable["felix_broken_fang_pt2_mirage_area_entry"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_mirage_area_entry.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//207
		//Felix - Brilliant work, Operator… now lets keep moving, we bought some time: we can't afford to waste it.
		SceneTable["felix_broken_fang_pt2_mirage_fight_end"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_mirage_fight_end.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//208
		//Felix - "Under construction" eh? Let's take a peek inside… maybe we can see what Valeria's next move is gonna be…
		SceneTable["felix_broken_fang_pt2_main_hall"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_main_hall.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//209
		//Felix - Wow that looks expensive… wonder what it does…
		SceneTable["felix_broken_fang_pt2_sim_entry"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_sim_entry.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//210
		//Felix - What the hell is this?
		SceneTable["felix_broken_fang_pt2_sim_entry_alt"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_sim_entry_alt.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//211
		//Felix - It’s another layout… don't recognize it… could be where the Phoenix is planning to strike next, though.  Make your way to that control room, and see what you can find out.
		SceneTable["felix_broken_fang_pt2_ancient_entry"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_ancient_entry.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//212
		//Felix - We're close to what Valeria is hiding, I can feel it.  Get to that control room and secure as much intel as you can.
		SceneTable["felix_broken_fang_pt2_ancient_fight"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_ancient_fight.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//213
		//Felix - Search the room and grab any piece of intel you can find!  We'll sort through it later.
		SceneTable["felix_broken_fang_pt2_ancient_intel_search"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_ancient_intel_search.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//214
		//Felix - We're out of time, get the hell out of there!
		SceneTable["felix_broken_fang_pt2_ancient_intel_picked_up"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_ancient_intel_picked_up.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//215
		//Felix - I just got reports of an inbound vehicle closing in on the farm, and it's not one of ours.  If you don't hurry, Valeria may be able to cut off your extraction route.
		SceneTable["felix_broken_fang_pt2_nearing_exit"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_nearing_exit.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//216
		//Felix - Bollocks, this is bad.  
		SceneTable["felix_broken_fang_pt2_exit_blocked"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_exit_blocked.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//217
		//Felix - This isn't some fanatic with knife and an AK, that's a goddamn tank!  Don't make your move until you find something that will actually damage that thing.
		SceneTable["felix_broken_fang_pt2_final_room"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_final_room.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//218
		//Felix - I was hoping for a rocket launcher or something, but since we can't blow up the tank we're gonna have to settle for cooking the bastard driving it.
		SceneTable["felix_broken_fang_pt2_molotovs_found"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_molotovs_found.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//219
		//Felix - Use the molotovs to take out the tank!
		SceneTable["felix_broken_fang_pt2_molotov_nag"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_molotov_nag.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//220
		//Felix - That’s it! Again!
		SceneTable["felix_broken_fang_pt2_molotov_hit1"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_molotov_hit1.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//221
		//Felix - Keep it up!
		SceneTable["felix_broken_fang_pt2_molotov_hit2"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_molotov_hit2.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//222
		//Felix - Nicely done!
		SceneTable["felix_broken_fang_pt2_molotov_hit3"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_molotov_hit3.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//223
		//Felix - I'm not gonna lie, when that tank showed up I was worried I'd have to be delivering some bad news tonight.  But you kept your wits about you and dealt a helluva blow to The Phoenix.  I'm honored to have you on the Taskfoce.  Now lets get you home so you can have the celebration heroes like you deserve.
		SceneTable["felix_broken_fang_pt2_end"] <- {vcd=CreateSceneEntity("scenes/m2/felix_broken_fang_pt2_end.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//300
		//Valeria - It would appear that the tyrants have breached our house of learning.  Recruits… report to Mirage Sector and show these interlopers what The Phoenix has taught you.  
		SceneTable["valeria_broken_fang_pt2_mirage_wave1"] <- {vcd=CreateSceneEntity("scenes/m2/valeria_broken_fang_pt2_mirage_wave1.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		
		
		//301
		//Valeria - The despots are still in the Mirage Sector, reenforcements are needed, now!
		SceneTable["valeria_broken_fang_pt2_mirage_wave2"] <- {vcd=CreateSceneEntity("scenes/m2/valeria_broken_fang_pt2_mirage_wave2.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//302
		//Valeria - For the love of god, KILL THEM!
		SceneTable["valeria_broken_fang_pt2_mirage_wave3"] <- {vcd=CreateSceneEntity("scenes/m2/valeria_broken_fang_pt2_mirage_wave3.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//303
		//Valeria - Blood has been spilt in these hallowed halls by the Coalition Taskforce.  Our brothers and sisters in The Struggle are dead, and their murderers have advanced to Hall 3.  Greet them with the respect these murderers deserve.
		SceneTable["valeria_broken_fang_pt2_ancient_fight"] <- {vcd=CreateSceneEntity("scenes/m2/valeria_broken_fang_pt2_ancient_fight.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//304
		//Valeria - Felix… I know you can hear me.  Your thugs are a long way from home and they will answer for your transgressions here.  I promise you, they will be found… and they will suffer on your behalf.
		SceneTable["valeria_broken_fang_pt2_intel_search_alt01"] <- {vcd=CreateSceneEntity("scenes/m2/valeria_broken_fang_pt2_intel_search_alt01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//305
		//Valeria - Lock it down!  No one leaves the facility or the farm!
		SceneTable["valeria_broken_fang_pt2_lock_down"] <- {vcd=CreateSceneEntity("scenes/m2/valeria_broken_fang_pt2_lock_down.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//306
		//Valeria - No more games Felix.  It's over.  Don’t let your stupidity masquerade as courage.  I'm going to be perfectly clear: your team will die… but how much they suffer is up to you.  Surrender.
		SceneTable["valeria_broken_fang_pt2_final_room"] <- {vcd=CreateSceneEntity("scenes/m2/valeria_broken_fang_pt2_final_room.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
		//307
		//Valeria - well well well
		SceneTable["valeria_broken_fang_pt2_facility_intro"] <- {vcd=CreateSceneEntity("scenes/m2/valeria_broken_fang_pt2_facility_intro.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}	
		
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
//if (curMapName=="coop_autumn" && self.GetName() == "@radiovoice")
if (self.GetName() == "@radiovoice")
	{
		printl(self.GetName() + " POPULATING LIST!!!!" );
		SceneTableLookup[1] <- "felix_broken_fang_mission1_intro_alt_01_tk01"
		SceneTableLookup[2] <- "felix_broken_fang_mission1_arrive"
		SceneTableLookup[3] <- "felix_broken_fang_mission1_riverbed"
		SceneTableLookup[4] <- "felix_broken_fang_mission1_shoot_truck"
		SceneTableLookup[5] <- "felix_broken_fang_mission1_shoot_truck_alt_01"
		SceneTableLookup[6] <- "felix_broken_fang_mission1_approach"
		SceneTableLookup[7] <- "felix_broken_fang_mission1_1st_wave_defeated"
		SceneTableLookup[8] <- "felix_broken_fang_mission1_investigate_farm_tk01"
		SceneTableLookup[9] <- "felix_broken_fang_mission1_investigate_farm_alt_01_tk04"
		SceneTableLookup[10] <- "felix_broken_fang_mission1_find_console_alt_01"
		SceneTableLookup[11] <- "felix_broken_fang_mission1_no_power"
		SceneTableLookup[12] <- "felix_broken_fang_mission1_no_power_alt_01"
		SceneTableLookup[13] <- "felix_broken_fang_mission1_no_power_alt_02"
		SceneTableLookup[14] <- "felix_broken_fang_mission1_no_power_alt_03"
		SceneTableLookup[15] <- "felix_broken_fang_mission1_use_console"
		SceneTableLookup[28] <- "felix_broken_fang_mission1_use_console_alt_02"
		SceneTableLookup[31] <- "felix_broken_fang_mission1_backtrack_alt_01"
		SceneTableLookup[32] <- "felix_broken_fang_mission1_descent_tk01"
		SceneTableLookup[33] <- "felix_broken_fang_mission1_descent_alt_01_tk02"
		SceneTableLookup[34] <- "felix_broken_fang_mission1_descent_alt_02_tk01"
		SceneTableLookup[100] <- "felix_broken_fang_mission1_fake_wall_alt_01_tk02"
		SceneTableLookup[101] <- "felix_broken_fang_mission1_fake_wall_alt_02_tk01"
		SceneTableLookup[102] <- "felix_broken_fang_mission1_discover_facility_alt_01_tk01"
		SceneTableLookup[103] <- "felix_broken_fang_mission1_discover_facility_tk01"
		SceneTableLookup[104] <- "felix_broken_fang_mission1_vending"
		SceneTableLookup[105] <- "felix_broken_fang_mission1_vending_alt_03_tk01"
		SceneTableLookup[106] <- "felix_broken_fang_mission1_find_trucks"
		SceneTableLookup[107] <- "felix_broken_fang_mission1_alarm"
		SceneTableLookup[108] <- "felix_broken_fang_mission1_survive_ambush"
		SceneTableLookup[109] <- "felix_broken_fang_mission1_survive_ambush_alt_01"
		SceneTableLookup[110] <- "felix_broken_fang_mission1_cant_open"
		SceneTableLookup[111] <- "felix_broken_fang_mission1_evac_tk01"
		SceneTableLookup[112] <- "felix_broken_fang_mission1_way_out"
		SceneTableLookup[113] <- "felix_broken_fang_mission1_elevator_out"
		SceneTableLookup[114] <- "felix_broken_fang_mission1_elevator_out_alt_01"
		SceneTableLookup[115] <- "felix_broken_fang_mission1_elevator_out_tk01"
		SceneTableLookup[116] <- "felix_broken_fang_mission1_end_alt_01"
		SceneTableLookup[200] <- "felix_broken_fang_pt2_intro"
		SceneTableLookup[201] <- "felix_broken_fang_pt2_breach_charge_pickup"
		SceneTableLookup[202] <- "felix_broken_fang_pt2_breach_charge_nag"
		SceneTableLookup[203] <- "felix_broken_fang_pt2_elevator_down"
		SceneTableLookup[204] <- "felix_broken_fang_pt2_breach_ready"
		SceneTableLookup[205] <- "felix_broken_fang_pt2_second_breach"
		SceneTableLookup[206] <- "felix_broken_fang_pt2_mirage_area_entry"
		SceneTableLookup[207] <- "felix_broken_fang_pt2_mirage_fight_end"
		SceneTableLookup[208] <- "felix_broken_fang_pt2_main_hall"
		SceneTableLookup[209] <- "felix_broken_fang_pt2_sim_entry"
		SceneTableLookup[210] <- "felix_broken_fang_pt2_sim_entry_alt"
		SceneTableLookup[211] <- "felix_broken_fang_pt2_ancient_entry"
		SceneTableLookup[212] <- "felix_broken_fang_pt2_ancient_fight"
		SceneTableLookup[213] <- "felix_broken_fang_pt2_ancient_intel_search"
		SceneTableLookup[214] <- "felix_broken_fang_pt2_ancient_intel_picked_up"
		SceneTableLookup[215] <- "felix_broken_fang_pt2_nearing_exit"
		SceneTableLookup[216] <- "felix_broken_fang_pt2_exit_blocked"
		SceneTableLookup[217] <- "felix_broken_fang_pt2_final_room"
		SceneTableLookup[218] <- "felix_broken_fang_pt2_molotovs_found"
		SceneTableLookup[219] <- "felix_broken_fang_pt2_molotov_nag"
		SceneTableLookup[220] <- "felix_broken_fang_pt2_molotov_hit1"
		SceneTableLookup[221] <- "felix_broken_fang_pt2_molotov_hit2"
		SceneTableLookup[222] <- "felix_broken_fang_pt2_molotov_hit3"
		SceneTableLookup[223] <- "felix_broken_fang_pt2_end"
		SceneTableLookup[300] <- "valeria_broken_fang_pt2_mirage_wave1"
		SceneTableLookup[301] <- "valeria_broken_fang_pt2_mirage_wave2"
		SceneTableLookup[302] <- "valeria_broken_fang_pt2_mirage_wave3"
		SceneTableLookup[303] <- "valeria_broken_fang_pt2_ancient_fight"
		SceneTableLookup[304] <- "valeria_broken_fang_pt2_intel_search_alt01"
		SceneTableLookup[305] <- "valeria_broken_fang_pt2_lock_down"
		SceneTableLookup[306] <- "valeria_broken_fang_pt2_final_room"
		SceneTableLookup[307] <- "valeria_broken_fang_pt2_facility_intro"
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
		printl ("Length of SceneTableLookup: " + SceneTableLookup.len() );
	}
	