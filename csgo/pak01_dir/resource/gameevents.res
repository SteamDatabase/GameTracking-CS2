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
//   bool   : unsigned int, 1 bit
//   byte   : unsigned int, 8 bit
//   short  : signed int, 16 bit
//   long   : signed int, 32 bit
//   float  : float, 32 bit



"gameevents"
{
	"team_info"				// info about team
	{
		"teamid"	"byte"		// unique team id
		"teamname"	"string"	// team name eg "Team Blue"
	}
	
	"team_score"				// team score changed
	{
		"teamid"	"byte"		// team id
		"score"		"short"		// total team score
	}
	
	"teamplay_broadcast_audio"	// emits a sound to everyone on a team
	{
		"team"	"byte"			// unique team id
		"sound"	"string"		// name of the sound to emit
	}

	"gameui_hidden"
	{}

	"items_gifted"
	{
		"player"	"short"		// entity used by player
		"itemdef"	"long"
		"numgifts"	"short"
		"giftidx"	"long"
		"accountid"	"long"
	}
	
//////////////////////////////////////////////////////////////////////
// Player events
//////////////////////////////////////////////////////////////////////
	
	"player_team"				// player change his team
	{
		"userid"	"short"		// user ID on server
		"team"		"byte"		// team id
		"oldteam" "byte"		// old team id
		"disconnect" "bool"	// team change because player disconnects
		"autoteam" "bool"		// true if the player was auto assigned to the team
		"silent" "bool"			// if true wont print the team join messages
		"isbot"	"bool"			// true if player is a bot
	}
	
	"player_class"				// a player changed his class
	{
		"userid"	"short"		// user ID on server
		"class"		"string"	// new player class / model
	}
	
	"player_death"				// a game event, name may be 32 charaters long
	{
		"userid"	"short"   	// user ID who died				
		"attacker"	"short"	 	// user ID who killed
	}
	
	"player_hurt"
	{
		"userid"	"short"   	// player index who was hurt				
		"attacker"	"short"	 	// player index who attacked
		"health"	"byte"		// remaining health points
	}
	
	"player_chat"				// a public player chat
	{
		"teamonly"	"bool"		// true if team only chat
		"userid" 	"short"		// chatting player 
		"text" 	 	"string"	// chat text
	}
	
	"player_score"				// players scores changed
	{
		"userid"	"short"		// user ID on server
		"kills"		"short"		// # of kills
		"deaths"	"short"		// # of deaths
		"score"		"short"		// total game score
	}
	
	"player_spawn"				// player spawned in game
	{
		"userid"	"short"		// user ID on server
		"teamnum"		"short"
	}
	
	"player_shoot"				// player shoot his weapon
	{
		"userid"	"short"		// user ID on server
		"weapon"	"byte"		// weapon ID
		"mode"		"byte"		// weapon mode
	}
	
	"player_use"
	{
		"userid"	"short"		// user ID on server
		"entity"	"short"		// entity used by player
	}

	"player_changename"
	{
		"userid"	"short"		// user ID on server
		"oldname"	"string"	// players old (current) name
		"newname"	"string"	// players new name
	}

	"player_hintmessage"
	{
		"hintmessage"	"string"	// localizable string of a hint
	}

//////////////////////////////////////////////////////////////////////
// Game events
//////////////////////////////////////////////////////////////////////

	"game_init"				// sent when a new game is started
	{
	}
		
	"game_newmap"				// send when new map is completely loaded
	{
		"mapname"	"string"	// map name
	}
	
	"game_start"				// a new game starts
	{
		"roundslimit"	"long"		// max round
		"timelimit"	"long"		// time limit
		"fraglimit"	"long"		// frag limit
		"objective"	"string"	// round objective
	}
	
	"game_end"				// a game ended
	{
		"winner"	"byte"		// winner team/user id
	}
	
	"round_start"
	{
		"timelimit"	"long"		// round time limit in seconds
		"fraglimit"	"long"		// frag limit in seconds
		"objective"	"string"	// round objective
	}

	"round_announce_match_point"
	{
	}

	"round_announce_final"
	{
	}

	"round_announce_last_round_half"
	{
	}

	"round_announce_match_start"
	{
	}

	"round_announce_warmup"
	{
	}
	
	"round_end"
	{
		"winner"	"byte"		// winner team/user i
		"reason"	"byte"		// reson why team won
		"message"	"string"	// end round message 
		"legacy"	"byte"		// server-generated legacy value
	}

	"round_end_upload_stats"			
	{
	}

	"round_officially_ended"
	{
	}

	"round_time_warning"
	{
	}

	"ugc_map_info_received"
	{
		"published_file_id"  "uint64"
	}
	
	"ugc_map_unsubscribed"
	{
		"published_file_id"  "uint64"
	}

	"ugc_map_download_error"
	{
		"published_file_id"  "uint64"
		"error_code"  "long"
	}	
	
	"ugc_file_download_finished"
	{
		"hcontent"  "uint64"				// id of this specific content (may be image or map)
	}

	"ugc_file_download_start"
	{
		"hcontent"  "uint64"				// id of this specific content (may be image or map)
		"published_file_id"  "uint64"				// id of the associated content package
	}
	// Fired when a match ends or is restarted
	"begin_new_match"
	{
	}
	
	"round_start_pre_entity"
	{
	}
	
	"teamplay_round_start"			// round restart
	{
		"full_reset"	"bool"		// is this a full reset of the map
	}
	
	"hostname_changed"
	{
		"hostname"		"string"
	}
	
	"difficulty_changed"
	{
		"newDifficulty"	"short"
		"oldDifficulty"	"short"
		"strDifficulty" "string" // new difficulty as string
	}
	
	"finale_start"
	{
		"rushes"		"short"
	}
	
	"game_message"				// a message send by game logic to everyone
	{
		"target"	"byte"		// 0 = console, 1 = HUD
		"text"		"string"	// the message text
	}

	"dm_bonus_weapon_start"
	{
		"time"		"short"		// The length of time that this bonus lasts
		"Pos"		"short"		// Loadout position of the bonus weapon
	}

//	"survival_announce_player_left"
//	{
//		"alive"		"short"		// The # of players left alive
//	}

	"survival_announce_phase"
	{
		"phase"		"short"		// The phase #
	}

	"break_breakable"
	{
		"entindex"	"long"
		"userid"		"short"
		"material"	"byte"	// BREAK_GLASS, BREAK_WOOD, etc
	}

	"break_prop"
	{
		"entindex"	"long"
		"userid"	"short"
	}

	"player_decal"
	{
		"userid"	"short"
	}

	"entity_killed"
	{
		"entindex_killed" 	"long"
		"entindex_attacker"	"long"
		"entindex_inflictor"	"long"
		"damagebits"		"long"
	}
	
	"bonus_updated"
	{
		"numadvanced"	"short"
		"numbronze"	"short"
		"numsilver"	"short"
		"numgold"	"short"
	}
	
	"player_stats_updated"
	{
		"forceupload"	"bool"
	}
	
	"achievement_event"
	{
		"achievement_name"	"string"	// non-localized name of achievement
		"cur_val"		"short"		// # of steps toward achievement
		"max_val"		"short"		// total # of steps in achievement
	}
	
	// sent whenever an achievement that's tracked on the HUD increases
	"achievement_increment"
	{
		"achievement_id"	"long"	// ID of achievement that went up
		"cur_val"		"short"		// # of steps toward achievement
		"max_val"		"short"		// total # of steps in achievement
	}

	"achievement_earned"
	{
		"player"	"byte"		// entindex of the player
		"achievement"	"short"		// achievement ID
	}

	// Used for a notification message when an achievement fails to write
	"achievement_write_failed"
	{
	}

	"physgun_pickup"
	{
		"entindex"		"long"		// entity picked up
	}

	"flare_ignite_npc"
	{
		"entindex"		"long"		// entity ignited
	}

	"helicopter_grenade_punt_miss"
	{
	}

	"user_data_downloaded"				// fired when achievements/stats are downloaded from Steam or XBox Live
	{
	}

	"ragdoll_dissolved"
	{
		"entindex"	"long"
	}
	
	"gameinstructor_draw"
	{
	}
	
	"gameinstructor_nodraw"
	{
	}
	
	"map_transition"
	{
	}
	
	"entity_visible"
	{
		"userid"		"short"		// The player who sees the entity
		"subject"		"short"		// Entindex of the entity they see
		"classname"		"string"	// Classname of the entity they see
		"entityname"	"string"	// name of the entity they see
	}
	
	"set_instructor_group_enabled"
	{
		"group"		"string"
		"enabled"	"short"
	}
	
	"instructor_server_hint_create" //create a hint using data supplied entirely by the server/map. Intended for hints to smooth playtests before content is ready to make the hint unneccessary. NOT INTENDED AS A SHIPPABLE CRUTCH
	{
		"hint_name"					"string"	// what to name the hint. For referencing it again later (e.g. a kill command for the hint instead of a timeout)
		"hint_replace_key"			"string"	// type name so that messages of the same type will replace each other
		"hint_target"				"long"		// entity id that the hint should display at
		"hint_activator_userid"		"short"		// userid id of the activator
		"hint_timeout"				"short"	 	// how long in seconds until the hint automatically times out, 0 = never
		"hint_icon_onscreen"		"string"	// the hint icon to use when the hint is onscreen. e.g. "icon_alert_red"
		"hint_icon_offscreen"		"string"	// the hint icon to use when the hint is offscreen. e.g. "icon_alert"
		"hint_caption"				"string"	// the hint caption. e.g. "#ThisIsDangerous"
		"hint_activator_caption"	"string"	// the hint caption that only the activator sees e.g. "#YouPushedItGood"
		"hint_color"				"string"	// the hint color in "r,g,b" format where each component is 0-255
		"hint_icon_offset"			"float"		// how far on the z axis to offset the hint from entity origin
		"hint_range"				"float"		// range before the hint is culled
		"hint_flags"				"long"		// hint flags
		"hint_binding"				"string"	// bindings to use when use_binding is the onscreen icon
		"hint_gamepad_binding"		"string"	// gamepad bindings to use when use_binding is the onscreen icon
		"hint_allow_nodraw_target"	"bool"		// if false, the hint will dissappear if the target entity is invisible
		"hint_nooffscreen"			"bool"		// if true, the hint will not show when outside the player view
		"hint_forcecaption"			"bool"		// if true, the hint caption will show even if the hint is occluded
		"hint_local_player_only"	"bool"		// if true, only the local player will see the hint
	}
	
	"instructor_server_hint_stop" //destroys a server/map created hint
	{
		"hint_name"					"string"	// The hint to stop. Will stop ALL hints with this name
	}

	"read_game_titledata"						// read user titledata from profile
	{
		"controllerId"				"short"		// Controller id of user
	}

	"write_game_titledata"						// write user titledata in profile
	{
		"controllerId"				"short"		// Controller id of user
	}

	"reset_game_titledata"						// reset user titledata; do not automatically write profile
	{
		"controllerId"				"short"		// Controller id of user
	}

	
	/////////////////////////////////////////////
	// Client side VoteController talking to HUD
	/////////////////////////////////////////////
	"vote_ended"
	{
	}
	"vote_started"
	{
		"issue"			"string"
		"param1"		"string"
		"team"			"byte"
		"initiator"		"long" // entity id of the player who initiated the vote
	}
	"vote_changed"
	{
		"vote_option1"		"byte"
		"vote_option2"		"byte"
		"vote_option3"		"byte"
		"vote_option4"		"byte"
		"vote_option5"		"byte"
		"potentialVotes"	"byte"
	}
	"vote_passed"
	{
		"details"		"string"
		"param1"		"string"
		"team"			"byte"
	}
	"vote_failed"
	{
		"team"			"byte"
	}
	"vote_cast"
	{
		"vote_option"	"byte"  // which option the player voted on
		"team"			"short"
		"entityid"		"long"	// entity id of the voter
	}
	"vote_options"
	{
		"count"			"byte"	// Number of options - up to MAX_VOTE_OPTIONS
		"option1"		"string"
		"option2"		"string"
		"option3"		"string"
		"option4"		"string"
		"option5"		"string"
	}

	"endmatch_mapvote_selecting_map"
	{
		"count"			"byte"	// Number of "ties"
		"slot1"			"byte"
		"slot2"			"byte"
		"slot3"			"byte"
		"slot4"			"byte"
		"slot5"			"byte"
		"slot6"			"byte"
		"slot7"			"byte"
		"slot8"			"byte"
		"slot9"			"byte"
		"slot10"		"byte"
	}
	
	"endmatch_cmm_start_reveal_items"
	{
	}

//////////////////////////////////////////////////////////////////////
// Economy events
//////////////////////////////////////////////////////////////////////
	"inventory_updated"
	{
	}
	"cart_updated"
	{
	}
	"store_pricesheet_updated"
	{
	}
	"gc_connected"
	{
	}
	"item_schema_initialized"
	{
	}
	"client_loadout_changed"
	{
	}
	
	"add_player_sonar_icon"
	{
		"userid"	"short"
		"pos_x"		"float"
		"pos_y"		"float"
		"pos_z"		"float"
	}
	
//////////////////////////////////////////////////////////////////////
// Debug events
//////////////////////////////////////////////////////////////////////
	"add_bullet_hit_marker"
	{
		"userid"	"short"
		"bone"		"short"
		"pos_x"		"short"
		"pos_y"		"short"
		"pos_z"		"short"
		"ang_x"		"short"
		"ang_y"		"short"
		"ang_z"		"short"
		"start_x"	"short"
		"start_y"	"short"
		"start_z"	"short"
		"hit"		"bool"
	}
	
	"verify_client_hit"
	{
		"userid"		"short"
		"pos_x"			"float"
		"pos_y"			"float"
		"pos_z"			"float"
		"timestamp"		"float"
	}
}
