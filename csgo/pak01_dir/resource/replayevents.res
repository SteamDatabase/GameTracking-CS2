//=========== (C) Copyright 1999 Valve, L.L.C. All rights reserved. ===========
//
// The copyright to the contents herein is the property of Valve, L.L.C.
// The contents may be used and/or copied only with the written permission of
// Valve, L.L.C., or in accordance with the terms and conditions stipulated in
// the agreement/contract under which the contents have been supplied.
//=============================================================================

// Don't change "server_*" events 
// No spaces in event names, max length 32
// All strings are case sensitive
//
// valid data key types are:
//   string : a zero terminated string
//   bool   : unsigned int, 1 bit
//   byte   : unsigned int, 8 bit
//   short  : signed int, 16 bit
//   long   : signed int, 32 bit
//   float  : float, 32 bit
//   local : any data, dont network this field
//
// following keys names are reserved:
//   local      : if set to 1, event is not networked to clients
//   reliable   : if set to 0, event is networked unreliable


"replayevents"
{

//////////////////////////////////////////////////////////////////////
// replay specific events
//////////////////////////////////////////////////////////////////////
	
	"replay_status"				// general replay status
	{
		"clients"	"long"		// number of replay spectators
		"slots"		"long"		// number of replay slots
		"proxies"	"short"		// number of replay proxies
		"master"	"string"	// disptach master IP:port
	}
	
	"replay_cameraman"			// a spectator/player is a cameraman
	{
		"index"		"short"			// camera man entity index
	}
	
	"replay_rank_camera"			// a camera ranking
	{
		"index"		"byte"			// fixed camera index
		"rank"		"float"			// ranking, how interesting is this camera view
		"target"	"short"			// best/closest target entity
	}
	
	"replay_rank_entity"			// an entity ranking
	{
		"index"		"short"			// entity index
		"rank"		"float"			// ranking, how interesting is this entity to view
		"target"	"short"			// best/closest target entity
	}
	
	"replay_fixed"				// show from fixed view
	{
		"posx"		"long"		// camera position in world
		"posy"		"long"		
		"posz"		"long"		
		"theta"		"short"		// camera angles
		"phi"			"short"		
		"offset"	"short"
		"fov"			"float"
		"target"	"short"		// follow this entity or 0
	}
	
	"replay_chase"					// shot of a single entity
	{
		"target1"		"short"		// primary traget index 
		"target2"		"short"		// secondary traget index or 0
		"distance"	"short"		// camera distance
		"theta"			"short"		// view angle horizontal 
		"phi"				"short"		// view angle vertical
		"inertia"		"byte"		// camera inertia
		"ineye"			"byte"		// diretcor suggests to show ineye
	}
	
	"replay_message"	// a replay message send by moderators
	{
		"text"	"string"
	}
	
	"replay_title"
	{
		"text"	"string"
	}
	
	"replay_chat"	// a replay chat msg send by spectators
	{
		"text"	"string"
	}
}