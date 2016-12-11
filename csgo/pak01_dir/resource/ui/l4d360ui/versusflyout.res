"Resource/UI/VersusFlyout.res"
{
	"PnlBackground"
	{
		"ControlName"			"Panel"
		"fieldName"				"PnlBackground"
		"xpos"					"0"
		"ypos"					"0"
		"zpos"					"-1"
		"wide"					"180" [$ENGLISH]
		"wide"					"270" [!$ENGLISH]
		"tall"					"85" [$X360]
		"tall"					"105" [$WIN32]
		"visible"				"1"
		"enabled"				"1"
		"paintbackground"		"1"
		"paintborder"			"1"
	}

	"BtnQuickMatch"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnQuickMatch"
		"xpos"					"0"
		"ypos"					"0"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnPlayOnGroupServer"
		"navDown"				"BtnPlayVersusWithAnyone"
		"labelText"				"#L4D360UI_QuickMatch"
		"tooltiptext"			"#L4D360UI_QuickMatch_Versus_Tip"
		"disabled_tooltiptext"	"#L4D360UI_QuickMatch_Tip_Disabled"
		"style"					"FlyoutMenuButton"
		"command"				"QuickMatch_versus"
	}
	
	"BtnPlayVersusWithAnyone"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnPlayVersusWithAnyone"
		"xpos"					"0"
		"ypos"					"20"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnQuickMatch"
		"navDown"				"BtnPlayVersusWithFriends"
		"labelText"				"#L4D360UI_CustomMatch"	[$X360]
		"labelText"				"#L4D360UI_MainMenu_PlayOnline" [$WIN32]
		"tooltiptext"			"#L4D360UI_MainMenu_Versus_Tip"
		"disabled_tooltiptext"	"#L4D360UI_MainMenu_PlayCoopWithAnyone_Tip_Disabled"
		"style"					"FlyoutMenuButton"
		"command"				"CustomMatch_versus"
	}	
	
	"BtnPlayVersusWithFriends"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnPlayVersusWithFriends"
		"xpos"					"0"
		"ypos"					"40"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnPlayVersusWithAnyone"
		"navDown"				"BtnPlayVersusWithTeam"
		"labelText"				"#L4D360UI_MainMenu_PlayCoopWithFriends"
		"tooltiptext"			"#L4D360UI_MainMenu_PlayCoopWithFriends_Tip"
		"disabled_tooltiptext"	"#L4D360UI_MainMenu_PlayCoopWithFriends_Tip_Disabled"
		"style"					"FlyoutMenuButton"
		"command"				"FriendsMatch_versus"
	}
	
	"BtnPlayVersusWithTeam"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnPlayVersusWithTeam"
		"xpos"					"0"
		"ypos"					"60"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnPlayVersusWithFriends"
		"navDown"				"BtnPlayOnGroupServer"
		"labelText"				"#L4D360UI_MainMenu_PlayTeamVersus"
		"tooltiptext"			"#L4D360UI_MainMenu_PlayTeam_Tip"
		"disabled_tooltiptext"	"#L4D360UI_MainMenu_PlayTeam_Tip_Disabled"
		"style"					"FlyoutMenuButton"
		"command"				"FriendsMatch_teamversus"
	}

	"BtnPlayOnGroupServer"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnPlayOnGroupServer"
		"xpos"					"0"
		"ypos"					"80"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"		[$WIN32]
		"visible"				"0"		[$X360]
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnPlayVersusWithTeam"
		"navDown"				"BtnQuickMatch"
		"labelText"				"#L4D360UI_MainMenu_PlayOnGroupServer"
		"tooltiptext"			"#L4D360UI_MainMenu_PlayOnGroupServer_Tip"
		"disabled_tooltiptext"	"#L4D360UI_MainMenu_PlayOnGroupServer_Tip_Disabled"
		"style"					"FlyoutMenuButton"
		"command"				"GroupServer_versus"
	}
}