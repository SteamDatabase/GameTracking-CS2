"GameInfo"
{
	game 		"Core"
	title 		"Core"
	type		singleplayer_only

	FileSystem
	{
		SteamAppId				890		// This will mount all the GCFs we need (240=CS:S, 220=HL2).
		ToolsAppId				895		// Tools will load this (ie: source SDK caches) to get things like materials\debug, materials\editor, etc.
		
		//
		// The code that loads this file automatically does a few things here:
		//
		// 1. For each "Game" search path, it adds a "GameBin" path, in <dir>\bin
		// 2. For each "Game" search path, it adds another "Game" path in front of it with _<langage> at the end.
		//    For example: c:\hl2\cstrike on a french machine would get a c:\hl2\cstrike_french path added to it.
		// 3. For the first "Game" search path, it adds a search path called "MOD".
		// 4. For the first "Game" search path, it adds a search path called "DEFAULT_WRITE_PATH".
		//

		//
		// Search paths are relative to the exe directory\..\
		//
		SearchPaths
		{
			Game				core
			Mod					core
		}
	}
	
	MaterialSystem2
	{
		RenderModes
		{
			"game" "Default"
			"game" "Depth"
			"game" "ProjectionDepth"
			"game" "PrepassLight"
			"game" "FullDeferredLight"	
			"game" "DeferredGather"			
			"game" "Forward"

			"tools" "ToolsVis" // Visualization modes for all shaders (lighting only, normal maps only, etc.)
			"tools" "ToolsWireframe" // This should use the ToolsVis mode above instead of being its own mode
			"tools" "ToolsUtil" // Meant to be used to render tools sceneobjects that are mod-independent, like the origin grid
		}
	}
	
	Engine2
	{
		"HasModAppSystems" "0"
		"Capable64Bit" "1"
	}
	
	ToolsEnvironment
	{
		"Engine"	"Source 2"
		"ToolsDir"	"../sdktools"	// NOTE: Default Tools path. This is relative to the mod path.
	}
	
	Hammer
	{
		"fgd"					"base.fgd"	// NOTE: This is relative to the 'mod' path.
		"DefaultTextureScale"	"0.250000"
		"DefaultSolidEntity"	"trigger_multiple"
		"DefaultPointEntity"	"info_player_start"
		"NavMarkupEntity"		"func_nav_markup"
	}

	SoundTool
	{
		"DefaultSoundEventType" "core_simple_3d"
	}

	RenderPipelineAliases
	{
		"Tools"			"Forward"
		"EnvMapBake"	"Forward"
	}
	ResourceCompiler
	{

		SoundStackScripts
		{
			CompilerVersion "1"
//			CompileForCompare "1"
		}
	}

	ModelDoc
	{
		"models_gamedata"	"models_base.fgd"
		"features"			"animgraph"
	}
}
