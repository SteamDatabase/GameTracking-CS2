//=========== (C) Copyright 1999 Valve, L.L.C. All rights reserved. ===========
//
// The copyright to the contents herein is the property of Valve, L.L.C.
// The contents may be used and/or copied only with the written permission of
// Valve, L.L.C., or in accordance with the terms and conditions stipulated in
// the agreement/contract under which the contents have been supplied.
//=============================================================================

// No spaces in event names, max length 32
// All strings are case sensitive
// total game event byte length must be < 1024
//
// valid data key types are:
//   none   : value is not networked
//   string : a zero terminated string
//   wstring: a zero terminated wide char string
//   bool   : unsigned int, 1 bit
//   byte   : unsigned int, 8 bit
//   short  : signed int, 16 bit
//   long   : signed int, 32 bit
//   float  : float, 32 bit

"cstrikeevents"
{
	"player_death"				// a game event, name may be 32 characters long
	{
		// this extents the original player_death by a new fields
		"userid"		"short"   	// user ID who died			
		"attacker"		"short"	 	// user ID who killed
		"assister"		"short"	 	// user ID who assisted in the kill
		"weapon"		"string" 	// weapon name killer used 
		"weapon_itemid"	"string"	// inventory item id of weapon killer used
		"weapon_fauxitemid"	"string"	// faux item id of weapon killer used
		"weapon_originalowner_xuid"	"string"
		"headshot"		"bool"		// singals a headshot
		"dominated"		"short"		// did killer dominate victim with this kill
		"revenge"		"short"		// did killer get revenge on victim with this kill
		"penetrated"	"short"	// number of objects shot penetrated before killing target
		"noreplay"		"bool"  // if replay data is unavailable, this will be present and set to false
	}

	"other_death"
	{
		"otherid"		"short"   	// other entity ID who died			
		"othertype"		"string"   	// other entity type
		"attacker"		"short"	 	// user ID who killed
		"weapon"		"string" 	// weapon name killer used 
		"weapon_itemid"	"string"	// inventory item id of weapon killer used
		"weapon_fauxitemid"	"string"	// faux item id of weapon killer used
		"weapon_originalowner_xuid"	"string"
		"headshot"		"bool"		// singals a headshot
		"penetrated"	"short"	// number of objects shot penetrated before killing target
	}

	"player_hurt"
	{
		"userid"	"short"   	// player index who was hurt
		"attacker"	"short"	 	// player index who attacked
		"health"	"byte"		// remaining health points
		"armor"		"byte"		// remaining armor points
		"weapon"	"string"	// weapon name attacker used, if not the world
		"dmg_health"	"short"	// damage done to health
		"dmg_armor"	"byte"		// damage done to armor
		"hitgroup"	"byte"		// hitgroup that was damaged
	}

	"item_purchase"
	{

		"userid"	"short"
		"team"		"short"
		"loadout"	"short"
		"weapon"	"string"
	}	

	"bomb_beginplant"
	{
		"userid"	"short"		// player who is planting the bomb
		"site"		"short"		// bombsite index
	}

	"bomb_abortplant"
	{
		"userid"	"short"		// player who is planting the bomb
		"site"		"short"		// bombsite index
	}

	"bomb_planted"
	{
		"userid"	"short"		// player who planted the bomb
		"site"		"short"		// bombsite index
	}
	
	"bomb_defused"
	{
		"userid"	"short"		// player who defused the bomb
		"site"		"short"		// bombsite index
	}
	
	"bomb_exploded"
	{
		"userid"	"short"		// player who planted the bomb
		"site"		"short"		// bombsite index
	}
	
	"bomb_dropped"
	{
		"userid"	"short"		// player who dropped the bomb
		"entindex"	"long"
	}
	
	"bomb_pickup"
	{
		"userid"	"short"		// player who picked up the bomb
	}

	"defuser_dropped"
	{
		"entityid"	"long"		// defuser's entity ID
	}
	
	"defuser_pickup"
	{
		"entityid"	"long"		// defuser's entity ID
		"userid"	"short"		// player who picked up the defuser
	}
	
	"announce_phase_end"
	{
	}
	
	"cs_intermission"
	{
	}

	"bomb_begindefuse"
	{
		"userid"	"short"		// player who is defusing
		"haskit"	"bool"
	}

	"bomb_abortdefuse"
	{
		"userid"	"short"		// player who was defusing
	}

	"hostage_follows"
	{
		"userid"	"short"		// player who touched the hostage
		"hostage"	"short"		// hostage entity index
	}
	
	"hostage_hurt"
	{
		"userid"	"short"		// player who hurt the hostage
		"hostage"	"short"		// hostage entity index
	}
	
	"hostage_killed"
	{
		"userid"	"short"		// player who killed the hostage
		"hostage"	"short"		// hostage entity index
	}
	
	"hostage_rescued"
	{
		"userid"	"short"		// player who rescued the hostage
		"hostage"	"short"		// hostage entity index
		"site"		"short"		// rescue site index
	}

	"hostage_stops_following"
	{
		"userid"	"short"		// player who rescued the hostage
		"hostage"	"short"		// hostage entity index
	}

	"hostage_rescued_all"
	{
	}

	"hostage_call_for_help"
	{
		"hostage"	"short"		// hostage entity index
	}
	
	"vip_escaped"
	{
		"userid"	"short"		// player who was the VIP
	}

	"vip_killed"
	{
		"userid"		"short"		// player who was the VIP
		"attacker"	"short"	 	// user ID who killed the VIP
	}

	"player_radio"
	{
		"userid"	"short"
		"slot"		"short"
	}

	"bomb_beep"
	{
		"entindex"	"long"		// c4 entity
	}

	"weapon_fire"
	{
		"userid"	"short"
		"weapon"	"string" 	// weapon name used
		"silenced"	"bool"		// is weapon silenced
	}

	"weapon_fire_on_empty"
	{
		"userid"	"short"
		"weapon"	"string" 	// weapon name used
	}

	"grenade_thrown"
	{
		"userid"	"short"
		"weapon"	"string" 	// weapon name used
	}

	"weapon_outofammo"
	{
		"userid"	"short"
	}

	"weapon_reload"
	{
		"userid"	"short"
	}

	"weapon_zoom"
	{
		"userid"	"short"
	}

	"silencer_detach"
	{
		"userid"	"short"
	}
	
	"inspect_weapon"
	{
		"userid"	"short"
	}
	
	// exists for the game instructor to let it know when the player zoomed in with a regular rifle
	// different from the above weapon_zoom because we don't use this event to notify bots
	"weapon_zoom_rifle"
	{
		"userid"	"short"
	}

	"player_spawned"
	{
		"userid"	"short"
		"inrestart" "bool"		// true if restart is pending
	}

	"item_pickup"
	{
		"userid"	"short"
		"item"		"string"	// either a weapon such as 'tmp' or 'hegrenade', or an item such as 'nvgs'
		"silent"	"bool"
		"defindex"	"long"
	}

	"item_remove"
	{
		"userid"	"short"
		"item"		"string"	// either a weapon such as 'tmp' or 'hegrenade', or an item such as 'nvgs'
		"defindex"	"long"
	}

	"ammo_pickup"
	{
		"userid"	"short"
		"item"		"string"	// either a weapon such as 'tmp' or 'hegrenade', or an item such as 'nvgs'
		"index"		"long"		// the weapon entindex
	}

	"item_equip"
	{
		"userid"		"short"
		"item"			"string"	// either a weapon such as 'tmp' or 'hegrenade', or an item such as 'nvgs'
		"defindex"		"long"
		"canzoom"		"bool"
		"hassilencer"	"bool"
		"issilenced"	"bool"
		"hastracers"	"bool"
		"weptype"		"short"
				//WEAPONTYPE_UNKNOWN		=	-1
				//WEAPONTYPE_KNIFE			=	0	
				//WEAPONTYPE_PISTOL			=	1
				//WEAPONTYPE_SUBMACHINEGUN	=	2
				//WEAPONTYPE_RIFLE			=	3
				//WEAPONTYPE_SHOTGUN		=	4
				//WEAPONTYPE_SNIPER_RIFLE	=	5
				//WEAPONTYPE_MACHINEGUN		=	6
				//WEAPONTYPE_C4				=	7
				//WEAPONTYPE_GRENADE		=	8
				//
		"ispainted"	"bool"
	}

	"enter_buyzone"
	{
		"userid"	"short"
		"canbuy"	"bool"
	}

	"exit_buyzone"
	{
		"userid"	"short"
		"canbuy"	"bool"
	}

	"buytime_ended"
	{
	}

	"enter_bombzone"
	{
		"userid"	"short"
		"hasbomb"	"bool"
		"isplanted"	"bool"
	}

	"exit_bombzone"
	{
		"userid"	"short"
		"hasbomb"	"bool"
		"isplanted"	"bool"
	}

	"enter_rescue_zone"
	{
		"userid"	"short"
	}

	"exit_rescue_zone"
	{
		"userid"	"short"
	}

	"silencer_off"
	{
		"userid"	"short"
	}

	"silencer_on"
	{
		"userid"	"short"
	}

	"buymenu_open"
	{
		"userid"	"short"
	}

	"buymenu_close"
	{
		"userid"	"short"
	}

	"round_prestart"			// sent before all other round restart actions
	{
	}
	
	"round_poststart"			// sent after all other round restart actions
	{
	}
	
	"round_start"
	{
		"timelimit"	"long"		// round time limit in seconds
		"fraglimit"	"long"		// frag limit in seconds
		"objective"	"string"	// round objective
	}

	
	"round_end"
	{
		"winner"	"byte"		// winner team/user i
		"reason"	"byte"		// reson why team won
		"message"	"string"	// end round message 
		"legacy"	"byte"		// server-generated legacy value
		"player_count"	"short"		// total number of players alive at the end of round, used for statistics gathering, computed on the server in the event client is in replay when receiving this message
	}

	"grenade_bounce"
	{
		"userid"	"short"
	}

	"hegrenade_detonate"
	{
		"userid"	"short"
		"entityid"	"short"
	        "x"        "float"
	        "y"        "float"
	        "z"        "float"
	}

	"flashbang_detonate"
	{
		"userid"	"short"
		"entityid"	"short"
	        "x"        "float"
	        "y"        "float"
	        "z"        "float"
	}

	"smokegrenade_detonate"
	{
		"userid"	"short"
		"entityid"	"short"
	        "x"        "float"
	        "y"        "float"
	        "z"        "float"
	}

	"smokegrenade_expired"
	{
		"userid"	"short"
		"entityid"	"short"
	        "x"        "float"
	        "y"        "float"
	        "z"        "float"
	}

	"molotov_detonate"
	{
		"userid"	"short"
        "x"        "float"
        "y"        "float"
        "z"        "float"
	}

	"decoy_detonate"
	{
		"userid"	"short"
		"entityid"	"short"
		"x"        "float"
		"y"        "float"
		"z"        "float"
	}
	
	"decoy_started"
	{
		"userid"	"short"
		"entityid"	"short"
		"x"        "float"
		"y"        "float"
		"z"        "float"
	}

	"tagrenade_detonate"
	{
		"userid"	"short"
		"entityid"	"short"
		"x"        "float"
		"y"        "float"
		"z"        "float"
	}

	"inferno_startburn"
	{
		"entityid"	"short"
		"x"        "float"
		"y"        "float"
		"z"        "float"
	}

	"inferno_expire"
	{
		"entityid"	"short"
		"x"        "float"
		"y"        "float"
		"z"        "float"
	}

	"inferno_extinguish"
	{
		"entityid"	"short"
		"x"        "float"
		"y"        "float"
		"z"        "float"
	}	
	
	"decoy_firing"
	{
		"userid"	"short"
		"entityid"	"short"
		"x"        "float"
		"y"        "float"
		"z"        "float"
	}

	"bullet_impact"
	{
		"userid"	"short"
		"x"		"float"
		"y"		"float"
		"z"		"float"
	}

	"player_footstep"
	{
		"userid"	"short"
	}

	"player_jump"
	{
		"userid"	"short"
	}

	"player_blind"
	{
		"userid"	"short"
		"attacker"		"short"	 	// user ID who threw the flash 
		"entityid"		"short"		// the flashbang going off
		"blind_duration"	"float"
	}

	"player_falldamage"
	{
		"userid"	"short"
		"damage"	"float"
	}

	"door_moving"
	{
		"entindex"	"long"
		"userid"		"short"
	}

	"round_freeze_end"
	{
	}
	
	"mb_input_lock_success"
	{
	}
	
	"mb_input_lock_cancel"
	{
	}

	"nav_blocked"
	{
		"area"		"long"
		"blocked"	"bool"
	}

	"nav_generate"
	{
	}
	
	"player_stats_updated"
	{
		"forceupload"	"bool"
	}

	"achievement_info_loaded"
	{
	}

	"spec_target_updated"
	{
		"userid"	"byte"		// entindex of the player
	}

	"spec_mode_updated"
	{
		"userid"	"byte"		// entindex of the player
	}
	
	"hltv_changed_mode"
	{
		"oldmode"		"long"
		"newmode"		"long"
		"obs_target"	"long"
	}

	"cs_game_disconnected"
	{
	}
	
	"cs_win_panel_round"
	{
		"show_timer_defend"	"bool"
		"show_timer_attack"	"bool"
		"timer_time"		"short"
		
		"final_event"		"byte"		//define in cs_gamerules.h
		
		"funfact_token"		"string"
		"funfact_player"	"short"
		"funfact_data1"		"long"
		"funfact_data2"		"long"
		"funfact_data3"		"long"
	}
	
	"cs_win_panel_match"			
	{
	}
	
	"cs_match_end_restart"
	{
	}
	"cs_pre_restart"
	{
	}
	
	"show_freezepanel"
	{
		"victim"	"short"		// endindex of the one who was killed
		"killer"	"short"		// entindex of the killer entity
		"hits_taken"	"short"
		"damage_taken"	"short"
		"hits_given"	"short"
		"damage_given"	"short"
	}

	"hide_freezepanel"
	{
	}

	"freezecam_started"
	{
	}
	
	"player_avenged_teammate"
	{
		"avenger_id"			"short"
		"avenged_player_id"		"short"
	}
	
	"achievement_earned"
	{
		"player"	"byte"		// entindex of the player
		"achievement"	"short"		// achievement ID
	}
	
	"achievement_earned_local"
	{		
		"achievement"			"short"		// achievement ID
		"splitscreenplayer"		"short"		// splitscreen ID
	}

	"item_found"
	{
		"player"		"byte"		// entindex of the player
		"quality"		"byte"		// quality of the item
		"method"		"byte"		// method by which we acquired the item
		"itemdef"		"long"		// the item definition index
		"itemid"		"long"		// the item id in the players inventory
	}

	"items_gifted"
	{
		"player"		"byte"		// entindex of the player who sent the gift
		"itemdef"		"long"		// the item definition index of the gift that was opened
		"numgifts"		"byte"		// how many recipients got the gifts in this gift batch
		"giftidx"		"byte"		// index of recipient in this gift batch (0 for the first recipient, 1 for second, and so on...)
		"accountid"		"long"		// gift recipient's account ID
	}

	"repost_xbox_achievements"
	{
		"splitscreenplayer"		"short"		// splitscreen ID
	}
	
	"match_end_conditions"
	{
		"frags"			"long"
		"max_rounds"	"long"
		"win_rounds"	"long"
		"time"			"long"
	}
	
	"round_mvp"
	{
		"userid"		"short"
		"reason"		"short"
		"musickitmvps"	"long"
	}
	
	"player_decal"
	{
		"userid"	"short"
	}
	
	"teamplay_round_start"			// round restart
	{
		"full_reset"	"bool"		// is this a full reset of the map
	}

	"client_disconnect"
	{
	}
		
	"gg_player_levelup"
	{
		"userid"	"short"		// player who leveled up
		"weaponrank"	"short"
		"weaponname"	"string"	// name of weapon being awarded
	}
	
	"ggtr_player_levelup"
	{
		"userid"	"short"		// player who leveled up
		"weaponrank"	"short"
		"weaponname"	"string"	// name of weapon being awarded
	}

	"assassination_target_killed"
	{
		"target"		"short"		// player killed
		"killer"		"short"		// killing player (with the quest)
	}
	
	"ggprogressive_player_levelup"
	{
		"userid"	"short"		// player who leveled up
		"weaponrank"	"short"
		"weaponname"	"string"	// name of weapon being awarded
	}
	
	"gg_killed_enemy"
	{
		"victimid"	"short"   	// user ID who died				
		"attackerid"	"short"	 	// user ID who killed
		"dominated"	"short"		// did killer dominate victim with this kill
		"revenge"	"short"		// did killer get revenge on victim with this kill
		"bonus"	"bool"		// did killer kill with a bonus weapon?
	}
	
	"gg_final_weapon_achieved"
	{
		"playerid"	"short"	 	// user ID who achieved the final gun game weapon
	}

	"gg_bonus_grenade_achieved"
	{
		"userid"	"short"	 	// user ID who achieved the bonus grenade
	}

	"switch_team"
	{
		"numPlayers"	"short"	// number of active players on both T and CT
		"numSpectators"	"short"	// number of spectators
		"avg_rank"		 "short" // average rank of human players
		"numTSlotsFree"	 "short"
		"numCTSlotsFree" "short"
	}

	"gg_leader"
	{
		"playerid"	"short"	 	// user ID that is currently in the lead
	}

	"gg_team_leader"
	{
		"playerid"	"short"	 	// user ID that is currently in the lead
	}

	"gg_player_impending_upgrade"
	{
		"userid"	"short"		// player who will be leveling up
	}
	
	"write_profile_data"
	{
	}


	// fired when a player runs out of time in trial mode
	"trial_time_expired"
	{
		"slot"		"short"		// player whose time has expired
	}

	// Fired when it's time to update matchmaking data at the end of a round.
	"update_matchmaking_stats"
	{
	}

	"player_reset_vote"
	{
		"userid"	"short"
		"vote"		"bool"
	}

	"enable_restart_voting"
	{		
		"enable"	"bool"
	}

	"sfuievent"
	{
		"action" "string"
		"data" "string"
		"slot" "byte"
	}

	"start_vote"
	{
		"userid"	"short"		// user ID on server
		"type" "byte"
		"vote_parameter" "short"
	}

	"player_given_c4"
	{
		"userid"	"short"	 	// user ID who received the c4
	}

	"gg_reset_round_start_sounds"
	{
		"userid"	"short"	 	// user ID who should have round start sounds reset
	}

	"tr_player_flashbanged"
	{
		"userid"	"short"	 	// user ID of the player banged
	}

	// not used yet because this relied on vgui panels, scaleform isn't supported yet
	//"tr_highlight_ammo"
	//{
	//	"userid"	"short"	 	// user ID of the player
	//}

	"tr_mark_complete"
	{
		"complete" "short"
	}

	"tr_mark_best_time"
	{
		"time"		"long"
	}

	"tr_exit_hint_trigger"
	{
	}

	"bot_takeover"
	{
		"userid"	"short"
		"botid"		"short"
		"index"     "short"
	}
	
	"tr_show_finish_msgbox"
	{
		"userid"	"short"	 	// user ID of the player
	}
	"tr_show_exit_msgbox"
	{
		"userid"	"short"	 	// user ID of the player
	}

	"reset_player_controls"		// used for demos
	{
	}

	"jointeam_failed"
	{
		"userid"	"short"
		"reason"	"byte"		// 0 = team_full
	}

	"teamchange_pending"
	{
		"userid"	"short"
		"toteam"    "byte"
	}
	
	"material_default_complete"
	{
	}

	"cs_prev_next_spectator"
	{
		"next" "bool"
	}

	"cs_handle_ime_event"
	{
		"local" "1"
		"eventtype" "string"
		"eventdata" "wstring"
	}

	"nextlevel_changed"				// a game event, name may be 32 characters long
	{
		"nextlevel"	"string" 	// weapon name killer used 
	}

	"seasoncoin_levelup"
	{
		"player"	"short"		// entindex of the player
		"category"	"short"
		"rank"		"short"
	}

	"tournament_reward"
	{
		"defindex"		"long"
		"totalrewards"	"long"
		"accountid"		"long"
	}
	"start_halftime"
	{
	}
}
