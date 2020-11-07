includeTestString <- "!!!INCLUDE SUCCESS!!!"

SceneTable <- {}
if (curMapName=="coop_kasbah" && self.GetName() == "@radiovoice")
	{
		printl(self.GetName() + " INCLUDING COOPRADIO SCENE TABLE FELIX!!!!" );

		//1
		//Felix - Hello Sunshine, I know you've missed me but we don't have time to catch up.  I have it on good authority that Franz Kreigkeld, one of Valeria's top Lieutentants is operating out of the Mediterranean.  Seems like our favorite terrorist industrialist is dipping his toes into biological warfare on a private island.  Your mission is to breach the facility, and get a sample of any biotech he's developing.   So pick out your gear, and get to the deploy zone - you're leaving A-SAP.   Welcome to Operation Shattered Web.
		SceneTable["web_felix_mission_intro_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_intro_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//2
		//Felix - My source says the samples are being held in the tunnels beneath the kasbah.  Get in there, take a sample, and get out before anyone knows we were here.
		SceneTable["web_felix_mission_deployed_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_deployed_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//3
		//Felix - Alright, there's the kasbah.  Secure the area and find a way into the underground tunnels.
		SceneTable["web_felix_mission_kasbah_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_kasbah_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//4
		//Felix - You don't put this many guards around something that doesn't need defending.  The way in has to be around here somewhere.
		SceneTable["web_felix_mission_find_tunnels_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_find_tunnels_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//5
		//Felix - There's the entrance!  We don't know what sort of opposition is down there, so stay alert.
		SceneTable["web_felix_mission_enter_tunnels_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_enter_tunnels_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//6
		//Felix - The tunnels are causing a lot of interference, I'm going to have to go dark until you're back out.
		SceneTable["web_felix_mission_broke_radio_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_broke_radio_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//7
		//Felix - Well done, you've secured the sample! Now let's get you home.
		SceneTable["web_felix_mission_find_sample_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_find_sample_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//8
		//Felix - Glad you made it out of there in one piece! We have a helicopter standing by for extraction, get down to the coast and secure a landing zone!
		SceneTable["web_felix_mission_leave_tunnels_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_leave_tunnels_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//9
		//Felix - There's a helipad nearby, secure it and we'll get you out of there!
		SceneTable["web_felix_mission_radar_station_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_radar_station_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}

		//10
		//Felix - Great work! The helicopter has been dispatched, ETA one minute.
		SceneTable["web_felix_mission_lz_holdout_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_lz_holdout_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}		

		//11
		//Felix - Incoming missile!
		SceneTable["web_felix_mission_missile_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_missile_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
				
		//12
		//Felix - We’re re-routing the helicopter to a new landing zone. Follow the coast and get out of there!
		SceneTable["web_felix_mission_new_lz_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_new_lz_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//13
		//Felix - The LZ is too hot, we're re-routing the helicopter to a new extraction point.  Follow the coast and get out of there!
		SceneTable["web_felix_mission_new_lz_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_new_lz_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//14
		//Felix - Pick it up! You need get out of there, now!
		SceneTable["web_felix_mission_helicopter_close_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_helicopter_close_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//15
		//Felix - Pick it up! You need get out of there, now! variation
		SceneTable["web_felix_mission_helicopter_close_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_helicopter_close_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		

		//28
		//Felix - Once you get home that sample is going to the lab straight away… time to find out what Kreigeld is up to.
		SceneTable["web_felix_mission_complete_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_felix_mission_complete_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		

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
		
		//Mission 2
		
		//100
		//Felix - Briefing.
		SceneTable["web_m2_felix_briefing_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_briefing_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//101
		//Felix - Mission start.
		SceneTable["web_m2_felix_mission_start_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_mission_start_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//102
		//Felix - Virus bad.
		SceneTable["web_m2_felix_virus_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_virus_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//103
		//Felix - Entrance found.
		SceneTable["web_m2_felix_find_entrance_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_find_entrance_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//104
		//Felix - Facility entered.
		SceneTable["web_m2_felix_enter_facility_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_enter_facility_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//105
		//Felix - Plant factory bomb.
		SceneTable["web_m2_felix_plant_bomb1_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_plant_bomb1_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//106
		//Felix - Plant factory bomb nag.
		SceneTable["web_m2_felix_plant_bomb1_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_plant_bomb1_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//107
		//Felix - Plant storage bomb.
		SceneTable["web_m2_felix_plant_bomb2_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_plant_bomb2_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//108
		//Felix - All bombs planted, lets leave.
		SceneTable["web_m2_felix_all_bombs_planted"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_all_bombs_planted.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//109
		//Felix - C4 nag.
		SceneTable["web_m2_felix_c4_nag_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_c4_nag_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//110
		//Felix - C4 nag variation.
		SceneTable["web_m2_felix_c4_nag_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_c4_nag_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//111
		//Felix - Wakeup.
		SceneTable["web_m2_felix_wakeup_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_wakeup_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//112
		//Felix - Good, you are not dead.
		SceneTable["web_m2_felix_wakeup2_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_wakeup2_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//113
		//Felix - Elevator out of service.
		SceneTable["web_m2_felix_elevator_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_elevator_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//114
		//Felix - Find fire.
		SceneTable["web_m2_felix_find_fire_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_find_fire_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//115
		//Felix - Find valve.
		SceneTable["web_m2_felix_find_valve_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_find_valve_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//116
		//Felix - Didnt work.
		SceneTable["web_m2_felix_use_valve_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_use_valve_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//117
		//Felix - Used smoke.
		SceneTable["web_m2_felix_use_smoke_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_use_smoke_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//118
		//Felix - Used smoke early.
		SceneTable["web_m2_felix_use_smoke_early_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_use_smoke_early_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//119
		//Felix - Have to cross tunnel.
		SceneTable["web_m2_felix_find_tunnel_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_find_tunnel_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//120
		//Felix - Shut down fan.
		SceneTable["web_m2_felix_use_fan_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_use_fan_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//121
		//Felix - Found office.
		SceneTable["web_m2_felix_find_office_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_find_office_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//122
		//Felix - Badman gone.
		SceneTable["web_m2_felix_enter_office_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_enter_office_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//123
		//Felix - Found exit.
		SceneTable["web_m2_felix_find_exit_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_find_exit_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//124
		//Felix - Overlook.
		SceneTable["web_m2_felix_overlook_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_overlook_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//125
		//Felix - Shoot boat.
		SceneTable["web_m2_felix_boat_nag2_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_boat_nag2_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//126
		//Felix - Shoot boat please.
		SceneTable["web_m2_felix_boat_nag2_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_boat_nag2_alt_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//127
		//Felix - Friendly fire.
		SceneTable["web_m2_felix_attack_heli_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_attack_heli_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//128
		//Felix - Friendly fire again.
		SceneTable["web_m2_felix_attack_heli_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_attack_heli_02.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//129
		//Felix - Boat escape.
		SceneTable["web_m2_felix_boat_escape_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_boat_escape_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//130
		//Felix - Boat dead.
		SceneTable["web_m2_felix_boat_destroy_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_boat_destroy_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		//131
		//Felix - Fin.
		SceneTable["web_m2_felix_reach_heli_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/valeria/web_m2_felix_reach_heli_01.vcd"),postdelay=0.00,next=null,char="radiovoice",predelay=0.00}
		
		
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
	
if (curMapName=="coop_kasbah" && self.GetName() == "@franz")
	{
		printl(self.GetName() + " INCLUDING COOPRADIO SCENE TABLE FRANZ!!!!" );

		//16
		//Franz - Well hello… now this is a fascinating situation.  It's rare to have visitors here of their own volition, though seeing the source of this interruption I suppose I shouldn't be surprised... Felix truly has an eye for talent, doesn't he.  But defeating Valeria's idealogues is one thing... survivng against proper killers is quite another.   
		SceneTable["web_franz_mission_enter_cellblock_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_enter_cellblock_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}	
		
		//17
		//Franz - Attention! Whomever brings me the head of these intruders will be granted their freedom.
		SceneTable["web_franz_mission_cellblock_pre_fight_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_cellblock_pre_fight_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//18
		//Franz - Let's see who the lucky winnner is..
		SceneTable["web_franz_mission_cellblock_post_fight_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_cellblock_post_fight_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//19
		//Franz - Hm. Impressive.  Your talents are wasted by serving Felix, you have so much more potentional.  If you survive, perhaps I can show you what you're really capable of.
		SceneTable["web_franz_mission_cellblock_post_fight_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_cellblock_post_fight_02.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//20
		//Franz - And so you've found what you were looking for.  But consider this: Why do you think Felix knows so much about this place?  Perhaps you don't have the whole story.  Perhaps I am not the demon he is making me out to be.  
		SceneTable["web_franz_mission_find_sample_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_find_sample_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//21
		//Franz - It's really not in your best interest to leave.  Stay.  Return the sample.  Join my experiments, and if you emerge victorious I will show you how the world truly works.  You could be so much more than Felix's catspaw.
		SceneTable["web_franz_mission_leave_tunnels_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_leave_tunnels_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//23
		//Franz - Attention! Stop these intruders, or find yourself in the next round of experiments.
		SceneTable["web_franz_mission_lz_fight_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_lz_fight_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//24
		//Franz - Maybe I’m not motivating you properly. This should help.
		SceneTable["web_franz_mission_lz_fight_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_lz_fight_02.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//25
		//Franz - Stop them!
		SceneTable["web_franz_mission_coast_run_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_coast_run_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//26
		//Franz - Stop them! variation
		SceneTable["web_franz_mission_coast_run_02"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_coast_run_02.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//27
		//Franz - Stop them! variation
		SceneTable["web_franz_mission_coast_run_03"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_franz_mission_coast_run_03.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//50
		//Franz - Attention.  Our pest problem has been dealt with.  Cleanup crews are to report to section alpha immediately and initiate ventilation purge protocols. That is all.
		SceneTable["web_m2_felix_cleanup_crew_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_m2_felix_cleanup_crew_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//51
		//Franz - Felix truly has trained you well, but in the end it's all for naught.  I will not be taken.  Not today.  Not ever.
		SceneTable["web_m2_felix_corridor_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_m2_felix_corridor_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//52
		//Franz - My friend, you didn't think you were actually escaping did you?  Make no mistake:  I am still in control here… and this place will be your tomb.
		SceneTable["web_m2_felix_escape_elevator_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_m2_felix_escape_elevator_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//53
		//Franz - Mein Gott, who disabled the ventilation purge? Start it back up again before this place fills up with noxious gas! 
		SceneTable["web_m2_felix_fans_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_m2_felix_fans_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//54
		//Franz - Well look what crawled out of the basement.  I must commend you, you are most resilient.  Sadly, this is where your story comes to a close.  Guards.  Kill them.
		SceneTable["web_m2_felix_outside_office_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_m2_felix_outside_office_alt_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}
		
		//55
		//Franz - Oh it's been fun…but it's time for me to say good bye.
		SceneTable["web_m2_felix_taunt_alt_01"] <- {vcd=CreateSceneEntity("scenes/coop_radio/kasbah/web_m2_felix_taunt_alt_01.vcd"),postdelay=0.00,next=null,char="franz",predelay=0.00}

	}


SceneTableLookup <- {}
if (curMapName=="coop_kasbah" && self.GetName() == "@radiovoice")
	{
		printl(self.GetName() + " POPULATING LIST!!!!" );
		SceneTableLookup[1] <- "web_felix_mission_intro_01"
		SceneTableLookup[2] <- "web_felix_mission_deployed_01"
		SceneTableLookup[3] <- "web_felix_mission_kasbah_01"
		SceneTableLookup[4] <- "web_felix_mission_find_tunnels_01"
		SceneTableLookup[5] <- "web_felix_mission_enter_tunnels_01"
		SceneTableLookup[6] <- "web_felix_mission_broke_radio_01"
		SceneTableLookup[7] <- "web_felix_mission_find_sample_01"
		SceneTableLookup[8] <- "web_felix_mission_leave_tunnels_01"
		SceneTableLookup[9] <- "web_felix_mission_radar_station_01"
		SceneTableLookup[10] <- "web_felix_mission_lz_holdout_01"
		SceneTableLookup[11] <- "web_felix_mission_missile_01"
		SceneTableLookup[12] <- "web_felix_mission_new_lz_01"
		SceneTableLookup[13] <- "web_felix_mission_new_lz_02"
		SceneTableLookup[14] <- "web_felix_mission_helicopter_close_01"
		SceneTableLookup[15] <- "web_felix_mission_helicopter_close_02"
		SceneTableLookup[28] <- "web_felix_mission_complete_01"
		SceneTableLookup[100] <- "web_m2_felix_briefing_01"
		SceneTableLookup[101] <- "web_m2_felix_mission_start_01"
		SceneTableLookup[102] <- "web_m2_felix_virus_01"
		SceneTableLookup[103] <- "web_m2_felix_find_entrance_01"
		SceneTableLookup[104] <- "web_m2_felix_enter_facility_01"
		SceneTableLookup[105] <- "web_m2_felix_plant_bomb1_01"
		SceneTableLookup[106] <- "web_m2_felix_plant_bomb1_alt_01"
		SceneTableLookup[107] <- "web_m2_felix_plant_bomb2_01"
		SceneTableLookup[108] <- "web_m2_felix_all_bombs_planted"
		SceneTableLookup[109] <- "web_m2_felix_c4_nag_01"
		SceneTableLookup[110] <- "web_m2_felix_c4_nag_alt_01"
		SceneTableLookup[111] <- "web_m2_felix_wakeup_alt_01"
		SceneTableLookup[112] <- "web_m2_felix_wakeup2_01"
		SceneTableLookup[113] <- "web_m2_felix_elevator_01"
		SceneTableLookup[114] <- "web_m2_felix_find_fire_01"
		SceneTableLookup[115] <- "web_m2_felix_find_valve_01"
		SceneTableLookup[116] <- "web_m2_felix_use_valve_01"
		SceneTableLookup[117] <- "web_m2_felix_use_smoke_alt_01"
		SceneTableLookup[118] <- "web_m2_felix_use_smoke_early_alt_01"
		SceneTableLookup[119] <- "web_m2_felix_find_tunnel_01"
		SceneTableLookup[120] <- "web_m2_felix_use_fan_01"
		SceneTableLookup[121] <- "web_m2_felix_find_office_01"
		SceneTableLookup[122] <- "web_m2_felix_enter_office_01"
		SceneTableLookup[123] <- "web_m2_felix_find_exit_01"
		SceneTableLookup[124] <- "web_m2_felix_overlook_01"
		SceneTableLookup[125] <- "web_m2_felix_boat_nag2_01"
		SceneTableLookup[126] <- "web_m2_felix_boat_nag2_alt_01"
		SceneTableLookup[127] <- "web_m2_felix_attack_heli_01"
		SceneTableLookup[128] <- "web_m2_felix_attack_heli_02"
		SceneTableLookup[129] <- "web_m2_felix_boat_escape_01"
		SceneTableLookup[130] <- "web_m2_felix_boat_destroy_01"
		SceneTableLookup[131] <- "web_m2_felix_reach_heli_01"
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
	
if (curMapName=="coop_kasbah" && self.GetName() == "@franz")
	{
		printl(self.GetName() + " POPULATING LIST!!!!" );
		SceneTableLookup[16] <- "web_franz_mission_enter_cellblock_01"
		SceneTableLookup[17] <- "web_franz_mission_cellblock_pre_fight_01"
		SceneTableLookup[18] <- "web_franz_mission_cellblock_post_fight_01"
		SceneTableLookup[19] <- "web_franz_mission_cellblock_post_fight_02"
		SceneTableLookup[20] <- "web_franz_mission_find_sample_01"
		SceneTableLookup[21] <- "web_franz_mission_leave_tunnels_01"
		SceneTableLookup[23] <- "web_franz_mission_lz_fight_01"
		SceneTableLookup[24] <- "web_franz_mission_lz_fight_02"
		SceneTableLookup[25] <- "web_franz_mission_coast_run_01"
		SceneTableLookup[26] <- "web_franz_mission_coast_run_02"
		SceneTableLookup[27] <- "web_franz_mission_coast_run_03"
		SceneTableLookup[50] <- "web_m2_felix_cleanup_crew_01"
		SceneTableLookup[51] <- "web_m2_felix_corridor_01"
		SceneTableLookup[52] <- "web_m2_felix_escape_elevator_01"
		SceneTableLookup[53] <- "web_m2_felix_fans_01"
		SceneTableLookup[54] <- "web_m2_felix_outside_office_alt_01"
		SceneTableLookup[55] <- "web_m2_felix_taunt_alt_01"
		printl ("Length of SceneTableLookup: " + SceneTableLookup.len() );
	}