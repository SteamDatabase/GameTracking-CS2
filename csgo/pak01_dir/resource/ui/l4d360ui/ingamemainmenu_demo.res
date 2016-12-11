"Resource/UI/InGameMainMenu.res"
{
	"InGameMainMenu"
	{
		"ControlName"			"Frame"
		"fieldName"				"InGameMainMenu"
		"xpos"					"0"
		"ypos"					"0"
		"wide"					"f0"
		"tall"					"f0"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"PaintBackgroundType"	"0"
	}
	
	"PnlBackground"
	{
		"ControlName"		"L4DMenuBackground"
		"fieldName"			"PnlBackground"
		"xpos"				"0"
		"ypos"				"110"
		"zpos"				"-1"
		"wide"				"f0"
		"tall"				"170"	[$WIN32]
		"tall"				"245"	[$X360]
		"visible"			"1"
		"enabled"			"1"
		"fillColor"			"0 0 0 240"	[$WIN32]
		"fillColor"			"0 0 0 200"	[$X360]
	}
			
	"BtnReturnToGame"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnReturnToGame"
		"xpos"					"100"
		"ypos"					"135"
		"wide"					"220"	[$WIN32]
		"wide"					"180"	[$X360]
		"tall"					"15"	[$WIN32]
		"tall"					"20"	[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"1"
		"navUp"					"BtnExitToMainMenu"
		"navDown"				"BtnGoIdle"
		"labelText"				"#L4D360UI_InGameMainMenu_ReturnToGame"
		"tooltiptext"			"#L4D360UI_InGameMainMenu_ReturnToGame_Tip"
		"style"					"MainMenuButton"
		"command"				"ReturnToGame"
		"ActivationType"		"1"
	}

	"BtnGoIdle"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnGoIdle"
		"xpos"					"100"
		"ypos"					"150"	[$WIN32]
		"ypos"					"160"	[$X360]
		"wide"					"220"	[$WIN32]
		"wide"					"180"	[$X360]
		"tall"					"15"	[$WIN32]
		"tall"					"20"	[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"1"
		"navUp"					"BtnReturnToGame"
		"navDown"				"BtnCallAVoteNotAvailableInDemo"
		"labelText"				"#L4D360UI_InGameMainMenu_GoIdle"
		"tooltiptext"			"#L4D360UI_InGameMainMenu_GoIdle_Tip"
		"style"					"MainMenuButton"
		"command"				"GoIdle"
		"ActivationType"		"1"
	}

	"BtnCallAVoteNotAvailableInDemo"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCallAVoteNotAvailableInDemo"
		"xpos"					"100"
		"ypos"					"165"	[$WIN32]
		"ypos"					"185"	[$X360]
		"wide"					"220"	[$WIN32]
		"wide"					"180"	[$X360]
		"tall"					"15"	[$WIN32]
		"tall"					"20"	[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"0"
		"tabPosition"			"0"
		"navUp"					"BtnGoIdle"
		"navDown"				"BtnInviteAFriendNotAvailableInDemo"
		"labelText"				"#L4D360UI_InGameMainMenu_CallAVote"
		"tooltiptext"			"#L4D360UI_InGameMainMenu_CallAVote_Tip"
		"style"					"MainMenuButton"
		"command" 				"FlmVoteFlyout"
		"ActivationType"		"1"
	}

	"BtnInviteAFriendNotAvailableInDemo"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnInviteAFriendNotAvailableInDemo"
		"xpos"					"100"
		"ypos"					"180"	[$WIN32]
		"ypos"					"210"	[$X360]
		"wide"					"220"	[$WIN32]
		"wide"					"180"	[$X360]
		"tall"					"15"	[$WIN32]
		"tall"					"20"	[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"0"
		"tabPosition"			"0"
		"navUp"					"BtnCallAVoteNotAvailableInDemo"
		"navDown"				"BtnLeaderboardNotAvailableInDemo"
		"labelText"				"#L4D360UI_InGameMainMenu_InviteAFriend"
		"tooltiptext"			"#L4D360UI_InGameMainMenu_InviteAFriend_Tip"
		"style"					"MainMenuButton"
		"command" 				"NotAvailableInDemo"
		"ActivationType"		"1"
	}
	
	"BtnLeaderboardNotAvailableInDemo"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnLeaderboardNotAvailableInDemo"
		"xpos"					"100"
		"ypos"					"195"	[$WIN32]
		"ypos"					"235"	[$X360]
		"wide"					"220"	[$WIN32]
		"wide"					"180"	[$X360]
		"tall"					"20"	
		"autoResize"			"1"		
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"0"
		"tabPosition"			"0"
		"navUp"					"BtnInviteAFriendNotAvailableInDemo"
		"navDown"				"BtnStatsAndAchievementsNotAvailableInDemo"
		"labelText"				"#L4D360UI_Leaderboard_Title"
		"tooltiptext"			"#L4D360UI_MainMenu_SurvivalLeaderboards_Tip"
		"style"					"MainMenuButton"
		"command"				"NotAvailableInDemo"
		"ActivationType"		"1"
	}
	
	"BtnStatsAndAchievementsNotAvailableInDemo"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnStatsAndAchievementsNotAvailableInDemo"
		"xpos"					"100"
		"ypos"					"210"	[$WIN32]
		"ypos"					"260"	[$X360]
		"wide"					"220"	[$WIN32]
		"wide"					"180"	[$X360]
		"tall"					"15"	[$WIN32]
		"tall"					"20"	[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"0"
		"tabPosition"			"0"
		"navUp"					"BtnLeaderboardNotAvailableInDemo"
		"navDown"				"BtnOptions"
		"labelText"				"#L4D360UI_MainMenu_StatsAndAchievements"
		"tooltiptext"			"#L4D360UI_MainMenu_PCStatsAndAchievements_Tip"	[$WIN32]
		"tooltiptext"			"#L4D360UI_MainMenu_StatsAndAchievements_Tip"	[$X360]
		"style"					"MainMenuButton"
		"command"				"NotAvailableInDemo"
		"ActivationType"		"1"
	}

	"BtnOptions"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnOptions"
		"xpos"					"100"
		"ypos"					"225"	[$WIN32]
		"ypos"					"285"	[$X360]
		"wide"					"220"	[$WIN32]
		"wide"					"180"	[$X360]
		"tall"					"15"	[$WIN32]
		"tall"					"20"	[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnStatsAndAchievementsNotAvailableInDemo"
		"navDown"				"BtnExitToMainMenu"
		"labelText"				"#L4D360UI_MainMenu_Options"
		"tooltiptext"			"#L4D360UI_MainMenu_Options_Tip"
		"style"					"MainMenuButton"
		"command"				"FlmOptionsFlyout"	[$WIN32]
		"command"				"FlmOptionsGuestFlyout"	[$X360]
		"ActivationType"		"1"
	}

	"BtnExitToMainMenu"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnExitToMainMenu"
		"xpos"					"100"
		"ypos"					"250"	[$WIN32]
		"ypos"					"322"	[$X360]
		"wide"					"220"	[$WIN32]
		"wide"					"180"	[$X360]
		"tall"					"15"	[$WIN32]
		"tall"					"20"	[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnOptions"
		"navDown"				"BtnReturnToGame"
		"labelText"				"#L4D360UI_InGameMainMenu_ExitToMainMenu"
		"tooltiptext"			"#L4D360UI_InGameMainMenu_ExitToMainMenu_Tip"
		"style"					"MainMenuButton"
		"command"				"ExitToMainMenu"
		"ActivationType"		"1"
	}

	"FlmOptionsFlyout"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmOptionsFlyout"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnVideo" [$WIN32]
		"InitialFocus"			"BtnAudioVideo" [$X360]
		"ResourceFile"			"resource/UI/L4D360UI/OptionsFlyout.res"		[$WIN32]
		"ResourceFile"			"resource/UI/L4D360UI/OptionsGuestFlyout.res"	[$X360]
	}
	
	"FlmOptionsGuestFlyout"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmOptionsGuestFlyout"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnAudioVideo"
		"ResourceFile"			"resource/UI/L4D360UI/OptionsGuestFlyout.res"
	}

	"FlmVoteFlyout"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmVoteFlyout"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnReturnToLobby"
		"ResourceFile"			"resource/UI/L4D360UI/InGameVoteFlyout.res"
	}
	
	"FlmVoteFlyoutVersus"
	{
		"ControlName"		"FlyoutMenu"
		"fieldName"			"FlmVoteFlyoutVersus"
		"visible"			"0"
		"wide"				"0"
		"tall"				"0"
		"zpos"				"3"
		"InitialFocus"		"BtnReturnToLobby"
		"ResourceFile"		"resource/UI/L4D360UI/InGameVoteFlyoutVersus.res"
	}
	
	"FlmVoteFlyoutSurvival"
	{
		"ControlName"		"FlyoutMenu"
		"fieldName"			"FlmVoteFlyoutSurvival"
		"visible"			"0"
		"wide"				"0"
		"tall"				"0"
		"zpos"				"3"
		"InitialFocus"		"BtnReturnToLobby"
		"ResourceFile"		"resource/UI/L4D360UI/InGameVoteFlyoutSurvival.res"
	}
}
